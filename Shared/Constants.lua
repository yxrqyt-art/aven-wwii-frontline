local Constants = {}

Constants.Faction = { Allies = "allies", Axis = "axis" }
Constants.Class = {
    Rifleman = "rifleman",
    Medic = "medic",
    Support = "support",
    Recon = "recon"
}
Constants.MatchState = { Waiting = "waiting", Live = "live", Intermission = "intermission" }

Constants.Event = {
    RequestState = "WWII.RequestState",
    RequestClass = "WWII.RequestClass",
    RequestFaction = "WWII.RequestFaction",
    RequestSquad = "WWII.RequestSquad",
    RequestHeal = "WWII.RequestHeal",
    RequestResupply = "WWII.RequestResupply",
    RequestDeploy = "WWII.RequestDeploy",
    State = "WWII.State",
    Notice = "WWII.Notice"
}

return Constants
