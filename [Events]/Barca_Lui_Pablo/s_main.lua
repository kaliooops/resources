--import all vRP 
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local drops = {
    "cocaina",
    "cocaina",
    "cocaina",
    "cocaina",
    "cocaina",
    "kush",
    "lemonhaze",
    "purplehaze",
    "speed",
    "extazy",
    "lsd",
    "jamaika",
    "cristal",
    "mdma",
}

local stock = 900

RegisterNetEvent("Barca:Finish")
AddEventHandler("Barca:Finish", function()
    stock = 900
end)

RegisterNetEvent("Barca:Give_Drop")
AddEventHandler("Barca:Give_Drop", function()
    src = source
    uid = vRP.getUserId({src})

    if stock <= 0 then
        TriggerClientEvent("toasty:Notify", src, {type='info', title="Stock", message="Nu mai e niciun drog"})
        return
    end

    stock = stock - 1

    inventory_weight = vRP.getInventoryWeight({uid})
    inventory_max_weight = vRP.getInventoryMaxWeight({uid})
    if inventory_weight < inventory_max_weight then
        chance = math.random(1, 100)
        if chance < 30 then
            TriggerClientEvent("toasty:Notify", src, {type="info", title="Speriat", message="Din cauza fricii, ai scapat drogurile"})
        else
            ritem = drops[math.random(1, #drops)]
            vRP.giveInventoryItem({uid, ritem, math.random(1,6)})
        end
    else
        TriggerClientEvent("toasty:Notify", src, {type="error", title="Barca", message="Nu ai loc in geanta"})
    end
end)






AddEventHandler("playerJoining", function ()
    TriggerClientEvent("Barca_Lui_Pablo:Secure_Load", source, LoadResourceFile("Barca_Lui_Pablo", "c_config.lua"))
    TriggerClientEvent("Barca_Lui_Pablo:Secure_Load", source, LoadResourceFile("Barca_Lui_Pablo", "c_utils.lua"))
    TriggerClientEvent("Barca_Lui_Pablo:Secure_Load", source, LoadResourceFile("Barca_Lui_Pablo", "c_main.lua"))
end)