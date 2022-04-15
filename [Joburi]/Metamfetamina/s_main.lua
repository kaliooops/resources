--import all vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterNetEvent("Metamfetamina:AdaugaProduse")
AddEventHandler("Metamfetamina:AdaugaProduse", function()
    local uid = vRP.getUserId({source})
    vRP.giveInventoryItem({uid,"cristal", math.random(5, 15)})
    vRP.giveInventoryItem({uid,"speed", math.random(5, 15)})
    vRP.giveInventoryItem({uid,"mdma", math.random(5, 15)})
end)