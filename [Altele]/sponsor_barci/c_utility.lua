function Draw3DText(x, y, z, text)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextScale(0.0, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
function tryLoadModel(model)
    RequestModel(model)
    local i = 0
    while not HasModelLoaded(model) do
        Wait(300)
        i = i +1
        if (i == 5) then print("Failed loading model: " .. model) return false  end
    end
    return true
end

function spawnCar(veh_name, coords, heading)
    local model = GetHashKey(veh_name)
    if not tryLoadModel(model) then return end
    
    if HasModelLoaded(model) then
        local veh = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, true) 
        NetworkRegisterEntityAsNetworked(VehToNet(veh))
        return veh
    end        
end

function TeleportPedInCreatedVeh(ped, vehname, coords, heading)
    veh = spawnCar(vehname, coords, heading)

    SetPedIntoVehicle(ped, veh, -1)

    return veh
end