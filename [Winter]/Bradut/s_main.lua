local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterNetEvent("winter_misiuni:k2uri_sub_brad")
AddEventHandler("winter_misiuni:k2uri_sub_brad", function()
    
    local src = source
    local user_id = vRP.getUserId({src})

    if vRP.tryGetInventoryItem({user_id, "Cadouri", 1}) then
        TriggerClientEvent("winter_misiuni:k2uri_sub_brad", src)
        local krcoins_amount = math.random(5, 10)
        local money_amount = math.random(2500, 7500)
        local fireworks_amount = math.random(7, 15)

        vRP.giveKRCoins({user_id, krcoins_amount})
        vRP.giveMoney({user_id, money_amount})
        vRP.giveInventoryItem({user_id, "fireworks", fireworks_amount})
        TriggerClientEvent("toasty:Notify", src, {type = "success", title = "Misiuni", message = "Ai primit " .. krcoins_amount .. " diamante, " .. money_amount .. " $ si " .. fireworks_amount .. " artificii"})        
    
    end
    
end)