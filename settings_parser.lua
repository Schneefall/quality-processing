local shared = require("shared")
local graphics = require("prototype.entity.pictures")

parsed = {}

parsed.graphics_settings = {}
for _, quality in pairs(shared.qualities) do 
	parsed.graphics_settings[quality] = graphics.internal_name_by_name[settings.startup[shared.mod_prefix .. quality .. "-custom-graphics"].value]
end

parsed.no_promethium = settings.startup[shared.mod_prefix .. "no-promethium"].value or false

return parsed