local SquadService = {}
SquadService.__index = SquadService

function SquadService.New(config)
    return setmetatable({ config = config, squads = {} }, SquadService)
end

function SquadService:IsValid(name)
    if type(name) ~= "string" then return false end
    for _, allowed in ipairs(self.config.Squads) do
        if allowed == name then return true end
    end
    return false
end

function SquadService:Count(faction, name)
    local count = 0
    for player, membership in pairs(self.squads) do
        if membership.faction == faction and membership.name == name then count = count + 1 end
    end
    return count
end

function SquadService:Join(player, faction, name)
    if not self:IsValid(name) then return false, "Unknown squad." end
    if self:Count(faction, name) >= self.config.MaxSquadSize then
        return false, "This squad is full."
    end
    self.squads[player] = { faction = faction, name = name }
    player:SetValue("wwii:squad", name)
    return true
end

function SquadService:Get(player)
    return self.squads[player]
end

function SquadService:Remove(player)
    self.squads[player] = nil
end

return SquadService
