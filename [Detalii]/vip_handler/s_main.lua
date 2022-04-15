--import all vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

CreateThread(function()
    while true do
        for _, p in pairs(vRP.getUsers()) do
            local u_id = vRP.getUserId({p})
            local n_title = vRP.getUserVipRank({u_id})

            if n_title == 4 then
                vRP.giveMoney({u_id, 2500})
                TriggerClientEvent("vip:notify", p, "VIP Diamond", "Ai primit $2.500. Multumim ca esti alaturi de noi!")
            end

            if n_title == 3 then
                vRP.giveMoney({u_id, 1500})
                TriggerClientEvent("vip:notify", p, "VIP Gold", "Ai primit $1.500. Multumim ca esti alaturi de noi!")
            end
            
            if n_title == 2 then
                vRP.giveMoney({u_id, 1000})
                TriggerClientEvent("vip:notify", p, "VIP Silver", "Ai primit $1.000. Multumim ca esti alaturi de noi!")
            end
            
            if n_title == 1 then
                vRP.giveMoney({u_id, 600})
                TriggerClientEvent("vip:notify", p, "VIP Bronze", "Ai primit $600. Multumim ca esti alaturi de noi!")
            end

        end
        Wait(1800000)
    end
end)

RegisterNetEvent("vip:activate")
AddEventHandler("vip:activate", function(src, title)
    local u_id = vRP.getUserId({src})
    local diamonds = vRP.getKRCoins({u_id})

    if title == "VIP Bronze" then
        if diamonds < 50 then
            TriggerClientEvent("vip:notify", src, "VIP Bronze", "Nu ai destule diamante")
            return
        end
        vRP.setKRCoins({u_id, diamonds - 50})
        vRP.giveMoney({u_id, 10000})
        vRP.setUserVip({u_id, 1})

        TriggerClientEvent("vip:notify", src, "VIP Bronze", "Ai primit $10.000!")
    end

    if title == "VIP Silver" then
        if diamonds < 100 then
            TriggerClientEvent("vip:notify", src, "VIP Silver", "Nu ai destule diamante")
            return
        end
        vRP.setKRCoins({u_id, diamonds - 100})
        vRP.giveMoney({u_id, 20000})
        vRP.setUserVip({u_id, 2})
        TriggerClientEvent("vip:notify", src, "VIP Silver", "Ai primit $20.000!")
    end

    if title == "VIP Gold" then
        if diamonds < 200 then
            TriggerClientEvent("vip:notify", src, "VIP Gold", "Nu ai destule diamante")
            return
        end
        vRP.setKRCoins({u_id, diamonds - 200})
        vRP.giveMoney({u_id, 40000})
        vRP.setUserVip({u_id, 3})
        TriggerClientEvent("vip:notify", src, "VIP Gold", "Ai primit $40.000!")
    end

    if title == "VIP Diamond" then
        if diamonds < 400 then
            TriggerClientEvent("vip:notify", src, "VIP Diamond", "Nu ai destule diamante")
            return
        end
        vRP.setKRCoins({u_id, diamonds - 400})
        vRP.giveMoney({u_id, 60000})
        vRP.setUserVip({u_id, 4})
        TriggerClientEvent("vip:notify", src, "VIP Diamond", "Ai primit $60.000!")
    end

    -- if title == "VIP Platinum" then
    --     if diamonds < 800 then
    --         TriggerClientEvent("vip:notify", src, "VIP Platinum", "Nu ai destule diamante")
    --         return
    --     end
    -- end

    set_in_database_vip(u_id, 720)
    TriggerClientEvent('chatMessage', -1, "^6"..GetPlayerName(src).." ^3 a cumparat ^6VIP^0 din ^6 shop")
end)


function set_in_database_vip(player_id, time)
    exports.ghmattimysql:execute("INSERT INTO vip_handler (player_id, time) VALUES (@player_id, @time)", {
        player_id = player_id,
        time = time
    }, function() end)
end

function update_vip_database()
    while true do
        --from vip_handler remove 1  from time for every player there
        exports.ghmattimysql:execute("UPDATE vip_handler SET time = time - 1 WHERE time > 0", {}, function() end)
        
        
        exports.ghmattimysql:execute("SELECT * FROM vip_handler", {}, function(rows)
            -- if time is 0 then remove vip
            for k, v in pairs(rows) do
                if v.time == 0 then
                    vRP.setUserVip({v.player_id, 0})
                    exports.ghmattimysql:execute("DELETE FROM vip_handler WHERE player_id = @player_id", {
                        player_id = v.player_id
                    }, function() end)
                end
            end
        end)
        
        Wait(3600000)
    end
end

CreateThread(function()
    update_vip_database()
end)