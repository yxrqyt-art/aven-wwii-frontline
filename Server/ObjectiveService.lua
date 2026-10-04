local ObjectiveService = {}
ObjectiveService.__index = ObjectiveService

function ObjectiveService.New(config, factions, on_captured)
    local self = setmetatable({
        config = config, factions = factions, on_captured = on_captured,
        objectives = {}, active_index = 1
    }, ObjectiveService)

    for index, definition in ipairs(config.Objectives) do
        local objective = {
            definition = definition,
            progress = 0,
            owner = nil,
            state = index == 1 and "active" or "locked",
            occupants = { allies = {}, axis = {} }
        }

        local trigger = Trigger(
            definition.location, Rotator(), definition.extent,
            TriggerType.Box, config.DebugCaptureZones, Color(1, 1, 1),
            { "Character" }
        )
        objective.trigger = trigger

        trigger:Subscribe("BeginOverlap", function(_, actor)
            local player = actor:GetPlayer()
            if not player then return end
            local faction = factions:Get(player)
            if faction then objective.occupants[faction][player] = true end
        end)

        trigger:Subscribe("EndOverlap", function(_, actor)
            local player = actor:GetPlayer()
            if not player then return end
            objective.occupants.allies[player] = nil
            objective.occupants.axis[player] = nil
        end)

        self.objectives[index] = objective
    end

    return self
end

local function count(set)
    local result = 0
    for _ in pairs(set) do result = result + 1 end
    return result
end

function ObjectiveService:Reset()
    self.active_index = 1
    for index, objective in ipairs(self.objectives) do
        objective.progress = 0
        objective.owner = nil
        objective.state = index == 1 and "active" or "locked"
        objective.occupants = { allies = {}, axis = {} }
    end
end

function ObjectiveService:Tick(delta_seconds)
    local objective = self.objectives[self.active_index]
    if not objective or objective.state ~= "active" then return end

    local allies = count(objective.occupants.allies)
    local axis = count(objective.occupants.axis)
    if allies == axis then return end

    local faction = allies > axis and "allies" or "axis"
    local advantage = math.abs(allies - axis)
    local direction = faction == "allies" and 1 or -1
    objective.progress = math.max(-1, math.min(1,
        objective.progress + direction * advantage * delta_seconds / self.config.CaptureSeconds
    ))

    if objective.progress >= 1 or objective.progress <= -1 then
        objective.owner = faction
        objective.state = "captured"
        if self.on_captured then self.on_captured(objective.definition.id, faction) end

        self.active_index = self.active_index + 1
        local next_objective = self.objectives[self.active_index]
        if next_objective then
            next_objective.state = "active"
            next_objective.progress = 0
        end
    end
end

function ObjectiveService:Snapshot()
    local snapshot = {}
    for _, objective in ipairs(self.objectives) do
        table.insert(snapshot, {
            id = objective.definition.id,
            name = objective.definition.name,
            state = objective.state,
            owner = objective.owner,
            progress = objective.progress,
            allies = count(objective.occupants.allies),
            axis = count(objective.occupants.axis)
        })
    end
    return snapshot
end

return ObjectiveService
