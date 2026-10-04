local Network = {}

function Network.Bind(constants, state, hud)
    Events.SubscribeRemote(constants.Event.State, function(payload)
        if type(payload) == "table" then
            state.Set(payload)
            hud.Repaint()
        end
    end)

    Events.SubscribeRemote(constants.Event.Notice, function(message)
        hud.Notice(message)
        hud.Repaint()
    end)

    Events.CallRemote(constants.Event.RequestState, Reliability.Reliable)
end

return Network
