local ClassService = {}
ClassService.__index = ClassService

function ClassService.New(config)
    return setmetatable({ config = config }, ClassService)
end

function ClassService:IsValid(class_id)
    return type(class_id) == "string" and self.config.Classes[class_id] ~= nil
end

function ClassService:Set(player, class_id)
    if not self:IsValid(class_id) then return false, "Unknown class." end
    player:SetValue("wwii:class", class_id)
    return true
end

function ClassService:Get(player)
    local class_id = player:GetValue("wwii:class")
    return self:IsValid(class_id) and class_id or "rifleman"
end

function ClassService:GetDefinition(player)
    return self.config.Classes[self:Get(player)]
end

return ClassService
