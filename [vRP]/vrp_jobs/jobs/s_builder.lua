builderMoney = {}

function vRPjobs.initTheSantier(thePlayer)
    user_id = vRP.getUserId({thePlayer})
    vRPCjobs.initBuilderJob(thePlayer,{})
    builderMoney[user_id] = {money = 0}


end

RegisterCommand("fixbuild", function(source)
    vRPCjobs.initBuilderJob(source,{})
    user_id = vRP.getUserId({source})
    builderMoney[user_id] = {money = 0}
end)

RegisterNetEvent("sendPlayerCurrentJob")
AddEventHandler("sendPlayerCurrentJob",function ()
    local src = source
    user_id = vRP.getUserId({src})
    exports.ghmattimysql:execute("SELECT job FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)    
        job = rows[1].job
        
        TriggerClientEvent("getPlayerCurrentJob", src, job)
    end)
end) 


RegisterNetEvent("getdbClothes")
AddEventHandler("getdbClothes", function(pid)
    user_id = vRP.getUserId({pid})
    exports.ghmattimysql:execute("SELECT skin FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)    
        local json = require "json"
        skin_obj = json.decode(rows[1].skin)
       
        TriggerClientEvent("updateDresser", pid, 
        {
            hat = {0, skin_obj.props["0"][2]},
            jacket = {11, skin_obj.drawables["11"][2]},
            armsgloves = {3, skin_obj.drawables["3"][2]},
            pants = { 4, skin_obj.drawables["4"][2]},
            shoes = { 6, skin_obj.drawables["6"][2]}
        })

    end)

end)

local biz_owner = ""



function vRPjobs.finishBuilderJob()
    thePlayer = source
    user_id = vRP.getUserId({thePlayer})

    if biz_owner == "" then
        exports.ghmattimysql:execute("SELECT patron FROM Joburi WHERE jobname = \"constructor\"", function(rows)    
            biz_owner = rows[1].patron
        end)    
    
    end
    
    local money = math.random(30,50)
    vRPclient.notify(thePlayer,{"~w~[~g~CONSTRUCTOR~w~]~g~ Ai terminat lucrarea, ai primit ~y~"..money.."$"})
    vRP.giveMoney({user_id, money,"true",GetCurrentResourceName()})
    local bizmon = 15/100*money

    exports.ghmattimysql:execute("UPDATE Joburi SET incasari = incasari + @bizmon WHERE patron = @patron", {bizmon = bizmon, patron = biz_owner})


    
end


RegisterNetEvent("AngajeazaBuilder")
AddEventHandler("AngajeazaBuilder", function ()
    user_id = vRP.getUserId({source})
    exports.ghmattimysql:execute("UPDATE vrp_users SET job = \"Constructor\" WHERE id = @user_id", {user_id = user_id})
end)

RegisterNetEvent("DemisioneaazaBuilder")
AddEventHandler("DemisioneaazaBuilder", function ()
    user_id = vRP.getUserId({source})
    exports.ghmattimysql:execute("UPDATE vrp_users SET job = \"Somer\" WHERE id = @user_id", {user_id = user_id})
end)




AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if first_spawn then
        SetTimeout(1000, function()
                builderMoney[user_id] = {money = 0}
                vRPCjobs.initBuilderJob(source,{})
        end)
    end
end)

AddEventHandler("vRP:playerLeave",function(user_id, source)
    local job = vRPjobs.getPlayerJob(user_id)
        builderMoney[user_id] = nil
end)




