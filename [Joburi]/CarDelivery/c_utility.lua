function k_CreatePed(model, x,y,z, heading)
    local npcPed = nil
    local model = model
    RequestModel(model)
    while (not HasModelLoaded(model)) do
    Citizen.Wait(1)
    print("lading model")
    end
    npcPed = CreatePed(1, model, x,y,z-1.0, heading, false, false)
    SetModelAsNoLongerNeeded(model)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    return npcPed
end
function Draw3DTextC(x,y,z, text, scl, font) 

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

function setRoute(waypoint)
    cfg.mission_blip = AddBlipForCoord(waypoint)
    SetBlipRoute(cfg.mission_blip, true)
    SetBlipSprite(cfg.mission_blip,1)
	SetBlipColour(cfg.mission_blip,5)
	SetBlipAsShortRange(cfg.mission_blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Car Delivery")
	EndTextCommandSetBlipName(cfg.mission_blip)
	SetBlipRoute(cfg.mission_blip,true)
end

function spawnCar(veh_name, coords, heading)
    local model = GetHashKey(veh_name)
    if not tryLoadModel(model) then return end
    
    if HasModelLoaded(model) then
        local veh = CreateVehicle(model, coords.x, coords.y, coords.z, heading, false, false) 
        return veh
    end        
end
function tryLoadModel(model)
    RequestModel(model)
    local i = 0
    while not HasModelLoaded(model) do
        Wait(300)
        i = i +1
        if (i == 5) then print("Failed loading model: " .. model) return false  end
    end
    return true
end

--pick random points around entity
function getRandomPointsAroundEntity(entity, points)
    local coords = GetEntityCoords(entity)
    local rnd = math.random(1, points)
    local angle = 360 / points
    local newCoords = {}
    for i = 1, points do
        local x = math.sin(math.rad(angle * i)) * rnd
        local y = math.cos(math.rad(angle * i)) * rnd
        local z = 0
        newCoords[i] = {x = coords.x + x, y = coords.y + y, z = coords.z + z}
    end
    return newCoords
end

--get players in a 5 meter radius from active players
function getPlayersInRadius(radius)
    local players = {}
    for _, player in pairs(GetActivePlayers()) do
        local player = GetPlayerPed(player)
        if Vdist(GetEntityCoords(player), GetEntityCoords(PlayerPedId())) < radius then
            table.insert(players, player)

        end
    end
    return {n_players = #players, players = players}
end



function DeleteGivenVehicle( veh, timeoutMax )
    local timeout = 0 

    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle( veh )

    if ( DoesEntityExist( veh ) ) then

        -- Fallback if the vehicle doesn't get deleted
        while ( DoesEntityExist( veh ) and timeout < timeoutMax ) do 
            DeleteVehicle( veh )

            -- The vehicle has been banished from the face of the Earth!
            if ( not DoesEntityExist( veh ) ) then 
            end 

            -- Increase the timeout counter and make the system wait
            timeout = timeout + 1 
            Citizen.Wait( 500 )

            -- We've timed out and the vehicle still hasn't been deleted. 
            if ( DoesEntityExist( veh ) and ( timeout == timeoutMax - 1 ) ) then
            end 
        end 
    else 
    end 
end 