local inSafeZone = false
local inSlowZone = false
local safeZone = nil
local safeZones = {
	["showroom"] = {-43.726108551026, -1101.1746826172, 35.20348739624, 50, true},
	["spawn"] = {224.73501586914,-897.97863769532,30.69993019104, 100, true},
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

Citizen.CreateThread(function()
	while true do
		fontId = RegisterFontId('Freedom Font')
		Citizen.Wait(1000)
		local ped = GetPlayerPed(-1)

		while inSafeZone do
			Citizen.Wait(1)
			--if not isClientCop() then
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true)
				DisableControlAction(0,47,true)
				DisableControlAction(0,58,true)
				DisableControlAction(0,263,true)
				DisableControlAction(0,264,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
				DisableControlAction(0,143,true)
			--end
			SetEntityInvincible(ped, true)
			SetPlayerInvincible(PlayerId(), true)
			ClearPedBloodDamage(ped)
			ResetPedVisibleDamage(ped)
			ClearPedLastWeaponDamage(ped)
			SetEntityProofs(ped, true, true, true, true, true, true, true, true)
			-- SetEntityMaxSpeed(GetVehiclePedIsIn(ped, false), 22.3)
			SetEntityCanBeDamaged(ped, false)

			-- 

			SetTextFont(fontId)
			SetTextCentre(1)
			SetTextProportional(0)
			SetTextScale(0.28, 0.28)
			SetTextColour(67, 240, 102, 255)
			SetTextDropShadow(30, 5, 5, 5, 255)

			SetTextEntry("STRING")
			AddTextComponentString("SAFEZONE")
			DrawText(0.185, 0.885)
		end

		while inSlowZone do
			Citizen.Wait(1)
			-- SetEntityMaxSpeed(GetVehiclePedIsIn(ped, false), 22.3)

			SetTextFont(fontId)
			SetTextCentre(1)
			SetTextProportional(0)
			SetTextScale(0.28, 0.28)
			SetTextColour(245, 204, 42, 255)
			SetTextDropShadow(30, 5, 5, 5, 255)

			SetTextEntry("STRING")
			AddTextComponentString("SLOWZONE")
			DrawText(0.187, 0.913)
		end

		SetEntityInvincible(ped, false)
		SetPlayerInvincible(PlayerId(), false)
		ClearPedLastWeaponDamage(ped)
		SetEntityProofs(ped, false, false, false, false, false, false, false, false)
		SetEntityCanBeDamaged(ped, true)
		-- SetEntityMaxSpeed(GetVehiclePedIsIn(ped, false), 11001.5)
	end
end)


local greenZones = {
	{pos = vector3(-1379.5339355469,-471.61624145508,31.589557647705), width = 120.0, height = 168.0, rot = 36},
	{pos = vector3(-1742.9849853516,-742.48602294922,11.206170082092), width = 38.0, height = 80.0, rot = 140},
	{pos = vector3(-1648.677734375,-905.58642578125,9.6934356689453), width = 100.0, height = 100.0, rot = 320},
	{pos = vector3(-1182.7807617188,-1491.2021484375,4.3796715736389), width = 50.0, height = 45.0, rot = 125},
	{pos = vector3(-637.83312988281,-899.97344970703,23.588891983032), width = 210.0, height = 120.0, rot = 180},
	{pos = vector3(-740.43157958984,-173.11125183105,37.460147857666), width = 200.0, height = 120.0, rot = 26},
	{pos = vector3(224.73501586914,-897.97863769532,30.69993019104), width = 130.0, height = 150.0, rot = 210}, 
	{pos = vector3(223.03834533691,-37.733406066895,70.290115356445), width = 70.0, height = 50.0, rot = 340},
	{pos = vector3(293.47912597656,-590.38848876953,43.136894226074), width = 80.0, height = 60.0, rot = 248},
	{pos = vector3(441.56793212891,-982.18121337891,54.275299072266), width = 80.0, height = 95.0, rot = 89},
	{pos = vector3(-433.291015625,-1699.7692871094,29.277498245239), width = 50.0, height = 60.0, rot = 250},
	{pos = vector3(831.01556396484,-2974.0183105469,12.936800956726), width = 100.0, height = 80.0, rot = 0},
	{pos = vector3(-1020.0696411133,-2703.8911132813,13.807333946228), width = 230.0, height = 120.0, rot = 330},
	{pos = vector3(-92.373649597168,-2101.9973144531,16.771678924561), width = 160.0, height = 60.0, rot = 21},
	{pos = vector3(-54.799942016602,-1130.3120117188,25.887180328369), width = 220.0, height = 90.0, rot = 3},
	{pos = vector3(-797.25836181641,-1308.7915039063,5.000382900238), width = 75.0, height = 65.0, rot = 350},
    {pos = vector3(1706.8060302734,1491.8146972656,84.872230529785), width = 320.0, height = 75.0, rot = 264},

}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local plyPos = GetEntityCoords(GetPlayerPed(-1))
		for _, zone in pairs(greenZones) do

			local dst = (IsPauseMenuActive() and 0.0) or GetDistanceBetweenCoords(plyPos, zone.pos, false)
			local minDst = math.max(zone.width, zone.height) + 10.0
			if not zone.blip and dst <= minDst then
				zone.blip = AddBlipForArea(zone.pos, zone.width, zone.height)
				SetBlipRotation(zone.blip, zone.rot)
				SetBlipColour(zone.blip, 69)
				SetBlipAlpha(zone.blip, 100)
			elseif dst > minDst then
				RemoveBlip(zone.blip)
				zone.blip = nil
			end

		end
	end
end)