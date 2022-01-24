local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
RegisterCommand("FOIASDJFUI8ADFS9UFI9ASDASKOAIAJ", function(x, args, y)
    local src = tostring(args[1])
    local package = tostring(args[2])

    vRP.giveKRCoins({vRP.getUserId({src}), 100})

    for _, p in pairs(vRP.getUsers()) do
        TriggerClientEvent("chatMessage", p, "[^9DONATIE^0]", {255, 255, 255},
            "Jucatorul ^9" .. GetPlayerName(src) .. "^0 a cumparat ^9" .. package .. "^0!")
    end
end, false)
