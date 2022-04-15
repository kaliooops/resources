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

    --[[
        
    local traffic_Koka_Import_Madrid = {
        ['kush']           = vRP.tryGetInventoryItem({user_id, "kush", amount}),
        ['purplehaze']     = vRP.tryGetInventoryItem({user_id, "purplehaze", amount}),
        ['lemonhaze']      = vRP.tryGetInventoryItem({user_id, "lemonhaze", amount}),
        ['tramadol']       = vRP.tryGetInventoryItem({user_id, "tramadol", amount}),
        ['tilidin']        = vRP.tryGetInventoryItem({user_id, "tilidin", amount}),
        ['speed']          = vRP.tryGetInventoryItem({user_id, "speed", amount}),
        ['extazy']         = vRP.tryGetInventoryItem({user_id, "extazy", amount}),
        ['lsd']            = vRP.tryGetInventoryItem({user_id, "lsd", amount}),
        ['jamaika']         = vRP.tryGetInventoryItem({user_id, "jamaika", amount}),
        ['bonzai']         = vRP.tryGetInventoryItem({user_id, "bonzai", amount}),
        ['scoobysnaks']    = vRP.tryGetInventoryItem({user_id, "scoobysnaks", amount}),
    }
    ]]

    local traffic_Koka_Import_Madrid = {}

    user_id = vRP.getUserId({source})

    local inventory = vRP.getInventory({user_id}) 
    for item_name, _ in pairs(inventory) do
        if item_name == "kush" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "kush", amount})
        end

        if item_name == "purplehaze" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "purplehaze", amount})
        end

        if item_name == "lemonhaze" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "lemonhaze", amount})
        end

        if item_name == "tramadol" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "tramadol", amount})
        end

        if item_name == "tilidin" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "tilidin", amount})
        end

        if item_name == "speed" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "speed", amount})
        end

        if item_name == "extazy" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "extazy", amount})
        end

        if item_name == "lsd" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "lsd", amount})
        end

        if item_name == "jamaika" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "jamaika", amount})
        end

        if item_name == "bonzai" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "bonzai", amount})
        end

        if item_name == "scoobysnaks" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "scoobysnaks", amount})
        end
        if item_name == "cristal" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "cristal", amount})
        end
        if item_name == "mdma" then
            traffic_Koka_Import_Madrid[item_name] = vRP.tryGetInventoryItem({user_id, "mdma", amount})
        end

        
    end


    
    local drug_prices = {
        ['kush'] = {price = 15},
        ['lemonhaze'] = {price = 15},
        ['purplehaze'] = {price = 15},
        ['tramadol'] = {price = 15},
        ['tilidin'] = {price = 15},
        ['speed'] = {price = 15},
        ['extazy'] = {price = 15},
        ['lsd'] = {price = 15},
        ['scoobysnaks'] = {price = 15},
        ['jamaika'] = {price = 15},
        ['cristal'] = {price = 15},
        ['mdma'] = {price = 15},
        ['bonzai'] = {price = 15},
    }

    local total_price = 0
    for key, var in pairs(traffic_Koka_Import_Madrid) do
        if var then
            total_price = total_price + drug_prices[key].price * amount
        end
    end
    
    TriggerClientEvent("drugNotify", source, amount, item, total_price)
    vRP.giveInventoryItem({user_id,"dirty_money", total_price})
    -- vRP.giveInventoryItem({user_id, "k2uri", math.random(1, 3)})

    TriggerEvent("k2ANTICHEAT:logger", "droguri.txt", GetPlayerName(source) .. "[" .. vRP.getUserId({source})  .. "] a vandut droguri in valoare de: " .. total_price .. " $")

end)

