--bind client tunnel interface
vRPbm = {}
Tunnel.bindInterface("vRP_basic_menu", vRPbm)
vRPserver = Tunnel.getInterface("vRP", "vRP_basic_menu")
HKserver = Tunnel.getInterface("vrp_hotkeys", "vRP_basic_menu")
BMserver = Tunnel.getInterface("vRP_basic_menu", "vRP_basic_menu")
vRP = Proxy.getInterface("vRP")

function vRPbm.spawnVehicle(model) 
    -- load vehicle model
    local i = 0
    local mhash = GetHashKey(model)
    while not HasModelLoaded(mhash) and i < 1000 do
	  	if math.fmod(i,100) == 0 then
	  	  vRP.notify({"~r~[System]\n~w~Modelul vehiculului se incarca~b~.~y~.~r~."})
	  	end
      	RequestModel(mhash)
      	Citizen.Wait(30)
	  	i = i + 1
    end

    if HasModelLoaded(mhash) then
      	local x,y,z = vRP.getPosition({})
      	local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false)
      	SetVehicleOnGroundProperly(nveh)
      	SetEntityInvincible(nveh,false)
      	SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
      	Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true)
      	SetVehicleHasBeenOwnedByPlayer(nveh,true)
      	SetModelAsNoLongerNeeded(mhash)
	  	vRP.notify({"~r~[System]\n~w~Vehicul spawnat cu succes."})
	else
	  	vRP.notify({"~r~[System]\n~w~Model vehicul invalid."})
	end
end

function vRPbm.getArmour()
  	return GetPedArmour(GetPlayerPed(-1))
end

function vRPbm.setArmour(armour,vest)
  	local player = GetPlayerPed(-1)
  	if vest then
		if(GetEntityModel(player) == GetHashKey("mp_m_freemode_01")) then
		  	SetPedComponentVariation(player, 9, 4, 1, 2)
		else 
		  	if(GetEntityModel(player) == GetHashKey("mp_f_freemode_01")) then
		    	SetPedComponentVariation(player, 9, 6, 1, 2)
		  	end
		end
  	end
  	local n = math.floor(armour)
  	SetPedArmour(player,n)
end

local state_ready = false

Citizen.CreateThread(function()
  	while true do
   		Citizen.Wait(30000)
    	if IsPlayerPlaying(PlayerId()) and state_ready then
		  	if vRPbm.getArmour() == 0 then
		  	  	if(GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01")) or (GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01")) then
		  	   	 	SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)
				end
		  	end
    	end
  	end
end)

Citizen.CreateThread(function()
	while true do
		if frozen then
			if unfrozen then
				SetEntityInvincible(GetPlayerPed(-1),false)
				SetEntityVisible(GetPlayerPed(-1),true)
				FreezeEntityPosition(GetPlayerPed(-1),false)
				frozen = false
			else
				SetEntityInvincible(GetPlayerPed(-1),true)
				SetEntityVisible(GetPlayerPed(-1),false)
				FreezeEntityPosition(GetPlayerPed(-1),true)
			end
		end
		Citizen.Wait(10)
	end
end)



RegisterNetEvent("admin:spawnScuter")
AddEventHandler("admin:spawnScuter", function(model)
	-- load vehicle model
	local i = 0
	local mhash = GetHashKey(model)
	while not HasModelLoaded(mhash) and i < 1000 do
		if math.fmod(i,100) == 0 then
			vRP.notify({"~r~[System]\n~w~Modelul vehiculului se incarca~b~.~y~.~r~."})
		end
		RequestModel(mhash)
		Citizen.Wait(30)
		i = i + 1
	end

	if HasModelLoaded(mhash) then
		local x,y,z = vRP.getPosition({})
		local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false)
		SetVehicleOnGroundProperly(nveh)
		SetEntityInvincible(nveh,false)
		SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
		Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true)
		SetVehicleHasBeenOwnedByPlayer(nveh,true)
		SetModelAsNoLongerNeeded(mhash)
		vRP.notify({"~r~[System]\n~w~Vehicul spawnat cu succes."})
	else
		vRP.notify({"~r~[System]\n~w~Model vehicul invalid."})
	end


end)