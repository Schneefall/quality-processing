local shared = require("shared")
local graphics = require("prototype.entity.pictures")

parsed = {}

parsed.graphics_settings = {}
for _, quality in pairs(shared.qualities) do 
	parsed.graphics_settings[quality] = graphics.internal_name_by_name[settings.startup[shared.mod_prefix .. quality .. "-custom-graphics"].value]
end

parsed.quality_cost_scale = {
	normal = 1,
	uncommon = settings.startup[shared.mod_prefix .. "uncommon-cost-scale"].value or 1,
	rare = settings.startup[shared.mod_prefix .. "rare-cost-scale"].value or 1,
	epic = settings.startup[shared.mod_prefix .. "epic-cost-scale"].value or 1,
	legendary = settings.startup[shared.mod_prefix .. "legendary-cost-scale"].value or 1,
}

parsed.no_promethium = settings.startup[shared.mod_prefix .. "no-promethium"].value or false

return parsed