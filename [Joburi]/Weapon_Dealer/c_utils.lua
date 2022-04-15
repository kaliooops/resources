function spawn_net_object(x, y, z, model, heading)
    local hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
    local obj = CreateObject(hash, x, y, z, true, false, false)
    SetEntityHeading(obj, heading)
    SetEntityAsMissionEntity(obj, true, true)
    FreezeEntityPosition(obj, true)
    PlaceObjectOnGroundProperly(obj)
    return obj
end

function spawn_local_npc(x, y, z , model, heading, scenario)
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
    TaskStartScenarioInPlace(npcPed, scenario, 0, false)
    return npcPed
end

function force_despawn_object(obj)
    SetEntityAsMissionEntity(obj, false, true)
    SetEntityAsNoLongerNeeded(obj)
    DeleteObject(obj)
    DeleteEntity(obj)
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



function k_draw3DText(x,y,z, text, size)
    if not size then
        size = 2
    end
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*size
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
            k_draw3DText(p_coords.x, p_coords.y, p_coords.z+1.3, "~w~Informator: ~g~" .. text)
        end
    end
end

general_blip = nil
function setRoute(x, y, z)
    if general_blip ~= nil then 
        RemoveBlip(general_blip)
    end
    general_blip = AddBlipForCoord(x, y, z)
    SetBlipRoute(general_blip, true)
    SetBlipSprite(general_blip,1)
	SetBlipColour(general_blip,5)
	SetBlipAsShortRange(general_blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Weapon_delivery")
	EndTextCommandSetBlipName(general_blip)
	SetBlipRoute(general_blip,true)

    CreateThread(function()
        while general_blip ~= nil do
            Wait(0)
            if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) <= 2.5 then
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

function transform_ms_to_minutes(ms)
    local minutes = math.floor(ms / 60000)
    local seconds = math.floor((ms % 60000) / 1000)
    return minutes .. ":" .. seconds
end


function plant_bomb(crate)
    CreateThread(function()
        local groundZ = GetEntityCoords(PlayerPedId()).z-1.0
        local groundX, groundY = table.unpack(GetEntityCoords(PlayerPedId()))
        bomb = spawn_net_object(groundX, groundY, groundZ-1.0, "prop_ld_bomb", 180.0)
        -- rotate bomb  to be with the back to the ground
        local rot = GetEntityRotation(bomb)
        SetEntityRotation(bomb, rot.x+260.0, rot.y, rot.z, 2, true)

        ExecuteCommand("e pickup")
        FreezeEntityPosition(PlayerPedId(), true)
        Wait(700)
        FreezeEntityPosition(PlayerPedId(), false)
    end)
end

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

function getPlayersInRadius(radius)
    local players = {}
    local player_ids = {}
    for _, player_id in pairs(GetActivePlayers()) do
        local player = GetPlayerPed(player_id)
        if Vdist(GetEntityCoords(player), GetEntityCoords(PlayerPedId())) < radius then
            table.insert(players, player)
            table.insert(player_ids, player_id)

        end
    end
    return {n_players = #players, players = players, player_ids  = player_ids}
end



function get_random_weapon()
    -- if 1 then give pistol if 2 then give assault rifle
    local weapon_id = math.random(1, 12)
    if weapon_id == 1 then
        return "WEAPON_PISTOL"
    elseif weapon_id == 2 then
        return "WEAPON_ASSAULTRIFLE"
    elseif weapon_id == 3 then
        return "WEAPON_PUMPSHOTGUN"
    elseif weapon_id == 4 then
        return "WEAPON_RPG"
    elseif weapon_id == 5 then
        return "WEAPON_HEAVYSNIPER"
    elseif weapon_id == 6 then
        return "WEAPON_ASSAULTSHOTGUN"
    elseif weapon_id == 7 then
        return "WEAPON_ASSAULTSMG"
    elseif weapon_id == 8 then
        return "WEAPON_SMG"
    elseif weapon_id == 9 then
        return "WEAPON_PISTOL50"
    elseif weapon_id == 10 then
        return "WEAPON_COMBATPISTOL"
    elseif weapon_id == 11 then
        return "WEAPON_ASSAULTRIFLE"
    elseif weapon_id == 12 then
        return "WEAPON_ASSAULTRIFLE"
    end

end


RegisterNetEvent("Weapons_Dealer:Net_Explosion")
AddEventHandler("Weapons_Dealer:Net_Explosion", function(x,y,z)
    AddExplosion(x, y, z, 4, 1.0, true, false, true)
end)
