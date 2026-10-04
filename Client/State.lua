local State = { data = nil, listeners = {} }

function State.Set(data)
    State.data = data
    for _, listener in ipairs(State.listeners) do listener(data) end
end

function State.Subscribe(listener)
    table.insert(State.listeners, listener)
end

return State
