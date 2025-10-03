local shared = require("__quality-processing__.shared")

local processor_by_quality = {}
local level_by_quality = {}
local min_level_by_quality = {}
min_level_by_quality[shared.qualities[1]] = 0
for _,q in ipairs(shared.qualities) do
	processor_by_quality[q] = shared.mod_prefix .. q
	local qp = prototypes.quality[q]
	level_by_quality[q] = qp.level
	if (qp.next ~= nil) then
		min_level_by_quality[qp.next.name] = qp.level
	end
end
log("qualities = "..serpent.block(shared.qualities))
log("level_by_quality = "..serpent.block(level_by_quality))
log("min_level_by_quality = "..serpent.block(min_level_by_quality))

-- returns the quality this processor handles (not the quality of the processor entity)
--- @param entity LuaEntity
local function get_processor_quality(entity)
	for q,n in pairs(processor_by_quality) do
		if entity.name == n or (entity.type == "entity-ghost" and entity.ghost_name == n) then
			return q
		end
	end
	return nil
end

script.on_init(function() -- called once when the mod is newly added
	storage.processors = {}
	for _,q in ipairs(shared.qualities) do
		storage.processors[q] = {}
	end
	storage.destroyed_event_IDs = {}
end)

-- script.on_load(function() -- called when a save is loaded where the mod is already added

-- end)

-- script.on_configuration_changed(function() -- called when a save is loaded and any startup setting was changed

-- end)

--[[ Handle building and destoying processors]]

--- @param event EventData.on_built_entity
local function handle_processor_built(event)
	if event.entity.last_user == nil
		then return end


	-- register quality processors for updates
	local processor_quality = get_processor_quality(event.entity)
	if processor_quality then
		log("register processor "..event.entity.unit_number)
		storage.processors[processor_quality][event.entity.unit_number] = event.entity
		storage.destroyed_event_IDs[script.register_on_object_destroyed(event.entity)] = {quality=processor_quality, unit_number=event.entity.unit_number}
	end
end

local built_events ={
	defines.events.on_built_entity,
	defines.events.on_robot_built_entity,
	defines.events.on_space_platform_built_entity,
	defines.events.script_raised_built,
	defines.events.script_raised_revive,
	defines.events.on_entity_cloned
}

local built_entity_filters = {}
for q,e in pairs(processor_by_quality) do
	table.insert(built_entity_filters, {filter="name", name=e})
end

for _, event in ipairs(built_events) do
	script.on_event(event, handle_processor_built, built_entity_filters)
end

local function handle_processor_destroyed(event) 
	-- removed destroyed quality processors from the registry
	local destroy_info = storage.destroyed_event_IDs[event.registration_number]
	if destroy_info then
		log("processor "..destroy_info.unit_number.." destroyed")
		storage.processors[destroy_info.quality][destroy_info.unit_number] = nil
	end
end

script.on_event(defines.events.on_object_destroyed, handle_processor_destroyed)

--[[ Handle processor output updates ]]

local function handle_processor_tick(event)
	local direct_upgrades = settings.startup[shared.mod_prefix .. "direct-upgrades"].value
	for quality, processors in pairs(storage.processors) do
		local min_level = min_level_by_quality[quality]
		for _, entity in pairs(processors) do
			if entity.valid and entity.is_crafting() and (direct_upgrades or entity.result_quality.level >= min_level) then
				entity.result_quality = quality
			end
		end
	end
end

script.on_event(defines.events.on_tick, handle_processor_tick)