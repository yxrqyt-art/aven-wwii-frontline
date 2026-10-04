local Util = {}

function Util.Clamp(value, minimum, maximum)
    return math.max(minimum, math.min(maximum, value))
end

function Util.Contains(list, value)
    for _, item in ipairs(list) do
        if item == value then return true end
    end
    return false
end

function Util.ShallowCopy(source)
    local copy = {}
    for key, value in pairs(source or {}) do copy[key] = value end
    return copy
end

return Util
