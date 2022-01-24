local radare = {
	{-30.438453674316,-950.46606445312,29.229768753052,50},
	{98.459381103516,-999.68212890625,29.225748062134,50},
	{393.9930114746,-1051.6182861328,29.14234161377,50},
	{780.17028808594,-1006.6711425782,25.957412719726,50},
	{53.383766174316,-1132.7622070312,29.156173706054,50},
	{172.35095214844,-821.84747314454,31.000087738038,50}
}

Citizen.CreateThread(function()
	while true do
	    Wait(15)
		for k,v in pairs(radare) do
			local playerPed = GetPlayerPed(-1)
        	local coords = GetEntityCoords(playerPed)
			if Vdist2(v[1],v[2],v[3],coords.x,coords.y,coords.z) < 10 then
				checkSpeed(v[4])
			end
	  	end
	end
end)

local amendast = false

function timeout()
	Citizen.Wait(5000)
	amendast=false
end

function checkSpeed(maxspeed)
  local pP = GetPlayerPed(-1)
  local speed = GetEntitySpeed(pP)
  local vehicle = GetVehiclePedIsIn(pP, false)
  local driver = GetPedInVehicleSeat(vehicle, -1)
	local kmhspeed = math.ceil(speed*3.6)
	if kmhspeed > maxspeed and driver == pP and not amendast then
		Citizen.Wait(250)
		amendast = true
		amenda = math.floor(tonumber(kmhspeed - maxspeed) *2)
		viteza = kmhspeed
		TriggerServerEvent('amendeaza',amenda,viteza)
		timeout()
	end
end

