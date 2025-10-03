local item_sounds = require("__base__.prototypes.item_sounds")
local shared = require("__quality-processing__.shared")
local graphics = require("prototype.entity.pictures")
local parsed_settings = require("__quality-processing__.settings_parser")

-- Items for crafter entities

local qp_normal_name = shared.mod_prefix .. "normal"
local qp_crafter_normal_item = table.deepcopy(data.raw["item"]["assembling-machine-1"])
qp_crafter_normal_item.name = qp_normal_name
qp_crafter_normal_item.icon = graphics[parsed_settings.graphics_settings["normal"]].get_icon_64()
qp_crafter_normal_item.subgroup = shared.mod_prefix.."normal"
qp_crafter_normal_item.place_result = qp_normal_name
qp_crafter_normal_item.order = "1"

local qp_uncommon_name = shared.mod_prefix .. "uncommon"
local qp_crafter_uncommon_item = table.deepcopy(data.raw["item"]["assembling-machine-2"])
qp_crafter_uncommon_item.name = qp_uncommon_name
qp_crafter_uncommon_item.icon = graphics[parsed_settings.graphics_settings["uncommon"]].get_icon_64()
qp_crafter_uncommon_item.subgroup = shared.mod_prefix.."uncommon"
qp_crafter_uncommon_item.place_result = qp_uncommon_name
qp_crafter_uncommon_item.order = "1"

local qp_rare_name = shared.mod_prefix .. "rare"
local qp_crafter_rare_item = table.deepcopy(data.raw["item"]["assembling-machine-3"])
qp_crafter_rare_item.name = qp_rare_name
qp_crafter_rare_item.icon = graphics[parsed_settings.graphics_settings["rare"]].get_icon_64()
qp_crafter_rare_item.subgroup = shared.mod_prefix.."rare"
qp_crafter_rare_item.place_result = qp_rare_name
qp_crafter_rare_item.order = "1"

local qp_epic_name = shared.mod_prefix .. "epic"
local qp_crafter_epic_item = table.deepcopy(data.raw["item"]["assembling-machine-3"])
qp_crafter_epic_item.name = qp_epic_name
qp_crafter_epic_item.icon = graphics[parsed_settings.graphics_settings["epic"]].get_icon_64()
qp_crafter_epic_item.subgroup = shared.mod_prefix.."epic"
qp_crafter_epic_item.place_result = qp_epic_name
qp_crafter_epic_item.order = "1"

local qp_legendary_name = shared.mod_prefix .. "legendary"
local qp_crafter_legendary_item = table.deepcopy(data.raw["item"]["assembling-machine-3"])
qp_crafter_legendary_item.name = qp_legendary_name
qp_crafter_legendary_item.icon = graphics[parsed_settings.graphics_settings["legendary"]].get_icon_64()
qp_crafter_legendary_item.subgroup = shared.mod_prefix.."legendary"
qp_crafter_legendary_item.place_result = qp_legendary_name
qp_crafter_legendary_item.order = "1"

data:extend({qp_crafter_normal_item, qp_crafter_uncommon_item, qp_crafter_rare_item, qp_crafter_epic_item, qp_crafter_legendary_item})

-- Upgrade items

-- uncommon

data:extend({
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-uncommon",
		icon = shared.mod_directory .. "/graphics/icons/part-electronic-transformer-2.png",
		subgroup = shared.mod_prefix.."uncommon",
		color_hint = { text = "1" },
		order = "a",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25
	},

-- rare
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-rare",
		icon = shared.mod_directory .. "/graphics/icons/part-electronic-module-5.png",
		subgroup = shared.mod_prefix.."rare",
		color_hint = { text = "3" },
		order = "a",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25
	},
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-rare-1",
		icon = shared.mod_directory .. "/graphics/icons/part-electronic-sensor-package.png",
		subgroup = shared.mod_prefix.."rare",
		color_hint = { text = "3" },
		order = "aa",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25
	},
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-rare-2",
		icon = shared.mod_directory .. "/graphics/icons/part-electronic-module-1.png",
		subgroup = shared.mod_prefix.."rare",
		color_hint = { text = "3" },
		order = "ab",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25
	},

