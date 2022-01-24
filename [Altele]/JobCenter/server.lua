--import all vrp

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

local function getUserId(source)
    -- local ids = GetPlayerIdentifiers(source)
    -- local user_id = 0
    -- local finished = false 
    -- exports.ghmattimysql:execute("SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier", {identifier = ids[1]}, function (rows)
    --     user_id = rows[1].user_id
    --     finished = true
    -- end)
    -- while not finished do Wait(100) end
    -- return user_id

    return vRP.getUserId({source})
end



RegisterNetEvent("jobCenter_GetCurrentJobTitle")
AddEventHandler("jobCenter_GetCurrentJobTitle", function ()
    --user_id = vRP.getUserId({source})
    user_id = getUserId(source)
    exports.ghmattimysql:execute("SELECT job FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function (rows)
        TriggerClientEvent("jobcenter_JobTitle", user_id, {rows[1].job})
    end)
end)


RegisterNetEvent("AngajeazaBodyGuard")
AddEventHandler("AngajeazaBodyGuard", function ()
    user_id = getUserId(source)
    exports.ghmattimysql:execute("UPDATE vrp_users SET job = \"BodyGuard\" WHERE id = @user_id", {user_id = user_id})
end)

RegisterNetEvent("AngajeazaCarDelivery")
AddEventHandler("AngajeazaCarDelivery", function ()
    user_id = getUserId(source)
    if vRP.getUserHoursPlayed({user_id}) >= 10 then
        if vRP.getUserFaction({user_id}) ~= "Politia Romana" and vRP.getUserFaction({user_id}) ~= "Smurd" then
            exports.ghmattimysql:execute("UPDATE vrp_users SET job = \"CarDelivery\" WHERE id = @user_id", {user_id = user_id})
        end
    end
end)

RegisterNetEvent("bodyguard_InsertInDatabase")
AddEventHandler("bodyguard_InsertInDatabase", function ()
    local src = source
    user_id = getUserId(src)
    exports.ghmattimysql:execute("SELECT * FROM job_BodyGuard WHERE user_id = @user_id", {user_id = user_id}, function (rows)
        if #rows == 0 then
            exports.ghmattimysql:execute("INSERT INTO job_BodyGuard (user_id, isOnDuty) VALUES (@user_id, @isOnDuty)", {user_id = user_id, isOnDuty = "nu"})
        end
    end)
end)


-- RegisterNetEvent("AngajeazaDezapezitor")
-- AddEventHandler("AngajeazaDezapezitor", function ()
--     user_id = getUserId(source)
--     exports.ghmattimysql:execute("UPDATE vrp_users SET job = \"Dezapezitor\" WHERE id = @user_id", {user_id = user_id})
-- end)

RegisterNetEvent("AngajeazaDemolari")
AddEventHandler("AngajeazaDemolari", function ()
    user_id = getUserId(source)
    exports.ghmattimysql:execute("UPDATE vrp_users SET job = \"Demolari\" WHERE id = @user_id", {user_id = user_id})
end)

RegisterNetEvent("AngajeazaAprovizionari")
AddEventHandler("AngajeazaAprovizionari", function ()
    user_id = getUserId(source)
    exports.ghmattimysql:execute("UPDATE vrp_users SET job = \"Aprovizionari\" WHERE id = @user_id", {user_id = user_id})
end)






