function get_GZ()
    local coords = GetEntityCoords(PlayerPedId())
    local _ , groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z+30.0, true)
    return groundZ
end


function isAtSea()
    local coords = GetEntityCoords(PlayerPedId())
    if not GetWaterHeight(coords.x, coords.y, coords.z) == false then
        return true
    else
        return false
    end
end


function SpawnRodInPedHand()
    local fishingRod = CreateObject(GetHashKey("prop_fishing_rod_01"), GetEntityCoords(PlayerPedId()), true, false, true)
    local boneIndex = GetPedBoneIndex(PlayerPedId(), 0x49d9)
    AttachEntityToEntity(fishingRod, PlayerPedId(), boneIndex, 0.15, 0.040, 0.001, 220.0, 300.0, 0.0, true, true, false, true, 1, true)
    return fishingRod 
end

function DespawnAllRods()
    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
    for i =1, 10 do -- force remove fishing rod from animation
        local xfishingRod = GetClosestObjectOfType(playerPedPos, 20.0, GetHashKey("prop_fishing_rod_01"), false, false, false)
        SetEntityAsMissionEntity(xfishingRod, false, true)
        
        DeleteEntity(xfishingRod)    
        fishingRod = nil
    end
end

function disable_abilities()
    DisableControlAction(0,24,true) -- disable attack
    DisableControlAction(0,25,true) -- disable aim
    DisableControlAction(0,47,true) -- disable weapon
    DisableControlAction(0,58,true) -- disable weapon
    DisableControlAction(0,263,true) -- disable melee
    DisableControlAction(0,264,true) -- disable melee
    DisableControlAction(0,257,true) -- disable melee
    DisableControlAction(0,140,true) -- disable melee
    DisableControlAction(0,141,true) -- disable melee
    DisableControlAction(0,142,true) -- disable melee
    DisableControlAction(0,143,true) -- disable melee
end

function CanFish()
    if isAtSea() and not IsPedSwimming(PlayerPedId()) and not IsPedFalling(PlayerPedId()) then
        return true
    else
        return false
    end 
end

