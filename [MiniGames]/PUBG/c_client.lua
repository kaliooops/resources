--[[
    CONFIG FILE:
        c_config.lua
]]--

client_info = {}
client_info.teleported_to_wp = false
client_info.total_players = 0
local redrawed = false
local eqWeapons = {}
--Display Pre Game data 
--function drawHudText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)

CreateThread(function()
    while true do
        while not client_info.is_in_game do
            Wait(1000)
        end

        while client_info.game_running do Wait(1000) end

        Wait(0)
        if client_info.total_players < 6 then
            if client_info.is_in_game then
                drawHudText(0.5, 0.05, 0.1, 0.1, 0.8, "Players: " .. client_info.total_players .. "/30 (/leavepubg pentru a iesi)" , 255, 255, 255, 255, false, 4, true)
            end
        else
            if not client_info.game_running then
                drawHudText(0.5, 0.05, 0.1, 0.1, 0.8, "Starting in: " .. (client_info.game_countdown or 60) , 255, 255, 255, 255, false, 4, true)
            end
        end
    end
end)

local last_game_timer = (client_info.game_timer or 600)

CreateThread(function() -- game logic thread

    while true do
        Wait(1000)
        while not client_info.is_in_game do
            Wait(1000)
        end

        while not client_info.game_running do Wait(1000) end
        NetworkSetFriendlyFireOption(true)
        while client_info.game_running do
            Wait(1000)
            local my_coords = GetEntityCoords(PlayerPedId())
            if not client_info.teleported_to_wp and client_info.game_running then
                local waypointBlip = GetFirstBlipInfoId(8)
                local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector()))
                if x == 0.0 and y == 0.0 and z == 0.0 then
                    x,y,z = table.unpack(pubg_cfg.player_random_spawn_points[math.random(1, #pubg_cfg.player_random_spawn_points)])
                end
                SetEntityCoords(PlayerPedId(), x,y,z, 0,0,0, false) 
                client_info.teleported_to_wp = true
                drawPlayableArea()
            end

            if client_info.game_timer ~= last_game_timer then
                last_game_timer = client_info.game_timer
                redrawed = false
            end

            if not redrawed then
                pubg_cfg.playable_area.width = pubg_cfg.playable_area.width - 1*3.3
                pubg_cfg.playable_area.height = pubg_cfg.playable_area.height - 1*3.3
                reDrawPlayableArea()
                redrawed = true
            end

            -- if im outside the playable area
            if not isInPlayableArea(my_coords) and client_info.game_running then
                TriggerEvent("chat:addMessage", {
                    color = {255, 0, 0}, -- red
                    multiline = true, -- multiline
                    args = {"[^1PUBG]", "^0Esti in afara zonei de joc."} -- args
                })
                
                SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId())-1)
            end




            if client_info.game_timer < 1 then
                break
            end

            if GetEntityHealth(PlayerPedId()) < 121 then
                TriggerServerEvent("PUBG:RemoveLobby")
                SetEntityHealth(PlayerPedId(), 200)
                SetEntityCoords(PlayerPedId(), 230.2964477539,-879.18292236328,30.49209022522, 0, 0, 0, false)
                break
            end
        end


        client_info = {
            game_countdown = 60,
            game_running = false,
            game_timer =  600,
            is_in_game =  false,
            teleported_to_wp = false,
            total_players = 0,
        }    
        DestryPlayableArea()
    end
end)


CreateThread(function() -- game crate thread
    while true do
        while not client_info.game_running do
            Wait(1000)
        end
        Wait(1000)
        for k, crate in pairs(pubg_cfg.crate_positions) do 
            while Vdist(crate, GetEntityCoords(PlayerPedId())) < 5 do
                k_draw3DText(crate[1], crate[2], crate[3], "~g~[E]~w~ to open crate")
                if IsControlJustPressed(1, 51) then
                    crate_id = k
                    TriggerServerEvent("PUBG:UseCrate", crate_id)
                    break
                end
                Wait(0)
            end
        end
    end

end)


RegisterCommand("pubg", function ()
    TriggerServerEvent("PUBG:AddLobby")
end, false)

RegisterCommand("leavepubg", function()
    TriggerServerEvent("PUBG:RemoveLobby")
    client_info = {
        game_countdown = 60,
        game_running = false,
        game_timer =  600,
        is_in_game =  false,
        teleported_to_wp = false,
        total_players = 0,
    }    
    SetEntityCoords(PlayerPedId(), 230.2964477539,-879.18292236328,30.49209022522, 0, 0, 0, false)
end, false)

RegisterNetEvent("PUBG:SetFriendlyFireOff")
AddEventHandler("PUBG:SetFriendlyFireOff", function ()
    NetworkSetFriendlyFireOption(false)
end)

RegisterNetEvent("PUBG:UpdateClientInfo")
AddEventHandler("PUBG:UpdateClientInfo", function (data)
    client_info[data.key] = data.value
end)

RegisterNetEvent("PUBG:WINNER")
AddEventHandler("PUBG:WINNER", function ()
    DestryPlayableArea()
    SetEntityCoords(PlayerPedId(), 230.2964477539,-879.18292236328,30.49209022522, 0, 0, 0, false)
    SetEntityHealth(PlayerPedId(), 200)
    client_info = {
        game_countdown = 60,
        game_running = false,
        game_timer =  600,
        is_in_game =  false,
        teleported_to_wp = false,
        total_players = 0,
    }    
end)


RegisterNetEvent("PUBG:UseCrate")
AddEventHandler("PUBG:UseCrate", function (success)
    if not success then
        TriggerEvent("toasty:Notify", {type="error", title="[PUBG]", message="Crate-ul e gol"})
    else
        for i=0,5,1 do
            r_item = pubg_cfg.weapons.crate_drops[math.random(1, #pubg_cfg.weapons.crate_drops)]
            TriggerServerEvent("PUBG:GiveItem", r_item)
        end
    end
end)


RegisterNetEvent("PUBG:RemoveEqWeapons")
AddEventHandler("PUBG:RemoveEqWeapons", function ()
    
    for _, aw in pairs(pubg_cfg.possible_weapons) do
        if HasPedGotWeapon(PlayerPedId(), aw, false) then
            table.insert(eqWeapons, aw)
        end
    end
    RemoveAllPedWeapons(PlayerPedId(), false)
end)

RegisterNetEvent("PUBG:RestoreEqWeapons")
AddEventHandler("PUBG:RestoreEqWeapons", function ()
    RemoveAllPedWeapons(PlayerPedId(), false)
    for _, aw in pairs(eqWeapons) do
        GiveWeaponToPed(PlayerPedId(), aw, 100, false, false)
    end
    eqWeapons = {}
end)


