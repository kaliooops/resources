--import all vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
local x,y,z = -1137.83, 4872.70, 215.17


RegisterNetEvent("CANTABOGDANE")
AddEventHandler("CANTABOGDANE",function()
    local xSound = exports.xsound
    xSound:PlayUrlPos(-1, "CANTABOGDANE", "https://www.youtube.com/watch?v=m6L6GOSCZqA", 0.8, vector3(x,y,z), false)
    xSound:Distance(-1, "CANTABOGDANE", 50)
    local src = source
    SetTimeout(10000, function ()
        vRP.giveMoney({vRP.getUserId({src}), -10000})
        TriggerClientEvent("notify", src,1, "[BOGDAN]", "Fa plata pentru colinda")    
    end)
    
end)