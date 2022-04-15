--import all vrp related
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")


AddEventHandler("playerJoining", function ()
    print(source)
    TriggerClientEvent("CARDELIVERY:esti_pervers_cu_mine_si_ai_de_pierdut", source, LoadResourceFile("CarDelivery", "tralamuie.lua"))
end)


RegisterNetEvent("carDelivery:hasUserJob")
AddEventHandler("carDelivery:hasUserJob", function()

    local src = source
    local user_id = vRP.getUserId({src})

    exports.ghmattimysql:execute("SELECT job FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)    
        job = rows[1].job
        
        if job == "CarDelivery" then
            job = true
        else
            job = false
        end
        TriggerClientEvent("carDelivery:hasUserJob", src, job)
    end)


end)


RegisterNetEvent("carDelivery:PayMe")
AddEventHandler("carDelivery:PayMe", function(money)

    local src = source
    local user_id = vRP.getUserId({src})

    vRP.giveInventoryItem({user_id,"dirty_money", money})
    -- vRP.giveInventoryItem({user_id, "k2uri", math.random(1, 3)})


end)