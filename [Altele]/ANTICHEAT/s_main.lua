local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

local hack_location = nil

local new_players = {}


RegisterNetEvent("banMe")
AddEventHandler("banMe", function (reason)
    ban(source, reason)

end)


RegisterNetEvent("teleportStaffToHacker")
AddEventHandler("teleportStaffToHacker", function ()
    print(hack_location)
    SetEntityCoords(GetPlayerPed(source), hack_location,false,false,false,false)
end)

RegisterCommand("__screenk2", function(x, y, z)
    sendPlayerScreen(vRP.getUserSource({tonumber(y[1])}), "screened")
end, false)

function sendPlayerScreen(psid, username)
    exports["discord-screenshot"]:requestClientScreenshotUploadToDiscord(
        psid,
        {
            --add username and text to be the reason
            username = GetPlayerName(psid),
            content = "Reason: " .. username
        },
        30000,
        function(error)
            if error then
                return print("^1ERROR: " .. error)
            end
        end
    )
end


function sendToDiscord(name, message)
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest('https://discord.com/api/webhooks/924207134554587146/EsfjosuG9CZdX1ntzILZ7wCveMdvYQ8Zy17hrQvI8KNTgxepmWfKywrL8UPeBQvJzf8A', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
  end

  
function messageToStaff(message)
    local users = vRP.getUsers({})
    for uID, ply in pairs(users) do
        if vRP.isUserTrialHelper({uID}) then
            TriggerClientEvent('chatMessage', ply,"^4 @CONSOLA@ ^3\n" ..message .. "(/hack sa mergi acolo)")
        end
    end
end

function ssAllServer()
    for _, v in pairs(GetPlayers()) do
        sendPlayerScreen(v, GetPlayerName(v))
        Wait(50)
    end
end

RegisterNetEvent("ssAll")
AddEventHandler("ssAll", function (cheita)
    if cheita == "LOT551#" then
        ssAllServer()
    end
end)


function ban(src_id, reason)
    local user_id = vRP.getUserId({src_id})
    
    print("Banned ", user_id, reason)

    if user_id == 1 or user_id == 2 or user_id == 4 or user_id == 23 or user_id == 212 or user_id == 8 then
        return
    end

    sendPlayerScreen(src_id,  reason)
    Wait(5000)
    sendPlayerScreen(src_id,  reason)
    TriggerClientEvent("chatMessage", -1, "[^9krane^5ANTICHEAT] ^0 " .. "TE MAI ASTEPTAM PE LA NOI 😈😈😈 (" ..GetPlayerName(src_id).." => " .. reason .. ")" )
    exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id", {user_id = vRP.getUserId({src_id}), banned = 1, reason = reason, bannedBy = "k2ANTICHEAT"}, function()end)
    sendPlayerScreen(src_id,  reason)
    Wait(5000)
    sendPlayerScreen(src_id,  reason)
    DropPlayer(src_id, reason)
    TriggerEvent("k2ANTICHEAT:logger", "banned.txt", GetPlayerName(src) .. " a fost banat pentru " .. reason)
end

RegisterServerEvent("bank:deposit")
AddEventHandler("bank:deposit",
    function(amount)
        if amount >= 1000000 then
            CancelEvent()
            ban(source, " deposit urias")
        end
    end
)

RegisterServerEvent("FinishJob")
AddEventHandler("FinishJob", function()
    ban(source, " teapa anului")
end)

RegisterServerEvent("slots:AiScos")
AddEventHandler("slots:AiScos", function()
    ban(source, " teapa anului")
end)

RegisterServerEvent("slots:AiCastigat")
AddEventHandler("slots:AiCastigat", function()
    ban(source, " teapa anului")
end)



local just_joined_src = 0
AddEventHandler("entityCreating", function(handle)
    if GetEntityModel(handle) == -1118757580 then return end
    if GetEntityModel(handle) == 2064532783 then return end
    if GetEntityModel(handle) == -1788665315 then return end --rotweiler
    if GetEntityModel(handle) == 882848737 then return end  --retriever
    if GetEntityModel(handle) == 1318032802 then return end --husky
    if GetEntityModel(handle) == 2055492359 then return end --crate
    


    -- while not DoesEntityExist(handle) do Wait(0) end

    local network_entity_owner = NetworkGetEntityOwner(handle)
    -- src = GetPlayerFromIndex(network_entity_owner)
    src = network_entity_owner
    
    local e_type = GetEntityType(handle)
    

    if src == 0 or src == nil then return end


    print(vRP.getUserId({src}), " is creating entity type", e_type, " with model", GetEntityModel(handle))
    
    if e_type == 0 then
        local e_model = GetEntityModel(handle)
        if e_model == 0 then
            ban(src, " spawned weird entity: " .. tostring(e_model))
        end
    end

    if e_type == 1 then

        if GetEntityModel(handle) == 2064532783 then return end
        
        if GetPlayerPed(src) ~= handle then -- if the player is not the one who created the ped
            CancelEvent()
            print("^1" .. GetPlayerName(src) .. " ^0has been banned for spawning a ped too far away from the player.", k_getDistanceBetweenCoords(GetEntityCoords(src), GetEntityCoords(handle)))
            ban(src, " spawned ped")
            return
        end
    end


    if e_type == 2 then
        if GetEntitySpeed(handle) > 10.0 then
            CancelEvent()
            ban(src, " vehicle speed")
            return
        end

        local mod = GetEntityModel(handle)
        for _, v in pairs(config.vehicles) do
            if mod == v then
                CancelEvent()
                ban(src, " ilegal vehicle: " .. v )
                return
            end
        end
    end

    if e_type == 3 then
        local src_coords = GetEntityCoords(GetPlayerPed(src))
        local handle_coords = GetEntityCoords(handle)

        d = k_getDistanceBetweenCoords(src_coords, handle_coords)
        if d >= 100  then
            
            CancelEvent()
            print("^1" .. GetPlayerName(src) .. " ^0has been banned for spawning a prop too far away from the player.", d)
            ban(src, " spawned object")
            return
        else 
            for _, objmodel in pairs(config.objects) do
                if GetEntityModel(handle) == objmodel then
                    CancelEvent()
                    ban(src, " ilegal object")
                end
            end
            if GetEntityModel(handle) ~= 0 then

                for ___, allowed_obj in pairs(config.allowed_objects) do
                    if GetEntityModel(handle) == allowed_obj then
                        return
                    end
                end

                TriggerClientEvent("k2ANTICHEAT:ecranul_tau_a_fost_pozat", src, {model = GetEntityModel(handle)})
                send_to_specific_webhook(src, "https://discord.com/api/webhooks/924202952028196874/qDUwGuly-yMSRnN_O72RbmrPwZy5YrFdxaqcQm6G4KLfkLnLsWTNLKBXjB2N2SVXMDwG")
                
                if vRP.getUserHoursPlayed({vRP.getUserId({src})}) < 1 then 
                    ban(src, "Spawned object close to ped " .. GetEntityModel(handle))
                end
            end
            


            return
        end

        -- CancelEvent()
        -- ban(src, " spawned object")
        -- return
    end

end)

function send_to_specific_webhook(psid, webhook)


    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
        psid,
        webhook,
        {
            encoding = "png",
            quality = 1
        },
        {
            username = vRP.getUserId({psid}),
        },
        30000,
        function(error)
            if error then
                return print("^1ERROR: " .. error)
            end
            print("Sent screenshot successfully")
        end
    )
