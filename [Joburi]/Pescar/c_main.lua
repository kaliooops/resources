iteme_in_inv = {}
has_any_type_of_fish = false
RegisterNetEvent("Pescar:ItemeInInventar")
AddEventHandler("Pescar:ItemeInInventar", function(iteme)
    iteme_in_inv = iteme
    has_any_type_of_fish = has_any_fish(iteme_in_inv)
end)

CreateThread(function()
    Wait(0)
    TriggerServerEvent("Pescar:GiveFishing_Fish", "update") -- update at load time
end)

local fishingRod = nil
RegisterNetEvent("Pescar:Echipeaza_Undita")
AddEventHandler("Pescar:Echipeaza_Undita", function()
    
    if fishingRod == nil then
        fishingRod = SpawnRodInPedHand()
    else
        DeleteObject(object)
        fishingRod = nil
        TriggerEvent("toasty:Notify",{type="error", title="[Pescar]", message="Ai aruncat undita."})
    end

end)


RegisterNetEvent("Pescar:Deschide_Sonar")
AddEventHandler("Pescar:Deschide_Sonar", function()
    ExecuteCommand("e tablet2")
    openGui()
end)


CreateThread(function() -- start rendering and handlers
    local mircea_pescarul = k_CreatePed(0x6C9B2849, locatie_vandut_peste.x, locatie_vandut_peste.y, locatie_vandut_peste.z, locatie_vandut_peste.heading)
    TaskStartScenarioInPlace(mircea_pescarul, "WORLD_HUMAN_AA_SMOKE", 0, false)

    
    while true do
        Wait(1000)
        while Vdist(GetEntityCoords(PlayerPedId()), garaj_barca.x, garaj_barca.y, garaj_barca.z) < 15 do
            Wait(0)
            DrawMarker(1, garaj_barca.x, garaj_barca.y, garaj_barca.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 3, 207, 252, 200, 0, 0, 0, 0)

            if Vdist(GetEntityCoords(PlayerPedId()), garaj_barca.x, garaj_barca.y, garaj_barca.z) < 5.5 then
                k_draw3DText(garaj_barca.x, garaj_barca.y, garaj_barca.z+1.5, "~w~[~g~E~w~] Pentru a lua barca de pescuit")
                if IsControlJustPressed(1, 51) then
                    teleport_ped_in_created_vehicle("squalo")
                end
            end
        end

        while Vdist(GetEntityCoords(PlayerPedId()), locatie_unelte_pescuit.x, locatie_unelte_pescuit.y, locatie_unelte_pescuit.z) < 5 do
            Wait(0)
            DrawMarker(1, locatie_unelte_pescuit.x, locatie_unelte_pescuit.y, locatie_unelte_pescuit.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 42, 52, 125, 200, 0, 0, 0, 0)
            
            if Vdist(GetEntityCoords(PlayerPedId()), locatie_unelte_pescuit.x, locatie_unelte_pescuit.y, locatie_unelte_pescuit.z) < 5.5 then
                k_draw3DText(locatie_unelte_pescuit.x, locatie_unelte_pescuit.y, locatie_unelte_pescuit.z+1.5, "~w~[~g~E~w~] Pentru a lua unelte de pescuit")
                if IsControlJustPressed(1, 51) then
                    CreateThread(function()
                        ExecuteCommand("e pickup")
                        Wait(500)
                        equip_Fishing_Backpack_Visuals()
                        TriggerServerEvent("Pescar:GiveBasicNeeds")
                    end)
                end
            end
        end


        while Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(mircea_pescarul)) < 5.5 do
            Wait(0)
            drawSubtitleText("~w~[~g~E~w~] Pentru a comunica cu Mircea.")
            local mircea_pos = GetEntityCoords(mircea_pescarul)
            k_draw3DText(mircea_pos.x, mircea_pos.y, mircea_pos.z+1.11, "Mircea")
            k_draw3DText(mircea_pos.x, mircea_pos.y, mircea_pos.z+1.0, "[~y~Pescarul Satului~w~]")
            if IsControlJustPressed(1, 51) then
                TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Vorbeste cu Mircea Pescarul Satului din Paleto.")
                if not has_any_type_of_fish then
                    mircea_presenting(mircea_pescarul)
                else
                    mircea_trading(mircea_pescarul, iteme_in_inv)
                end
            end
            if Vdist(GetEntityCoords(PlayerPedId()), locatie_unelte_pescuit.x, locatie_unelte_pescuit.y, locatie_unelte_pescuit.z) < 5.5 then
                break
            end
        end

    end

