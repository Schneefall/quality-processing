local shared = require("__quality-processing__.shared")
local parsed_settings = require("__quality-processing__.settings_parser")

-- Upgrade machine recipes

data:extend({
	{
		type = "recipe",
		name = shared.mod_prefix .. "normal",
		order = "1",
		category = "crafting",
		subgroup = shared.mod_prefix.."normal",
		energy_required = 5,
		enabled = false,
		hidden = false,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "assembling-machine-1", amount = 1},
			{type = "item", name = "iron-plate", amount = 10},
			{type = "item", name = "stone", amount = 5}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "normal", amount = 1}
		},
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "uncommon",
		order = "1",
		category = "crafting",
		subgroup = shared.mod_prefix.."uncommon",
		energy_required = 5,
		enabled = false,
		hidden = false,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "assembling-machine-2", amount = 2},
			{type = "item", name = "advanced-circuit", amount = 10},
			{type = "item", name = "electric-engine-unit", amount = 6}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "uncommon", amount = 1}
		},
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "rare",
		order = "1",
		category = "crafting",
		subgroup = shared.mod_prefix.."rare",
		energy_required = 5,
		enabled = false,
		hidden = false,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "assembling-machine-3", amount = 2},
			{type = "item", name = "processing-unit", amount = 20},
			{type = "item", name = "electric-engine-unit", amount = 40},
			{type = "item", name = "low-density-structure", amount = 8}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "rare", amount = 1}
		},
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "epic",
		order = "1",
		category = "crafting",
		subgroup = shared.mod_prefix.."epic",
		energy_required = 10,
		enabled = false,
		hidden = false,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "foundry", amount = 2},
			{type = "item", name = "electric-engine-unit", amount = 100},
			{type = "item", name = "tungsten-plate", amount = 40},
			{type = "item", name = "carbon-fiber", amount = 60}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "epic", amount = 1}
		},
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "legendary",
		order = "1",
		category = "crafting",
		subgroup = shared.mod_prefix.."legendary",
		energy_required = 10,
		enabled = false,
		hidden = false,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "electromagnetic-plant", amount = 2},
			{type = "item", name = "cryogenic-plant", amount = 1},
			{type = "item", name = "quantum-processor", amount = 100},
			{type = "item", name = "low-density-structure", amount = 200}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "legendary", amount = 1}
		},
	},
})

-- Upgrage item recipes
local simple_upgrades = settings.startup[shared.mod_prefix .. "simple-upgrade-items"].value
local no_upgrades = settings.startup[shared.mod_prefix .. "no-upgrade-items"].value


