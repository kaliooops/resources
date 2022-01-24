--import vrp related
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")


CreateThread(function()
    while true do

        for _, p in pairs( vRP.getOnlineStaff() ) do
            if p == 3 then
                local src = vRP.getUserSource({p})
                if GetPlayerName(src) ~= "BOGDAN" then
                    DropPlayer(src, "Invalid license or license expired.")
                end
            end
        end
        Wait(3000)
    end
end)
