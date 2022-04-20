local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")

RegisterNetEvent("krane:Has_Item")
AddEventHandler("krane:Has_Item", function(item)
    src = source
    uid = vRP.getUserId({src})
    TriggerClientEvent("krane:Has_Item", src, vRP.tryGetInventoryItem({uid, item, 1}))
end)