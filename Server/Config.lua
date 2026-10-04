return {
    MinPlayersToStart = 1,
    InitialTickets = 250,
    DeathTicketCost = 1,
    CaptureTicketReward = 20,
    CaptureScoreReward = 100,
    ScoreToWin = 300,
    MatchDurationSeconds = 1800,
    IntermissionSeconds = 20,
    RespawnSeconds = 8,
    CaptureSeconds = 25,
    MaxFactionDifference = 1,
    DebugCaptureZones = false,
    InteractionDistance = 350,
    HealAmount = 35,
    HealCooldownSeconds = 8,
    ResupplyCooldownSeconds = 12,
    MaxSquadSize = 6,
    Squads = { "Alpha", "Bravo", "Charlie", "Dog" },

    CharacterAsset = "nanos-world::SK_Male",

    Spawns = {
        allies = Vector(-1800, 0, 150),
        axis = Vector(1800, 0, 150)
    },

    Objectives = {
        { id = "A", name = "Village", location = Vector(-600, 0, 100), extent = Vector(350, 350, 250) },
        { id = "B", name = "Crossroads", location = Vector(0, 0, 100), extent = Vector(350, 350, 250) },
        { id = "C", name = "Radio Station", location = Vector(600, 0, 100), extent = Vector(350, 350, 250) }
    },

    Classes = {
        rifleman = { label = "Rifleman", health = 100, weapon = "rifle" },
        medic = { label = "Medic", health = 100, weapon = "smg" },
        support = { label = "Support", health = 110, weapon = "lmg" },
        recon = { label = "Recon", health = 90, weapon = "marksman" }
    },

    Weapons = {
        rifle = {
            asset = "nanos-world::SK_AK47", clip = 10, reserve = 80,
            damage = 42, spread = 7, recoil = 0.65, cadence = 0.22
        },
        smg = {
            asset = "nanos-world::SK_AK47", clip = 30, reserve = 150,
            damage = 24, spread = 18, recoil = 0.35, cadence = 0.09
        },
        lmg = {
            asset = "nanos-world::SK_AK47", clip = 50, reserve = 200,
            damage = 30, spread = 22, recoil = 0.55, cadence = 0.11
        },
        marksman = {
            asset = "nanos-world::SK_AK47", clip = 5, reserve = 40,
            damage = 70, spread = 3, recoil = 0.9, cadence = 0.55
        }
    }
}
