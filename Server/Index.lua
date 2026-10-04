local Config = Package.Require("Config.lua")
local Logger = Package.Require("Logger.lua")
local RateLimiter = Package.Require("RateLimiter.lua")
local FactionService = Package.Require("FactionService.lua")
local ClassService = Package.Require("ClassService.lua")
local WeaponService = Package.Require("WeaponService.lua")
local PlayerService = Package.Require("PlayerService.lua")
local ObjectiveService = Package.Require("ObjectiveService.lua")
local MatchService = Package.Require("MatchService.lua")
local NetworkService = Package.Require("NetworkService.lua")
local SquadService = Package.Require("SquadService.lua")
local RoleAbilityService = Package.Require("RoleAbilityService.lua")

local Constants = WWII.Constants
local factions = FactionService.New(Config)
local classes = ClassService.New(Config)
local weapons = WeaponService.New(Config)
local players = PlayerService.New(Config, factions, classes, weapons, Logger)
local match = MatchService.New(Config, Logger)
local limiter = RateLimiter.New(0.35)
local squads = SquadService.New(Config)
local abilities = RoleAbilityService.New(Config, classes, factions)
local objectives
local network

local function build_state(player)
    local personal = nil
    if player then
        personal = {
            faction = factions:Get(player),
            class = classes:Get(player),
            stats = players:GetStats(player),
            squad = player:GetValue("wwii:squad")
        }
    end

    return {
        match = match:Snapshot(),
        objectives = objectives:Snapshot(),
        player = personal
    }
end

objectives = ObjectiveService.New(Config, factions, function(objective_id, faction)
    local final_id = Config.Objectives[#Config.Objectives].id
    match:OnObjectiveCaptured(faction, objective_id == final_id)
end)

network = NetworkService.New(
    Constants, limiter, factions, classes, squads, abilities, players, build_state
)
network:Bind()

Player.Subscribe("Spawn", function(player)
    players:Register(player)
end)

Player.Subscribe("Ready", function(player)
    if match.state == Constants.MatchState.Waiting then
        match:Start()
    end

    players:Spawn(player)
    network:SendState(player)
end)

Character.Subscribe("Death", function(character, _, _, _, _, instigator)
    local victim = character:GetPlayer()
    if not victim then return end

    players:RecordDeath(victim)
    local victim_faction = factions:Get(victim)
    match:OnDeath(victim_faction)

    if instigator and instigator.GetPlayer then
        local killer = instigator:GetPlayer()
        if killer and killer ~= victim and factions:Get(killer) ~= victim_faction then
            players:RecordKill(killer)
        end
    end

    Timer.SetTimeout(function(player)
        players:Spawn(player)
        network:SendState(player)
    end, Config.RespawnSeconds * 1000, victim)
end)

Player.Subscribe("Destroy", function(player)
    limiter:Forget(player)
    abilities:Forget(player)
    squads:Remove(player)
    players:Remove(player)
end)

Timer.SetInterval(function()
    local delta_seconds = 0.25
    match:Tick(delta_seconds)
    if match.state == Constants.MatchState.Live then
        objectives:Tick(delta_seconds)
    end
end, 250)

Timer.SetInterval(function()
    network:BroadcastState()
end, 1000)

Logger.Info("Aven WWII Frontline loaded.")
