local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")


RegisterNetEvent("FinishJob")
AddEventHandler("FinishJob", function ()
    TriggerClientEvent("crashme", source)
end)

RegisterNetEvent("sendPlayerJob")
AddEventHandler("sendPlayerJob", function() 
    local player = source
    user_id = vRP.getUserId({player})

    exports.ghmattimysql:execute("SELECT job FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)    
        job = rows[1].job
        
        TriggerClientEvent("getPlayerJob", player, job)
    end)

end)

bizmon = ""
RegisterNetEvent("giveMoney")
AddEventHandler("giveMoney", function ()

    local player = source
    user_id = vRP.getUserId({player})


    local money = math.random(50, 250) -- random money

    vRP.giveMoney({user_id, money})
    -- vRP.giveInventoryItem({user_id, "k2uri", math.random(1, 3)})

    local bizmon = 15/100*money
    if biz_owner == "" then
        exports.ghmattimysql:execute("SELECT patron FROM Joburi WHERE jobname = \"aprovizionari\"", function(rows)    
            biz_owner = rows[1].patron
        end)    
    
    end
    exports.ghmattimysql:execute("UPDATE Joburi SET incasari = incasari + @bizmon WHERE patron = @patron", {bizmon = bizmon, patron = biz_owner})
    -- exports.ghmattimysql:execute("UPDATE vrp_users SET walletMoney = walletMoney + @money WHERE id = @user_id", {money = money, user_id = user_id}, function(rows)end)
    
    TriggerEvent("k2ANTICHEAT:logger", "aprovizionari.txt", "player: " .. user_id .. "name: " .. GetPlayerName(player))


end)