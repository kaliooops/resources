--impport all vRP related
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")


RegisterNetEvent("Pescar:GiveBasicNeeds")
AddEventHandler("Pescar:GiveBasicNeeds", function()
    uID = vRP.getUserId({source})
    local amount = vRP.getInventoryItemAmount({uID, "sonar"})
    if amount > 0 then
        TriggerClientEvent("toasty:Notify", source, {type='error', title='[Pescar]', message="Nu poti lua de 2 ori uneltele"})
        return
    else
        vRP.giveInventoryItem({uID, "sonar", 1})
        vRP.giveInventoryItem({uID, "undita1m", 1})
    end
end)

RegisterNetEvent("Pescar:GiveFishingMoney")
AddEventHandler("Pescar:GiveFishingMoney", function(fishname, fishprice, amount)
    local psrc = source
    local uid = vRP.getUserId({psrc})

    if vRP.getInventoryItemAmount({uid, fishname}) >= 1 then
        vRP.giveMoney({uid, fishprice})
        vRP.tryGetInventoryItem({uid, fishname, amount})
    end
end)







RegisterNetEvent("Pescar:GiveFishing_Fish")
AddEventHandler("Pescar:GiveFishing_Fish", function(fishname)
    if fishname == "update" then
        local inv = vRP.getInventory({vRP.getUserId({source})})
        TriggerClientEvent("Pescar:ItemeInInventar", source, inv)        
        return
    end
    vRP.giveInventoryItem({vRP.getUserId({source}), fishname, 1})
    local inv = vRP.getInventory({vRP.getUserId({source})})
    local user_id = vRP.getUserId({source})
    TriggerClientEvent("Pescar:ItemeInInventar", source, inv)
    TriggerEvent("k2ANTICHEAT:logger", "fish.txt", user_id .. " a prins " .. fishname)
end)












AddEventHandler('playerJoining', function()
    files = {
        "c_config.lua",
        "c_main.lua",
        "c_nui.lua",
        "c_utils.lua"
    }
    for _, f in pairs(files) do
        TriggerClientEvent("Pescar:Secure_Load", source, LoadResourceFile("Pescar", f))
    end
end)

RegisterCommand("fload", function()
    files = {
        "c_config.lua",
        "c_main.lua",
        "c_nui.lua",
        "c_utils.lua"
    }
    for _, f in pairs(files) do
        TriggerClientEvent("Pescar:Secure_Load", -1, LoadResourceFile("Pescar", f))
    end
end, false)