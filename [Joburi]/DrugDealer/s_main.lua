--import all vrp functions
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

    

RegisterNetEvent("drugdealer_Vinde")
AddEventHandler("drugdealer_Vinde", function(item, amount)

    if item == nil or amount == nil then
        --ban me
        TriggerEvent("k2ANTICHEAT:ban", source, " DRUG_DEALER nil")
    end

    user_id = vRP.getUserId({source})

    local traffic_Koka_Import_Madrid = {
        ['kush']       = vRP.tryGetInventoryItem({user_id, "kush", amount}),
        ['purplehaze'] = vRP.tryGetInventoryItem({user_id, "purplehaze", amount}),
        ['lemonhaze']  = vRP.tryGetInventoryItem({user_id, "lemonhaze", amount}),
        ['tramadol']   = vRP.tryGetInventoryItem({user_id, "tramadol", amount}),
        ['tilidin']    = vRP.tryGetInventoryItem({user_id, "tilidin", amount})
    }
    
    local drug_prices = {
        ['kush'] = {price = 15},
        ['lemonhaze'] = {price = 15},
        ['purplehaze'] = {price = 15},
        ['tramadol'] = {price = 15},
        ['tilidin'] = {price = 15}
    }

    local total_price = 0
    for key, var in pairs(traffic_Koka_Import_Madrid) do
        -- print(key, var) -- e.g. kush, true

        if var then
            total_price = total_price + drug_prices[key].price * amount
        end
    end
    
    TriggerClientEvent("drugNotify", source, amount, item, total_price)
    vRP.giveMoney({user_id, total_price})
    -- vRP.giveInventoryItem({user_id, "k2uri", math.random(1, 3)})

    TriggerEvent("k2ANTICHEAT:logger", "droguri.txt", GetPlayerName(source) .. "[" .. vRP.getUserId({source})  .. "] a vandut droguri in valoare de: " .. total_price .. " $")

end)

