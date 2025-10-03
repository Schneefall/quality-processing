local shared = {}

shared.mod_name = "quality-processing"
shared.mod_prefix = shared.mod_name .. "--"
shared.mod_suffix_short = "-qp-"
shared.mod_directory = "__" .. shared.mod_name .. "__"

shared.qualities = {"normal", "uncommon", "rare", "epic", "legendary"}
-- shared.qualities = {"normal", "uncommon", "rare"}


shared.debug = false

function shared.get_upgrade_item_names(simple_upgrades)
	if simple_upgrades then
		return {
			shared.mod_prefix .. "upgrade-item-uncommon",
			shared.mod_prefix .. "upgrade-item-rare",
			shared.mod_prefix .. "upgrade-item-epic",
			shared.mod_prefix .. "upgrade-item-legendary"
		}
	else
		return {
			shared.mod_prefix .. "upgrade-item-uncommon",
			shared.mod_prefix .. "upgrade-item-rare", shared.mod_prefix .. "upgrade-item-rare-1", shared.mod_prefix .. "upgrade-item-rare-2",
			shared.mod_prefix .. "upgrade-item-epic", shared.mod_prefix .. "upgrade-item-epic-1", shared.mod_prefix .. "upgrade-item-epic-2", shared.mod_prefix .. "upgrade-item-epic-3",
			shared.mod_prefix .. "upgrade-item-legendary", shared.mod_prefix .. "upgrade-item-legendary-1", shared.mod_prefix .. "upgrade-item-legendary-2", shared.mod_prefix .. "upgrade-item-legendary-2-1", shared.mod_prefix .. "upgrade-item-legendary-2-2",
		}
	end
end

shared.upgrade_item_names = shared.get_upgrade_item_names(false)

function shared.get_processor_names()
	return {
			shared.mod_prefix .. "normal",
			shared.mod_prefix .. "uncommon",
			shared.mod_prefix .. "rare",
			shared.mod_prefix .. "epic",
			shared.mod_prefix .. "legendary"
	}
end

shared.processor_names = shared.get_processor_names()

function shared.log_debug(s)
	if shared.debug then
		log(s)
	end
end

function shared.get_table_length(t)
	local n = 0
	for _ in pairs(t) do n = n + 1 end
	return n
end

function shared.array_contains(arr, s)
	for _,a in ipairs(arr) do
		if a == s then
			return true
		end
	end
	return false
end

function shared.array_contains_with_key(arr, key, s)
	for _,a in ipairs(arr) do
		if a[key] == s then
			return true
		end
	end
	return false
end

-- https://stackoverflow.com/questions/12394841/safely-remove-items-from-an-array-table-while-iterating
function shared.array_remove(t, fnKeep)
	local j, n = 1, #t;

	for i=1,n do
		if (fnKeep(t, i, j)) then
			-- Move i's kept value to j's position, if it's not already there.
			if (i ~= j) then
				t[j] = t[i];
				t[i] = nil;
			end
			j = j + 1; -- Increment position of where we'll place the next kept value.
		else
			t[i] = nil;
		end
	end

	return t;
end


-- from on https://github.com/Quezler/glutenfree/blob/main/mods_2.0/050_quality-condenser/data-final-fixes.lua
function shared.string_split(s, delimiter)
	if s == "" then return {} end
	local result = {}
	for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

function shared.parse_table_string(s, value_as_number)
	local t = {}
	for _, part in ipairs(shared.string_split(s, ",")) do
		local name, value = table.unpack(shared.string_split(part, "="))
		if value_as_number then
			value = tonumber(value)
		end
		t[name] = value
	end
	return t
end

function shared.parse_array_string(s)
	return shared.string_split(s, ",")
end

return shared