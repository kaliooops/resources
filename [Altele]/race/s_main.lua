--import all vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local lobbies = {}

RegisterNetEvent("race:send_data_to_lobby_members")
AddEventHandler("race:send_data_to_lobby_members", function (data)    
    
    
    table.insert(lobbies, data.lobby)
    for _, lobby_data in pairs(data.lobby) do
        user_id = tonumber(lobby_data.id)
        local player = vRP.getUserSource({user_id}) 
        if player == nil then
            player = user_id
        end
        TriggerClientEvent("race:build_game", player, data.lobby) 
    end
end)


RegisterNetEvent("race:PlayerState")
AddEventHandler("race:PlayerState", function(data)
    if data.ready then
        --go thru all lobbies
        for _, lobby in pairs(lobbies) do
            --go thru players in lobby
            for __, player in pairs(lobby) do
                if tonumber(player.id) == user_id then
                    player.ready = true
                end
            end
        end
    end
end)


RegisterNetEvent("race:Set_Ready_For_Animation")
AddEventHandler("race:Set_Ready_For_Animation", function()
    for _, lobby in pairs(lobbies) do
        for __, player in pairs(lobby) do
            if tonumber(player.id) == vRP.getUserId({source}) then
                player.read_for_animation = true
            end
        end
        local ready_players = 0
        for __, player in pairs(lobby) do
            if player.read_for_animation then
                ready_players = ready_players + 1
            end
        end
        print(ready_players, #lobby, #lobbies)
        if ready_players == #lobby then
            --go thru all players in lobby
            for p_index, player in pairs(lobby) do                
                --if user doesn't have the money return
                if vRP.getMoney({tonumber(player.id)}) < tonumber(player.bet) then
                    TriggerClientEvent("race:stop_race", vRP.getUserSource({tonumber(player.id)}))    
                    TriggerClientEvent("toasty:Notify", vRP.getUserSource({tonumber(player.id)}), {type = 'error', title='Race', message = 'Cursa a fost anulata, jucatorul ' .. player.id .. " nu are bani"}) 
                    table.remove(lobby, p_index)
                end

                vRP.giveMoney({tonumber(player.id), -tonumber(player.bet)})

                TriggerClientEvent("race:all_players_ready", vRP.getUserSource({tonumber(player.id)}))
                -- SetTimeout(3000, function()
                --     TriggerClientEvent("race:seconds_passed", vRP.getUserSource({tonumber(player.id)}))
                -- end)
                -- SetTimeout(2000, function()
                --     TriggerClientEvent("race:seconds_passed", vRP.getUserSource({tonumber(player.id)}))
                -- end)
                -- SetTimeout(1000, function()
                --     TriggerClientEvent("race:seconds_passed", vRP.getUserSource({tonumber(player.id)}))
                -- end)
                -- SetTimeout(4000, function()
                --     TriggerClientEvent("race:seconds_passed", vRP.getUserSource({tonumber(player.id)}))
                -- end)
            end
        end
    end
end)


CreateThread(function()
    while true do
        Wait(1000)
        if #lobbies > 0 then
            for _, lobby in pairs(lobbies) do
                local counter = 0
                for __, player in pairs(lobby) do
                    if player.ready then
                        counter = counter + 1
                    end
                end
                if counter > 0 and counter == #lobby then
                    for __, player in pairs(lobby) do
                        TriggerClientEvent("race:startRaceGUI", vRP.getUserSource({tonumber(player.id)}))
                    end
                end
            end
        end
    end
end)




RegisterNetEvent("race:GetLocalPlayerUserID")
AddEventHandler("race:GetLocalPlayerUserID", function ()
    local src = source
    TriggerClientEvent("race:GetLocalPlayerUserID", src, vRP.getUserId({src}))
end)


RegisterNetEvent("race:Winner")
AddEventHandler("race:Winner", function ()
    local user_id = vRP.getUserId({source})
    for _, lobby in pairs(lobbies) do
        local tmp_lobby = {}
        local tmp_lobby_index = 0
        local finished_lobby = false

        for i_lobby, player in pairs(lobby) do
            table.insert(tmp_lobby, player)
            tmp_lobby_index = i_lobby       
        end

        local prize_money = 0
        local recieved_money = false
        for __, player in pairs(tmp_lobby) do
            prize_money = prize_money + player.bet
        end

        for __, player in pairs(tmp_lobby) do
            local id = tonumber(player.id)
            if user_id == id then
                if not recieved_money then
                    vRP.giveMoney({id, prize_money})
                    print("winner: " .. prize_money)
                    TriggerClientEvent("toasty:Notify", vRP.getUserSource({id}), {type = 'success', title='Race', message = 'Ai terminat cursa'}) 
                    TriggerClientEvent("race:stop_race", vRP.getUserSource({id}))
                    recieved_money = true
                end
            else
                TriggerClientEvent("toasty:Notify", vRP.getUserSource({id}), {type = 'error', title='Race', message = "Winner: (" .. user_id .. ")" })
                TriggerClientEvent("race:stop_race", vRP.getUserSource({id}))
            end
        end
        table.remove(lobbies, tmp_lobby_index)
        return
        
    end
end)