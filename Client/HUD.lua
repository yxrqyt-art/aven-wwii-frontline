local HUD = {}

local canvas = Canvas(true, Color.TRANSPARENT, 0, true)
local state = nil
local notice = nil
local notice_until = 0

canvas:SetAutoRepaintRate(10)

local function draw_text(self, text, x, y, size)
    self:DrawText(
        tostring(text),
        Vector2D(x, y),
        FontType.Roboto,
        size or 18,
        Color.WHITE
    )
end

local function faction_label(value)
    if value == "allies" then return "ALLIES" end
    if value == "axis" then return "AXIS" end
    return "UNASSIGNED"
end

canvas:Subscribe("Update", function(self, width, height)
    if not state or not state.match then return end

    local match = state.match
    local remaining = math.max(0, math.floor(match.duration - match.elapsed))
    local minutes = math.floor(remaining / 60)
    local seconds = remaining % 60

    draw_text(self, "WWII FRONTLINE", 40, 35, 28)
    draw_text(
        self,
        string.format(
            "ALLIES %d tickets  |  %02d:%02d  |  %d tickets AXIS",
            match.tickets.allies,
            minutes,
            seconds,
            match.tickets.axis
        ),
        40, 78, 20
    )

    local y = 120
    for _, objective in ipairs(state.objectives or {}) do
        local progress = math.floor((objective.progress or 0) * 100)
        draw_text(
            self,
            string.format(
                "%s — %s | %s | %d%% | A:%d X:%d",
                objective.id,
                objective.name,
                objective.state,
                progress,
                objective.allies or 0,
                objective.axis or 0
            ),
            40, y, 17
        )
        y = y + 28
    end

    if state.player then
        draw_text(
            self,
            string.format(
                "%s | %s | K %d / D %d",
                faction_label(state.player.faction),
                string.upper(state.player.class or "rifleman"),
                state.player.stats.kills or 0,
                state.player.stats.deaths or 0
            ),
            40, y + 18, 17
        )
    end

    if notice and os.clock() < notice_until then
        draw_text(self, notice, 40, y + 58, 18)
    end
end)

function HUD.SetState(payload)
    state = payload
end

function HUD.Notice(message)
    notice = tostring(message)
    notice_until = os.clock() + 3
end

function HUD.Repaint()
    canvas:Repaint()
end

return HUD
