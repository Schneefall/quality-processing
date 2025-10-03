-- inspired by "Promethium is Quality" by Luka967 https://github.com/Luka967/promethium-quality/

local shared = require("__quality-processing__.shared")
local complexity_util = require("__quality-processing__.prototype.processing_utility")

local item_complexity = {}

local min_complexity = 0.05

local preset_item_complexity = {
	["spoilage"] = 0.5,
	--["ice"] = 1,
	--["plasitic-bar"] = 1,
	--["holmium-plate"] = 1,
	["holmium-ore"] = 0.5,
	["pentapod-egg"] = 100,
	--["lithium"] = 10,
}

local excluded_recipes = {
	"kovarex-enrichment-process",
	"nuclear-fuel-reprocessing",
	"pentapod-egg",
	"fish-breeding",
	"thruster-fusion-plasma", -- blocks fluoroketone-hot
	
	-- cyclic recipes from Aquilo Science Juggling
	"cryogenic-supercomputing-applied-electromagnetics",
	"cryogenic-supercomputing-applied-cryogenics",
	"cryogenic-supercomputing-space-agriculture",
	"cryogenic-supercomputing-space-production",
	"cryogenic-supercomputing-space-defense",
	"cryogenic-supercomputing-innovative-materials",
	"cryogenic-supercomputing-enhanced-cultivation",
	"cryogenic-supercomputing-extreme-lifeforms",
	
	-- cyclic recipes from Quantum Lab
	"quantum-cube-purification",
	
	-- debug recipes
	shared.mod_prefix .. "normal-debug",
	shared.mod_prefix .. "uncommon-debug",
	shared.mod_prefix .. "rare-debug",
	shared.mod_prefix .. "epic-debug",
	shared.mod_prefix .. "legendary-debug",
	shared.mod_prefix .. "upgrade-item-uncommon-debug",
	shared.mod_prefix .. "upgrade-item-rare-debug",
	shared.mod_prefix .. "upgrade-item-epic-debug",
	shared.mod_prefix .. "upgrade-item-legendary-debug",
}

local excluded_recipe_categories = {
	"refining", -- from "Promethium is Quality"
	"recycling-or-hand-crafting",
	"recycling",
}

local recipe_category_multiplier = {
	["smelting"] = 2
}

function item_complexity.make_complexity_data(generator_multiplier, fluid_only_multiplier, loot_health_multiplier)
	return {
		item = table.deepcopy(preset_item_complexity), -- item_name: complexity
		recipes_visited = {}, -- recipe_name
		items_available = {}, -- item_name: {{type: ("recipe"|"spoiling"|"burning"), recipe: recipe_prototype, has_all_complexity: bool},}
		--num_last_available = nil,
		generator_multiplier = generator_multiplier or 1,
		fluid_only_multiplier = fluid_only_multiplier or 1,
		loot_health_multiplier = loot_health_multiplier or 1/100,
	}
end

function item_complexity.is_basic_recipe(recipe)
	return recipe.results ~= nil
		--and recipe.ingredients ~= nil -- generator recipes allowed
		--and recipe.energy_required ~= nil -- default energy_required = 0.5
end

function item_complexity.is_valid_recipe(recipe)
	if not item_complexity.is_basic_recipe(recipe) then
		shared.log_debug("Recipe ".. recipe.name.." invalid: not basic.")
		return false
	end
	
	-- explicitly excluded recipes
	if shared.array_contains(excluded_recipes, recipe.name) then
		shared.log_debug("Recipe ".. recipe.name.." invalid: excluded.")
		return false
	end
	if shared.array_contains(excluded_recipe_categories, recipe.category) then
		shared.log_debug("Recipe ".. recipe.name.." invalid: category excluded.")
		return false
	end
	
	-- recipe with no item input (generators, item from fluid)
	-- if not shared.array_contains_with_key(recipe.ingredients, "type", "item") then
		-- return false
	-- end
	
	-- recipe with no item or fluid output
	if not (shared.array_contains_with_key(recipe.results, "type", "item") or shared.array_contains_with_key(recipe.results, "type", "fluid")) then
		shared.log_debug("Recipe ".. recipe.name.." invalid: no item/fluid output.")
		return false
	end
	
	-- cyclic recipes (any output item is also input) (e.g. fish breeding, u enrichment, refining)
	-- for _,result in ipairs(recipe.results) do
		-- if result.type == "item" then
			-- if shared.array_contains_with_key(recipe.ingredients, "name", result.name) then
				-- shared.log_debug("Recipe ".. recipe.name.." invalid: cyclic.")
				-- return false
			-- end
		-- end
	-- end
	
	return true
