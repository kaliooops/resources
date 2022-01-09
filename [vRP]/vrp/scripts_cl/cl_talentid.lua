local disPlayerNames = 13
local playerData = {}

local function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
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

AddEventHandler("playerSpawned", function()
	Citizen.CreateThread(function()
	    while true do
	        if IsControlPressed(0, 178) then
	            for _, id in ipairs(GetActivePlayers()) do
	    			if NetworkIsPlayerActive(id) then
	    				if GetPlayerPed(id) ~= GetPlayerPed(-1) then
	    					local sId = GetPlayerServerId(id)
	                        if playerData[sId] then
	                        	if playerData[sId].dst then
		        					if playerData[sId].dst < disPlayerNames then
		        						local ped = GetPlayerPed(id)
										if IsPedInAnyVehicle(ped, false) then
											local veh = GetVehiclePedIsIn(ped)
											if not IsThisModelABike(GetEntityModel(veh)) then
												if GetPedInVehicleSeat(veh, -1) == ped then
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, -0.4, 0.0, 0.0))
												elseif GetPedInVehicleSeat(veh, 0) == ped then
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.4, 0.0, 0.0))
												elseif GetPedInVehicleSeat(veh, 1) == ped then
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, -0.4, -0.8, 0.0))
												else
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.4, -0.8, 0.0))
												end
											else
												if GetPedInVehicleSeat(veh, -1) == ped then
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.0, 0.0, 0.3))
												else
													x2, y2, z2 = table.unpack(GetOffsetFromEntityInWorldCoords(veh, 0.0, -0.5, 0.5))
												end
											end
										else
											x2, y2, z2 = table.unpack(GetEntityCoords(ped, true))
										end
		        						if NetworkIsPlayerTalking(id) then
		        							DrawText3D(x2, y2, z2+1, playerData[sId].user_id, 46, 217, 118)
		        						else
		        							DrawText3D(x2, y2, z2+1, playerData[sId].user_id, 255, 255, 255)
		        						end
		        					end
		        				end
	                        end
	    				end
	    			end
	            end
	        end
	        Citizen.Wait(0)
	    end
	end)

	Citizen.CreateThread(function()
	    while true do
	        for _, id in ipairs(GetActivePlayers()) do
	            if NetworkIsPlayerActive(id) then
	            	local selfPed = GetPlayerPed(-1)
	            	local userPed = GetPlayerPed(id)
	                if userPed ~= selfPed then
                        local x1, y1, z1 = table.unpack(GetEntityCoords(selfPed, true))
                        local x2, y2, z2 = table.unpack(GetEntityCoords(userPed, true))
                        local distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                        if playerData[GetPlayerServerId(id)] then
                        	playerData[GetPlayerServerId(id)].dst = distance
                        end
	                end
	            end
	        end
	        Citizen.Wait(3000)
	    end
	end)
end)

RegisterNetEvent("id:initPlayer")
AddEventHandler("id:initPlayer", function(src, uid)
	playerData[src] = {user_id = uid}
end)

RegisterNetEvent("id:removePlayer")
AddEventHandler("id:removePlayer", function(src)
	playerData[src] = nil
end)