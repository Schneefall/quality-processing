local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local graphics = require("prototype.entity.pictures")
local parsed_settings = require("__quality-processing__.settings_parser")

local shared = require("__quality-processing__.shared")

local qp_normal_name = shared.mod_prefix .. "normal"
local qp_uncommon_name = shared.mod_prefix .. "uncommon"
local qp_rare_name = shared.mod_prefix .. "rare"
local qp_epic_name = shared.mod_prefix .. "epic"
local qp_legendary_name = shared.mod_prefix .. "legendary"

-- data:extend({qp_crafter_normal_entity})

data:extend({
	{
		type = "assembling-machine",
		name = qp_normal_name,
		subgroup = shared.mod_prefix.."normal",
		icon = graphics[parsed_settings.graphics_settings["normal"]].get_icon_64(),
		flags = {"placeable-neutral", "placeable-player", "player-creation"},
		minable = {mining_time = 0.2, result = qp_normal_name},
		max_health = 300,
		corpse = "assembling-machine-1-remnants",
		dying_explosion = "assembling-machine-1-explosion",
		icon_draw_specification = {shift = {0, -0.3}},
		resistances =
		{
			{
				type = "fire",
				percent = 70
			}
		},
		collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		fluid_boxes = 
		{
			{
				production_type = "input",
				pipe_picture = graphics[parsed_settings.graphics_settings["normal"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 200,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input", direction = defines.direction.north, position = {0, -1} }}
			},
		},
		damaged_trigger_effect = hit_effects.entity(),
		fast_replaceable_group = qp_normal_name,
		circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
		circuit_connector = circuit_connector_definitions["assembling-machine"],
		alert_icon_shift = util.by_pixel(0, -12),
		graphics_set = graphics[parsed_settings.graphics_settings["normal"]].get_graphics_set(3),
		crafting_categories = {qp_normal_name},
		crafting_speed = 1,
		energy_source =
		{
			type = "electric",
			usage_priority = "secondary-input",
			emissions_per_minute = { pollution = 10 }
		},
		energy_usage = "150kW",
		open_sound = sounds.machine_open,
		close_sound = sounds.machine_close,
		allowed_effects = {"speed", "consumption", "pollution"},
		module_slots = 2,
		effect_receiver = {uses_module_effects = true, uses_beacon_effects = true, uses_surface_effects = true},
		impact_category = "metal",
		working_sound =
		{
			sound = {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.5, audible_distance_modifier = 0.5},
			fade_in_ticks = 4,
			fade_out_ticks = 20
		}
	},
	{
		type = "assembling-machine",
		name = qp_uncommon_name,
		subgroup = shared.mod_prefix.."uncommon",
		icon = graphics[parsed_settings.graphics_settings["uncommon"]].get_icon_64(),
		flags = {"placeable-neutral", "placeable-player", "player-creation"},
		minable = {mining_time = 0.2, result = qp_uncommon_name},
		max_health = 300,
		corpse = "assembling-machine-1-remnants",
		dying_explosion = "assembling-machine-1-explosion",
		icon_draw_specification = {shift = {0, -0.3}},
		resistances =
		{
			{
				type = "fire",
				percent = 70
			}
		},
		collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		fluid_boxes = 
		{
			{
				production_type = "input",
				pipe_picture = graphics[parsed_settings.graphics_settings["uncommon"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 200,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input-output", direction = defines.direction.north, position = {0, -1} }}
			},
			{
				production_type = "input",
				pipe_picture = graphics[parsed_settings.graphics_settings["uncommon"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 200,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input-output", direction = defines.direction.south, position = {0, 1} }}
			},
		},
		damaged_trigger_effect = hit_effects.entity(),
		fast_replaceable_group = qp_uncommon_name,
		circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
		circuit_connector = circuit_connector_definitions["assembling-machine"],
		alert_icon_shift = util.by_pixel(0, -12),
		graphics_set = graphics[parsed_settings.graphics_settings["uncommon"]].get_graphics_set(3),
		crafting_categories = {qp_uncommon_name},
		crafting_speed = 1,
		energy_source =
		{
			type = "electric",
			usage_priority = "secondary-input",
			emissions_per_minute = { pollution = 10 }
		},
		energy_usage = "300kW",
		open_sound = sounds.machine_open,
		close_sound = sounds.machine_close,
		allowed_effects = {"speed", "consumption", "pollution"},
		module_slots = 2,
		effect_receiver = {uses_module_effects = true, uses_beacon_effects = true, uses_surface_effects = true},
		impact_category = "metal",
		working_sound =
		{
			sound = {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.5, audible_distance_modifier = 0.5},
			fade_in_ticks = 4,
			fade_out_ticks = 20
		}
	},
	{
		type = "assembling-machine",
		name = qp_rare_name,
		subgroup = shared.mod_prefix.."rare",
		icon = graphics[parsed_settings.graphics_settings["rare"]].get_icon_64(),
		flags = {"placeable-neutral", "placeable-player", "player-creation"},
		minable = {mining_time = 0.2, result = qp_rare_name},
		max_health = 300,
		corpse = "assembling-machine-1-remnants",
		dying_explosion = "assembling-machine-1-explosion",
		icon_draw_specification = {shift = {0, -0.3}},
		resistances =
		{
			{
				type = "fire",
				percent = 70
			}
		},
		collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		damaged_trigger_effect = hit_effects.entity(),
		fast_replaceable_group = qp_rare_name,
		circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
		circuit_connector = circuit_connector_definitions["assembling-machine"],
		alert_icon_shift = util.by_pixel(0, -12),
		graphics_set = graphics[parsed_settings.graphics_settings["rare"]].get_graphics_set(3),
		crafting_categories = {qp_rare_name},
		crafting_speed = 1,
		energy_source =
		{
			type = "electric",
			usage_priority = "secondary-input",
			emissions_per_minute = { pollution = 4 }
		},
		energy_usage = "1MW",
		open_sound = sounds.machine_open,
		close_sound = sounds.machine_close,
		allowed_effects = {"speed", "consumption", "pollution"},
		module_slots = 2,
		effect_receiver = {uses_module_effects = true, uses_beacon_effects = true, uses_surface_effects = true},
		impact_category = "metal",
		working_sound =
		{
			sound = {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.5, audible_distance_modifier = 0.5},
			fade_in_ticks = 4,
			fade_out_ticks = 20
		}
	},
	{
		type = "assembling-machine",
		name = qp_epic_name,
		subgroup = shared.mod_prefix.."epic",
		icon = graphics[parsed_settings.graphics_settings["epic"]].get_icon_64(),
		flags = {"placeable-neutral", "placeable-player", "player-creation"},
		minable = {mining_time = 0.2, result = qp_epic_name},
		max_health = 300,
		corpse = "assembling-machine-1-remnants",
		dying_explosion = "assembling-machine-1-explosion",
		icon_draw_specification = {shift = {0, -0.3}},
		resistances =
		{
			{
				type = "fire",
				percent = 70
			}
		},
		collision_box = {{-1.7, -1.7}, {1.7, 1.7}},
		selection_box = {{-2, -2}, {2, 2}},
		fluid_boxes = 
		{
			{
				production_type = "input",
				pipe_picture = graphics[parsed_settings.graphics_settings["epic"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 200,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input-output", direction = defines.direction.north, position = {-0.5, -1.5} }}
			},
			{
				production_type = "input",
				pipe_picture = graphics[parsed_settings.graphics_settings["epic"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 200,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input-output", direction = defines.direction.south, position = {0.5, 1.5} }}
			},
			{
				production_type = "output",
				pipe_picture = graphics[parsed_settings.graphics_settings["epic"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 100,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input-output", direction = defines.direction.west, position = {-1.5, 0.5} }}
			},
			{
				production_type = "output",
				pipe_picture = graphics[parsed_settings.graphics_settings["epic"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 100,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input-output", direction = defines.direction.east, position = {1.5, -0.5} }}
			},
		},
		damaged_trigger_effect = hit_effects.entity(),
		fast_replaceable_group = qp_epic_name,
		circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
		circuit_connector = circuit_connector_definitions["assembling-machine"],
		alert_icon_shift = util.by_pixel(0, -12),
		graphics_set = graphics[parsed_settings.graphics_settings["epic"]].get_graphics_set(4),
		crafting_categories = {qp_epic_name},
		crafting_speed = 1,
		energy_source =
		{
			type = "electric",
			usage_priority = "secondary-input",
			emissions_per_minute = { pollution = 25 }
		},
		energy_usage = "3MW",
		open_sound = sounds.machine_open,
		close_sound = sounds.machine_close,
		allowed_effects = {"speed", "consumption", "pollution"},
		module_slots = 2,
		effect_receiver = {uses_module_effects = true, uses_beacon_effects = true, uses_surface_effects = true},
		impact_category = "metal",
		working_sound =
		{
			sound = {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.5, audible_distance_modifier = 0.5},
			fade_in_ticks = 4,
			fade_out_ticks = 20
		}
	},
	{
		type = "assembling-machine",
		name = qp_legendary_name,
		subgroup = shared.mod_prefix.."legendary",
		icon = graphics[parsed_settings.graphics_settings["legendary"]].get_icon_64(),
		flags = {"placeable-neutral", "placeable-player", "player-creation"},
		minable = {mining_time = 0.2, result = qp_legendary_name},
		max_health = 300,
		corpse = "assembling-machine-1-remnants",
		dying_explosion = "assembling-machine-1-explosion",
		icon_draw_specification = {shift = {0, -0.3}},
		resistances =
		{
			{
				type = "fire",
				percent = 70
			}
		},
		collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
		selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
		fluid_boxes = 
		{
			{
				production_type = "input",
				pipe_picture = graphics[parsed_settings.graphics_settings["legendary"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 200,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input-output", direction = defines.direction.south, position = {-1, 2} }}
			},
			{
				production_type = "input",
				pipe_picture = graphics[parsed_settings.graphics_settings["legendary"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 200,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input-output", direction = defines.direction.north, position = {1, -2} }}
			},
			{
				production_type = "output",
				pipe_picture = graphics[parsed_settings.graphics_settings["legendary"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 100,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input-output", direction = defines.direction.north, position = {-1, -2} }}
			},
			{
				production_type = "output",
				pipe_picture = graphics[parsed_settings.graphics_settings["legendary"]].get_pipe_pictures(),
				pipe_covers = pipecoverspictures(),
				volume = 100,
				secondary_draw_orders = { north = -1 },
				pipe_connections = {{ flow_direction="input-output", direction = defines.direction.south, position = {1, 2} }}
			}
		},
		damaged_trigger_effect = hit_effects.entity(),
		fast_replaceable_group = qp_legendary_name,
		circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
		circuit_connector = circuit_connector_definitions["assembling-machine"],
		alert_icon_shift = util.by_pixel(0, -12),
		graphics_set = graphics[parsed_settings.graphics_settings["legendary"]].get_graphics_set(5),
		crafting_categories = {qp_legendary_name},
		crafting_speed = 1,
		energy_source =
		{
			type = "electric",
			usage_priority = "secondary-input",
			emissions_per_minute = { pollution = 10 }
		},
		energy_usage = "10MW",
		open_sound = sounds.machine_open,
		close_sound = sounds.machine_close,
		allowed_effects = {"speed", "consumption", "pollution"},
		module_slots = 2,
		effect_receiver = {uses_module_effects = true, uses_beacon_effects = true, uses_surface_effects = true},
		impact_category = "metal",
		working_sound =
		{
			sound = {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.5, audible_distance_modifier = 0.5},
			fade_in_ticks = 4,
			fade_out_ticks = 20
		}
	},
})