local ind = {l = false, r = false}

local hudState = true
RegisterNetEvent("ples-hud:Speedometer")
AddEventHandler("ples-hud:Speedometer", function(state)
	hudState = state

	if not hudState then
		SendNUIMessage({
			showhud = false
		})
	end
end)

Citizen.CreateThread(function()
	while true do

		if not hudState then
			Citizen.Wait(1000)
		else 
			local Ped = GetPlayerPed(-1)
			if(IsPedInAnyVehicle(Ped)) then
				local PedCar = GetVehiclePedIsIn(Ped, false)
				if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then

					-- Speed
					carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
					SendNUIMessage({
						showhud = true,
						speed = carSpeed
					})

					-- Lights
					_,feuPosition,feuRoute = GetVehicleLightsState(PedCar)
					if(feuPosition == 1 and feuRoute == 0) then
						SendNUIMessage({
							feuPosition = true
						})
					else
						SendNUIMessage({
							feuPosition = false
						})
					end
					if(feuPosition == 1 and feuRoute == 1) then
						SendNUIMessage({
							feuRoute = true
						})
					else
						SendNUIMessage({
							feuRoute = false
						})
					end

					local VehIndicatorLight = GetVehicleIndicatorLights(GetVehiclePedIsUsing(PlayerPedId()))

					if(VehIndicatorLight == 0) then
						SendNUIMessage({
							clignotantGauche = false,
							clignotantDroite = false,
						})
					elseif(VehIndicatorLight == 1) then
						SendNUIMessage({
							clignotantGauche = true,
							clignotantDroite = false,
						})
					elseif(VehIndicatorLight == 2) then
						SendNUIMessage({
							clignotantGauche = false,
							clignotantDroite = true,
						})
					elseif(VehIndicatorLight == 3) then
						SendNUIMessage({
							clignotantGauche = true,
							clignotantDroite = true,
						})
					end

				else
					SendNUIMessage({
						showhud = false
					})
				end
			else
				SendNUIMessage({
					showhud = false
				})
			end
		end

		Citizen.Wait(1000)
	end
end)

-- Consume fuel factor
Citizen.CreateThread(function()
	while true do

		if not hudState then
			Citizen.Wait(1000)
		else 
			local Ped = GetPlayerPed(-1)
			if(IsPedInAnyVehicle(Ped)) then
				local PedCar = GetVehiclePedIsIn(Ped, false)
				if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
					carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
					fuel = GetVehicleFuelLevel(PedCar)


					SendNUIMessage({
						showfuel = true,
						fuel = fuel
					})
				end
			end
		end
		
		Citizen.Wait(500)
	end
end)