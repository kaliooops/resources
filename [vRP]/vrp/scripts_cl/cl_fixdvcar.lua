local function ObiectInFata(ped, pos)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
	local car = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, ped, 0)
	local _, _, _, _, result = GetRaycastResult(car)
	return result
end

local function IaVehicululDirectiei(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

function tvRP.fixCar()
	local playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed)
		SetVehicleEngineHealth(vehicle, 9999)
		SetVehiclePetrolTankHealth(vehicle, 9999)
		SetVehicleFixed(vehicle)
	end
end

local distanceToCheck = 5.0

function tvRP.deleteCar()
    local ped = PlayerPedId()
    if(DoesEntityExist(ped) and not IsEntityDead(ped))then 
        local pos = GetEntityCoords(ped)
        if(IsPedSittingInAnyVehicle(ped))then 
            local vehicle = GetVehiclePedIsIn(ped, false)

            NetworkRequestControlOfEntity(vehicle)
            local timeout = 2000
            while timeout > 0 and not NetworkHasControlOfEntity(vehicle)do
                Wait(100)
                timeout = timeout - 100
            end

            SetEntityAsMissionEntity(vehicle, true, true)
            
            local timeout = 2000
            while timeout > 0 and not IsEntityAMissionEntity(vehicle)do
                Wait(100)
                timeout = timeout - 100
            end

            if(GetPedInVehicleSeat(vehicle, -1) == ped)then 
                SetEntityAsMissionEntity(vehicle, true, true)
                if(DoesEntityExist(vehicle))then 
                    DeleteEntity(vehicle)
                end
                if(DoesEntityExist(vehicle))then 
                	tvRP.notify("~r~Masina nu s-a putut sterge, Incearca din nou!")
                else 
                	tvRP.notify("~g~Vehiculul s-a sters!")
                end
            else 
                tvRP.notify("~r~Trebuie sa fi soferul vehiculului!")
            end
        else
            local playerPos = GetEntityCoords(ped, 1)
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(ped, 0.0, distanceToCheck, 0.0)
            local vehicle = IaVehicululDirectiei(playerPos, inFrontOfPlayer)
            if(DoesEntityExist(vehicle))then
                SetEntityAsMissionEntity(vehicle, true, true)
                if(DoesEntityExist(vehicle))then
                    DeleteEntity(vehicle)
                end
                if(DoesEntityExist(vehicle))then
                	tvRP.notify("~r~Masina nu s-a putut sterge, Incearca din nou!")
                else
                	tvRP.notify("~g~Vehiculul este sters!")
                end
            else
                tvRP.notify("~r~Trebuie sa fi soferul vehiculului!")
            end
        end
    end
end

RegisterNetEvent("murtaza:fix")
AddEventHandler("murtaza:fix", function()
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed)
		SetVehicleEngineHealth(vehicle, 9999)
		SetVehiclePetrolTankHealth(vehicle, 9999)
		SetVehicleFixed(vehicle)
	else
	end
end)