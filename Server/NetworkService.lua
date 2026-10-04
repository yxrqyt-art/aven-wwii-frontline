local NetworkService = {}
NetworkService.__index = NetworkService

function NetworkService.New(constants, limiter, factions, classes, squads, abilities, players, build_state)
    return setmetatable({
        C = constants, limiter = limiter, factions = factions, classes = classes,
        squads = squads, abilities = abilities, players = players, build_state = build_state
    }, NetworkService)
end

function NetworkService:Notice(player, message)
    Events.CallRemote(self.C.Event.Notice, player, Reliability.Reliable, tostring(message))
end

function NetworkService:SendState(player)
    Events.CallRemote(self.C.Event.State, player, Reliability.Reliable, self.build_state(player))
end

function NetworkService:BroadcastState()
    Events.BroadcastRemote(self.C.Event.State, Reliability.Unreliable, self.build_state(nil))
end

function NetworkService:Bind()
    Events.SubscribeRemote(self.C.Event.RequestState, function(player)
        if self.limiter:Allow(player, "state") then self:SendState(player) end
    end)

    Events.SubscribeRemote(self.C.Event.RequestClass, function(player, class_id)
        if not self.limiter:Allow(player, "class") or type(class_id) ~= "string" then return end
        local ok, reason = self.classes:Set(player, class_id)
        self:Notice(player, ok and ("Class selected: " .. class_id) or reason)
        if ok then self:SendState(player) end
    end)

    Events.SubscribeRemote(self.C.Event.RequestFaction, function(player, faction)
        if not self.limiter:Allow(player, "faction") or type(faction) ~= "string" then return end
        local ok, reason = self.factions:CanJoin(player, faction)
        if not ok then self:Notice(player, reason) return end
        self.factions:Set(player, faction)
        self:Notice(player, "Faction selected: " .. faction)
        self:SendState(player)
    end)

    Events.SubscribeRemote(self.C.Event.RequestSquad, function(player, squad_name)
        if not self.limiter:Allow(player, "squad") or type(squad_name) ~= "string" then return end
        local faction = self.factions:Get(player)
        if not faction then self:Notice(player, "Choose a faction first.") return end
        local ok, reason = self.squads:Join(player, faction, squad_name)
        self:Notice(player, ok and ("Joined squad " .. squad_name) or reason)
        if ok then self:SendState(player) end
    end)

    Events.SubscribeRemote(self.C.Event.RequestHeal, function(player, target)
        if not self.limiter:Allow(player, "heal") then return end
        local ok, reason = self.abilities:Heal(player, target)
        self:Notice(player, reason)
    end)

    Events.SubscribeRemote(self.C.Event.RequestResupply, function(player, target)
        if not self.limiter:Allow(player, "resupply") then return end
        local ok, reason = self.abilities:Resupply(player, target)
        self:Notice(player, reason)
    end)

    Events.SubscribeRemote(self.C.Event.RequestDeploy, function(player)
        if not self.limiter:Allow(player, "deploy") then return end
        self.players:Spawn(player)
        self:Notice(player, "Deployment confirmed.")
        self:SendState(player)
    end)
end

return NetworkService
