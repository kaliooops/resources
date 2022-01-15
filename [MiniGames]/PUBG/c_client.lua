--[[
    CONFIG FILE:
        c_config.lua
]]--

client_info = {}
client_info.teleported_to_wp = false
client_info.total_players = 0
local redrawed = false
--Display Pre Game data 
--function drawHudText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)

CreateThread(function()
    while true do
        while not client_info.is_in_game do
            Wait(1000)
        end

        while client_info.game_running do Wait(1000) end

        Wait(0)
        if client_info.total_players < 10 then
            if client_info.is_in_game then
                drawHudText(0.5, 0.05, 0.1, 0.1, 0.8, "Players: " .. client_info.total_players .. "/30" , 255, 255, 255, 255, false, 4, true)
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
    while not client_info.is_in_game do
        Wait(1000)
    end

    while not client_info.game_running do Wait(1000) end
    NetworkSetFriendlyFireOption(true)
    while client_info.game_running do
        Wait(1000)
        local my_coords = GetEntityCoords(PlayerPedId())
        if not client_info.teleported_to_wp then
            local waypointBlip = GetFirstBlipInfoId(8)
            local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector()))
            SetEntityCoords(PlayerPedId(), x,y,z, 0,0,0, false) 
            client_info.teleported_to_wp = true
            drawPlayableArea()
        end

        if client_info.game_timer ~= last_game_timer then
            last_game_timer = client_info.game_timer
            redrawed = false
            print(client_info.game_timer)
        end

        if not redrawed then
            pubg_cfg.playable_area.width = pubg_cfg.playable_area.width - 1*3.3
            pubg_cfg.playable_area.height = pubg_cfg.playable_area.height - 1*3.3
            reDrawPlayableArea()
            redrawed = true
        end

        -- if im outside the playable area
        if not isInPlayableArea(my_coords) then
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
            SetEntityCoords(PlayerPedId(), -536.83709716797,-218.65562438965,37.649787902832, 0, 0, 0, false)
            break
        end
    end

    client_info = {}
    DestryPlayableArea()

end)

RegisterCommand("pubg", function ()
    TriggerServerEvent("PUBG:AddLobby")
    NetworkSetFriendlyFireOption(false)
end, false)


RegisterNetEvent("PUBG:UpdateClientInfo")
AddEventHandler("PUBG:UpdateClientInfo", function (data)
    client_info[data.key] = data.value
end)

RegisterNetEvent("PUBG:WINNER")
AddEventHandler("PUBG:WINNER", function ()
    client_info = {}
    DestryPlayableArea()
    SetEntityCoords(PlayerPedId(), -536.83709716797,-218.65562438965,37.649787902832, 0, 0, 0, false)
    SetEntityHealth(PlayerPedId(), 200)

end)