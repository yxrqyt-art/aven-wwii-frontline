local MatchService = {}
MatchService.__index = MatchService

function MatchService.New(config, logger)
    return setmetatable({
        config = config, logger = logger, state = "waiting",
        tickets = { allies = config.InitialTickets, axis = config.InitialTickets },
        score = { allies = 0, axis = 0 },
        elapsed = 0, winner = nil
    }, MatchService)
end

function MatchService:Start()
    self.state = "live"
    self.elapsed = 0
    self.winner = nil
    self.tickets = { allies = self.config.InitialTickets, axis = self.config.InitialTickets }
    self.score = { allies = 0, axis = 0 }
    self.logger.Info("Match started.")
end

function MatchService:End(winner)
    if self.state ~= "live" then return end
    self.state = "intermission"
    self.winner = winner
    self.logger.Info("Match ended. Winner: " .. tostring(winner))
end

function MatchService:OnDeath(faction)
    if self.state ~= "live" or not self.tickets[faction] then return end
    self.tickets[faction] = math.max(0, self.tickets[faction] - self.config.DeathTicketCost)
    if self.tickets[faction] <= 0 then
        self:End(faction == "allies" and "axis" or "allies")
    end
end

function MatchService:OnObjectiveCaptured(faction, final_objective)
    if self.state ~= "live" then return end
    self.score[faction] = self.score[faction] + self.config.CaptureScoreReward
    self.tickets[faction] = self.tickets[faction] + self.config.CaptureTicketReward
    if final_objective or self.score[faction] >= self.config.ScoreToWin then self:End(faction) end
end

function MatchService:Tick(delta_seconds)
    if self.state ~= "live" then return end
    self.elapsed = self.elapsed + delta_seconds
    if self.elapsed >= self.config.MatchDurationSeconds then
        if self.score.allies == self.score.axis then
            self:End(self.tickets.allies >= self.tickets.axis and "allies" or "axis")
        else
            self:End(self.score.allies > self.score.axis and "allies" or "axis")
        end
    end
end

function MatchService:Snapshot()
    return {
        state = self.state, tickets = self.tickets, score = self.score,
        elapsed = self.elapsed, duration = self.config.MatchDurationSeconds,
        winner = self.winner
    }
end

return MatchService
