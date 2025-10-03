--require("prototype.processing_recipes")
require("prototype.recipe-updates")

local shared = require("shared")
local processing_utility = require("prototype.processing_utility")


if settings.startup[shared.mod_prefix .. "hide-quality-modules"].value then
	local quality_recipe_names = {
		"quality-module", "quality-module-2", "quality-module-3",
		"quality-module-recycling", "quality-module-recycling-2", "quality-module-recycling-3"
	}
	for _,name in ipairs(quality_recipe_names) do
		if data.raw.recipe[name] then data.raw.recipe[name].hidden = true end
	end
	
	local quality_module_names = {"quality-module", "quality-module-2", "quality-module-3"}
	for _,name in ipairs(quality_recipe_names) do
		local item = processing_utility.get_prototype(name, "item")
		if item then
			item.hidden = true
			-- also hide the quality module upgrade recipes
			for _,quality in ipairs(shared.qualities) do
				local recipe_name = name .. shared.mod_suffix_short .. quality
				if data.raw.recipe[recipe_name] then data.raw.recipe[recipe_name].hidden = true end
			end
		end
	end
	
	local quality_tech_names = {"quality-module", "quality-module-2", "quality-module-3"}
	for _,name in ipairs(quality_tech_names) do
		local tech = data.raw.technology[name]
		if tech then
			tech.icon = "__core__/graphics/icons/any-quality.png"
			tech.icon_size = 64
			tech.localised_name = {"technology-name." .. shared.mod_prefix .. name}
			tech.localised_description = {"technology-description." .. shared.mod_prefix .. name}
		end
	end
end