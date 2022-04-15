--import all VRP 
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")

RegisterNetEvent("CarLock:Toggle")
AddEventHandler("CarLock:Toggle", function()
    vRPclient.getNearestOwnedVehicle(source,{15},function(found, idk, model, id)
        TriggerClientEvent("CarLock:Toggle", source, id)
    end)
end)