-- CONFIG --

-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 240

-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(5000)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == math.ceil(secondsUntilKick / 4) then
						TriggerEvent("chatMessage", "^3k2^0: ^0Vei fi dat afara in ^1" .. time .. " ^0secunde pentru ca ai fost AFK!")
					end

					time = time - 1
				else
					TriggerServerEvent("kickForBeingAnAFKDouchebag")
				end
			else
				time = secondsUntilKick
			end

			prevPos = currentPos
		end
	end
end)