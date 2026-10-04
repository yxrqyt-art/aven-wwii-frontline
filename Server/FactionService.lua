local FactionService = {}
FactionService.__index = FactionService

function FactionService.New(config)
    return setmetatable({ config = config, members = { allies = {}, axis = {} } }, FactionService)
end

function FactionService:Count(faction)
    local count = 0
    for _ in pairs(self.members[faction]) do count = count + 1 end
    return count
end

function FactionService:Get(player)
    return player:GetValue("wwii:faction")
end

function FactionService:AssignBalanced(player)
    local faction = self:Count("allies") <= self:Count("axis") and "allies" or "axis"
    return self:Set(player, faction)
end

function FactionService:CanJoin(player, faction)
    if faction ~= "allies" and faction ~= "axis" then return false, "Unknown faction." end
    local current = self:Get(player)
    if current == faction then return true end

    local allies = self:Count("allies")
    local axis = self:Count("axis")
    if current == "allies" then allies = allies - 1 end
    if current == "axis" then axis = axis - 1 end
    if faction == "allies" then allies = allies + 1 else axis = axis + 1 end

    if math.abs(allies - axis) > self.config.MaxFactionDifference then
        return false, "Faction switch would unbalance the teams."
    end
    return true
end

function FactionService:Set(player, faction)
    local current = self:Get(player)
    if current and self.members[current] then self.members[current][player] = nil end
    self.members[faction][player] = true
    player:SetValue("wwii:faction", faction)
    return faction
end

function FactionService:Remove(player)
    local current = self:Get(player)
    if current and self.members[current] then self.members[current][player] = nil end
end

return FactionService
