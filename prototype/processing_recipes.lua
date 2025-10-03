local shared = require("shared")
local processing_utility = require("processing_utility")
local item_complexity = require("item_complexity")

local log_complexity = settings.startup[shared.mod_prefix .. "log-complexity"].value or shared.debug

local complexity_data = item_complexity.make_complexity_data(300, 1, 1/100) -- generator_multiplier, fluid_only_multiplier, loot_health_multiplier

local preset_complexity = settings.startup[shared.mod_prefix .. "preset-complexity"].value or ""
if preset_complexity then
	local preset_complexities = shared.parse_table_string(preset_complexity, true)
	for item_name, complexity in pairs(preset_complexities) do
		shared.log_debug("Pre-setting complexity "..item_name.."="..complexity)
		complexity_data.item[item_name] = math.max(complexity, 0.01)
	end
end

shared.log_debug("Setting complexity for minables.")
-- Assign base complexity to items that can come from these prototypes:
for _, resource in pairs(data.raw["resource"]) do
    item_complexity.set_from_minable(complexity_data, resource, 0.5) -- 1s -> 0.5 complexity
    shared.log_debug("Triggered for resource "..resource.name)
end
for _, resource in pairs(data.raw["fish"]) do
    item_complexity.set_from_minable(complexity_data, resource, 7500) -- 0.4s for 5x raw fish -> 600 complexity
    shared.log_debug("Triggered for fish "..resource.name)
end
for _, resource in pairs(data.raw["asteroid-chunk"]) do
    item_complexity.set_from_minable(complexity_data, resource, 25) -- Default 2 complexity for modded asteroid chunks
    shared.log_debug("Triggered for asteroid-chunk "..resource.name)
end
for _, resource in pairs(data.raw["plant"]) do
    item_complexity.set_from_minable(complexity_data, resource, 200) -- 0.5s for 50x fruit -> 2 complexity
    shared.log_debug("Triggered for plant "..resource.name)
end

for _, tile in pairs(data.raw["tile"]) do
	item_complexity.set_from_fluid_tile(complexity_data, tile, 0.05)
    shared.log_debug("Triggered for tile "..tile.name)
end

--item_complexity.set_generator_complexity(complexity_data, data.raw["recipe"], 300)
--item_complexity.set_fluid_only_complexity(complexity_data, data.raw["recipe"], 1)

