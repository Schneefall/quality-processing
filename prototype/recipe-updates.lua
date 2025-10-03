local shared = require("shared")

if settings.startup[shared.mod_prefix .. "no-thruster-surface-restriction"].value then
	local thruster_recipe_names = {
		"thruster-fuel",
		"thruster-oxidizer",
		"advanced-thruster-fuel",
		"advanced-thruster-oxidizer",
	}
	for _,recipe_name in ipairs(thruster_recipe_names) do
		data.raw.recipe[recipe_name].surface_conditions = nil
	end
end