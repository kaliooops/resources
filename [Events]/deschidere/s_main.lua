--import all vrp related
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")


RegisterNetEvent("deschidere:vreauArtificii")

AddEventHandler("deschidere:vreauArtificii", function(amount)

    if amount == nil or amount > 5 then
        TriggerEvent("k2ANTICHEAT:ban", source, " cheie artificii")
    end


    TriggerEvent("k2ANTICHEAT:logger", "deschidere.txt", GetPlayerName(source) .. " " .. "[" .. vRP.getUserId({source}) .. "]" .. " a castigat: " .. amount)


    local user = vRP.getUserId({source})
    vRP.giveInventoryItem({user, "fireworks", amount})
    -- vRP.giveInventoryItem({user, "sudura", amount})

end)