local shared = require("shared")

data:extend({
	{
		type = "bool-setting",
		name = shared.mod_prefix .. "no-surface-restriction",
		order = "a",
		setting_type = "startup",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = shared.mod_prefix .. "no-thruster-surface-restriction",
		order = "aa",
		setting_type = "startup",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = shared.mod_prefix .. "no-promethium",
		order = "b",
		setting_type = "startup",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = shared.mod_prefix .. "simple-upgrade-items",
		order = "ba",
		setting_type = "startup",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = shared.mod_prefix .. "no-upgrade-items",
		order = "c",
		setting_type = "startup",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = shared.mod_prefix .. "direct-upgrades",
		order = "d",
		setting_type = "startup",
		default_value = false,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "spoil-time-mul",
		order = "e",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "cost-pre-scale",
		order = "fa",
		setting_type = "startup",
		default_value = 0.595,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "cost-exp",
		order = "fb",
		setting_type = "startup",
		default_value = 0.461,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "cost-scale",
		order = "fc",
		setting_type = "startup",
		default_value = 0.933,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "uncommon-cost-scale",
		order = "fca",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "rare-cost-scale",
		order = "fcb",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "epic-cost-scale",
		order = "fcc",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "legendary-cost-scale",
		order = "fcd",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "upgrade-item-cost-scale",
		order = "fd",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "min-time",
		order = "ga",
		setting_type = "startup",
		default_value = 5,
		minimum_value = 0.1,
		maximum_value = 10000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "time-pre-scale",
		order = "gb",
		setting_type = "startup",
		default_value = 0.595,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "time-exp",
		order = "gc",
		setting_type = "startup",
		default_value = 0.461,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "time-scale",
		order = "gd",
		setting_type = "startup",
		default_value = 0.933,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "upgrade-item-time-scale",
		order = "ge",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0.001,
		maximum_value = 1000,
	},
	{
		type = "bool-setting",
		name = shared.mod_prefix .. "log-complexity",
		order = "h",
		setting_type = "startup",
		default_value = false,
	},
	{
		type = "string-setting",
		name = shared.mod_prefix .. "preset-complexity",
		order = "ha",
		setting_type = "startup",
		default_value = "",
		allow_blank = true,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "unknown-ingredients-complexity",
		order = "hb",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 0,
		maximum_value = 1000000,
	},
	{
		type = "double-setting",
		name = shared.mod_prefix .. "fallback-complexity",
		order = "hc",
		setting_type = "startup",
		default_value = 0,
		minimum_value = 0,
		maximum_value = 1000000,
	},
	{
		type = "bool-setting",
		name = shared.mod_prefix .. "hide-quality-modules",
		order = "i",
		setting_type = "startup",
		default_value = false,
	},
	{
		type = "string-setting",
		name = shared.mod_prefix .. "item-blacklist",
		order = "ia",
		setting_type = "startup",
		default_value = "",
		allow_blank = true,
	},
})

--[[
MIT License

Copyright (c) 2024 Wiwiweb

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

]]

local default_names = {
	["normal"] = "Standard",
	["uncommon"] = "Processed",
	["rare"] = "Calibrated",
	["epic"] = "Reinforced",
	["legendary"] = "Tuned",
}

local graphics = require("prototype.entity.pictures")
local default_graphics = {
	["normal"] = graphics.name_by_internal_name["chemical-stager"],
	["uncommon"] = graphics.name_by_internal_name["gravity-assembler"],
	["rare"] = graphics.name_by_internal_name["cybernetics-facility"],
	["epic"] = graphics.name_by_internal_name["atom-forge"],
	["legendary"] = graphics.name_by_internal_name["photometric-lab"],
}

local available_graphics = {}
for name,_ in pairs(graphics.internal_name_by_name) do table.insert(available_graphics, name) end
table.sort(available_graphics)

local quality_settings = {}
for i, quality_name in pairs({"normal", "uncommon", "rare", "epic", "legendary"}) do
	local quality_setting = {
		type = "string-setting",
		name = quality_name .. "-custom-name",
		setting_type = "startup",
		order = tostring(i),
		default_value = default_names[quality_name],
		localised_name = {"", {"quality-name."..quality_name}, " ([img=quality."..quality_name.."])"}
	}
	table.insert(quality_settings, quality_setting)
	
	local graphics_setting = {
		type = "string-setting",
		name = shared.mod_prefix .. quality_name .. "-custom-graphics",
		setting_type = "startup",
		order = tostring(i).."a",
		default_value = default_graphics[quality_name],
		allowed_values = available_graphics,
	}
	table.insert(quality_settings, graphics_setting)
end

data:extend(quality_settings)