-- epic
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-epic",
		icon = shared.mod_directory .. "/graphics/icons/part-electronic-magnetron-3.png",
		subgroup = shared.mod_prefix.."epic",
		color_hint = { text = "3" },
		order = "a",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25
	},
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-epic-1",
		icon = shared.mod_directory .. "/graphics/icons/part-specimin-3.png",
		subgroup = shared.mod_prefix.."epic",
		color_hint = { text = "3" },
		order = "aa",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25,
		spoil_ticks = 30 * minute,
		spoil_to_trigger_result =
		{
			items_per_trigger = 1,
			trigger =
			{
				type = "direct",
				action_delivery =
				{
					type = "instant",
					source_effects =
					{
						{
							type = "create-entity",
							entity_name = "big-wriggler-pentapod-premature",
							affects_target = true,
							show_in_tooltip = true,
							as_enemy = true,
							find_non_colliding_position = true,
							abort_if_over_space = true,
							offset_deviation = {{-5, -5}, {5, 5}},
							non_colliding_fail_result =
							{
								type = "direct",
								action_delivery =
								{
									type = "instant",
									source_effects =
									{
										{
											type = "create-entity",
											entity_name = "big-wriggler-pentapod-premature",
											affects_target = true,
											show_in_tooltip = false,
											as_enemy = true,
											offset_deviation = {{-1, -1}, {1, 1}},
										}
									}
								}
							}
						}
					}
				}
			}
		}
	},
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-epic-2",
		icon = shared.mod_directory .. "/graphics/icons/part-metal-titanium-bearing-3.png",
		subgroup = shared.mod_prefix.."epic",
		color_hint = { text = "3" },
		order = "ab",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25
	},
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-epic-3",
		icon = shared.mod_directory .. "/graphics/icons/part-electronic-magnetron-1.png",
		subgroup = shared.mod_prefix.."epic",
		color_hint = { text = "3" },
		order = "ac",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25
	},

-- legendary
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-legendary",
		icon = shared.mod_directory .. "/graphics/icons/part-electronic-ai-core.png",
		subgroup = shared.mod_prefix.."legendary",
		color_hint = { text = "3" },
		order = "a",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25,
		spoil_ticks = 1 * hour,
		spoil_result = shared.mod_prefix .. "upgrade-item-legendary-2",
	},
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-legendary-1",
		icon = shared.mod_directory .. "/graphics/icons/part-electronic-photovoltaic-cell-2.png",
		subgroup = shared.mod_prefix.."legendary",
		color_hint = { text = "3" },
		order = "aa",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25,
		spoil_ticks = 10 * minute,
		spoil_result = "quantum-processor",
	},
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-legendary-2",
		icon = shared.mod_directory .. "/graphics/icons/part-ammo-warhead.png",
		subgroup = shared.mod_prefix.."legendary",
		color_hint = { text = "3" },
		order = "ab",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25
	},
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-legendary-2-1",
		icon = shared.mod_directory .. "/graphics/icons/part-artillery-shell-casing.png",
		subgroup = shared.mod_prefix.."legendary",
		color_hint = { text = "3" },
		order = "aba",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25
	},
	{
		type = "item",
		name = shared.mod_prefix .. "upgrade-item-legendary-2-2",
		icon = shared.mod_directory .. "/graphics/icons/part-fuel-rod-2.png",
		subgroup = shared.mod_prefix.."legendary",
		color_hint = { text = "3" },
		order = "abb",
		inventory_move_sound = item_sounds.electric_small_inventory_move,
		pick_sound = item_sounds.electric_small_inventory_pickup,
		drop_sound = item_sounds.electric_small_inventory_move,
		stack_size = 100,
		ingredient_to_weight_coefficient = 0.25
	},

})


local simple_upgrades = settings.startup[shared.mod_prefix .. "simple-upgrade-items"].value
if simple_upgrades then
	data.raw.item[shared.mod_prefix .. "upgrade-item-legendary"].spoil_result = "quantum-processor"
end

local spoil_time_mul = settings.startup[shared.mod_prefix .. "spoil-time-mul"].value
if spoil_time_mul==0 then
	for _, name in ipairs(shared.get_upgrade_item_names(simple_upgrades)) do
		if data.raw.item[name].spoil_ticks then
			data.raw.item[name].spoil_ticks = nil
			data.raw.item[name].spoil_result = nil
			data.raw.item[name].spoil_to_trigger_result = nil
		end
	end
elseif spoil_time_mul~=1 then
	for _, name in ipairs(shared.get_upgrade_item_names(simple_upgrades)) do
		if data.raw.item[name].spoil_ticks then
			data.raw.item[name].spoil_ticks = math.floor(data.raw.item[name].spoil_ticks * spoil_time_mul)
		end
	end
end