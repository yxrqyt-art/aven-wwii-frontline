local RateLimiter = {}
RateLimiter.__index = RateLimiter

function RateLimiter.New(window_seconds)
    return setmetatable({ window = window_seconds or 1, entries = {} }, RateLimiter)
end

function RateLimiter:Allow(player, action)
    local key = tostring(player:GetID()) .. ":" .. action
    local now = os.clock()
    local previous = self.entries[key] or 0
    if now - previous < self.window then return false end
    self.entries[key] = now
    return true
end

function RateLimiter:Forget(player)
    local prefix = tostring(player:GetID()) .. ":"
    for key in pairs(self.entries) do
        if string.sub(key, 1, #prefix) == prefix then self.entries[key] = nil end
    end
end

return RateLimiter