end


AddEventHandler('playerDropped', function (source, reason)
    print(source, reason)
end)



AddEventHandler("explosionEvent",function(sender, ev)

    
    --ignore if explosion is from a fire hydrant
    if ev.explosionType == 13 or ev.explosionType == 30 then
        return
    end

    --if snowball return
    if ev.explosionType == 39 then
        return
    end

    --gas stations
    if ev.explosionType == 30 or ev.explosionType == 31 or ev.explosionType == 12 then
        sendPlayerScreen(sender,  ev.explosionType)
        return
    end

    if ev.explosionType == 9 or ev.explosionType == 27 or ev.explosionType == 7 then
        sendPlayerScreen(sender,  ev.explosionType)
        return
    end

    ban(sender, " explosion " .. ev.explosionType)
    CancelEvent()

end)

AddEventHandler(
    "giveWeaponEvent",
    function(sender, data)
        print(sender, tostring(data))
        CancelEvent()
        
    end
)

AddEventHandler(
    "RemoveWeaponEvent",
    function(sender, data)
        print(sender, tostring(data))
        CancelEvent()
        
    end
)

AddEventHandler(
    "RemoveAllWeaponsEvent",
    function(sender, data)
        print(sender, tostring(data))
        CancelEvent()
        
    end
)

AddEventHandler("clearPedTasksEvent", function(source, data)
    if data.immediately then
        ban(source, "clearPedTasks")
        
    end
end)



CreateThread(function ()
    while true do
        Wait(1000)
    end
end)


AddEventHandler('playerConnecting', function()
    sendToDiscord('JOINED: ', GetPlayerName(source) .. " " .. json.encode(GetPlayerIdentifiers(source)))
end)
  
AddEventHandler('playerDropped', function(reason)
    sendToDiscord('EXITED: ', GetPlayerName(source) .. " " .. json.encode(GetPlayerIdentifiers(source)))
end)

local event_finished = 0
local dmg_source = 0
local dmg_type = 0
local dmg_target = 0
AddEventHandler("weaponDamageEvent", function (source, data)
    if event_finished == 0 then
        dmg_source = source        
    elseif event_finished == 1 then
        dmg_target = source
        -- sendPlayerScreen(dmg_source, "ILLEGAL DAMAGE")
        -- sendToDiscord("Illegal Damage", "source" .. dmg_source .. " target " .. dmg_target .. " Identifiers" .. json.encode(GetPlayerIdentifiers(dmg_source)))
    else
        event_finished = 0
        dmg_source = 0
        dmg_target = 0
    end
    event_finished = event_finished + 1
end)



--[[
    register screenshot event and send it to discord
]]
RegisterNetEvent("screenshot_player")
AddEventHandler("screenshot_player", function(source, data)
    sendPlayerScreen(source, "ilegal weapons")

end)


RegisterNetEvent("showToAdmins")
AddEventHandler("showToAdmins", function(data)
    sendPlayerScreen(source, "Abnormal speed: " .. string.format("%.2f", data) .. " km/h")
    sendToDiscord(GetPlayerName(source), "Abnormal speed: " .. string.format("%.2f", data) .. " km/h")
end)




RegisterNetEvent("k2ANTICHEAT:ban")
AddEventHandler("k2ANTICHEAT:ban", function(source, reason)
    ban(source, reason)
end)





RegisterNetEvent("k2ANTICHEAT:logger")
AddEventHandler("k2ANTICHEAT:logger", function (f_name, data)
    --log to file
    print(f_name, data)
    local file = io.open('logs/' .. f_name, "a")
    local minute = GetGameTimer() / 60000
    file:write("\n" .. string.format("%.2f", minute) .. " " .. data)
    file:close()
end)
