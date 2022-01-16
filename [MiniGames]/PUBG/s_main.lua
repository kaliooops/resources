--import all vrp related
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

lobby = {}

player_inventories = {}

crates_used = {}

local countdown = 60
local game_timer = 600
local game_running = false


RegisterNetEvent("PUBG:AddLobby")
AddEventHandler("PUBG:AddLobby", function()
    if not game_running and #lobby < 30 then  

        local uID = vRP.getUserId({source})
        
        if contains(lobby, uID) then
            TriggerClientEvent("toasty:Notify", source, {type="error",title="[PUBG]", message="Esti deja in lobby."})
            return
        end
        
        SetEntityCoords(GetPlayerPed(source), 5026.5063476562,-4615.6806640625,4.0569529533386, 0, 0, 0, false)
        table.insert(lobby, uID)
        player_inventories[uID] = vRP.getInventory({uID}) -- e.g: {'paracetamol', {"amount": 1}}
        vRP.clearInventory({uID})
        TriggerClientEvent("PUBG:SetFriendlyFireOff", source)
        TriggerClientEvent("PUBG:RemoveEqWeapons", source)
        
    else
        if #lobby >= 30 then
            TriggerClientEvent("toasty:Notify", source, {type="error",title="[PUBG]", message="Nu mai sunt locuri, asteapta sa se termine meciul"})
            return
        end
        TriggerClientEvent("toasty:Notify", source, {type = "error", title="[PUBG]", message = "Jocul de PUBG este in desfasurare. Jucatori in viata: " .. #lobby})
    end
end)

RegisterNetEvent("PUBG:RemoveLobby")
AddEventHandler("PUBG:RemoveLobby", function ()

    for k, _ in pairs(lobby) do
        if lobby[k] == vRP.getUserId({source}) then
            table.remove(lobby, k)
        end
    end

    vRP.clearInventory({vRP.getUserId({source})})
    TriggerClientEvent("PUBG:RestoreEqWeapons", source)

    return_Items(vRP.getUserId({source}))
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
            TriggerClientEvent("toasty:Notify", vRP.getUserSource({lobby[1]}), {type="success", title="[PUBG]", message="Ai castigat jocul de PUBG si $1.000!"})
            vRP.giveMoney({lobby[1], 1000})
            TriggerClientEvent("PUBG:WINNER", vRP.getUserSource({lobby[1]}))
            vRP.clearInventory({lobby[1]})
            return_Items(lobby[1])
            TriggerClientEvent("PUBG:RestoreEqWeapons", vRP.getUserSource({lobby[1]}))
            lobby = {}
            countdown = 60
            game_timer = 600
            game_running = false
            player_inventories = {}
            crates_used = {}

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
            TriggerClientEvent("PUBG:UpdateClientInfo", p_sid, {key = "game_countdown", value = countdown})
            
            
        end

        if not game_running then
            if #lobby >= 6 then
                countdown = countdown - 1
                TriggerClientEvent("PUBG:UpdateClientInfo", p_sid, {key = "game_countdown", value = countdown})
                
                if not sent_chat_message then
                    TriggerClientEvent("chat:addMessage", -1, { -- notify player
                        color = {255, 0, 0}, -- red
                        multiline = true, -- multiline
                        args = {"[^1PUBG]", "^0Mai sunt 60 de secunde pana incepe meciul de PUBG (/pubg). Jucatori: " .. #lobby .. "/30"} -- args
                    })
                    sent_chat_message = true
                end
            else
                countdown = 60
            end

            if countdown < 1 then
                game_running = true
                sent_chat_message = false
            end
        end
    end
end)

function spawn_default_crates()
    for _, crate_spawn_point in pairs(pubg_cfg.default_crate_spawn_locations) do
        kSpawnObject(pubg_cfg.props.crate, crate_spawn_point)
    end
end

CreateThread(function() --game timer
    while not game_running do Wait(1000) end
    kCleanUp()
    spawn_default_crates()
    while game_running do 
        Wait(1000)
        game_timer = game_timer - 1

        if game_timer < 1 then
            break
        end
    end
    
    lobby = {}
    countdown = 60
    game_timer = 600
    game_running = false
    player_inventories= {}
    crates_used = {}
    kCleanUp()

end)

RegisterNetEvent("PUBG:UseCrate")
RegisterNetEvent("PUBG:UseCrate", function (k)
    if contains(crates_used, k) then
        TriggerClientEvent("PUBG:UseCrate", source, false)
        return
    end

    TriggerClientEvent("PUBG:UseCrate", source, true)
    table.insert(crates_used, k)
end)


RegisterNetEvent("PUBG:GiveItem")
AddEventHandler("PUBG:GiveItem", function(ritem)
    if string_has_substring(ritem, "ammo") then
        vRP.giveInventoryItem({vRP.getUserId({source}), ritem,math.random(15,31)})
        return
    end
    vRP.giveInventoryItem({vRP.getUserId({source}), ritem,math.random(1,2)})
end)
