--import all vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")


RegisterNetEvent("fmessage")
AddEventHandler("fmessage", function (msg)
    
    local src = source
    local user_id = vRP.getUserId({src})
    local faction = vRP.getUserFaction({user_id})    

    for _, p in pairs(vRP.getOnlineUsersByFaction({faction})) do
        local player = vRP.getUserSource({p})
        if player then
            TriggerClientEvent("chatMessage", player, "[" .. faction .. "]", {255, 0, 0}, GetPlayerName(src) .. "(^5"..user_id.."^0): ".. msg)
        end
    end


end)