function catch_fish(depth)
    possible_fishes = {}
    for _, peste_data in pairs(cfg.pesti) do
        if peste_data.adancime > depth then
            table.insert(possible_fishes, peste_data)
        end
    end

    if #possible_fishes == 0 then
        return peste_prins
    end

    peste_prins = possible_fishes[math.random(#possible_fishes)]
    
    return peste_prins
end


function fishable_fishes(depth)
    local possible_fishes = {}
    for _, peste_data in pairs(cfg.pesti) do
        if peste_data.adancime > depth then
            table.insert(possible_fishes, peste_data)
        end
    end

    return possible_fishes
end


function drawTxtC(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
  SetTextCentre(center)
    if(outline)then
      SetTextOutline()
  end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function showProgress(text, time_to_finish)

    local start_time_seconds = GetGameTimer() / 1000
    local progress = 0
    local r,g,b 
    CreateThread(function()
        while progress < 100 do
            local current_time_seconds = GetGameTimer() / 1000
            local time_passed_seconds = current_time_seconds - start_time_seconds
            progress = time_passed_seconds * 100 / time_to_finish

            r = math.floor((255 * progress) / 100)
            g = math.floor((255 * progress) / 100)
            b = math.floor((255 * (100 - progress)) / 10)
            DrawRect(0.5, 0.93, 0.2, 0.055, 0, 0, 0, 150)
            DrawRect(0.5, 0.93, progress*0.002, 0.045, 0,g,b, 170)
            
            drawTxtC(0.50,0.913 ,0.0,0.0,0.4, "~w~" .. text .. ": ~r~".. string.format("%.2f", progress) .."%", 255,255,255,255, 1, 4, 1)
            Wait(0)
        end
    end)
end



function k_draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
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


function teleport_ped_in_created_vehicle(model)
    local ped = PlayerPedId()
    model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(10)
    end
    local vehicle = CreateVehicle(model, spawn_barca.x, spawn_barca.y, spawn_barca.z, spawn_barca.heading, true, true)
    SetPedIntoVehicle(ped, vehicle, -1)
    SetVehicleNumberPlateText(vehicle, "FISHING")
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehicleNumberPlateTextIndex(vehicle, 5)
    
end

function fish_animation(time)
    RequestAnimDict("amb")
    RequestAnimDict("amb@world_human_stand_fishing")
    RequestAnimDict("amb@world_human_stand_fishing@idle_a")

    while (not HasAnimDictLoaded("amb@world_human_stand_fishing@idle_a")) do 
        Wait(0) 
    end

   TaskPlayAnim(PlayerPedId(),"amb@world_human_stand_fishing@idle_a","idle_a",1.0,-1.0, time, 0, 1, 0,0,0)
end

function mircea_presenting(ped)
    FreezeEntityPosition(ped, false)
    TaskGoToCoordAnyMeans(ped, locatie_unelte_pescuit.x, locatie_unelte_pescuit.y, locatie_unelte_pescuit.z, 1.0, 0, 0, 786603, 0xbf800000)

    CreateThread(function() --/me explaining
        timer = GetGameTimer() / 1000 --in seconds
        iterations = 0
        while iterations < 18 do
            Wait(0)
            --increment timer by 1 second
            if GetGameTimer() / 1000 - timer > 1 then
                timer = GetGameTimer() / 1000
                iterations = iterations + 0.5
            end

            p_coords = GetEntityCoords(ped)
            if iterations < 2 then
                k_draw3DText(p_coords.x, p_coords.y, p_coords.z+1.3, "~w~Mircea: ~g~" .. "Pescaria e o meserie buna..")
            end

            if iterations < 4 and iterations > 2 then
                k_draw3DText(p_coords.x, p_coords.y, p_coords.z+1.3, "~w~Mircea: ~g~" .. "Am prins o data un rechin..")
            end

            if iterations < 6 and iterations > 4 then
                k_draw3DText(p_coords.x, p_coords.y, p_coords.z+1.3, "~w~Mircea: ~g~" .. "Din cauza lui am jurat sa nu las pe nimeni sa se raneasca pe mare..")
            end

            if iterations < 8 and iterations > 6 then
                k_draw3DText(p_coords.x, p_coords.y, p_coords.z+1.3, "~w~Mircea: ~g~" .. "Aici ai uneltele.. Un sonar si o undita de 1 metru..")
            end

            if iterations < 10 and iterations > 8 then
                k_draw3DText(p_coords.x, p_coords.y, p_coords.z+1.3, "~w~Mircea: ~g~" .. "Oh cat de mult am pescuit cu undita asta..")
            end

            if iterations < 12 and iterations > 10 then
                k_draw3DText(p_coords.x, p_coords.y, p_coords.z+1.3, "~w~Mircea: ~g~" .. "...")
            end

            if iterations < 14 and iterations > 12 then
                k_draw3DText(p_coords.x, p_coords.y, p_coords.z+1.3, "~w~Mircea: ~g~" .. "Te voi astepta aici pentru cand vi cu pestele..")
            end

            if iterations < 16 and iterations > 14 then
                k_draw3DText(p_coords.x, p_coords.y, p_coords.z+1.3, "~w~Mircea: ~g~" .. "Mult noroc.. Vei avea nevoie..")
            end

            
        end
    end)


    CreateThread(function()
        anim_dict = "missheistdockssetup1ig_10@base"
        anim_name = "talk_pipe_base_worker1"

        RequestAnimDict(anim_dict)
        while not HasAnimDictLoaded(anim_dict) do
            Wait(0)
        end

        while true do
            Wait(0)
            if Vdist(GetEntityCoords(ped), locatie_unelte_pescuit.x, locatie_unelte_pescuit.y, locatie_unelte_pescuit.z) <= 1.5 then
                FreezeEntityPosition(ped, true)
                TaskPlayAnim(ped, anim_dict, anim_name, 1.0, -1.0, -1, 0, 1, 0, 0, 0)
                break
            end
        end
        Wait(3000)
        FreezeEntityPosition(ped, false)
        TaskGoToCoordAnyMeans(ped, locatie_vandut_peste.x, locatie_vandut_peste.y, locatie_vandut_peste.z, 1.0, 0, 0, 786603, 0xbf800000)
    
        while true do
            Wait(0)
            if Vdist(GetEntityCoords(ped), locatie_vandut_peste.x, locatie_vandut_peste.y, locatie_vandut_peste.z) <= 1.5 then
                FreezeEntityPosition(ped, true)
                TaskStartScenarioInPlace(ped, "WORLD_HUMAN_AA_SMOKE", 0, false)
                break
            end
        end
        
        TriggerEvent("toasty:Notify", {type="info", title="[Mircea]", message="Ti-am notat pe GPS, de acolo iei o barca"})
        setRoute(vector3(garaj_barca.x, garaj_barca.y, garaj_barca.z))
    end)
end


function mircea_trading(ped, inv)
    TriggerServerEvent("Pescar:GiveFishing_Fish", "update") 
    pesti_gasiti = {}
    for specie, item in pairs(inv) do
        for _, pesti_table in pairs(cfg.pesti) do
            if specie == pesti_table.name then
                table.insert(pesti_gasiti, {specie = specie, amount = item.amount})
            end
        end
    end

    local lines = {
        function (peste, cantitate, price) return "Pentru ce ai tu aici... " .. cantitate .. " " .. peste .. " nu iti dau mult de " .. price  end,
        function (peste, cantitate, price) return "Din ochi il calculez... Pentru pestii astia " .. cantitate .. " " .. peste .. " " .. "iti dau " .. price end,
        function (peste, cantitate, price) return "Nu par asa multi.. dar iti dau " .. price .. " pentru " .. cantitate .. " bucati de " .. peste end, 
        function (peste, cantitate, price) return "Ma omule... La atatia pesti " .. cantitate .. " " .. peste .. " " .. "nu ca sunt zgarcit, dar iti dau " .. price end,
        function (peste, cantitate, price) return "Desi mi se par putini astia ".. cantitate .. " " .. peste .. " am sa-ti dau " .. price end,
        function (peste, cantitate, price) return "Fii atent.. pentru tine iti cumpar astia " .. cantitate .. " " .. peste .. " pentru " .. price end,
        function (peste, cantitate, price) return "Daca mai vi pe la mine, daca viitoare iti dau mai bine, acu numa " .. price .. " pentru " .. cantitate .. " " .. peste end,
    }

    
    for _, tbl in pairs(pesti_gasiti) do
        if tbl.specie == "Bocanc" then
            TriggerServerEvent("Pescar:GiveFishingMoney", 1)
            talk(ped, "Ce mi-ai adus aici... bocanci, am destui pe asta nu-ti dau nimic")
        else
            if tbl.specie == "Platica" then
                TriggerServerEvent("Achievements:UP_Current_Progress", "source=" , "Prinde o platica, si du-o lui Mircea.")
            end
            TriggerServerEvent("Pescar:GiveFishingMoney", tbl.specie, tbl.amount * get_fish_by_name(tbl.specie).price, tbl.amount)
            talk(ped, lines[math.random(1, #lines)](tbl.specie, tbl.amount, tbl.amount * get_fish_by_name(tbl.specie).price, tbl.amount))    
        end
    end
    iteme_in_inv = {}
    has_any_type_of_fish = false
end

function get_fish_by_name(name)
    for _, pesti_table in pairs(cfg.pesti) do
        if pesti_table.name == name then
            return pesti_table
        end
    end
end

function talk(ped, text)
    timer = GetGameTimer() / 1000 --in seconds
    iterations = 0
    while iterations < 5 do
        Wait(0)
        if GetGameTimer() / 1000 - timer > 1 then
            timer = GetGameTimer() / 1000
            iterations = iterations + 0.5
        end
        p_coords = GetEntityCoords(ped)
        if iterations < 5 then
            k_draw3DText(p_coords.x, p_coords.y, p_coords.z+1.3, "~w~Mircea: ~g~" .. text)
        end
    end
end


function has_any_fish(inv)
    for specie, item in pairs(inv) do
        for _, pesti_table in pairs(cfg.pesti) do
            if specie == pesti_table.name then
                return true
            end
        end
    end
    return false
end

function equip_Fishing_Backpack_Visuals()
    SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 0)
end


function k_CreatePed(model, x,y,z, heading)
    local npcPed = nil
    local model = model
    RequestModel(model)
    while (not HasModelLoaded(model)) do
        Wait(1)
    end
    npcPed = CreatePed(1, model, x,y,z-1.0, heading, false, false)
    SetModelAsNoLongerNeeded(model)
    --SetEntityHeading(licenseNpc, -50)
    FreezeEntityPosition(npcPed, true)
    SetEntityInvincible(npcPed, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    return npcPed
end

function drawSubtitleText(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	SetTextFont(fontId)
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end



general_blip = nil
function setRoute(waypoint)
    if general_blip ~= nil then 
        RemoveBlip(general_blip)
    end
    general_blip = AddBlipForCoord(waypoint)
    SetBlipRoute(general_blip, true)
    SetBlipSprite(general_blip,1)
	SetBlipColour(general_blip,5)
	SetBlipAsShortRange(general_blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Pescar")
	EndTextCommandSetBlipName(general_blip)
	SetBlipRoute(general_blip,true)

    CreateThread(function()
        while general_blip ~= nil do
            Wait(0)
            if Vdist(GetEntityCoords(PlayerPedId()), waypoint) <= 2.5 then
                destroyRoute()
            end
        end
    end)
end

function destroyRoute()
    if general_blip ~= nil then 
        RemoveBlip(general_blip)
        general_blip = nil
    end
end


