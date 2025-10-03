local shared = require("__quality-processing__.shared")

local graphics = {}

function graphics.get_pipe_pictures()
	return {
		north = util.sprite_load(shared.mod_directory.."/graphics/entity/generic/pipe-connections/north", {scale = 0.5}),
		south = util.sprite_load(shared.mod_directory.."/graphics/entity/generic/pipe-connections/south", {scale = 0.5}),
		east = util.sprite_load(shared.mod_directory.."/graphics/entity/generic/pipe-connections/east", {scale = 0.5}),
		west = util.sprite_load(shared.mod_directory.."/graphics/entity/generic/pipe-connections/west", {scale = 0.5})
	}
end

return graphics