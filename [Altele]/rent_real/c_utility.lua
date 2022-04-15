
function k_draw3DText(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
 
    -- local scale = (1/dist)*scl
    -- local fov = (1/GetGameplayCamFov())*100
    -- local scale = scale*fov   
    if onScreen then
        SetTextScale(0.65, 0.65)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


function TeleportPedInCreatedVeh(ped, vehname, coords, heading)
    veh = spawnCar(vehname, coords, heading)

    SetPedIntoVehicle(ped, veh, -1)

    return veh
end
function tryLoadModel(model)
    RequestModel(model)
    local i = 0
    while not HasModelLoaded(model) do
        Wait(1000)
        i = i +1
        if (i == 15) then print("Failed loading model: " .. model) return false  end
    end
    return true
end


function spawnCar(veh_name, coords, heading)
    local model = GetHashKey(veh_name)
    if not tryLoadModel(model) then return end
    
    if HasModelLoaded(model) then
        local veh = CreateVehicle(model, coords.x, coords.y, coords.z, heading, false, false) 
        PlaceObjectOnGroundProperly(veh)
        return veh
    end        
end




local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
  end
  
  function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end



function k_subtitle_text(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function get_closest_vehicle()
    local closestDistance = -1
    local closestVehicle = -1
    local coords = GetEntityCoords(PlayerPedId())
    for vehicle in EnumerateVehicles() do
        local vehicleCoords = GetEntityCoords(vehicle)
        local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicle
            closestDistance = distance
        end
    end
    return closestVehicle
end


function clone_vehicle(veh, coords, heading)
    local model = GetEntityModel(veh)
    local veh = spawnCar(model, coords, heading)
    return veh
end
