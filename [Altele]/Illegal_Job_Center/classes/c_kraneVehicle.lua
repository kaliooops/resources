utility = module(Classes_Config.resource_name, "classes/c_kraneUtility")

local c_kraneVehicle = {}
c_kraneVehicle.__index = c_kraneVehicle

function c_kraneVehicle.new()
    local instance = setmetatable({}, c_kraneVehicle)
    return instance
end


function c_kraneVehicle:Create_Me(x,y,z, heading, model)
    utility.Force_Model_Load(model)
    local modelhash = ""
    if type(model) == "number" then
        modelhash = model
    else
        modelhash = GetHashKey(model)
    end 
    local veh = CreateVehicle(modelhash, x,y,z, heading, false, false)
    SetEntityAsMissionEntity(veh, true, true)
    SetVehicleOnGroundProperly(veh)
    self.veh = veh
    return veh
end

function c_kraneVehicle:Open_Front_Doors()
    SetVehicleDoorOpen(self.veh, 0, false, false)
    SetVehicleDoorOpen(self.veh, 1, false, false)
end

function c_kraneVehicle:Close_Front_Doors()
    SetVehicleDoorOpen(self.veh, 0, false, true)
    SetVehicleDoorOpen(self.veh, 1, false, true)
end

function c_kraneVehicle:Turn_On_Headlights()
    SetVehicleLights(self.veh, 2)
end

function c_kraneVehicle:Turn_Off_Headlights()
    SetVehicleLights(self.veh, 0)
end

function c_kraneVehicle:Turn_On_Engine()
    SetVehicleEngineOn(self.veh, true, false, false)
end

function c_kraneVehicle:Turn_Off_Engine()
    SetVehicleEngineOn(self.veh, false, false, false)
end


return c_kraneVehicle
