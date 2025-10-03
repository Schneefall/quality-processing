local shared = require("__quality-processing__.shared")

data:extend({
	{
		type = "item-group",
		name = shared.mod_name,
		order = "z-qp",
		--icon = data.raw.quality["legendary"].icon,
		--icon_size = 64
		icon = "__core__/graphics/icons/any-quality.png",
		icon_size = 64,
	},
	{
		type = "item-subgroup",
		name = shared.mod_prefix.."normal",
		group = shared.mod_name,
		order = "a"
	},
	{
		type = "item-subgroup",
		name = shared.mod_prefix.."uncommon",
		group = shared.mod_name,
		order = "b"
	},
	{
		type = "item-subgroup",
		name = shared.mod_prefix.."rare",
		group = shared.mod_name,
		order = "c"
	},
	{
		type = "item-subgroup",
		name = shared.mod_prefix.."epic",
		group = shared.mod_name,
		order = "d"
	},
	{
		type = "item-subgroup",
		name = shared.mod_prefix.."legendary",
		group = shared.mod_name,
		order = "e"
	},
})

require("prototype.item")
require("prototype.entity")
require("prototype.recipe")
require("prototype.technology")

for quality_name, _quality_data in pairs(data.raw.quality) do
	if settings.startup[quality_name .. "-custom-name"] and settings.startup[quality_name .. "-custom-name"].value then
		data.raw.quality[quality_name].localised_name = settings.startup[quality_name .. "-custom-name"].value
	end
end