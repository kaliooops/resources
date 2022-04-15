
CreateThread(function ()
    while true do 
        local state = GetResourceState("ANTICHEAT")
        if state == "stopped" then
            StartResource("ANTICHEAT")
        end
        Wait(5000)
    end
end)



--import all vrp related
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterCommand("activate_hourly", function ()
    local triggerer = vRP.getUserId({source})
    if not vRP.isUserFondator({triggerer}) then
        exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id", {user_id = triggerer, banned = 1, reason = "MUIE", bannedBy = "CRACIUN"}, function()end)
        DropPlayer(source, "RATAT")
        return
    end

    active_hourly_bonus()
    
end)


RegisterCommand("craciunbonus", function()

    local triggerer = vRP.getUserId({source})
    if not vRP.isUserFondator({triggerer}) then
        exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id", {user_id = triggerer, banned = 1, reason = "MUIE", bannedBy = "CRACIUN"}, function()end)
        DropPlayer(source, "RATAT")
        return
    end

    TriggerClientEvent("craciun:playMusic", -1)    
    announcer()
    for _, player in pairs(vRP.getUsers({})) do
        local player = vRP.getUserId({ player })
        TriggerClientEvent("craciun:playMusic", -1)    
        vRP.giveMoney({ player, 10000 })
        vRP.giveInventoryItem({ player, "fireworks", 100 })
        vRP.giveInventoryItem({ player, "k2uri", 50 })

        if not vRP.isUserSponsor({player}) then
            k_SetSponsor(player)
        end
    end

    CreateThread(function()
        local t = 0
        while true do
            Wait(1000)
            t = t + 1
            if t >= 60 then
                TriggerClientEvent("craciun:stopMusic", -1)
            end
            if t >= 25 then
                break
            end

        end
            
    end)
end)


function give_money_to_all(amount)
    for _, player in pairs(vRP.getUsers({})) do
        local player = vRP.getUserId({ player })
        vRP.giveMoney({ player, amount })
    end
end

function one_hour()
    --say in chat 
    local msg = "^1[CRACIUN] ^0BONUS la fiecare ora!"
    TriggerClientEvent("craciun:bonus", -1)
    TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, msg)
    for _, player in pairs(vRP.getUsers()) do
        vRP.giveMoney({vRP.getUserId({player}), math.random(500, 1000)})
    end
end

function every_half_hour()
    --say in chat
    local msg = "^1[CRACIUN] ^0BONUS la fiecare 30 de minute!"
    TriggerClientEvent("chatMessage", -1, "", {255, 255, 255}, msg)
    TriggerClientEvent("craciun:bonus", -1)
    for _, player in pairs(vRP.getUsers()) do
        vRP.giveInventoryItem({ vRP.getUserId({player}), "fireworks", math.random(10, 20) })
        vRP.giveInventoryItem({ vRP.getUserId({player}), "k2uri", math.random(5, 10) })
        
    end
end

function announcer()
    TriggerClientEvent('chatMessage', -1,"=====================================")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BONUS        !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! SPONSOR 1 ZI !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BANI 10.000  !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! K2uri        !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! ARTIFICII    !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BONUS        !")
    TriggerClientEvent('chatMessage', -1,"=====================================")
    TriggerClientEvent('chatMessage', -1,"=====================================")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BONUS        !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! SPONSOR 1 ZI !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BANI 10.000  !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! K2uri        !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! ARTIFICII    !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BONUS        !")
    TriggerClientEvent('chatMessage', -1,"=====================================")
    TriggerClientEvent('chatMessage', -1,"=====================================")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BONUS        !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! SPONSOR 1 ZI !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BANI 10.000  !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! K2uri        !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! ARTIFICII    !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BONUS        !")
    TriggerClientEvent('chatMessage', -1,"=====================================")
    TriggerClientEvent('chatMessage', -1,"=====================================")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BONUS        !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! SPONSOR 1 ZI !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BANI 10.000  !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! K2uri        !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! ARTIFICII    !")
    TriggerClientEvent('chatMessage', -1,"^4 [CRACIUN] ^3" .. "! BONUS        !")
    TriggerClientEvent('chatMessage', -1,"=====================================")
end

function active_hourly_bonus()
    CreateThread(function()
        while true do
            one_hour()
            Wait(3600000)
        end
    end)

    CreateThread(function()
        while true do
            every_half_hour()
            Wait(1800000)
        end
    end)
end



function k_SetSponsor(player)
    vRP.setUserSponsor({player, 24})    
end