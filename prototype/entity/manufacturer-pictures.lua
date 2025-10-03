local shared = require("__quality-processing__.shared")
local generics = require("generic-pictures")

local animation_speed = 0.1
local frames = 128
local base_size = 4

local graphics = {name = "Manufacturer"}

function graphics.get_graphics_set(size)
	local scale =  0.5 * size / base_size
	return {
		always_draw_idle_animation = true,
		idle_animation = {
			layers = {
				util.sprite_load(shared.mod_directory.."/graphics/entity/manufacturer/manufacturer-hr-shadow",
				{
					priority="high",
					frame_count = 1,
					scale = scale,
					draw_as_shadow = true
				})
			}
		},
		states = {{
			name = "idle",
			duration = 1,
			next_active = "working",
			next_inactive = "idle"
		},
		{
			name = "working",
			duration = 99,
			next_active = "working",
			next_inactive = "idle"
		}},
		working_visualisations = {{
			name = "working",
			always_draw = true,
			draw_in_states = {"working"},
			animation = {
				layers = {
					util.sprite_load(shared.mod_directory.."/graphics/entity/manufacturer/manufacturer-hr-animation",
					{
						animation_speed = animation_speed,
						frame_count = frames,
						scale = scale
					}),
					-- util.sprite_load(shared.mod_directory.."/graphics/entity/manufacturer/manufacturer-hr-color1",
					-- {
						-- animation_speed = animation_speed,
						-- frame_count = frames,
						-- scale = scale
					-- }),
					-- util.sprite_load(shared.mod_directory.."/graphics/entity/manufacturer/manufacturer-hr-color2",
					-- {
						-- animation_speed = animation_speed,
						-- frame_count = frames,
						-- scale = scale
					-- }),
					-- util.sprite_load(shared.mod_directory.."/graphics/entity/manufacturer/manufacturer-hr-color3",
					-- {
						-- animation_speed = animation_speed,
						-- frame_count = frames,
						-- scale = scale
					-- }),
					util.sprite_load(shared.mod_directory.."/graphics/entity/manufacturer/manufacturer-hr-emission",
					{
						animation_speed = animation_speed,
						frame_count = frames,
						blend_mode = "additive",
						draw_as_glow = true,
						scale = scale
					}),
				}
			}
		},
		{
			always_draw = true,
			draw_in_states = {"idle"},
			animation = {
				layers = {
					util.sprite_load(shared.mod_directory.."/graphics/entity/manufacturer/manufacturer-hr-shadow",
					{
						priority="high",
						--frame_count = 1,
						scale = scale,
						draw_as_shadow = true
					}),
					util.sprite_load(shared.mod_directory.."/graphics/entity/manufacturer/manufacturer-hr-animation",
					{
						animation_speed = animation_speed,
						--frame_count = frames,
						scale = scale
					}),
				}
			}
		}},
		frozen_patch = util.sprite_load(shared.mod_directory.."/graphics/entity/manufacturer/manufacturer-hr-frozen-2",
		{
			animation_speed = animation_speed,
			frame_count = frames,
			scale = scale
		})
	}
end

graphics.get_pipe_pictures = generics.get_pipe_pictures

function graphics.get_icon_64()
	return shared.mod_directory .. "/graphics/icons/manufacturer-icon-64.png"
end

function graphics.get_icon_128()
	return shared.mod_directory .. "/graphics/icons/manufacturer-icon-128.png"
end

return graphics