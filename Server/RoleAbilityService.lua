local RoleAbilityService = {}
RoleAbilityService.__index = RoleAbilityService

function RoleAbilityService.New(config, classes, factions)
    return setmetatable({
        config = config,
        classes = classes,
        factions = factions,
        cooldowns = {}
    }, RoleAbilityService)
end

local function distance(a, b)
    return a:GetLocation():Distance(b:GetLocation())
end

function RoleAbilityService:_cooldown(player, key, seconds)
    local id = tostring(player:GetID()) .. ":" .. key
    local now = os.clock()
    local previous = self.cooldowns[id] or 0
    if now - previous < seconds then return false end
    self.cooldowns[id] = now
    return true
end

function RoleAbilityService:Heal(player, target)
    if self.classes:Get(player) ~= "medic" then return false, "Medic class required." end
    if not target or not target:IsValid() then return false, "Invalid target." end
    if self.factions:Get(player) ~= self.factions:Get(target) then return false, "You can only heal allies." end

    local source_character = player:GetControlledCharacter()
    local target_character = target:GetControlledCharacter()
    if not source_character or not target_character or target_character:IsDead() then return false, "Target unavailable." end
    if distance(source_character, target_character) > self.config.InteractionDistance then return false, "Target is too far away." end
    if not self:_cooldown(player, "heal", self.config.HealCooldownSeconds) then return false, "Medical kit is recharging." end

    target_character:SetHealth(math.min(
        target_character:GetMaxHealth(),
        target_character:GetHealth() + self.config.HealAmount
    ))
    return true, "Ally treated."
end

function RoleAbilityService:Resupply(player, target)
    if self.classes:Get(player) ~= "support" then return false, "Support class required." end
    if not target or not target:IsValid() then return false, "Invalid target." end
    if self.factions:Get(player) ~= self.factions:Get(target) then return false, "You can only resupply allies." end

    local source_character = player:GetControlledCharacter()
    local target_character = target:GetControlledCharacter()
    if not source_character or not target_character or target_character:IsDead() then return false, "Target unavailable." end
    if distance(source_character, target_character) > self.config.InteractionDistance then return false, "Target is too far away." end
    if not self:_cooldown(player, "resupply", self.config.ResupplyCooldownSeconds) then return false, "Supply kit is recharging." end

    -- Inventory/ammunition integration intentionally remains an adapter point:
    -- final behavior depends on the project's licensed weapon assets and ammo model.
    return true, "Supply request validated."
end

function RoleAbilityService:Forget(player)
    local prefix = tostring(player:GetID()) .. ":"
    for key in pairs(self.cooldowns) do
        if string.sub(key, 1, #prefix) == prefix then self.cooldowns[key] = nil end
    end
end

return RoleAbilityService
