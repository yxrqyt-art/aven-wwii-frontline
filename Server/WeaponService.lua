local WeaponService = {}
WeaponService.__index = WeaponService

function WeaponService.New(config)
    return setmetatable({ config = config }, WeaponService)
end

function WeaponService:Give(character, weapon_id)
    local definition = self.config.Weapons[weapon_id]
    if not definition then return nil end

    local weapon = Weapon(character:GetLocation(), Rotator(), definition.asset)
    weapon:SetAmmoSettings(definition.clip, definition.reserve)
    weapon:SetDamage(definition.damage)
    weapon:SetSpread(definition.spread)
    weapon:SetRecoil(definition.recoil)
    weapon:SetCadence(definition.cadence)
    weapon:SetBulletSettings(1, 20000, 20000, Color(100, 70, 30))
    character:PickUp(weapon)
    return weapon
end

return WeaponService
