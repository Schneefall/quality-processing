local shared = require("__quality-processing__.shared")
local generics = require("generic-pictures")

local animation_speed = 0.1
local frames = 100
--local scale = 0.5 * 3 / 5 * 0.9
local base_size = 6

local graphics = {name = "Quantum Stabilizer"}

function graphics.get_graphics_set(size)
	local scale =  0.5 * size / base_size * 0.9
	return {
		always_draw_idle_animation = true,
		idle_animation = {
			layers = {
				util.sprite_load(shared.mod_directory.."/graphics/entity/quantum-stabilizer/quantum-stabilizer-hr-shadow",
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
					util.sprite_load(shared.mod_directory.."/graphics/entity/quantum-stabilizer/quantum-stabilizer-hr-animation",
					{
						animation_speed = animation_speed,
						frame_count = frames,
						scale = scale
					}),
					util.sprite_load(shared.mod_directory.."/graphics/entity/quantum-stabilizer/quantum-stabilizer-hr-emission",
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
					util.sprite_load(shared.mod_directory.."/graphics/entity/quantum-stabilizer/quantum-stabilizer-hr-shadow",
					{
						priority="high",
						--frame_count = 1,
						scale = scale,
						draw_as_shadow = true
					}),
					util.sprite_load(shared.mod_directory.."/graphics/entity/quantum-stabilizer/quantum-stabilizer-hr-animation",
					{
						animation_speed = animation_speed,
						--frame_count = frames,
						scale = scale
					}),
				}
			}
		}},
		-- frozen_patch = util.sprite_load(shared.mod_directory.."/graphics/entity/quantum-stabilizer/quantum-stabilizer-hr-frozen-1",
		-- {
			-- animation_speed = animation_speed,
			-- frame_count = frames,
			-- scale = scale
		-- })
	}
end

graphics.get_pipe_pictures = generics.get_pipe_pictures

function graphics.get_icon_64()
	return shared.mod_directory .. "/graphics/icons/quantum-stabilizer-icon-64.png"
end

function graphics.get_icon_128()
	return shared.mod_directory .. "/graphics/icons/quantum-stabilizer-icon-128.png"
end

return graphics