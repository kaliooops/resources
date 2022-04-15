vRPCsponsor = {}
Tunnel.bindInterface("vRP_sponsor",vRPCsponsor)
Proxy.addInterface("vRP_sponsor",vRPCsponsor)
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP_sponsor","vRP_sponsor")

local lastVehicle

function vRPCsponsor.setSponsorSkin(skinID)
	if(skinID == 3)then
		model = "yoda"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	elseif(skinID == 4)then
		model = "ig_benny"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	end
end

function vRPCsponsor.setSponsorSkin2(skinID)
	if(skinID == 4)then
		model = "Child2"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	end
end

function vRPCsponsor.setXDSkin(skinID)
	if(skinsID == 3)then
		model = "Child2"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
	elseif(skinID == 4)then
		model = "sithyoda"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	end
end

function vRPCsponsor.setGimiSkin(skinID)
	if(skinsID == 3)then
		model = "ig_barry"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	elseif(skinID == 4)then
		model = "blackracer"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	end
end

function vRPCsponsor.setDXSkin(skinID)
	if(skinID == 4)then
		model = "JackSparrow"
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
	end
end


function vRPCsponsor.teleportOutOfCar(theVehicle)
	thePed = GetPlayerPed(-1)
	local pos = GetEntityCoords(theVehicle, true)
	SetEntityCoords(thePed, pos.x, pos.y, pos.z+1.0)
end

---- Sponsor Car ----
function vRPCsponsor.spawnSponsorCar()
	model = GetHashKey("MAVERICK")
	ped = GetPlayerPed(-1)
	
	if not lastVehicle and GetVehiclePedIsIn(ped, false) then
		lastVehicle = GetVehiclePedIsIn(ped, false)
	end
	
	x, y, z = table.unpack(GetEntityCoords(ped, true))
	
	local i = 0
	while not HasModelLoaded(model) and i < 1000 do
		RequestModel(model)
		Citizen.Wait(10)
		i = i+1
	end
	if HasModelLoaded(model) then
		local veh = CreateVehicle( model, x, y, z + 1, heading, true, true )
		
		SetPedIntoVehicle(ped, veh, -1)
	
		if (lastVehicle) then
			SetEntityAsMissionEntity(lastVehicle, true, true)
			DeleteVehicle(lastVehicle)
		end
		
		lastVehicle = veh
		UpdateVehicleFeatureVariables( veh )
		toggleRadio(ped)

		SetModelAsNoLongerNeeded( veh )
	end
end
---- Sponsor Car ----

---- Sponsor Car 2 ----
function vRPCsponsor.spawnSponsorCar2()
	model = GetHashKey("Deluxo")
	ped = GetPlayerPed(-1)
	
	if not lastVehicle and GetVehiclePedIsIn(ped, false) then
		lastVehicle = GetVehiclePedIsIn(ped, false)
	end
	
	x, y, z = table.unpack(GetEntityCoords(ped, true))
	
	local i = 0
	while not HasModelLoaded(model) and i < 1000 do
		RequestModel(model)
		Citizen.Wait(10)
		i = i+1
	end
	if HasModelLoaded(model) then
		local veh = CreateVehicle( model, x, y, z + 1, heading, true, true )
		
		SetPedIntoVehicle(ped, veh, -1)
	
		if (lastVehicle) then
			SetEntityAsMissionEntity(lastVehicle, true, true)
			DeleteVehicle(lastVehicle)
		end
		
		lastVehicle = veh
		UpdateVehicleFeatureVariables( veh )
		toggleRadio(ped)

		SetModelAsNoLongerNeeded( veh )
	end
end
---- Sponsor Car 2 ----

---- Rainbow Masina ----
local toggle = false 
local rainbowveh = false
local speed = 0.80
RegisterNetEvent("Masina:Rainbow")
AddEventHandler('Masina:Rainbow', function()
    toggle = not toggle
    if toggle then
        rainbowveh = true
    else
        rainbowveh = false
	end
	for k,v in pairs(args) do
		if k == 1 then
			speed = v
		end
	end
end,false)

Citizen.CreateThread(function()
	local function RGBRainbow( frequency )
		local result = {}
		local curtime = GetGameTimer() / 1000

		result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
		result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
		result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
		return result
	end
    while true do
    	local rainbow = RGBRainbow( speed )
    	Citizen.Wait(0)
    	if rainbowveh then
    		if IsPedInAnyVehicle(PlayerPedId(), true) then
    			veh = GetVehiclePedIsUsing(PlayerPedId())
    			SetVehicleCustomPrimaryColour(veh, rainbow.r, rainbow.g, rainbow.b)
				SetVehicleCustomSecondaryColour(veh, rainbow.r, rainbow.g, rainbow.b)
				SetVehicleNeonLightsColour(veh, rainbow.r, rainbow.g, rainbow.b)
				SetVehicleNeonLightEnabled(veh,0,true)
				SetVehicleNeonLightEnabled(veh,1,true)
				SetVehicleNeonLightEnabled(veh,2,true)
				SetVehicleNeonLightEnabled(veh,3,true)
    		else
    			rainbowveh = false
    			toggle = false
    		end
    	end
    end
end)
---- Rainbow Masina ----

---- SkyFAll ----
local isSkyfall = false

function DisplayHelpText(message)
	SetTextComponentFormat("STRING")
	AddTextComponentString(message)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("Skyfall:DoFall")
AddEventHandler('Skyfall:DoFall', function()
	if not isSkyfall then
		isSkyfall = true
		
		CreateThread(function()
			local playerPed = PlayerPedId()
			local playerPos = GetEntityCoords(playerPed)

			GiveWeaponToPed(playerPed, GetHashKey('gadget_parachute'), 1, true, true)

			DoScreenFadeOut(3000)

			while not IsScreenFadedOut() do
				Wait(0)
			end

			SetEntityCoords(playerPed, playerPos.x, playerPos.y, playerPos.z + 500.0)

			DoScreenFadeIn(2000)

			Wait(2000)

			DisplayHelpText('Skyfall ~g~activated')

			SetPlayerInvincible(playerPed, true)
			SetEntityProofs(playerPed, true, true, true, true, true, false, 0, false)

			while true do
				if isSkyfall then			
					if IsPedInParachuteFreeFall(playerPed) and not HasEntityCollidedWithAnything(playerPed) then
						ApplyForceToEntity(playerPed, true, 0.0, 200.0, 2.5, 0.0, 0.0, 0.0, false, true, false, false, false, true)
					else
						isSkyfall = false
					end
				else

					break
				end

				Wait(0)
			end

			RemoveWeaponFromPed(playerPed, GetHashKey('gadget_parachute'))

			Wait(3000)

			SetPlayerInvincible(playerPed, false)
			SetEntityProofs(playerPed, false, false, false, false, false, false, 0, false)
		end)
	end
end)
---- SkyFAll ----

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					vRPserver.denySponsorCarDriving({})
				end
			end
		end
	end
end)

function vRPCsponsor.denySponsorCarDriving()
	SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
end