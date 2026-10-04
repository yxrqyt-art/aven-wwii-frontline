local Logger = {}

local function write(level, message)
    Console.Log(string.format("[WWII][%s] %s", level, tostring(message)))
end

function Logger.Info(message) write("INFO", message) end
function Logger.Warn(message) write("WARN", message) end
function Logger.Error(message) write("ERROR", message) end

return Logger
