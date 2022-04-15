local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","fvr_carwash")

Sfvr = {}
Tunnel.bindInterface("fvr_carwash",Sfvr)
Proxy.addInterface("fvr_carwash",Sfvr)
Cfvr = Tunnel.getInterface("fvr_carwash","fvr_carwash")


function Sfvr.spalamasinutza(amount)
    local user_id = vRP.getUserId({source})
    if vRP.tryFullPayment({user_id,amount}) then
        TriggerClientEvent("fvr:spalamasina",source)
    else
        vRPclient.notify(source,{"~r~Nu ai destui bani :("})
    end
end