function k_CreatePed(model, x,y,z, heading)
    local npcPed = nil
    local model = model
    RequestModel(model)
    while (not HasModelLoaded(model)) do
    Citizen.Wait(1)
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

print("[CarDelivery] Securely Loaded")
local tocken = "1@3FSbnH23asdjvkas123ASDkvlasdeiv"
cfg = {
    npc = nil,
    npc_model = 0xA5C787B6,
    npc_location = vector3(-33.41, -1086.51, 26.28),
}
local difficulty = 1
RegisterCommand("cd_dificulty", function (x,args,y)
    difficulty = tonumber(args[1])

    if difficulty > 3 then difficulty = 3 end
    if difficulty < 1 then difficulty = 1 end
    TriggerEvent("toasty:Notify", {type = "info", title="Dificultate", message = "Ai setat dificultatea la "..difficulty})

end, false)


cfg.mission_blip = nil
cfg.hasUserJob = false
cfg.locatie_de_praduit = nil
cfg.locatii = {
    vector3(1212.4465332031,-2991.8959960938,5.8653540611267),
    vector3(210.62565612793,-3113.8706054688,5.7902607917786),
    vector3(-521.50170898438,-2827.4243164062,6.0003814697266),
    vector3(-521.50170898438,-2827.4243164062,6.0003814697266),
    vector3(-2336.4387207031,272.40728759766,169.46705627441),
    vector3(3694.2299804688,4563.955078125,25.174034118652),
    vector3(3813.7534179688,4461.6215820312,4.0192842483521),
    vector3(2749.2426757812,1340.1033935547,24.523977279663),
    vector3(2820.2561035156,1698.5621337891,24.706918716431),
    vector3(793.75189208984,1279.6602783203,360.29650878906),
    vector3(2791.9426269531,-709.01171875,4.7172923088074),
    vector3(-2764.2756347656,1443.4129638672,101.03409576416),
    vector3(-1151.9704589844,2677.5825195312,18.093910217285),
    vector3(100.32978820801,3710.462890625,39.729763031006),
    vector3(-489.99081420898,2982.6938476562,26.390264511108),
    vector3(-67.121353149414,1906.8155517578,196.14131164551),
}


cfg.car_to_steal = nil

cfg.masini = {
    "rmodx6",
    "rmodm4gts",
    "rmodmi8lb",
    "ocnetrongt",
    "audquattros",
    "divo",
    "lanex400",
    "rs6avant20",
    "c63s",
    "bugatti",
    "lp700",
    -- "gle21",
    -- "gtr50",
    -- "22g63",
    -- "m422",
    -- "sjamg",
    -- "mache",
    -- "ocni422spe",
    -- "19sclass",
    -- "1016urus",
}


RegisterNetEvent("carDelivery:hasUserJob")
AddEventHandler("carDelivery:hasUserJob", function (bool_job)
    cfg.hasUserJob = bool_job
end)

CreateThread(function () -- check if player has job
    while true do
        Wait(1000)
        TriggerServerEvent("carDelivery:hasUserJob")
    end
end)

--generate it
CreateThread(function()
    cfg.npc = k_CreatePed(cfg.npc_model, cfg.npc_location.x, cfg.npc_location.y, cfg.npc_location.z+0.1 , 221.92)
    FreezeEntityPosition(cfg.npc, true)
    SetEntityInvincible(cfg.npc, true)
    while true do
        Wait(1000)
    
        while Vdist2(cfg.npc_location.x, cfg.npc_location.y, cfg.npc_location.z , GetEntityCoords(PlayerPedId())) < 15 and cfg.hasUserJob do
            Wait(0)
            Draw3DTextC(cfg.npc_location.x, cfg.npc_location.y, cfg.npc_location.z+1.2, "Giany Versace", 1.0, 1)
            Draw3DTextC(cfg.npc_location.x, cfg.npc_location.y, cfg.npc_location.z+1.1, "[~b~Car Dealer~w~]", 1.0 , 1)
        end
    end
end)