data:extend({
	-- uncommon
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-uncommon",
		order = "a",
		category = "crafting-with-fluid",
		subgroup = shared.mod_prefix.."uncommon",
		energy_required = 1,
		enabled = false,
		hidden = no_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "stone-brick", amount = 4},
			{type = "item", name = "advanced-circuit", amount = 2},
			{type = "fluid", name = "lubricant", amount = 10}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-uncommon", amount = 1}
		},
		allow_productivity = true,
	},

	-- rare
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-rare",
		order = "a",
		category = "advanced-crafting",
		subgroup = shared.mod_prefix.."rare",
		energy_required = 1,
		enabled = false,
		hidden = no_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-rare-1", amount = 1},
			{type = "item", name = shared.mod_prefix .. "upgrade-item-rare-2", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-rare", amount = 1}
		},
		allow_productivity = true,
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-rare-1",
		order = "aa",
		category = "electronics-or-assembling",
		subgroup = shared.mod_prefix.."rare",
		energy_required = 5,
		enabled = false,
		hidden = no_upgrades or simple_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "processing-unit", amount = 12},
			{type = "item", name = "uranium-235", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-rare-1", amount = 6}
		},
		allow_productivity = true,
		surface_conditions = {{property="gravity", min=0, max=0}}, -- only in space
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-rare-2",
		order = "ab",
		category = "advanced-crafting",
		subgroup = shared.mod_prefix.."rare",
		energy_required = 2,
		enabled = false,
		hidden = no_upgrades or simple_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "electric-engine-unit", amount = 4},
			{type = "item", name = "low-density-structure", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-rare-2", amount = 1}
		},
		allow_productivity = true,
	},

	-- epic
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-epic",
		order = "a",
		category = "advanced-crafting",
		subgroup = shared.mod_prefix.."epic",
		energy_required = 1,
		enabled = false,
		hidden = no_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-epic-1", amount = 1},
			{type = "item", name = shared.mod_prefix .. "upgrade-item-epic-2", amount = 1},
			{type = "item", name = shared.mod_prefix .. "upgrade-item-epic-3", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-epic", amount = 1}
		},
		allow_productivity = true,
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-epic-1",
		order = "aa",
		category = "organic",
		subgroup = shared.mod_prefix.."epic",
		energy_required = 2,
		enabled = false,
		hidden = no_upgrades or simple_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "carbon-fiber", amount = 4},
			{type = "item", name = "bioflux", amount = 1},
			{type = "item", name = "iron-bacteria", amount = 2},
			{type = "item", name = "pentapod-egg", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-epic-1", amount = 1}
		},
		allow_productivity = true,
		surface_conditions = {{property = "pressure", min = 2000, max = 2000}}, -- only on gleba
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-epic-2",
		order = "ab",
		category = "metallurgy",
		subgroup = shared.mod_prefix.."epic",
		energy_required = 2,
		enabled = false,
		hidden = no_upgrades or simple_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "tungsten-carbide", amount = 4},
			{type = "item", name = "steel-plate", amount = 10},
			{type = "fluid", name = "molten-copper", amount = 60}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-epic-2", amount = 1}
		},
		allow_productivity = true,
		surface_conditions = {{property = "pressure", min = 4000, max = 4000}}, -- only on vulcanus
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-epic-3",
		order = "ac",
		category = "electromagnetics",
		subgroup = shared.mod_prefix.."epic",
		energy_required = 2,
		enabled = false,
		hidden = no_upgrades or simple_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "processing-unit", amount = 2},
			{type = "item", name = "superconductor", amount = 2},
			{type = "item", name = "supercapacitor", amount = 1},
			{type = "fluid", name = "electrolyte", amount = 10}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-epic-3", amount = 1}
		},
		allow_productivity = true,
		surface_conditions = {{property = "magnetic-field", min = 99}}, -- only on fulgora
	},

	-- legendary
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-legendary",
		order = "a",
		category = "cryogenics",
		subgroup = shared.mod_prefix.."legendary",
		energy_required = 1,
		enabled = false,
		hidden = no_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary-1", amount = 1},
			{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary-2", amount = 1},
			{type = "fluid", name = "fluoroketone-cold", amount = 2, ignored_by_stats = 2}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary", amount = 1},
			{type = "fluid", name = "fluoroketone-hot", amount = 2, ignored_by_stats = 2, ignored_by_productivity = 2}
		},
		main_product = shared.mod_prefix .. "upgrade-item-legendary",
		allow_productivity = true,
		surface_conditions = {{property = "pressure", min = 300, max = 300}}, -- only on aquilo
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-legendary-1",
		order = "aa",
		category = "electromagnetics",
		subgroup = shared.mod_prefix.."legendary",
		energy_required = 2,
		enabled = false,
		hidden = no_upgrades or simple_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "quantum-processor", amount = 2},
			--{type = "item", name = "promethium-asteroid-chunk", amount = 4},
			{type = "fluid", name = "fluoroketone-cold", amount = 10, ignored_by_stats = 10}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary-1", amount = 1},
			{type = "fluid", name = "fluoroketone-hot", amount = 10, ignored_by_stats = 10, ignored_by_productivity = 10}
		},
		main_product = shared.mod_prefix .. "upgrade-item-legendary-1",
		allow_productivity = true,
		surface_conditions = {{property = "gravity", min = 0, max = 0}}, -- only in space
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-legendary-2",
		order = "ab",
		category = "advanced-crafting",
		subgroup = shared.mod_prefix.."legendary",
		energy_required = 2,
		enabled = false,
		hidden = no_upgrades or simple_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary-2-1", amount = 1},
			{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary-2-2", amount = 1},
			{type = "fluid", name = "lubricant", amount = 10}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary-2", amount = 1}
		},
		allow_productivity = true,
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-legendary-2-1",
		order = "aba",
		category = "metallurgy",
		subgroup = shared.mod_prefix.."legendary",
		energy_required = 2,
		enabled = false,
		hidden = no_upgrades or simple_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "carbon-fiber", amount = 4},
			{type = "item", name = "superconductor", amount = 4},
			{type = "item", name = "low-density-structure", amount = 4},
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary-2-1", amount = 1}
		},
		allow_productivity = true,
		surface_conditions = {{property = "pressure", min = 4000, max = 4000}}, -- only on vulcanus
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-legendary-2-2",
		order = "abb",
		category = "electromagnetics",
		subgroup = shared.mod_prefix.."legendary",
		energy_required = 2,
		enabled = false,
		hidden = no_upgrades or simple_upgrades,
		unlock_results = true,
		auto_recycle = true,
		ingredients = {
			{type = "item", name = "fusion-power-cell", amount = 1},
			{type = "item", name = "supercapacitor", amount = 2},
			{type = "item", name = "carbon", amount = 4},
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary-2-2", amount = 1}
		},
		allow_productivity = true,
		surface_conditions = {{property = "magnetic-field", min = 99}}, -- only on fulgora
	},

})

if not parsed_settings.no_promethium then
	table.insert(
		data.raw.recipe[shared.mod_prefix .. "upgrade-item-legendary-1"].ingredients,
		{type = "item", name = "promethium-asteroid-chunk", amount = 4}
	)
end

