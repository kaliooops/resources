local gymTable = nil
local theGym = nil

local incircle = false
local flexing = false

local workDone = 0

GymInWorkout = false

function tvRP.populateGymTable(theWorkouts, gym)
	gymTable = theWorkouts
	theGym = gym
end

local function DrawText3D36(x,y,z, text, scl) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	local wTime = 2500
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 252.72,-271.10,59.92) < 5.0)then
			wTime = 1
			DrawText3D36(252.72,-271.10,59.92+0.4, "~y~Flexare", 1.2)
			DrawMarker(21, 252.72,-271.10,59.92, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 0, 255, 0, 0, 0, 1)
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 252.72,-271.10,59.92) < 0.95)then
				incircle = true
				if(incircle == true) then
					if(flexing == false)then
						--gym_DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a ~g~Te Flexa")
						msg ("APASA  ~g~E~w~  PENTRU A TE ~r~FLEXA",4,0.45,0.96,0.50,255,255,255,255)
						if(IsControlJustReleased(1, 51))then
							flexing = true
							TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_MUSCLE_FLEX", 0, true)
						end
					end
				end
			elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, 252.72,-271.10,59.92) > 0.25)then
				incircle = false
			end
			if(flexing == true)then
				wTime = 1
				--gym_DisplayHelpText("Apasa ~INPUT_CONTEXT_SECONDARY~ pentru a oprii flexarea")
				msg ("APASA  ~g~Q~w~  PENTRU A OPRII ~r~FLEXAREA",4,0.45,0.96,0.50,255,255,255,255)
				if(IsControlJustReleased(1, 44))then
					ClearPedTasksImmediately(GetPlayerPed(-1))
					flexing = false
				end
			end
		end
		if(theGym ~= nil)then
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, theGym[1], theGym[2], theGym[3]) < 5.0)then
				wTime = 1
				DrawText3D36(theGym[1], theGym[2], theGym[3]+0.4, "~y~Receptie", 1.2)
				DrawMarker(21, theGym[1], theGym[2], theGym[3], 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 255, 255, 0, 255, 0, 0, 0, 1)
				if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, theGym[1], theGym[2], theGym[3]) < 1.0)then
					incircle = true
					if(incircle == true) then
						-- gym_DisplayHelpText("Apasa ~INPUT_CONTEXT~ sa vorbesti cu ~g~Receptionistul")
						msg ("APASA  ~g~E~w~  SA VORBESTI CU ~r~RECEPTIONISTUL",4,0.45,0.96,0.50,255,255,255,255)
						if(IsControlJustReleased(1, 51))then
							inGymCircle = true
							TriggerServerEvent("showGymMenu")
						end
					end
				elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, theGym[1], theGym[2], theGym[3]) > 1.0)then
					incircle = false
				end
			end
		end
		
		if(gymTable ~= nil)then
			for i, v in pairs(gymTable) do
				local x, y, z = v[1], v[2], v[3]
				if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 18.0)then
					wTime = 1
					DrawText3D36(x,y,z+0.4, "~w~"..v[4], 1.2)
					DrawMarker(21, x, y, z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 153, 255, 255, 0, 0, 0, 1)
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 0.95)then
						incircle = true
						if(incircle == true) then
							DisableControlAction(2, 37, true) -- TAB
							if(GymInWorkout == false)then
								--gym_DisplayHelpText("Apasa ~INPUT_CONTEXT~ pentru a lucra ~g~"..v[4])
								msg ("APASA  ~g~E~w~  PENTRU A LUCRA LA ~r~"..v[4],4,0.45,0.96,0.50,255,255,255,255)
								if(IsControlJustReleased(1, 51))then
									vRPserver.hasMembership({}, function(membership)
										if(membership)then
											vRPserver.initWorkout({i})
										else
											tvRP.notify("~w~[GYM] ~r~Nu ai abonament!")
										end
									end)
								end
							end
						end
					elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) > 0.25)then
						incircle = false
					end
				end
				if(GymInWorkout == true)then
					wTime = 1
					--gym_DisplayHelpText("Apasa ~INPUT_CONTEXT_SECONDARY~ pentru a oprii exercitiul")
					msg ("APASA  ~g~Q~w~  PENTRU A TE ~r~OPRII",4,0.45,0.96,0.50,255,255,255,255)
					if(IsControlJustReleased(1, 44))then
						ClearPedTasksImmediately(GetPlayerPed(-1))
						GymInWorkout = false
						workDone = 0
						vRPserver.stopWorkout({})
					end
				end
			end
		end
		Citizen.Wait(wTime)
		wTime = 2500
	end
end)

local function randomFloat(lower, greater)
	local x = lower + math.random()  * (greater - lower);
	local result = string.format("%0.1f", x)
    return result
end

Citizen.CreateThread(function()
	local x2, y2, z2 = 244.45,-264.66,59.92
	while true do
		Citizen.Wait(60000)
		if(GymInWorkout and workDone < 5)then
			local px,py,pz = tvRP.getPosition()
			if(GetDistanceBetweenCoords(x2, y2, z2, px, py, pz, true) > 30.0)then
				ClearPedTasksImmediately(GetPlayerPed(-1))
				GymInWorkout = false
				workDone = 0
				vRPserver.stopWorkout({})
				tvRP.notify("~r~Te-ai indepartat prea mult de sala de sport si exercitiul s-a oprit!")
			else
				workDone = workDone + 1
				strenght = randomFloat(1, 2)
				vRPserver.gainStrenght({strenght})
				tvRP.notify("~g~Simti cum ti se umfla muschii iar bratele cum iti obosesc!")
			end
		end
	end
end)

function tvRP.startWorkout(workout)
	if(GymInWorkout == false)then
		GymInWorkout = true
		if(workout == "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS")then
			coords = GetEntityCoords(GetPlayerPed(-1))
			TaskStartScenarioAtPosition(GetPlayerPed(-1), "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS", coords.x, coords.y, coords.z-0.1, GetEntityHeading(GetPlayerPed(-1)), 0, 0, false)
		else
			TaskStartScenarioInPlace(GetPlayerPed(-1), workout, 0, true)
		end
	end
end

function msg (text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
  end