CreateThread(function() -- main
    while true do
        if cfg.hasUserJob and cfg.mission_blip == nil then
            TriggerEvent("toasty:Notify", {type = "info", title="Car Delivery", message = "Am gasit niste baieti cu o masina, adu-o la mine!"})

            --pick a random location
            cfg.locatie_de_praduit = cfg.locatii[math.random(1, #cfg.locatii)]
            setRoute(cfg.locatie_de_praduit)
            job()
        end

        Wait(180000)

    end    

end)


function job()
    local enemies = {}
    local factor = 1
    local n_enemies = 1
    local p_accuracy = 50
    local team = {}
    while cfg.mission_blip ~= nil do
        Wait(1000)

        while Vdist(GetEntityCoords(PlayerPedId()), cfg.locatie_de_praduit) < 100 and cfg.mission_blip ~= nil do
            Wait(0)
            
            if cfg.car_to_steal == nil then
                --spawn car at the cfg.locatie_de_praduit
                cfg.car_to_steal = spawnCar(cfg.masini[math.random(1, #cfg.masini)], cfg.locatie_de_praduit, math.random(0, 360))
                cfg.car_to_steal = VehToNet(cfg.car_to_steal)
                NetworkRegisterEntityAsNetworked(cfg.car_to_steal)
                
                team =getPlayersInRadius(15).players

                factor = getPlayersInRadius(15).n_players
                factor = factor * difficulty

                local p_fac = 1
                local p_health = 100

                if difficulty == 1 then
                    p_fac = math.random(2, 3)
                    p_health = 100
                    p_armor = 100
                    
                end

                if difficulty == 2 then
                    p_fac = math.random(3, 4)
                    p_health = 150
                    p_armor = 150
                    p_accuracy = 60
                end
                
                if difficulty == 3 then
                    p_fac = math.random(3, 3)
                    p_health = 200
                    p_armor = 200
                    p_accuracy = 75
                end

                local spawn_ped_coords = getRandomPointsAroundEntity(cfg.car_to_steal, p_fac * factor)
                n_enemies = p_fac
                for i=1 , #spawn_ped_coords do
                    local ped_to_insert = k_CreatePed(2064532783, spawn_ped_coords[i].x, spawn_ped_coords[i].y, spawn_ped_coords[i].z, math.random(0, 360))

                    GiveWeaponToPed(ped_to_insert, "WEAPON_PISTOL", 21, false, true)
                    ped_to_insert = PedToNet(ped_to_insert)
                    NetToPed(ped_to_insert)
                    -- NetworkUseHighPrecisionBlending(ped_to_insert, false)
                    SetEntityAsMissionEntity(ped, true, true)
                    SetNetworkIdExistsOnAllMachines(ped_to_insert, true)
                    Wait(100)
                    NetworkRegisterEntityAsNetworked(ped_to_insert)
                    table.insert(enemies, ped_to_insert)

                    CreateThread(function()
                        AddRelationshipGroup('team1')
                        AddRelationshipGroup('team2')
                        for _, ped in pairs(enemies) do
                            SetRelationshipBetweenGroups(5, 'team1', 'team2')
                            SetRelationshipBetweenGroups(5, 'team2', 'team1')
                            SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey('team2')) -- or team1
                            SetPedCombatAttributes(ped, 0, true) --[[ BF_CanUseCover ]]
                            SetPedCombatAttributes(ped, 5, true) --[[ BF_CanFightArmedPedsWhenNotArmed ]]
                            SetPedCombatAttributes(ped, 46, true) --[[ BF_AlwaysFight ]]
                            SetPedFleeAttributes(ped, 0, true) --[[ allows/disallows the ped to flee from a threat i think]]
                            
                            SetPedRelationshipGroupHash(ped, GetHashKey("team1")) --[[ when i did army, the peds fought eachother and it was pretty funny - https://runtime.fivem.net/doc/natives/#_0xC80A74AC829DDD92 ]]
                            SetPedAccuracy(ped, p_accuracy)
                            SetPedSuffersCriticalHits(ped, true)
                            GiveWeaponToPed(ped, "WEAPON_PISTOL", 2000, true--[[ weapon is hidden or not (bool)]], false) --[[ https://runtime.fivem.net/doc/natives/#_0xBF0FD6E56C964FCB]]
                            SetPedMaxHealth(ped, p_health)
                            SetPedArmour(ped, p_armor)
                            --get random team member
                            local team_member = team[math.random(1, #team)]
                            print(#team)
                            TaskCombatPed(ped, team_member, 0, 16)
                        end

                        while true do 
                            Wait(1000)
                            if GetEntityHealth(PlayerPedId()) <= 120 then
                                TriggerEvent("toasty:Notify", {type = "info", title="Car Delivery", message = "Ai pierdut o masina!"})

                                for _, ped in pairs(enemies) do
                                    NetworkUnregisterNetworkedEntity(ped)
                                    DeletePed(ped)
                                    DeleteEntity(ped)
                                end                  
                                enemies = {}    
                                SetEntityAsMissionEntity(cfg.car_to_steal, true, true)
                                DeleteVehicle(cfg.car_to_steal)
                                DeleteEntity(cfg.car_to_steal)
                                DeleteGivenVehicle(cfg.car_to_steal, 10)
                                cfg.car_to_steal = nil
                                RemoveBlip(cfg.mission_blip)
                                cfg.mission_blip = nil
                                RemovePedFromGroup(PlayerPedId())
                                return
                            end
                        end
                    end)
                end
            end
        end

        if #enemies > 0 then
            for _, ped in pairs(enemies) do
                NetworkUnregisterNetworkedEntity(ped)
                DeletePed(ped)
                DeleteEntity(ped)
            end
            enemies = {}


            if GetVehiclePedIsUsing(PlayerPedId()) == cfg.car_to_steal then
                TriggerEvent("toasty:Notify", {type = "info", title="Car Dealer", message = "Vino sa-mi aduci masina!"})
                CreateThread(function()
                    RemoveBlip(cfg.mission_blip)
                    cfg.mission_blip = nil
                    while true do
                        Wait(1000)
                        if cfg.mission_blip == nil then
                            setRoute(cfg.npc_location)
                        end
                        while Vdist(GetEntityCoords(PlayerPedId()), cfg.npc_location) < 5 do
                            Wait(0)
                            if IsControlJustPressed(1, 51) then
                                local money = math.random(400, 600) * factor * n_enemies
                                TriggerServerEvent("carDelivery:PayMe", money, tocken)
                                TriggerEvent("toasty:Notify", {type = "success", title="Car Delivery", message = "Ai primit " .. money .. "$"})
                                
                                TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Livreaza o masina lui Giany Versace.")
                                
                                RemoveBlip(cfg.mission_blip)
                                cfg.mission_blip = nil
                                ClearPedTasksImmediately(PlayerPedId())
                                --delete car to steal
                                SetEntityAsMissionEntity(cfg.car_to_steal, true, true)
                                DeleteVehicle(cfg.car_to_steal)
                                DeleteEntity(cfg.car_to_steal)
                                
                                DeleteGivenVehicle(cfg.car_to_steal, 10)
                                RemovePedFromGroup(PlayerPedId())

                                cfg.car_to_steal = nil
                                Wait(5000)
                                return
                            end
                        end
                    end
                end)
                return
            else
                TriggerEvent("toasty:Notify", {type = "info", title="Giany Versace", message = "Data viitoare macar incearca..."})

                SetEntityAsMissionEntity(cfg.car_to_steal, true, true)
                DeleteVehicle(cfg.car_to_steal)
                DeleteEntity(cfg.car_to_steal)
                RemoveBlip(cfg.mission_blip)
                cfg.car_to_steal = nil
                cfg.mission_blip = nil
                RemovePedFromGroup(PlayerPedId())
                DeleteGivenVehicle(cfg.car_to_steal, 10)

                return
            end
        end
    end
end    

