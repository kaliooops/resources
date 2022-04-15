local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_hungergames")

RegisterNetEvent("hungergames:status3sec")
AddEventHandler("hungergames:status3sec", function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local thirst = vRP.getThirst({user_id})
    local hunger = vRP.getHunger({user_id})
    if hunger < 10 and thirst < 10 then
        TriggerClientEvent("hungergames:heal", player)
    end


end)

RegisterNetEvent("hungergames:status60sec")
AddEventHandler("hungergames:status60sec", function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local thirst = vRP.getThirst({user_id})
    local hunger = vRP.getHunger({user_id})
    if hunger > 80 then
        TriggerClientEvent("hungergames:foame80", player)
    end
    if thirst > 80 then
        TriggerClientEvent("hungergames:foame80", player)
    end
    if hunger > 90 then
        TriggerClientEvent("hungergames:foame", player)
    end
    if thirst > 90 then
        TriggerClientEvent("hungergames:sete", player)
    end
end)