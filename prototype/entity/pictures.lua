local shared = require("__quality-processing__.shared")

local graphics = {
	["chemical-stager"] = require("chemical-stager-pictures"),
	["gravity-assembler"] = require("gravity-assembler-pictures"),
	["cybernetics-facility"] = require("cybernetics-facility-pictures"),
	["atom-forge"] = require("atom-forge-pictures"),
	["photometric-lab"] = require("photometric-lab-pictures"),
	["glass-furnace"] = require("glass-furnace-pictures"),
	["research-center"] = require("research-center-pictures"),
	["manufacturer"] = require("manufacturer-pictures"),
	["quantum-stabilizer"] = require("quantum-stabilizer-pictures"),
}

local name_by_internal_name = {}
for internal_name, g in pairs(graphics) do
	name_by_internal_name[internal_name] = g.name
end
graphics.name_by_internal_name = name_by_internal_name

graphics.internal_name_by_name = {}
for internal_name, name in pairs(graphics.name_by_internal_name) do
	graphics.internal_name_by_name[name] = internal_name
end

return graphics