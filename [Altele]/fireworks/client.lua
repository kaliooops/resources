local box = nil
local animlib = 'anim@mp_fireworks'

RegisterNetEvent('frobski-fireworks:start')
AddEventHandler('frobski-fireworks:start', function()

	
	RequestAnimDict(animlib)

	while not HasAnimDictLoaded(animlib) do
		   Citizen.Wait(10)
    end
        
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
		   Wait(10)
		end
	end

	local pedcoords = GetEntityCoords(GetPlayerPed(-1))
	local ped = GetPlayerPed(-1)
	local times = 5

	TaskPlayAnim(ped, animlib, 'place_firework_3_box', -1, -8.0, 3000, 0, 0, false, false, false)
	Citizen.Wait(4000)
	ClearPedTasks(ped)
		   
	box = CreateObject(GetHashKey('ind_prop_firework_03'), pedcoords, true, false, false)
	PlaceObjectOnGroundProperly(box)
	FreezeEntityPosition(box, true)
	local firecoords = GetEntityCoords(box)

	Citizen.Wait(10000)
	repeat
	UseParticleFxAssetNextCall("scr_indep_fireworks")
	local part1
	local bursts = {"scr_indep_firework_explosion_bombs", "scr_indep_firework_shotburst", "scr_indep_firework_trailburst", "scr_indep_firework_starburst","scr_indep_firework_fountain" }
	part1 = StartNetworkedParticleFxNonLoopedAtCoord(bursts[math.random(#bursts)], firecoords, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	local r,g,b = getNewGradiant()
	SetParticleFxNonLoopedColour(r,g,b)

	times = times - 1
	Citizen.Wait(1000)
	until(times == 0)
	DeleteEntity(box)
	box = nil
end)
function getNewGradiant()
	local r,g,b 
	r = math.floor((255 * math.random()) / 1.0)
	g = math.floor((255 * math.random()) / 1.0)
	b = math.floor((255 * math.random()) / 1.0)
	--convert 255 to be 1.0
	r = r / 255.0
	g = g / 255.0
	b = b / 255.0
	return r,g,b
end


--[[
	for admins
]]

function get_random_coord_in_radius(pos, rad)
	local vec = GetEntityCoords(GetPlayerPed(-1))
	local pos = pos or vec
	local rad = rad or 15.0
	local pos = pos + vector3(math.random(-rad, rad), math.random(-rad, rad), math.random(-rad, rad))
	pos = vector3(pos.x, pos.y, vec.z)
	return pos
end

RegisterCommand("firework", function ()
	TriggerServerEvent("admin_firework_area")
end)

--place fireworks in 10 meters radius around ped
RegisterNetEvent("admin_firework_area")
AddEventHandler("admin_firework_area", function()
	local x = 100
	while x > 0 do
		x= x-1 
		Wait(1)
		CreateThread(function ()
			local times = 5000
			local firecoords = get_random_coord_in_radius(GetEntityCoords(GetPlayerPed(-1)), 100.0)
			repeat
			UseParticleFxAssetNextCall("scr_indep_fireworks")
			local part1
			local bursts = {"scr_indep_firework_explosion_bombs", "scr_indep_firework_shotburst", "scr_indep_firework_trailburst", "scr_indep_firework_starburst"}
			part1 = StartNetworkedParticleFxNonLoopedAtCoord(bursts[math.random(#bursts)], firecoords, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
			local r,g,b = getNewGradiant()
			SetParticleFxNonLoopedColour(r,g,b)
			times = times - 1
			Citizen.Wait(150)
			until(times == 0)
		end)
	end
end)