if simple_upgrades then
	data.raw.recipe[shared.mod_prefix .. "upgrade-item-rare"].ingredients = {
		{type = "item", name = "processing-unit", amount = 12},
		{type = "item", name = "electric-engine-unit", amount = 24},
		{type = "item", name = "low-density-structure", amount = 6},
		{type = "item", name = "uranium-235", amount = 1},
	}
	data.raw.recipe[shared.mod_prefix .. "upgrade-item-rare"].results = {
		{type = "item", name = shared.mod_prefix .. "upgrade-item-rare", amount = 6}
	}
	
	data.raw.recipe[shared.mod_prefix .. "upgrade-item-epic"].ingredients = {
		{type = "item", name = "bioflux", amount = 2},
		{type = "item", name = "carbon-fiber", amount = 4},
		{type = "item", name = "tungsten-carbide", amount = 4},
		{type = "item", name = "supercapacitor", amount = 2}
	}
	
	data.raw.recipe[shared.mod_prefix .. "upgrade-item-legendary"].ingredients = {
		{type = "item", name = "quantum-processor", amount = 2},
		--{type = "item", name = "promethium-asteroid-chunk", amount = 4},
		{type = "item", name = "carbon-fiber", amount = 4},
		{type = "item", name = "supercapacitor", amount = 4},
		{type = "fluid", name = "fluoroketone-cold", amount = 2, ignored_by_stats = 2}
	}

	if not parsed_settings.no_promethium then
		table.insert(
			data.raw.recipe[shared.mod_prefix .. "upgrade-item-legendary"].ingredients,
			{type = "item", name = "promethium-asteroid-chunk", amount = 4}
		)
	end
end


if settings.startup[shared.mod_prefix .. "no-surface-restriction"].value then
	for _, name in ipairs(shared.get_upgrade_item_names(simple_upgrades)) do
		data.raw.recipe[name].surface_conditions = nil
	end
end


-- debug

if shared.debug then
data:extend({
	{
		type = "recipe",
		name = shared.mod_prefix .. "normal-debug",
		order = "1z",
		category = "crafting",
		subgroup = shared.mod_prefix.."normal",
		enabled = true,
		hidden = false,
		unlock_results = true,
		auto_recycle = false,
		ingredients = {
			{type = "item", name = "copper-plate", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "normal", amount = 1}
		},
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "uncommon-debug",
		order = "1z",
		category = "crafting",
		subgroup = shared.mod_prefix.."uncommon",
		enabled = true,
		hidden = false,
		unlock_results = true,
		auto_recycle = false,
		ingredients = {
			{type = "item", name = "copper-plate", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "uncommon", amount = 1}
		},
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "rare-debug",
		order = "1z",
		category = "crafting",
		subgroup = shared.mod_prefix.."rare",
		enabled = true,
		hidden = false,
		unlock_results = true,
		auto_recycle = false,
		ingredients = {
			{type = "item", name = "copper-plate", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "rare", amount = 1}
		},
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "epic-debug",
		order = "1z",
		category = "crafting",
		subgroup = shared.mod_prefix.."epic",
		enabled = true,
		hidden = false,
		unlock_results = true,
		auto_recycle = false,
		ingredients = {
			{type = "item", name = "copper-plate", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "epic", amount = 1}
		},
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "legendary-debug",
		order = "1z",
		category = "crafting",
		subgroup = shared.mod_prefix.."legendary",
		enabled = true,
		hidden = false,
		unlock_results = true,
		auto_recycle = false,
		ingredients = {
			{type = "item", name = "copper-plate", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "legendary", amount = 1}
		},
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-uncommon-debug",
		order = "az",
		category = "crafting",
		subgroup = shared.mod_prefix.."uncommon",
		enabled = true,
		hidden = false,
		unlock_results = true,
		auto_recycle = false,
		ingredients = {
			{type = "item", name = "iron-plate", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-uncommon", amount = 1}
		},
		allow_productivity = true,
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-rare-debug",
		order = "az",
		category = "crafting",
		subgroup = shared.mod_prefix.."rare",
		enabled = true,
		hidden = false,
		unlock_results = true,
		auto_recycle = false,
		ingredients = {
			{type = "item", name = "iron-plate", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-rare", amount = 1}
		},
		allow_productivity = true,
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-epic-debug",
		order = "az",
		category = "crafting",
		subgroup = shared.mod_prefix.."epic",
		enabled = true,
		hidden = false,
		unlock_results = true,
		auto_recycle = false,
		ingredients = {
			{type = "item", name = "iron-plate", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-epic", amount = 1}
		},
		allow_productivity = true,
	},
	{
		type = "recipe",
		name = shared.mod_prefix .. "upgrade-item-legendary-debug",
		order = "az",
		category = "crafting",
		subgroup = shared.mod_prefix.."legendary",
		enabled = true,
		hidden = false,
		unlock_results = true,
		auto_recycle = false,
		ingredients = {
			{type = "item", name = "iron-plate", amount = 1}
		},
		results = {
			{type = "item", name = shared.mod_prefix .. "upgrade-item-legendary", amount = 1}
		},
		allow_productivity = true,
	},
})
end


-- crafting categories
local recipe_categories = {}
for _,quality in ipairs(shared.qualities) do
	recipe_categories[quality] = shared.mod_prefix .. quality
	data:extend({{type="recipe-category", name=recipe_categories[quality]}})
	table.insert(data.raw["utility-constants"]["default"].factoriopedia_recycling_recipe_categories, recipe_categories[quality])
end