shared.log_debug("Computed complexity for "..shared.get_table_length(complexity_data.item).." items, visited "..#complexity_data.recipes_visited.." recipes.")

item_complexity.collect_valid_recipes(complexity_data, data.raw["recipe"])

for type_name in pairs(defines.prototypes["item"]) do
	local prototypes = data.raw[type_name]
	if prototypes then
		item_complexity.collect_spoiling_recipes(complexity_data, prototypes, true)
		item_complexity.collect_burning_recipes(complexity_data, prototypes, true)
	end
end

for type_name in pairs(defines.prototypes["entity"]) do
	local prototypes = data.raw[type_name]
	if prototypes then
		item_complexity.collect_loot_recipes(complexity_data, prototypes, false)
	end
end

local unknown_ingredient_complexity = settings.startup[shared.mod_prefix .. "unknown-ingredients-complexity"].value or 0
if log_complexity or unknown_ingredient_complexity>0 then
	local unknown_ingredients = item_complexity.get_unknown_ingredients(complexity_data)
	
	if unknown_ingredient_complexity>0 then
		for _, item_name in ipairs(unknown_ingredients) do
			complexity_data.item[item_name] = math.max(unknown_ingredient_complexity, 0.01)
		end
		if log_complexity then
			log("Unknown ingredients set to complexity="..unknown_ingredient_complexity..": " .. serpent.block(unknown_ingredients))
		end
	elseif log_complexity then
		log("Unknown ingredients: " .. serpent.block(unknown_ingredients))
	end
end

item_complexity.remove_recipies_with_unknown_ingredients(complexity_data)

item_complexity.remove_cyclic_recipes(complexity_data)

item_complexity.process_items(complexity_data)

shared.log_debug("Computed complexity for "..shared.get_table_length(complexity_data.item).." items, visited "..#complexity_data.recipes_visited.." recipes.")

local num_unresolved_items = shared.get_table_length(complexity_data.items_available)
log("Computed complexity for "..shared.get_table_length(complexity_data.item).." items, with "..num_unresolved_items.." unresolved items.")

if num_unresolved_items>0 then
	item_complexity.force_break_remaining_cycles(complexity_data)
	item_complexity.process_items(complexity_data)
	log("Computed complexity for "..shared.get_table_length(complexity_data.item).." items, with "..shared.get_table_length(complexity_data.items_available).." unresolved items.")
end



local function complexity_to_upgrade_count(item_name, complexity)
	local scale = settings.startup[shared.mod_prefix .. "cost-scale"].value -- 0.933
	local pre_scale = settings.startup[shared.mod_prefix .. "cost-pre-scale"].value -- 0.595
	local exponent = settings.startup[shared.mod_prefix .. "cost-exp"].value -- 0.461

	local cost = scale * math.pow(pre_scale * complexity, exponent)
	
	if shared.array_contains(shared.upgrade_item_names, item_name) then
		cost = cost * settings.startup[shared.mod_prefix .. "upgrade-item-cost-scale"].value or 1
	end
	return math.min(cost, 65535)
end


local function complexity_to_upgrade_time(item_name, complexity)
	local scale = settings.startup[shared.mod_prefix .. "time-scale"].value -- 0.933
	local pre_scale = settings.startup[shared.mod_prefix .. "time-pre-scale"].value -- 0.595
	local exponent = settings.startup[shared.mod_prefix .. "time-exp"].value -- 0.461

	local cost = scale * math.pow(pre_scale * complexity, exponent)
	
	if shared.array_contains(shared.upgrade_item_names, item_name) then
		cost = cost * settings.startup[shared.mod_prefix .. "upgrade-item-time-scale"].value or 1
	end
	return cost 
end

local not_stackable_types = {"armor"}
local function is_item_stackable(item)
	return ((item.flags==nil) or not shared.array_contains(item.flags, "not-stackable"))
		and not shared.array_contains(not_stackable_types, item.type)
end

local function round_time(final_time)
	if final_time <= 0.5 then
		final_time = math.ceil(final_time * 40) / 40    -- Under 0.5s: round up by .025
	elseif final_time <= 1 then
		final_time = math.ceil(final_time * 10) / 10    -- 0.5s -  1s: round up by .1
	elseif final_time <= 10 then
		final_time = math.ceil(final_time * 2) / 2      --   1s - 10s: round up by .5
	elseif final_time <= 30 then
		final_time = math.ceil(final_time)              --  10s - 30s: round up by 1
	elseif final_time <= 120 then
		final_time = math.ceil(final_time / 5) * 5      -- 30s - 120s: round up by 5
	else
		final_time = math.ceil(final_time / 10) * 10    -- Above 120s: round up by 10
	end
	return final_time
end

local function get_recipe_scales(upgrades_per_item, time_per_item, item_stackable)
	local min_time = settings.startup[shared.mod_prefix .. "min-time"].value or 5
	local items = 1
	
	if time_per_item<min_time and item_stackable then
		items = math.ceil(min_time / time_per_item)
	end
	
	local final_time = round_time(items * time_per_item)
	if not item_stackable then
		final_time = math.max(min_time, final_time)
	end
	
	local input_scale = math.max(1, math.floor(items * upgrades_per_item))
	
	return items, input_scale, final_time
end

if log_complexity or shared.debug then 
	log("--- Final item complexity sorted (upgrades/item, time/item) ---")
	
	local item_names_sorted = {}
	for item_name in pairs(complexity_data.item) do table.insert(item_names_sorted, item_name) end
	table.sort(item_names_sorted, function(a, b) return complexity_data.item[a] < complexity_data.item[b] end)
	
	for i, item_name in ipairs(item_names_sorted) do
		local item = processing_utility.get_prototype(item_name, "item")
		if item ~= nil then
			local complexity = complexity_data.item[item_name]
			local upgrades_per_item = complexity_to_upgrade_count(item_name, complexity)
			local time_per_item = complexity_to_upgrade_time(item_name, complexity)
			local items, input_scale, final_time = get_recipe_scales(upgrades_per_item, time_per_item, is_item_stackable(item))
			log(item_name..": "..complexity.." ("..upgrades_per_item..", "..time_per_item..")")
			log("    Recipe: input items="..items..", used upgrade items="..input_scale..", time="..final_time)
		end
	end
	
	log("--- Items without complexity (#recipes) ---")
	for item_name, r in pairs (complexity_data.items_available) do
		log(item_name.." ("..#r..")")
		shared.log_debug(serpent.block(r))
	end
end


if settings.startup[shared.mod_prefix .. "fallback-complexity"].value>0 then
	local complexity = settings.startup[shared.mod_prefix .. "fallback-complexity"].value
	log("Setting complexity "..complexity.." for "..shared.get_table_length(complexity_data.items_available).." unresolved items.")
	for item_name, r in pairs (complexity_data.items_available) do
		if complexity_data.item[item_name] == nil then
			complexity_data.item[item_name] = complexity
		end
	end
end

local ingredients = {
	normal = {
		{type = "fluid", name = "sulfuric-acid", amount = 2}
	},
	uncommon = {
		{type = "item", name = shared.mod_prefix .. "upgrade-item-uncommon", amount = 1},
		{type = "fluid", name = "water", amount = 10},
	},
	rare = {
		{type = "item", name = shared.mod_prefix .. "upgrade-item-rare", amount = 1},
	},
	epic = {
		{type = "item", name = shared.mod_prefix .. "upgrade-item-epic", amount = 1},
		{type = "fluid", name = "thruster-oxidizer", amount = 10},
		{type = "fluid", name = "thruster-fuel", amount = 10},
	},
	legendary = {
		{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary", amount = 1},
		{type = "fluid", name = "fluoroketone-cold", amount = 2, ignored_by_stats = 2}
	},
}

local results = {
	normal = {},
	uncommon = {},
	rare = {},
	epic = {},
	legendary = {
		{type = "fluid", name = "fluoroketone-hot", amount = 2, ignored_by_stats = 2, ignored_by_productivity = 2}
	},
}

local function get_scaled_ingredient(ingredient_proto, scale)
	local ingredient = table.deepcopy(ingredient_proto)
	ingredient.amount = ingredient.amount * scale
	if ingredient.ignored_by_stats ~= nil then
		ingredient.ignored_by_stats = ingredient.ignored_by_stats * scale
	end
	if ingredient.ignored_by_productivity ~= nil then
		ingredient.ignored_by_productivity = ingredient.ignored_by_productivity * scale
	end
	return ingredient
end

local item_quality_group_names = {}
local item_quality_subgroup_names = {}
local function get_item_quality_subgroup(item)
	local subgroup_name = item.subgroup
	if subgroup_name==nil then return end
	
	local subgroup = data.raw["item-subgroup"][subgroup_name]
	if subgroup==nil then return end
	
	local group_name = subgroup.group
	if group_name==nil then return end
	
	local group = data.raw["item-group"][group_name]
	if group_name==nil then return end
	
	local quality_group_name = group_name .. shared.mod_suffix_short
	local quality_subgroup_name = subgroup_name .. shared.mod_suffix_short
	
	if item_quality_group_names[quality_group_name]==nil then
		local quality_group = table.deepcopy(group)
		quality_group.name = quality_group_name
		quality_group.icons = processing_utility.generate_processing_recipe_group_icon(group)
		quality_group.localised_name = {"item-group-name.quality-processing--upgrade-recipe-group", group.localised_name or {"item-group-name."..group_name}}
		quality_group.order = "z-qp-" .. quality_group.order
		quality_group.hidden_in_factoriopedia = true
		data:extend({quality_group})
		item_quality_group_names[quality_group_name] = true
	end
	
	if item_quality_subgroup_names[quality_subgroup_name]==nil then
		local quality_subgroup = table.deepcopy(subgroup)
		quality_subgroup.name = quality_subgroup_name
		quality_subgroup.group = quality_group_name
		quality_subgroup.hidden_in_factoriopedia = true
		data:extend({quality_subgroup})
		item_quality_subgroup_names[quality_subgroup_name] = true
	end
	
	return quality_subgroup_name
end


local excluded_item_flags = {
	"only-in-cursor",
}

local excluded_items = shared.parse_array_string(settings.startup[shared.mod_prefix .. "item-blacklist"].value or "")
log("Excluded items: "..serpent.block(excluded_items))

for item_name, complexity in pairs(complexity_data.item) do
	if shared.array_contains(excluded_items, item_name) then
		shared.log_debug("Excluded item: "..item_name)
		goto skipitemloop
	end
	
	local item = processing_utility.get_prototype(item_name, "item")
	if item == nil or item.hidden then goto skipitemloop end
	
	if item.flags then
		for _,flag in ipairs(excluded_item_flags) do
			if shared.array_contains(item.flags, flag) then
				shared.log_debug("Excluded item "..item_name.." with flag "..flag)
				goto skipitemloop
			end
		end
	end
	
	local complexity = complexity_data.item[item_name]
	local upgrades_per_item = complexity_to_upgrade_count(item_name, complexity)
	local time_per_item = complexity_to_upgrade_time(item_name, complexity)
	local items, input_scale, final_time = get_recipe_scales(upgrades_per_item, time_per_item, is_item_stackable(item))
	
	local subgroup = get_item_quality_subgroup(item)
	
	for _,quality in ipairs(shared.qualities) do
		local recipe = {
			type = "recipe",
			name = item_name .. shared.mod_suffix_short .. quality,
			order = item.order,
			localised_name = {"recipe-name."..shared.mod_prefix .. quality .. "-process", processing_utility.get_item_localised_name(item_name)},
			--localised_name = {"recipe-name."..shared.mod_prefix .. quality .. "-process", "item-name."..item_name, },
			--localised_name = {"", {"item-name."..item_name}, {"recipe-name."..shared.mod_prefix .. quality .. "-process"}},
			category = shared.mod_prefix .. quality, --recipe_categories[quality],
			icons = processing_utility.generate_processing_recipe_icon(item, quality),
			subgroup = subgroup,
			energy_required = final_time,
			enabled = true,
			hidden = false,
			hide_from_stats = false,
			hide_from_player_crafting = true,
			hide_from_signal_gui = true,
			hidden_in_factoriopedia = true,
			unlock_results = false,
			-- Quality mod, and by extension recycling recipes, should be loaded before this mod does.
			-- But in case game whacks load order, make sure these recipes don't get considered
			auto_recycle = false,
			ingredients = {
				{type = "item", name = item_name, amount = items}
			},
			results = {
				{type = "item", name = item_name, amount = items}
			},
			main_product = item_name,
			allow_productivity = false,
		}
		if not settings.startup[shared.mod_prefix .. "no-upgrade-items"].value then
			local upgrade_item_name = shared.mod_prefix .. "upgrade-item-" .. quality
			if recipe.ingredients[1].name==upgrade_item_name then
				recipe.ingredients[1].amount = recipe.ingredients[1].amount + input_scale
				for i=2,#(ingredients[quality]) do
					table.insert(recipe.ingredients, get_scaled_ingredient(ingredients[quality][i], input_scale))
				end
			else
				for i=1,#(ingredients[quality]) do
					table.insert(recipe.ingredients, get_scaled_ingredient(ingredients[quality][i], input_scale))
				end
			end
			for i=1,#(results[quality]) do
				table.insert(recipe.results, get_scaled_ingredient(results[quality][i], input_scale))
			end
		end
		data:extend({recipe})
	end
	::skipitemloop::
end