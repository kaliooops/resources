
--import everything vrp related
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")




local renters = {}

RegisterNetEvent("rent_real:Rented")
AddEventHandler("rent_real:Rented", function(pret)
    local user_id = vRP.getUserId({source})
    table.insert(renters, {user_id = user_id, price = pret})
end)


CreateThread(function()
    while true do
        for k, v in pairs(renters) do
            vRP.takeMoney({v.user_id, v.price})
            TriggerClientEvent("winter_misiuni_handler:RentCondus", vRP.getUserSource({v.user_id}))
        end
        Wait(60000)
    end
end)

RegisterNetEvent("rent_real:EndOfRent")
AddEventHandler("rent_real:EndOfRent", function()
    local user_id = vRP.getUserId({source})
    for _, r in pairs(renters) do
        if r.user_id == user_id then
            table.remove(renters, _)
        end
    end
end)