end

function item_complexity.get_ingredients(recipe, types)
	if recipe.ingredients==nil then return {} end -- generator recipe
	types = types or {"item", "fluid"}
	local ingredients = {}
	for i = 1, #recipe.ingredients do
		if shared.array_contains(types, recipe.ingredients[i].type) then
			table.insert(ingredients, recipe.ingredients[i])
		end
	end
	return ingredients
end

function item_complexity.get_results(recipe, types)
	types = types or {"item", "fluid"}
	local results = {}
	for i = 1, #recipe.results do
		if shared.array_contains(types, recipe.results[i].type) then
			table.insert(results, recipe.results[i])
		end
	end
	return results
end

function item_complexity.add_item_recipe(cdata, item_name, recipe_data)
	if cdata.item[item_name] ~= nil then
		error("Tried to add recipe for item with complexity set: "..item_name.." = "..cdata.item[item_name])
	end
	if cdata.items_available[item_name]==nil then
		cdata.items_available[item_name] = {}
	end
	table.insert(cdata.items_available[item_name], recipe_data)
end

function item_complexity.can_process_recipe(cdata, recipe)
	-- all item inputs have defined complexity
	local ingredients = item_complexity.get_ingredients(recipe)
	for _, ingredient in ipairs(ingredients) do
		if cdata.item[ingredient.name] == nil then
			return false
		end
	end
	return true
end

function item_complexity.can_process_item(cdata, item_name)
	if cdata.item[item_name]~=nil then
		error("Tried to process item with complexity set: "..item_name.." = "..cdata.item[item_name])
	end
	if cdata.items_available[item_name]==nil then
		error("Item "..item_name.." has not been registered.")
	end
	if shared.get_table_length(cdata.items_available[item_name])<1 then
		return false
	end
	
	for _, recipe_data in ipairs(cdata.items_available[item_name]) do
		if recipe_data.has_all_complexity==false then
			if item_complexity.can_process_recipe(cdata, recipe_data.recipe) then
				recipe_data.has_all_complexity = true
			else
				return false
			end
		end
	end
	return true
end

function item_complexity.set_item_complexity(cdata, item_name, complexity)
	complexity = math.max(complexity, min_complexity)
	shared.log_debug("Set complexity of "..item_name..": "..complexity)
	if cdata.item[item_name] ~= nil then
		cdata.item[item_name] = math.min(complexity, cdata.item[item_name])
	else
		cdata.item[item_name] = complexity
	end
end

function item_complexity.set_from_products(cdata, products, complexity)
	for i=1,#products do
		local product = products[i]
		if product.type == "item" or product.type == "fluid" then
			local item_prototype = complexity_util.get_prototype(product.name, product.type)
			if item_prototype ~= nil then
				item_complexity.set_item_complexity(cdata, item_prototype.name, complexity_util.compute_complexity_totaled(complexity, product))
			end
		end
	end
end

function item_complexity.set_from_minable(cdata, resource_prototype, multiplier)
	if resource_prototype.minable == nil then return end
	local complexity = resource_prototype.minable.mining_time * multiplier
	
	local products = resource_prototype.minable.results or {{type = "item", name = resource_prototype.minable.result, amount = resource_prototype.minable.count or 1}}
	item_complexity.set_from_products(cdata, products, complexity)
end

function item_complexity.set_from_fluid_tile(cdata, tile_prototype, complexity)
	if tile_prototype.fluid == nil then return end
	
	local products = {{type = "fluid", name = tile_prototype.fluid, amount = 1}}
	item_complexity.set_from_products(cdata, products, complexity)
end

function item_complexity.get_from_recipe(cdata, recipe, multiplier)
	if recipe == nil then return end
	local complexity = (recipe.energy_required or 0.5) * multiplier
	--table.insert(cdata.recipes_visited, recipe.name)
	--shared.log_debug("Set complexity from recipe "..recipe.name..": "..complexity)
	--item_complexity.set_from_products(cdata, recipe.results, complexity)
	return complexity
