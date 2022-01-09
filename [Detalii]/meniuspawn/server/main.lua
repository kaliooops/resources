local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_panou")

RegisterServerEvent("vrp_panou:selectPanel")
AddEventHandler("vrp_panou:selectPanel", function(group)
    local user_id = vRP.getUserId(source)
    vRP.addUserGroup(user_id,group)
    TriggerClientEvent("vrp_panou:notification", source, Config.Language.SelectedJob .. " " .. group)
end)