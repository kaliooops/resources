local carryingBackInProgress = false
local carryAnimNamePlaying = ""
local carryAnimDictPlaying = ""
local carryControlFlagPlaying = 0
local inSafeZone = false
local plyPos = GetEntityCoords(GetPlayerPed(-1))
local safeZones = {
	["showroom"] = {-43.726108551026, -1101.1746826172, 35.20348739624, 50, true},
	["spawn"] = {-488.5849609375, -282.91690063477, 35.473323822021, 100, true},
	["cnn"] = {-606.72247314453,-930.59405517578,23.862083435059, 40, true},
	["casino"] = {-1746.8065185547,-755.10034179688,9.9973878860474, 50, true},
	["spital"] = {312.29745483398,-590.3564453125,43.283985137939, 60, true},
	["ajail"] =  {2050.4045410156,2844.6833496094,49.438919067383, 60, true}
}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		
		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		local px,py,pz = playerPos.x, playerPos.y, playerPos.z
		
		for i, v in pairs(safeZones)do
			x, y, z = v[1], v[2], v[3]
			radius = v[4]
			if(GetDistanceBetweenCoords(x, y, z, px, py, pz, false) < radius)then
				if v[5] then
					inSafeZone = true
				else
					inSlowZone = true
				end
				safeZone = i
			end
		end
		if safeZone ~= nil then
			x2, y2, z2 = safeZones[safeZone][1], safeZones[safeZone][2], safeZones[safeZone][3]
			radius2 = safeZones[safeZone][4]
			if(GetDistanceBetweenCoords(x2, y2, z2, px, py, pz, false) > radius2)then
				inSafeZone = false
				inSlowZone = false
				safeZone = nil
			end
		end
	end
end)
function tvRP.isInSafeZone()
	return inSafeZone
end
RegisterCommand("cara",function(source, args)
	if not carryingBackInProgress and not inSafeZone then
		if insafeZone then notify("Nu poti face asta in safezone")
		end
		local player = PlayerPedId()	
		lib = 'missfinale_c2mcs_1'
		anim1 = 'fin_c2_mcs_1_camman'
		lib2 = 'nm'
		anim2 = 'firemans_carry'
		distans = 0.15
		distans2 = 0.27
		height = 0.63
		spin = 0.0		
		length = 100000
		controlFlagMe = 49
		controlFlagTarget = 33
		animFlagTarget = 1
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		if closestPlayer ~= -1 and closestPlayer ~= nil then
			carryingBackInProgress = true
			TriggerServerEvent('CarryPeople:sync', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
		else
			drawNativeNotification("Nu e nimeni prin preajma.")
		end
	else
		carryingBackInProgress = false
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		local closestPlayer = GetClosestPlayer(3)
		target = GetPlayerServerId(closestPlayer)
		if target ~= 0 then 
			TriggerServerEvent("CarryPeople:stop",target)
		end
	end
end,false)

RegisterNetEvent('CarryPeople:syncTarget')
AddEventHandler('CarryPeople:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation2
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('CarryPeople:syncMe')
AddEventHandler('CarryPeople:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('CarryPeople:cl_stop')
AddEventHandler('CarryPeople:cl_stop', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if carryingBackInProgress then 
			while not IsEntityPlayingAnim(GetPlayerPed(-1), carryAnimDictPlaying, carryAnimNamePlaying, 3) do
				TaskPlayAnim(GetPlayerPed(-1), carryAnimDictPlaying, carryAnimNamePlaying, 8.0, -8.0, 100000, carryControlFlagPlaying, 0, false, false, false)
				Citizen.Wait(0)
			end
		end
		Wait(500)
	end
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	--print("closest player is dist: " .. tostring(closestDistance))
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

function drawNativeNotification(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end