end)

local last_gZ = 0
function get_last_gZ() return last_gZ end

local gZ = 0
local isOnBoat = false
-- RegisterCommand("sonar", function()
--     local gz_sonar = tostring(math.floor(last_gZ * 100) / 100) + math.random(0, 3) --maraja de eroare
--     if not isAtSea() then
--         TriggerEvent("toasty:Notify", {type="error", title='[Sonar]', message="Nu esti pe mare!"})
--         return
--     end

--     if last_gZ > 0 then
--         TriggerEvent("chatMessage", "[^4Sonar^0]", {255, 255, 255}, "Nu s-au gasit pesti in aceasta zona.")
--     else
--         TriggerEvent("Pescar:Deschide_Sonar")
--     end
-- end, false)

--logica esentiala pe care se face calculu cu ce pesti sunt acolo, daca sunt sardele sa iei coaiele mele
CreateThread(function()
    while true do
        Wait(1000)
        if GetVehiclePedIsUsing(PlayerPedId()) == 0 then
            isOnBoat = false
        else
            isOnBoat = true
            gZ = get_GZ()
            
            if gZ < 0 then
                last_gZ = gZ
            end    
        end
        
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        while CanFish() and not isOnBoat and fishingRod ~= nil do
            disable_abilities()
            Wait(0)

            if IsDisabledControlJustPressed(0, 24) then
                positiveint = math.floor(last_gZ)
                fish_data = catch_fish(last_gZ)
                if fish_data ~= nil then
                    local rnd_time = math.random(5000, 10000) 
                    fish_animation(rnd_time)
                    Wait(rnd_time) -- random delay for the fish to be caught
                    local keep_fishing = false
                    while not IsControlJustPressed(1, 51) do
                        Wait(0)
                        local c = GetEntityCoords(PlayerPedId())
                        k_draw3DText(c.x, c.y, c.z+1.0, "~w~[~g~E~w~] Pentru a prinde pestele")
                        if not keep_fishing then
                            fish_animation(99999999)
                            keep_fishing = true
                        end
                    end
                    showProgress(fish_data.name, fish_data.time )
                    fish_animation(fish_data.time * 1000)
                    Wait(fish_data.time * 1000)
                    TriggerServerEvent("Pescar:GiveFishing_Fish", fish_data.name)
                    TriggerEvent("toasty:Notify", {type="success", title="[Pescar]", message="Ai prins " .. fish_data.name .. " la adancimea de " .. fish_data.adancime.. " metri. Acesta costa " .. fish_data.price .. " $."})
                else
                    TriggerEvent("toasty:Notify", {type="error", title="[Pescar]", message="Nu s-a prins niciun peste la aceasta adancime. Foloseste Sonarul!"})
                end
                ClearPedTasks(PlayerPedId())
                DespawnAllRods()
                fishingRod = nil
                TriggerEvent("Pescar:Echipeaza_Undita")
            end
        end
        
        while not CanFish() and fishingRod ~= nil do
            Wait(0)
            disable_abilities()
            if IsDisabledControlJustPressed(0, 24) then
                TriggerEvent("toasty:Notify", {type="error", title="[Pescar]", message="Nu se poate pescui in aceasta zona!"})
            end
        end

        if isOnBoat then
            DespawnAllRods()
            fishingRod = nil
        end

    end
end)
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-456.71105957031,6336.7329101562,12.837232589722)
    SetBlipSprite(blip, 762)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pescar")
    EndTextCommandSetBlipName(blip)
  end)

print("[Pescar] Securely Loaded")