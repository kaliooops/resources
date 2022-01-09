--import vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

CreateThread(function()
    while true do
        exports.ghmattimysql:execute("UPDATE vrp_users SET sponsorRank = sponsorRank - 1 WHERE sponsorRank > 0", {}, function()end)
        Wait(3600000)
    end
end)

CreateThread(function()
    while true do
        for _, p in pairs(vRP.getUsers()) do
            local u_id = vRP.getUserId({p})
            if vRP.isUserSponsor({u_id}) then
                vRP.giveMoney({u_id, 2500})
                TriggerClientEvent("sponsor:notify", p, "Ai primit $2.500. Multumim ca esti alaturi de noi!")
            end
            
        end
        Wait(1800000)
    end
end)


RegisterNetEvent("sponsor:activate")
AddEventHandler("sponsor:activate", function(src)
    local u_id = vRP.getUserId({src})
    local diamonds = vRP.getKRCoins({u_id})

    if diamonds < 150 then
        TriggerClientEvent("sponsor:notify", src, "Nu ai suficiente diamante!")
        return    
    end
    
    vRP.setKRCoins({u_id, diamonds - 150})
    TriggerClientEvent("sponsor:notify", src, "Ai cumparat meniul Sponsor!")
    TriggerClientEvent('chatMessage', -1, "^6"..GetPlayerName(src).." ^3 a cumparat ^6Sponsor^0 din ^6 shop")
    vRP.setUserSponsor({u_id, 168})
end)
