Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterCommand("api_request_get", function (source, args,z)
    TriggerClientEvent("api_request:get", -1, args[1])
    
end, false)

RegisterCommand("api_request_post", function (source, args,z)
        TriggerClientEvent("api_request:post", -1, args[1], args[2])
end, false)



RegisterCommand("api_request_stop", function(x, args, z)
    TriggerClientEvent("api_request:stop", -1)
end, false)