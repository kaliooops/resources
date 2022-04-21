Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

parts = {
    "cilindru",
    "far",
    "piston",
    "segment",
    "carburator",
    "supapa",
    "radiator",
    "bujie",
    "teava",
    "WEAPON_COMBATPISTOL",
    "roata",
    "distributie",
    "curea_de_distributie",
    "arbore_cotit",
    "biela",
    "esapament",
    "carter",
}

RegisterNetEvent("ScrapMechanic:Parts")
AddEventHandler("ScrapMechanic:Parts", function()
    src = source
    uid = vRP.getUserId({src})
    part = parts[math.random(1, #parts)]

    if vRP.getInventoryWeight({uid}) + vRP.getItemWeight({part}) <= vRP.getInventoryMaxWeight({uid}) then
        vRP.giveInventoryItem({uid, part, 1})
    end
end)