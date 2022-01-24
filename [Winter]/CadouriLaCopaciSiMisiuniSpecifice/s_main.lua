--import all vrp
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

misiuni = {
    "Condu cu ATV 30 de km",
    "Gaseste Cadourile Ascunse in cele 3 zone albastre",
    "Aprinde 100 de artificii",
    "Viziteaza extraterestrul din iglu",
    -- "Plimbare cu masina de la rent",
    "Nu parasi si orasul timp de o ora",
    "Viziteaza insula cayo perico",
    "Mergi cu masina cu spatele 10 km",
    "Poarta caciula de craciun",
    "Obtine 5.000 euro",

}

function split (inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

local m
RegisterNetEvent("winter_misiuni:get_new_mision")
AddEventHandler("winter_misiuni:get_new_mision", function ()

    local user_id = vRP.getUserId({source})
    local src = source
    local c_mission     

    --check if user_id in mysql table
    exports.ghmattimysql:execute("select quests from winter where user_id = @user_id", {user_id = user_id}, function(rows)
        if rows[1] == nil then
            m = misiuni[math.random(1, #misiuni)] 
            c_mission = m 
    
            m = m .. ","
            TriggerClientEvent("winter_misiuni:get_new_mision", src, c_mission)        
            return
        end

        local quests = rows[1].quests
        local quests_array = split(quests, ",")


        --get a mission thats not in the quests array
        for i = 1, #misiuni do
            if not contains(quests_array, misiuni[i]) then
                m = misiuni[i]
                c_mission = m
                break
            end
        end

        if #quests_array >= #misiuni then
            TriggerClientEvent("toasty:Notify", src, {type = "info", title = "Misiuni", message = "Ai terminat toate misiunile"})
            return
        end


        TriggerClientEvent("winter_misiuni:get_new_mision", src, c_mission)        

        m = quests .. m .. ","
    


    end)


    



end)



RegisterNetEvent("winter_misiuni:finish_mission")
AddEventHandler("winter_misiuni:finish_mission", function (mission)
    
    TriggerClientEvent("winter_misiuni:finish_mission", source, mission)
    local user_id = vRP.getUserId({source})
    vRP.giveInventoryItem({user_id, "Cadouri", 1})
    print(m)

    exports.ghmattimysql:execute("select user_id from winter where user_id = @user_id", {user_id = user_id}, function(rows)
        if not rows[1] then
            --insert user with empty quests in the tablel
            exports.ghmattimysql:execute("INSERT INTO winter (user_id, quests) values (@user_id, @quests)", {user_id = user_id, quests = m}, function(rows) end)
        end
    end)

    exports.ghmattimysql:execute("UPDATE winter SET quests = @quests WHERE user_id = @user_id", {user_id = user_id, quests = m}, function(rows) end)

end)


RegisterNetEvent("winter_misiuni:k2uri_sub_brad")
AddEventHandler("winter_misiuni:k2uri_sub_brad", function()
    
    local src = source
    local user_id = vRP.getUserId({src})

    if vRP.tryGetInventoryItem({user_id, "Cadouri", 1}) then
        TriggerClientEvent("winter_misiuni:k2uri_sub_brad", src)
        local krcoins_amount = math.random(5, 10)
        local money_amount = math.random(2500, 7500)
        local fireworks_amount = math.random(7, 15)

        vRP.giveKRCoins({user_id, krcoins_amount})
        vRP.giveMoney({user_id, money_amount})
        vRP.giveInventoryItem({user_id, "fireworks", fireworks_amount})
        TriggerClientEvent("toasty:Notify", src, {type = "success", title = "Misiuni", message = "Ai primit " .. krcoins_amount .. " diamante, " .. money_amount .. " $ si " .. fireworks_amount .. " artificii"})        
    
    end
    
end)