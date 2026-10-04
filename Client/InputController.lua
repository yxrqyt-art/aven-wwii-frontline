local InputController = {}

local function request(event_name, value)
    Events.CallRemote(event_name, Reliability.Reliable, value)
end

function InputController.Bind(constants)
    local bindings = {
        { "WWII_Rifleman", "F1", "Select Rifleman", constants.Event.RequestClass, "rifleman" },
        { "WWII_Medic", "F2", "Select Medic", constants.Event.RequestClass, "medic" },
        { "WWII_Support", "F3", "Select Support", constants.Event.RequestClass, "support" },
        { "WWII_Recon", "F4", "Select Recon", constants.Event.RequestClass, "recon" },
        { "WWII_Allies", "F5", "Request Allies", constants.Event.RequestFaction, "allies" },
        { "WWII_Axis", "F6", "Request Axis", constants.Event.RequestFaction, "axis" },
        { "WWII_Alpha", "Num1", "Join Alpha Squad", constants.Event.RequestSquad, "Alpha" },
        { "WWII_Bravo", "Num2", "Join Bravo Squad", constants.Event.RequestSquad, "Bravo" },
        { "WWII_Charlie", "Num3", "Join Charlie Squad", constants.Event.RequestSquad, "Charlie" },
        { "WWII_Dog", "Num4", "Join Dog Squad", constants.Event.RequestSquad, "Dog" }
    }

    for _, binding in ipairs(bindings) do
        Input.Register(binding[1], binding[2], binding[3])
        Input.Bind(binding[1], InputEvent.Pressed, function()
            request(binding[4], binding[5])
        end)
    end
end

return InputController
