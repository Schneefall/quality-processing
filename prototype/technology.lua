local shared = require("shared")
local graphics = require("prototype.entity.pictures")
local parsed_settings = require("__quality-processing__.settings_parser")

local quality_icon_scale = 0.4
local expected_icon_size = 256
local quality_icon_shift = (1 - quality_icon_scale) * 0.25 * expected_icon_size
local quality_icon_scale = (0.5 * expected_icon_size / 64) * quality_icon_scale

data:extend({
	{
		type = "technology",
		name = shared.mod_prefix.."normal",
		icons = {
			{
				icon = graphics[parsed_settings.graphics_settings["normal"]].get_icon_128(),
				icon_size = 128,
			},
			{
				icon = data.raw.quality["normal"].icon,
				icon_size = 64,
				scale = quality_icon_scale,
				shift = {-quality_icon_shift, quality_icon_shift},
			}
		},
		effects = {
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "normal"
			},
		},
		prerequisites = {
			"quality-module",
			"sulfur-processing"
		},
		unit = {
			count = 250,
			time = 30,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
			}
		}
	},
	{
		type = "technology",
		name = shared.mod_prefix.."uncommon",
		icons = {
			{
				icon = graphics[parsed_settings.graphics_settings["uncommon"]].get_icon_128(),
				icon_size = 128,
			},
			{
				icon = data.raw.quality["uncommon"].icon,
				icon_size = 64,
				scale = quality_icon_scale,
				shift = {-quality_icon_shift, quality_icon_shift},
			}
		},
		effects = {
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "uncommon"
			},
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "upgrade-item-uncommon"
			},
		},
		prerequisites = {
			shared.mod_prefix.."normal",
			"electric-engine",
		},
		unit = {
			count = 250,
			time = 30,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
			}
		}
	},
	{
		type = "technology",
		name = shared.mod_prefix.."rare",
		icons = {
			{
				--icon = shared.mod_directory.."/graphics/icons/calibrator-icon-128.png",
				icon = graphics[parsed_settings.graphics_settings["rare"]].get_icon_128(),
				icon_size = 128,
			},
			{
				icon = data.raw.quality["rare"].icon,
				icon_size = 64,
				scale = quality_icon_scale,
				shift = {-quality_icon_shift, quality_icon_shift},
			}
		},
		effects = {
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "rare"
			},
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "upgrade-item-rare"
			},
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "upgrade-item-rare-1"
			},
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "upgrade-item-rare-2"
			},
		},
		prerequisites = {
			shared.mod_prefix.."uncommon",
			"kovarex-enrichment-process",
			"quality-module-2",
		},
		unit = {
			count = 500,
			time = 30,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"space-science-pack", 1},
			}
		}
	},
	{
		type = "technology",
		name = shared.mod_prefix.."epic",
		icons = {
			{
				icon = graphics[parsed_settings.graphics_settings["epic"]].get_icon_128(),
				icon_size = 128,
			},
			{
				icon = data.raw.quality["epic"].icon,
				icon_size = 64,
				scale = quality_icon_scale,
				shift = {-quality_icon_shift, quality_icon_shift},
			}
		},
		effects = {
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "epic"
			},
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "upgrade-item-epic"
			},
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "upgrade-item-epic-1"
			},
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "upgrade-item-epic-2"
			},
			{
				type = "unlock-recipe",
				recipe = shared.mod_prefix .. "upgrade-item-epic-3"
			},
		},
		prerequisites = {
			shared.mod_prefix.."rare",
			"epic-quality",
			"carbon-fiber",
			"metallurgic-science-pack",
			"quality-module-3",
		},
		unit = {
			count = 1000,
			time = 60,
			ingredients = {
				{"automation-science-pack", 1},
				{"logistic-science-pack", 1},
				{"chemical-science-pack", 1},
				{"utility-science-pack", 1},
				{"space-science-pack", 1},
				{"agricultural-science-pack", 1},
				{"metallurgic-science-pack", 1},
				{"electromagnetic-science-pack", 1},
			}
		}
	},
	
})

local qp_legendary = {
	type = "technology",
	name = shared.mod_prefix.."legendary",
	icons = {
		{
			icon = graphics[parsed_settings.graphics_settings["legendary"]].get_icon_128(),
			icon_size = 128,
		},
		{
			icon = data.raw.quality["legendary"].icon,
			icon_size = 64,
			scale = quality_icon_scale,
			shift = {-quality_icon_shift, quality_icon_shift},
		}
	},
	effects = {
		{
			type = "unlock-recipe",
			recipe = shared.mod_prefix .. "legendary"
		},
		{
			type = "unlock-recipe",
			recipe = shared.mod_prefix .. "upgrade-item-legendary"
		},
		{
			type = "unlock-recipe",
			recipe = shared.mod_prefix .. "upgrade-item-legendary-1"
		},
		{
			type = "unlock-recipe",
			recipe = shared.mod_prefix .. "upgrade-item-legendary-2"
		},
		{
			type = "unlock-recipe",
			recipe = shared.mod_prefix .. "upgrade-item-legendary-2-1"
		},
		{
			type = "unlock-recipe",
			recipe = shared.mod_prefix .. "upgrade-item-legendary-2-2"
		},
	},
	prerequisites = {
		shared.mod_prefix.."epic",
		"legendary-quality",
		--"promethium-science-pack",
	},
	unit = {
		count = 2500,
		time = 60,
		ingredients = {
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
			{"utility-science-pack", 1},
			{"production-science-pack", 1},
			{"space-science-pack", 1},
			{"agricultural-science-pack", 1},
			{"metallurgic-science-pack", 1},
			{"electromagnetic-science-pack", 1},
			{"cryogenic-science-pack", 1},
			--{"promethium-science-pack", 1},
		}
	}
}

if not parsed_settings.no_promethium then
	table.insert(qp_legendary.prerequisites, "promethium-science-pack")
	table.insert(qp_legendary.unit.ingredients, {"promethium-science-pack", 1})
end

data:extend({qp_legendary})