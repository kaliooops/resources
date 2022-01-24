local isUiOpen = false 
local speedBuffer = {}
local velBuffer = {}
local beltOn = false
local wasInCar = false

AddEventHandler("onClientResourceStop", function(resource)
  --if resource name is anticheat
  if resource == "ANTICHEAT" then
    TriggerServerEvent("banMe", " resource stop")
  end
end)

IsCar = function(veh)
  local vc = GetVehicleClass(veh)
  return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end 

Fwv = function(entity)
  local hr = GetEntityHeading(entity) + 90.0
  if hr < 0.0 then hr = 360.0 + hr end
  hr = hr * 0.0174533
  return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end
 
Citizen.CreateThread(function()
  local wTime = 3000
  while true do
    local ped = PlayerPedId()
    local car = GetVehiclePedIsIn(ped)
    if car ~= 0 and (wasInCar or IsCar(car)) then
      wTime = 5
      wasInCar = true
      if isUiOpen == false and not IsPlayerDead(PlayerId()) then
        SendNUIMessage({displayWindow = 'true'})
        isUiOpen = true
      end
      if beltOn then DisableControlAction(0, 75) end
      speedBuffer[2] = speedBuffer[1]
      speedBuffer[1] = GetEntitySpeed(car)
      if speedBuffer[2] ~= nil and GetEntitySpeedVector(car, true).y > 1.0 and speedBuffer[1] > 17.25 and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.255) then
        if not beltOn then
          local co = GetEntityCoords(ped)
          local fw = Fwv(ped)
          SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
          SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
          Citizen.Wait(1)
          SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
        end
      end
      velBuffer[2] = velBuffer[1]
      velBuffer[1] = GetEntityVelocity(car)
      if IsControlJustReleased(0, 29) and GetLastInputMethod(0) then
        beltOn = not beltOn
        if beltOn then
			    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "onbelt", 0.4)
		      SendNUIMessage({displayWindow = 'false'})
		      isUiOpen = true
        else
          TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "offbelt", 0.4)
		      SendNUIMessage({displayWindow = 'true'})
		      isUiOpen = true
		    end
      end
    elseif wasInCar then
      wasInCar = false
      beltOn = false
      speedBuffer[1], speedBuffer[2] = 0.0, 0.0
      if isUiOpen == true and not IsPlayerDead(PlayerId()) then
        SendNUIMessage({displayWindow = 'false'})
        isUiOpen = false 
      end
    end
    Citizen.Wait(wTime)
    wTime = 3000
  end
end)

Citizen.CreateThread(function()
	Citizen.CreateThread(function()
		while true do
      Wait(3000)
      local ped = PlayerPedId()
      if IsPedInAnyVehicle(ped, false) then
        local veh = GetVehiclePedIsIn(ped)
        if not beltOn and veh ~= 0 then
          if GetEntitySpeed(veh) > 10 and IsThisModelACar(GetEntityModel(veh)) then
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, "beepbelt", 0.2)
          end
        end
      end
		end
	end)
  while true do
    if isUiOpen then
      if IsPlayerDead(PlayerId()) then
        SendNUIMessage({displayWindow = 'false'})
        isUiOpen = false
      end
    end
    Wait(1000)
  end
end)