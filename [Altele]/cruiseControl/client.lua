local enableCruise = false
Citizen.CreateThread( function()
	while true do 
		Citizen.Wait( 0 )   
		if IsControlJustPressed(1, 166) then
			local ped = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(ped, false)
			local vehicleModel = GetEntityModel(vehicle)
			local speed = GetEntitySpeed(vehicle)
			local float Max = GetVehicleMaxSpeed(vehicleModel)
			
			local inVehicle = IsPedSittingInAnyVehicle(ped)
			if (inVehicle) then
				if (GetPedInVehicleSeat(vehicle, -1) == ped) then
					if enableCruise == false then
						SetEntityMaxSpeed(vehicle, speed)
						TriggerEvent("chatMessage", "^3Cruise Control^0:", {255, 255, 255}, "Cruise control | Viteza max ".. math.floor(speed*3.6).."km/h")
						enableCruise = true
				
					else
						SetEntityMaxSpeed(vehicle, Max)
						TriggerEvent("chatMessage", "^3Cruise Control^0:", {255, 255, 255}, "Cruise control dezactivat")
						enableCruise = false
					end
				end
			end
		end
	end
end)