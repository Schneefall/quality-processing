-- adapted from promethium-quality by Luka967 https://github.com/Luka967/promethium-quality

local processing_utility = {}
local quality_icon_scale = 0.4

-- Ripped out of recycling recipe generation
-- Thank you factorio devs >.<
--- @param name string
--- @param base_prototype string
--- @return data.ItemPrototype|nil
--- @return string|nil
function processing_utility.get_prototype(name, base_prototype)
	for type_name in pairs(defines.prototypes[base_prototype]) do
		local prototypes = data.raw[type_name]
		if prototypes and prototypes[name] then
			return prototypes[name], type_name
		end
	end
	return nil, nil
end
function processing_utility.generate_processing_recipe_icon(item, quality)
	local expected_icon_size = defines.default_icon_size
	local icons = table.deepcopy(item.icons or {{icon = item.icon, icon_size = item.icon_size or defines.default_icon_size}})
	for _, icon in ipairs(icons) do
		icon.scale = (0.5 * expected_icon_size / (item.icon_size or defines.default_icon_size)) * 0.8
		if icon.shift ~= nil then
			icon.shift = util.mul_shift(icon.shift, 0.8)
		end
	end
	local icon_size = data.raw.quality[quality].icon_size or defines.default_icon_size
	local icon_scale = (0.5 * expected_icon_size / icon_size) * quality_icon_scale
	local icon_shift = (1 - quality_icon_scale) * 0.25 * expected_icon_size
	table.insert(icons, {
		icon = data.raw.quality[quality].icon,
		scale = icon_scale,
		shift = {icon_shift,-icon_shift},
		icon_size = icon_size,
	})
	return icons
end
function processing_utility.generate_processing_recipe_group_icon(item_group)
	local expected_icon_size = 128
	local icons = table.deepcopy(item_group.icons or {{icon = item_group.icon, icon_size = item_group.icon_size or defines.default_icon_size}})
	for _, icon in ipairs(icons) do
		icon.scale = (0.5 * expected_icon_size / (item_group.icon_size or defines.default_icon_size)) * 0.8
		if icon.shift ~= nil then
			icon.shift = util.mul_shift(icon.shift, 0.8)
		end
	end
	
	local icon_size = 64
	local icon_scale = (0.5 * expected_icon_size / icon_size) * quality_icon_scale * 0.6
	local icon_shift = (1 - quality_icon_scale) * 0.25 * expected_icon_size
	table.insert(icons, {
		icon = "__core__/graphics/icons/any-quality.png",
		scale = icon_scale,
		shift = {icon_shift,-icon_shift},
		icon_size = icon_size,
	})
	return icons
end
function processing_utility.get_item_localised_name(name)
	local item = processing_utility.get_prototype(name, "item")
	if not item then return end
	if item.localised_name then
		return item.localised_name
	end
	local prototype
	local type_name = "item"
	if item.place_result then
		prototype = processing_utility.get_prototype(item.place_result, "entity")
		type_name = "entity"
	elseif item.place_as_equipment_result then
		prototype = processing_utility.get_prototype(item.place_as_equipment_result, "equipment")
		type_name = "equipment"
	elseif item.place_as_tile then
		-- Tiles with variations don't have a localised name
		local tile_prototype = data.raw.tile[item.place_as_tile.result]
		if tile_prototype and tile_prototype.localised_name then
			prototype = tile_prototype
			type_name = "tile"
		end
	end
	return prototype and prototype.localised_name or {type_name.."-name."..name}
end

--- @param total number
--- @param product data.ItemProductPrototype
function processing_utility.compute_complexity_totaled(total, product)
	local product_min = product.amount or product.amount_min
	local product_max = product.amount or product.amount_max
	local product_avg = (product_min + product_max) / 2 * (product.probability or 1)
	return total / product_avg
end
--- @param data ItemComplexity
--- @param ingredients data.IngredientPrototype[]
--- @param product data.ItemProductPrototype
function processing_utility.compute_complexity(cdata, ingredients, product)
	local total = 0
	for i = 1, #ingredients do
		local ingredient = ingredients[i]
		--if ingredient.type == "item" then
			total = total + ingredient.amount * cdata.item[ingredient.name]
		--end
	end
	return processing_utility.compute_complexity_totaled(total, product)
end

return processing_utility
