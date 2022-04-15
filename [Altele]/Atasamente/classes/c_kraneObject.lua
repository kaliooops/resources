utility = module(Classes_Config.resource_name, "classes/c_kraneUtility")

local c_kraneObject = {}
c_kraneObject.__index = c_kraneObject

function c_kraneObject.new()
    local instance = setmetatable({}, c_kraneObject)
    return instance
end

function c_kraneObject:Create_Me(x,y,z, heading, model, isNet)
    if not isNet then isNet = false end
    local modelhash = utility.Get_Model(model)
    utility.Force_Model_Load(modelhash)

    obj = CreateObject(modelhash, x, y, z, isNet, isNet, true)
    SetEntityHeading(obj, heading)

    self.obj = obj
    self.isNet = isNet

    return obj
end

function c_kraneObject:Freeze()
    FreezeEntityPosition(self.obj, true)
end

function c_kraneObject:Unfreeze()
    FreezeEntityPosition(self.obj, false)
end

function c_kraneObject:Invincible()
    SetEntityInvincible(self.obj, true)
end

function c_kraneObject:Uninvincible()
    SetEntityInvincible(self.obj, false)
end

function c_kraneObject:Generic_Object()
    self:Freeze()
    self:Invincible()
end

function c_kraneObject:Is_Aiming_Me()
    return IsPlayerFreeAimingAtEntity(PlayerId(), self.obj)
end

function c_kraneObject:Is_Shot()
    return IsPedShooting(PlayerPedId()) and self:Is_Aiming_Me()
end

function c_kraneObject:Got_Damaged()
    if not self.health then self.health = GetEntityHealth(self.obj) end
    if GetEntityHealth(self.obj) < self.health then
        self.health = GetEntityHealth(self.obj)
        return true
    end
    return false
end

function c_kraneObject:Get_Health()
    return GetEntityHealth(self.obj)
end

function c_kraneObject:Set_Health(health)
    SetEntityHealth(self.obj, health)
end


function c_kraneObject:Get_Max_Health()
    return GetEntityMaxHealth(self.obj)
end

function c_kraneObject:Set_Max_Health(amount)
    SetEntityMaxHealth(self.obj, amount)
end

function c_kraneObject:Subtract_Health(health)
    if self:Get_Health() - health <= 0 then
        self:Set_Health(0)
    else
        self:Set_Health(self:Get_Health() - health)
    end
end


function c_kraneObject:Internal_Cycle(cb, timeout)
    if not timeout then timeout = 0 end
    CreateThread(function()
        while self.obj do
            Wait(timeout)
            cb()
        end
    end)
end


function c_kraneObject:Can_Interact()
    if Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(self.obj)) < 3.0 then
        return true
    else
        return false
    end
end

function c_kraneObject:Listen_Interactions(cb)
    CreateThread(function()
        while self.obj do
            Wait(1000)
            while self:Can_Interact() do
                if IsControlJustPressed(1, 51) then
                    ClearPedTasksImmediately(self.ped)
                    cb()
                end
                Wait(0)
            end
        end
    end)
end

function c_kraneObject:Swap_Model(model)
    heading = GetEntityHeading(self.obj)
    x,y,z = table.unpack(GetEntityCoords(self.obj))

    DeleteEntity(self.obj)
    DeleteObject(self.obj)
    self:Create_Me(x,y,z, heading, model, self.isNet)
end

function c_kraneObject:Draw_Info(text, scale)
    x,y,z = table.unpack(GetEntityCoords(self.obj))
    utility.DrawText3D(x,y,z+1.0, text, scale)    
end

function c_kraneObject:Destroy()
    utility.Force_Delete(self.obj, true)
    self.obj = nil
end

return c_kraneObject