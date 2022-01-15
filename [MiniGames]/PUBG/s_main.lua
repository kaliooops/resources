--import all vrp related
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

lobby = {}

local countdown = 60
local game_timer = 600
local game_running = false



RegisterNetEvent("PUBG:AddLobby")
AddEventHandler("PUBG:AddLobby", function()
    if not game_running and #lobby < 30 then  
        SetEntityCoords(GetPlayerPed(source), 5026.5063476562,-4615.6806640625,4.0569529533386, 0, 0, 0, false)
        local uID = vRP.getUserId({source})
        table.insert(lobby, uID)
    else
        if #lobby >= 30 then
            TriggerClientEvent("toasty:Notify", source, {type="error",title="[PubG]", message="Nu mai sunt locuri, asteapta sa se termine meciul"})
            return
        end
        TriggerClientEvent("toasty:Notify", source, {type = "error", title="[PubG]", message = "Jocul de PubG este in desfasurare. Jucatori in viata: " .. #lobby})
    end
end)

RegisterNetEvent("PUBG:RemoveLobby")
AddEventHandler("PUBG:RemoveLobby", function ()
    print(json.encode(lobby))

    for k, _ in pairs(lobby) do
        if lobby[k] == vRP.getUserId({source}) then
            table.remove(lobby, k)
        end
    end
end)

local sent_chat_message = false
CreateThread(function() --updater
    while true do
        Wait(1000)

        if game_running and #lobby == 1 then
            game_running = false
            game_timer = 600
            sent_chat_message = false
            countdown = 60
            TriggerEvent("chat:addMessage", -1, {
                color = {255, 0, 0}, -- red
                multiline = true, -- multiline
                args = {"[^1PUBG]", "^0Jocul de PUBG a luat sfarsit.\nWinner: ID(" .. lobby[1] .. ") !"} -- args
            })
            TriggerClientEvent("toasty:Notify", vRP.getUserSource({lobby[1]}), {type="success", title="[PubG]", message="Ai castigat jocul de PUBG si $1.000!"})
            vRP.giveMoney({lobby[1], 1000})
            TriggerClientEvent("PUBG:WINNER", vRP.getUserSource({lobby[1]}))
            lobby = {}
        end

        for _, player in pairs(lobby) do
            p_sid = vRP.getUserSource({player})
            

            if not contains(vRP.getUsers(), p_sid) then
                table.remove(lobby, player)
                break
            end

            TriggerClientEvent("PUBG:UpdateClientInfo", p_sid, {key = "total_players", value = #lobby})
            TriggerClientEvent("PUBG:UpdateClientInfo", p_sid, {key = "is_in_game", value = true}) 
            TriggerClientEvent("PUBG:UpdateClientInfo", p_sid, {key = "game_running", value = game_running})
            TriggerClientEvent("PUBG:UpdateClientInfo", p_sid, {key = "game_timer", value = game_timer})
            
            
        end

        if not game_running then
            if #lobby >= 2 then
                countdown = countdown - 1
                TriggerClientEvent("PUBG:UpdateClientInfo", p_sid, {key = "game_countdown", value = countdown})
                
                if not sent_chat_message then
                    TriggerClientEvent("chat:addMessage", -1, { -- notify player
                        color = {255, 0, 0}, -- red
                        multiline = true, -- multiline
                        args = {"[^1PUBG]", "^0Mai sunt 60 de secunde pana incepe meciul de PubG (/pubg). Jucatori: " .. #lobby .. "/30"} -- args
                    })
                    sent_chat_message = true
                end
            else
                countdown = 10
            end

            if countdown < 1 then
                game_running = true
                sent_chat_message = false
            end
        end
    end
end)


CreateThread(function() --game timer
    while not game_running do Wait(1000) end
    while game_running do 
        Wait(1000)
        game_timer = game_timer - 1
    end
end)