end

function item_complexity.is_generator_recipe(recipe)
	local has_no_ingredients = recipe.ingredients == nil or #recipe.ingredients == 0
	local has_results = recipe.results ~= nil and #recipe.results > 0
	return has_no_ingredients and has_results
end

function item_complexity.get_generator_complexity(cdata, recipe)
	-- for _, recipe in pairs(recipes) do
		-- local has_no_ingredients = recipe.ingredients == nil or #recipe.ingredients == 0
		-- local has_results = recipe.results ~= nil and #recipe.results > 0
		-- if has_no_ingredients and has_results and recipe.energy_required ~= nil then
			-- item_complexity.set_from_recipe(cdata, recipe, multiplier)
		-- end
	-- end
	return item_complexity.get_from_recipe(cdata, recipe, cdata.generator_multiplier)
end

-- function item_complexity.is_fluid_only_recipe(recipe)
	-- return (item_complexity.is_basic_recipe(recipe)
		-- and #item_complexity.get_ingredients(recipe, "item") == 0
		-- and #item_complexity.get_ingredients(recipe, "fluid") > 0)
-- end

-- function item_complexity.get_fluid_only_complexity(cdata, recipe)
	-- -- for _, recipe in pairs(recipes) do
		-- -- if
			-- -- item_complexity.is_basic_recipe(recipe)
			-- -- and #item_complexity.get_ingredients(recipe, "item") == 0
			-- -- and #item_complexity.get_ingredients(recipe, "fluid") > 0
		-- -- then
			-- -- item_complexity.set_from_recipe(cdata, recipe, multiplier)
		-- -- end
	-- -- end
	-- return item_complexity.get_from_recipe(cdata, recipe, cdata.fluid_only_multiplier)
-- end

function item_complexity.get_unknown_ingredients(cdata)
	local unknown_items = {}
	for item_name, recipes in pairs(cdata.items_available) do
		for _, recipe_data in ipairs(recipes) do
			if recipe_data.recipe.ingredients~=nil then
				for _, ingredient in ipairs(recipe_data.recipe.ingredients) do
					if cdata.item[ingredient.name]==nil and cdata.items_available[ingredient.name]==nil then
						unknown_items[ingredient.name]=true
					end
				end
			end
		end
	end
	
	local unkown_ingredients = {}
	for item_name, _ in pairs(unknown_items) do table.insert(unkown_ingredients, item_name) end
	table.sort(unkown_ingredients)
	
	return unkown_ingredients
end

function item_complexity.remove_recipies_with_unknown_ingredients_loop(cdata)
	for item_name, recipes_data in pairs(cdata.items_available) do
		for i=#recipes_data,1,-1 do
			local unkown_ingredient
			local ingredients = item_complexity.get_ingredients(recipes_data[i].recipe)
			for _, ingredient in ipairs(ingredients) do
				if cdata.item[ingredient.name]==nil and cdata.items_available[ingredient.name]==nil then
					shared.log_debug("Found unknown ingredient "..ingredient.name)
					unkown_ingredient = ingredient.name
					break
				end
			end
			if unkown_ingredient~=nil then
				shared.log_debug("Removed recipe "..recipes_data[i].recipe.name.." with unknown ingredient "..unkown_ingredient.." from item "..item_name..".")
				table.remove(recipes_data, i)
			end
		end
	end
end

function item_complexity.remove_items_without_recipes(cdata)
	for item_name, recipe_data in pairs(cdata.items_available) do
		if #recipe_data==0 then
			shared.log_debug("Removed item "..item_name.." with no remaining recipes.")
			cdata.items_available[item_name] = nil
		end
	end
end

function item_complexity.remove_recipies_with_unknown_ingredients(cdata)
	local last_num_items_available = shared.get_table_length(cdata.items_available)
	while true do
		item_complexity.remove_recipies_with_unknown_ingredients_loop(cdata)
		
		item_complexity.remove_items_without_recipes(cdata)
		
		if last_num_items_available == shared.get_table_length(cdata.items_available) then
			break
		end
		last_num_items_available = shared.get_table_length(cdata.items_available)
	end
end

function item_complexity.find_path_to_resolvable(cdata, recipe, recipes_visited, ingredients_visited)
	recipes_visited = recipes_visited or {}
	ingredients_visited = ingredients_visited or {}
	
	if recipes_visited[recipe.name]~=nil then
		--if log_steps then log(depth_string .. "Recipe already visited: "..tostring(recipes_visited[recipe.name])) end
		return false
	end
	
	recipes_visited[recipe.name] = true -- just for quick checking
	
	local ingredients = item_complexity.get_ingredients(recipe)
	--if #ingredients==0 then return false end
	
	-- generator recipes are always resolvable
	local all_ingredients_resolvable = true
	
	for _, ingredient in ipairs(ingredients) do
		
		if cdata.item[ingredient.name]==nil then -- item not already resolved
			if ingredients_visited[ingredient.name]~=nil then
				all_ingredients_resolvable = false
				break
			end
			
			ingredients_visited[ingredient.name] = true
			
			local any_recipe_resolvable = false -- = is_ingredient_resolvable
			if cdata.items_available[ingredient.name] ~= nil then
				for _, recipe_data in ipairs(cdata.items_available[ingredient.name]) do
					
					-- end early if the recipe is resolved
					if recipe_data.has_all_complexity then
						any_recipe_resolvable = true
						break
					end
					
					if item_complexity.find_path_to_resolvable(cdata, recipe_data.recipe, recipes_visited, ingredients_visited) then
						any_recipe_resolvable = true
						break
					end
				end
			end
			if not any_recipe_resolvable then
				all_ingredients_resolvable = false
				break
			end
		end
	end
	return all_ingredients_resolvable
end

function item_complexity.is_cyclic_ingredient(cdata, ingredient, item_name, recipes_visited, ingredients_visited, log_steps, depth)
	ingredients_visited = ingredients_visited or {}
	depth = depth or 1
	local depth_string = string.rep("  ", depth)
	
	if ingredients_visited[ingredient.name]~=nil then
		if log_steps then log(depth_string .. "Ingredient "..ingredient.name.." already visited: "..tostring(ingredients_visited[ingredient.name])) end
		return ingredients_visited[ingredient.name]
	end
	
	ingredients_visited[ingredient.name] = true
	
	if cdata.items_available[ingredient.name] ~= nil then
		if log_steps then log(depth_string .. "Checking ingredient "..ingredient.name.."("..#cdata.items_available[ingredient.name]..")") end
		for _, recipe_data in ipairs(cdata.items_available[ingredient.name]) do
			
			-- can end early if the recipe is resolved
			if recipe_data.has_all_complexity then
				ingredients_visited[ingredient.name] = false
				break
			end
			
			if not item_complexity.is_cyclic_recipe(cdata, recipe_data.recipe, item_name, recipes_visited, ingredients_visited, log_steps, depth + 1) then
				ingredients_visited[ingredient.name] = false
				break
			end
		end
	else
		if log_steps then log(depth_string .. "Resolved or unknown ingredient "..ingredient.name) end
		ingredients_visited[ingredient.name] = false
	end
	
	-- ALL recipes require item_name
	return ingredients_visited[ingredient.name]
end

function item_complexity.is_cyclic_recipe(cdata, recipe, item_name, recipes_visited, ingredients_visited, log_steps, depth)
	recipes_visited = recipes_visited or {}
	depth = depth or 1
	local depth_string = string.rep("  ", depth)
	
	if log_steps then log(depth_string .. "Checking recipe "..recipe.name) end
	if recipes_visited[recipe.name]~=nil then
		if log_steps then log(depth_string .. "Recipe already visited: "..tostring(recipes_visited[recipe.name])) end
		return recipes_visited[recipe.name]
	end
	
	recipes_visited[recipe.name] = false
	
	local ingredients = item_complexity.get_ingredients(recipe)
	--if #ingredients==0 then return false end
	
	for _, ingredient in ipairs(ingredients) do
		if item_name == ingredient.name then
			shared.log_debug(depth_string .. "Recipe "..recipe.name.." is cyclic for "..item_name..".")
			--return true
			recipes_visited[recipe.name] = true
			break
		end
		
		if item_complexity.is_cyclic_ingredient(cdata, ingredient, item_name, recipes_visited, ingredients_visited, log_steps, depth + 1) then
			-- there EXISTS an ingredient that requires item_name
			--return true
			recipes_visited[recipe.name] = true
			break
		end
	end
	
	return recipes_visited[recipe.name]
end

-- find cyclic recipe chains with a clear break point
function item_complexity.remove_cyclic_recipes(cdata)
	for item_name, recipes_data in pairs(cdata.items_available) do
		if #recipes_data>1 then
			local resovable_recipes = {}
			for _, recipe_data in ipairs(recipes_data) do
				if item_complexity.find_path_to_resolvable(cdata, recipe_data.recipe, {}, {[item_name]=true}) then
					table.insert(resovable_recipes, recipe_data.recipe.name)
					resovable_recipes[recipe_data.recipe.name] = #resovable_recipes
				end
			end
			--local cyclic_recipe_indices = {}
			for i=#recipes_data,1,-1 do
				local is_resolvable = shared.array_contains(resovable_recipes, recipes_data[i].recipe.name)
				shared.log_debug("Checking "..item_name..": "..recipes_data[i].recipe.name.." ("..#recipes_data.." recipes, "..#resovable_recipes.." resolvable ["..tostring(is_resolvable).."]).")
				if #recipes_data>1
					and (#resovable_recipes>1 or not shared.array_contains(resovable_recipes, recipes_data[i].recipe.name))
					and item_complexity.is_cyclic_recipe(cdata, recipes_data[i].recipe, item_name, {}, {}, false)
				then
					if shared.debug then item_complexity.is_cyclic_recipe(cdata, recipes_data[i].recipe, item_name, {}, {}, true) end
					shared.log_debug("Removed cyclic recipe "..recipes_data[i].recipe.name.." from item "..item_name..".")
					if shared.array_contains(resovable_recipes, recipes_data[i].recipe.name) then
						table.remove(resovable_recipes, resovable_recipes[recipes_data[i].recipe.name])
					end
					table.remove(recipes_data, i)
				end
			end
		end
	end
end

function item_complexity.find_any_cycle(cdata, recipe, item_name, recipes_visited)
	recipes_visited = recipes_visited or {}
	
	if recipes_visited[recipe.name]~=nil then
		--if log_steps then log(depth_string .. "Recipe already visited: "..tostring(recipes_visited[recipe.name])) end
		return false
	end
	
	recipes_visited[recipe.name] = true -- just for quick checking
	
	local ingredients = item_complexity.get_ingredients(recipe)
	--if #ingredients==0 then return false end
	
	for _, ingredient in ipairs(ingredients) do
		if item_name == ingredient.name then
			shared.log_debug("Recipe "..recipe.name.." is cyclic for "..item_name..".")
			return true
		end
		
		if cdata.items_available[ingredient.name] ~= nil then
			for _, recipe_data in ipairs(cdata.items_available[ingredient.name]) do
				
				-- end early if the recipe is resolved
				-- if recipe_data.has_all_complexity then
					-- return false
				-- end
				
				if item_complexity.find_any_cycle(cdata, recipe_data.recipe, item_name, recipes_visited) then
					return true
				end
			end
		end
	end
	return false
end

-- find cyclic recipe chains and just break them somewhere, but never remove the last recipe
function item_complexity.force_break_remaining_cycles(cdata)
	for item_name, recipes_data in pairs(cdata.items_available) do
		if #recipes_data>1 then
			local resovable_recipes = {}
			for _, recipe_data in ipairs(recipes_data) do
				if item_complexity.find_path_to_resolvable(cdata, recipe_data.recipe, {}, {[item_name]=true}) then
					table.insert(resovable_recipes, recipe_data.recipe.name)
					resovable_recipes[recipe_data.recipe.name] = #resovable_recipes
				end
			end
			
			--local cyclic_recipe_indices = {}
			for i=#recipes_data,1,-1 do
				shared.log_debug("Checking "..item_name..": "..recipes_data[i].recipe.name..".")
				if #recipes_data>1
					and (#resovable_recipes>1 or not shared.array_contains(resovable_recipes, recipes_data[i].recipe.name))
					--and recipe_removal_candidates[recipes_data[i].recipe.name]==true
					and item_complexity.find_any_cycle(cdata, recipes_data[i].recipe, item_name)
				then
					shared.log_debug("Removed cyclic recipe "..recipes_data[i].recipe.name.." from item "..item_name..".")
					if shared.array_contains(resovable_recipes, recipes_data[i].recipe.name) then
						table.remove(resovable_recipes, resovable_recipes[recipes_data[i].recipe.name])
					end
					table.remove(recipes_data, i)
				end
			end
		end
	end
end

function item_complexity.collect_valid_recipes(cdata, recipes)
	local num_valid_recipes = 0
	for _,recipe in pairs(recipes) do
		if item_complexity.is_valid_recipe(recipe) and not shared.array_contains(cdata.recipes_visited, recipe.name) then
			local recipe_data = {recipe = recipe, has_all_complexity = item_complexity.can_process_recipe(cdata, recipe)}
			for _,product in ipairs(item_complexity.get_results(recipe)) do
				if cdata.item[product.name] == nil
					and not shared.array_contains_with_key(item_complexity.get_ingredients(recipe), "name", product.name) -- directly cyclic for this product, e.g. cultivation recipes
				then
					item_complexity.add_item_recipe(cdata, product.name, recipe_data)
				end
			end
			table.insert(cdata.recipes_visited, recipe.name)
			num_valid_recipes = num_valid_recipes + 1
		end
	end
	--cdata.num_last_available = #cdata.recipes_available
	shared.log_debug("Collected " .. num_valid_recipes ..  " valid recipes from " .. shared.get_table_length(recipes) .. " total.")
end

function item_complexity.collect_spoiling_recipes(cdata, items, exclude_existing_items)
	-- make pseudo recipes for spoiling results
	-- exclude_existing_items: only consider spoiling results if there is no other recipe for the item
	local num_spoiling_recipes = 0
	
	for _, item in pairs(items) do
		if not (item.spoil_result==nil or item.spoil_result=="") then 
			local product_name = item.spoil_result
			local recipe_name = shared.mod_prefix .. item.name .. "-spoiling"
			if cdata.item[product_name]==nil
				and (not exclude_existing_items or cdata.items_available[product_name]==nil)
				and not shared.array_contains(cdata.recipes_visited, recipe_name)
			then
				local spoil_recipe = {
					name = recipe_name,
					ingredients = {{type = "item", name = item.name, amount = 1},},
					results = {{type = "item", name = product_name, amount = 1},},
				}
				local spoil_recipe_data = {recipe = spoil_recipe, has_all_complexity = item_complexity.can_process_recipe(cdata, spoil_recipe)}
				
				item_complexity.add_item_recipe(cdata, product_name, spoil_recipe_data)
				table.insert(cdata.recipes_visited, recipe_name)
				num_spoiling_recipes = num_spoiling_recipes + 1
			end
		end
	end
	
	shared.log_debug("Generated " .. num_spoiling_recipes ..  " spoiling recipes from " .. shared.get_table_length(items) .. " items.")
end

function item_complexity.collect_burning_recipes(cdata, items, exclude_existing_items)
	-- make pseudo recipes for burning results
	-- exclude_existing_items: only consider burning results if there is no other recipe for the item
	local num_burning_recipes = 0
	
	for _, item in pairs(items) do
		if not (item.burnt_result==nil or item.burnt_result=="") then
			local product_name = item.burnt_result
			local recipe_name = shared.mod_prefix .. item.name .. "-burning"
			if cdata.item[product_name]==nil
				and (not exclude_existing_items or cdata.items_available[product_name]==nil)
				and not shared.array_contains(cdata.recipes_visited, recipe_name)
			then
				local burnt_recipe = {
					name = recipe_name,
					ingredients = {{type = "item", name = item.name, amount = 1},},
					results = {{type = "item", name = product_name, amount = 1},},
				}
				local burnt_recipe_data = {recipe = burnt_recipe, has_all_complexity = item_complexity.can_process_recipe(cdata, burnt_recipe)}
				
				item_complexity.add_item_recipe(cdata, product_name, burnt_recipe_data)
				table.insert(cdata.recipes_visited, recipe_name)
				num_burning_recipes = num_burning_recipes + 1
			end
		end
	end
	
	shared.log_debug("Generated " .. num_burning_recipes ..  " burning recipes from " .. shared.get_table_length(items) .. " items.")
end

function item_complexity.collect_loot_recipes(cdata, entities, exclude_existing_items)
	-- make pseudo (generator) recipes for loot results
	-- complexity scales with entity max health via energy_required
	-- exclude_existing_items: only consider burning results if there is no other recipe for the item
	local num_loot_recipes = 0
	
	for _, entity in pairs(entities) do
		if not (entity.loot==nil or #entity.loot==0) then
			local recipe_name = shared.mod_prefix .. entity.name .. "-loot"
			local loot_recipe = {
				name = recipe_name,
				energy_required = (entity.max_health or 10) * cdata.loot_health_multiplier,
				results = {}
			}
			
			for _, loot_item in ipairs(entity.loot) do
				table.insert(loot_recipe.results,
					{
						type = "item",
						name = loot_item.item,
						amount_min = loot_item.count_min or 1,
						amount_max = loot_item.count_max or 1,
						probability = loot_item.probability or 1,
					}
				)
			end
			
			local recipe_data = {recipe = loot_recipe, has_all_complexity = item_complexity.can_process_recipe(cdata, loot_recipe)}
			
			for _, product in ipairs(loot_recipe.results) do
				if cdata.item[product.name]==nil
					and (not exclude_existing_items or cdata.items_available[product.name]==nil)
					and not shared.array_contains(cdata.recipes_visited, recipe_name)
				then
					
					item_complexity.add_item_recipe(cdata, product.name, recipe_data)
				end
			end
			table.insert(cdata.recipes_visited, recipe_name)
			num_loot_recipes = num_loot_recipes + 1
		end
	end
	
	shared.log_debug("Generated " .. num_loot_recipes ..  " loot recipes from " .. shared.get_table_length(entities) .. " entities.")
end

function item_complexity.process_item(cdata, item_name)
	if cdata.item[item_name]~=nil then
		error("Item "..item_name.." already has complexity set.")
	end
	-- this assumes that all recipes' ingredients already have defined complexity, from can_process_item before
	local min_complexity
	local min_complexity_recipe
	for _, recipe_data in ipairs(cdata.items_available[item_name]) do
		local recipe = recipe_data.recipe
		
		local multiplier = 1
		if recipe_category_multiplier[recipe.category] ~= nil then
			multiplier = multiplier * recipe_category_multiplier[recipe.category]
		end
		
		local results = item_complexity.get_results(recipe)
		local item_result
		for _,result in ipairs(results) do
			if result.name == item_name then
				item_result = result
				break
			end
		end
		
		local complexity
		if item_complexity.is_generator_recipe(recipe) then
			complexity = item_complexity.get_generator_complexity(cdata, recipe)
			complexity = complexity_util.compute_complexity_totaled(complexity, item_result)
		-- elseif item_complexity.is_fluid_only_recipe(recipe) then
			-- complexity = item_complexity.get_fluid_only_complexity(cdata, recipe)
			-- complexity = complexity_util.compute_complexity_totaled(complexity, item_result)
		else
			local ingredients = item_complexity.get_ingredients(recipe)
			
			complexity = complexity_util.compute_complexity(cdata, ingredients, item_result) * multiplier
		end
		
		if min_complexity==nil or complexity<min_complexity then
			min_complexity = complexity
			min_complexity_recipe = recipe.name
		end
	end
	
	if min_complexity ~= nil then 
		shared.log_debug("Setting "..item_name.." complexity to "..min_complexity.." from recipe "..min_complexity_recipe..".")
		item_complexity.set_item_complexity(cdata, item_name, min_complexity)
	else
		shared.log_debug("Item "..item_name.." has no recipes.")
	end
end

function item_complexity.process_items(cdata)
	shared.log_debug("Processing "..shared.get_table_length(cdata.items_available).." available items.")
	local i = 0
	while true do
		i = i + 1
		
		local processed_items = {}
		for item_name, r in pairs(cdata.items_available) do
			if item_complexity.can_process_item(cdata, item_name) then
				item_complexity.process_item(cdata, item_name)
				table.insert(processed_items, item_name)
			end
		end
		
		for _,item_name in ipairs(processed_items) do
			cdata.items_available[item_name] = nil
		end
		
		shared.log_debug("Iteration "..i.." processed "..#processed_items.." items.")
		if #processed_items == 0 then
			break
		end
		--cdata.num_last_available = #cdata.recipes_available
	end
	
	shared.log_debug("Finished processing items after "..i.." iterations with "..shared.get_table_length(cdata.items_available).." unused items.")
end

return item_complexity