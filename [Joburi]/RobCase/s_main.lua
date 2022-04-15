local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local cfg = {
    houses = {
        Weazel = {
            name = "Weazel",
            secunde_ramase = 0,
            location = vector3(-899.06, -456.49, 125.53),
        },
        House8 = {
            name = "House8",
            secunde_ramase = 0,
            location = vector3(-1289.12,443.34,96.89),
        },
        House4 = {
            name = "House4",
            secunde_ramase = 0,
            location = vector3(-678.35,589.75,144.38),
        },
        House1 = {
            name = "House1",
            secunde_ramase = 0,
            location = vector3(-172.06,493.51,136.65),
        },
        Integrity = {
            name = "Integrity",
            secunde_ramase = 0,
            location = vector3(-17.91,-603.22,99.23),
        },
        Del = {
            name = "Del",
            secunde_ramase = 0,
            location = vector3(-1458.81,-523.34,68.56),
        },
        Richads = {
            name = "Richads",
            secunde_ramase = 0,
            location = vector3(-915.65,-369.00,108.44),
        },
        Eclipse = {
            name = "Eclipse",
            secunde_ramase = 0,
            location = vector3(-774.17,335.27,195.09),
        },
    }
}

RegisterNetEvent("RobCase:Rob")
AddEventHandler("RobCase:Rob", function(name) 
    for _, h in pairs(cfg.houses) do
        if h.name == name then
            h.secunde_ramase = 300
        end
    end
end)


RegisterNetEvent("RobCase:Payment")
AddEventHandler("RobCase:Payment", function(stolen) 
    local total = 0
    for _, v in pairs(stolen) do
        total = total + v.price
    end
    vRP.giveInventoryItem({vRP.getUserId({source}),"dirty_money", total})
    TriggerClientEvent("RobCase:notify", source, "Pentru ce e aici iti dau $" .. total)
end)

RegisterNetEvent("RobCase:GiveMission")
AddEventHandler("RobCase:GiveMission", function() 

    local src = source

    for _, h in pairs(cfg.houses) do
        if h.secunde_ramase == 0 then
            TriggerClientEvent("RobCase:GiveMission", src, h)
            break
        end
    end


end)

RegisterNetEvent("RobCase:GiveLock")
AddEventHandler("RobCase:GiveLock", function()
    local user = vRP.getUserId({source})
    vRP.giveInventoryItem({user, "lockpick", 3})
end)

