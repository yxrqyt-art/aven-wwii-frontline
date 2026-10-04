local PlayerService = {}
PlayerService.__index = PlayerService

function PlayerService.New(config, factions, classes, weapons, logger)
    return setmetatable({
        config = config, factions = factions, classes = classes,
        weapons = weapons, logger = logger, stats = {}
    }, PlayerService)
end

function PlayerService:Register(player)
    self.stats[player] = { kills = 0, deaths = 0 }
    if not self.factions:Get(player) then self.factions:AssignBalanced(player) end
    if not player:GetValue("wwii:class") then self.classes:Set(player, "rifleman") end
end

function PlayerService:Spawn(player)
    local faction = self.factions:Get(player) or self.factions:AssignBalanced(player)
    local class_definition = self.classes:GetDefinition(player)
    local location = self.config.Spawns[faction]

    local old = player:GetControlledCharacter()
    if old then old:Destroy() end

    local character = Character(location, Rotator(), self.config.CharacterAsset)
    character:SetMaxHealth(class_definition.health)
    character:SetHealth(class_definition.health)
    player:Possess(character)
    self.weapons:Give(character, class_definition.weapon)
    return character
end

function PlayerService:RecordDeath(player)
    local stat = self.stats[player]
    if stat then stat.deaths = stat.deaths + 1 end
end

function PlayerService:RecordKill(player)
    local stat = self.stats[player]
    if stat then stat.kills = stat.kills + 1 end
end

function PlayerService:GetStats(player)
    return self.stats[player] or { kills = 0, deaths = 0 }
end

function PlayerService:Remove(player)
    self.stats[player] = nil
    self.factions:Remove(player)
end

return PlayerService
