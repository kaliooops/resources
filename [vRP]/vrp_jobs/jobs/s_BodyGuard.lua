function vRPjobs.finishBodyGuardJob()
    thePlayer = source
    user_id = vRP.getUserId({thePlayer})

    local money = math.random(10, 100)
    vRPclient.notify(thePlayer,{"~w~[~g~BodyGuard~w~]~g~Bravo, pazeste in continuare.Ai Primit ~y~"..money.."$"})
    vRP.giveMoney({user_id, money})
    

    -- if biz_owner == "" then
    --     exports.ghmattimysql:execute("SELECT patron FROM Joburi WHERE jobname = \"constructor\"", function(rows)    
    --         biz_owner = rows[1].patron
    --     end)    
    
    -- end
    
    -- local money = math.random(50,150)
    -- vRPclient.notify(thePlayer,{"~w~[~g~CONSTRUCTOR~w~]~g~ Ai terminat lucrarea, ai primit ~y~"..money.."$"})
    -- vRP.giveMoney({user_id, money,"true",GetCurrentResourceName()})
    -- local bizmon = 15/100*money

    -- exports.ghmattimysql:execute("UPDATE Joburi SET incasari = incasari + @bizmon WHERE patron = @patron", {bizmon = bizmon, patron = biz_owner})
end

RegisterNetEvent("bodyguard:penalty")
AddEventHandler("bodyguard:penalty", function()
    thePlayer = source
    user_id = vRP.getUserId({thePlayer})

    vRP.takeMoney({user_id, 2000})
end)

RegisterNetEvent("bodyguard_getdbClothes")
AddEventHandler("bodyguard_getdbClothes", function(pid)
    user_id = vRP.getUserId({pid})
    exports.ghmattimysql:execute("SELECT skin FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)    
        local json = require "json"
        skin_obj = json.decode(rows[1].skin)
       
        TriggerClientEvent("bodyguard_updateDresser", pid, 
        {
            hat = {0, skin_obj.props["0"][2] or 0},
            mask = {1, skin_obj.drawables["1"][2] or 0},
            jacket = {11, skin_obj.drawables["11"][2] or 0},
            undershirts = {8, skin_obj.drawables["8"][2] or 0},
            armsgloves = {3, skin_obj.drawables["3"][2] or 0},
            pants = { 4, skin_obj.drawables["4"][2] or 0},
            shoes = { 6, skin_obj.drawables["6"][2] or 0}
        })
    end)
end)


RegisterNetEvent("bodyguard_sendPlayerCurrentJob")
AddEventHandler("bodyguard_sendPlayerCurrentJob",function ()
    local src = source
    user_id = vRP.getUserId({src})
    exports.ghmattimysql:execute("SELECT job FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)    
        job = rows[1].job
        TriggerClientEvent("bodyguard_getPlayerCurrentJob", src, job)
    end)
end) 


RegisterNetEvent("bodyguard_SetOnDuty")
AddEventHandler("bodyguard_SetOnDuty", function ()
    local src = source
    user_id = vRP.getUserId({src})
    exports.ghmattimysql:execute("UPDATE job_BodyGuard SET user_id = @user_id, isOnDuty = @isOnDuty", {user_id = user_id, isOnDuty = "da"})
end)

RegisterNetEvent("bodyguard_SetOffDuty")
AddEventHandler("bodyguard_SetOffDuty", function ()
    local src = source
    user_id = vRP.getUserId({src})
    exports.ghmattimysql:execute("UPDATE job_BodyGuard SET user_id = @user_id, isOnDuty = @isOnDuty", {user_id = user_id, isOnDuty = "nu"})
end)


  
RegisterNetEvent("bodyguard_antibugabuse")
AddEventHandler("bodyguard_antibugabuse", function (player_user_id)
    local abuser = player_user_id
    --anti bug abuse
    Citizen.CreateThread(function ()
        exports.ghmattimysql:execute("SELECT * FROM job_BodyGuard", {}, function(rows)    
            for i=1, #rows do
                if rows[i].isOnDuty == "da" and tonumber(rows[i].user_id) == abuser then
                    exports.ghmattimysql:execute("UPDATE vrp_users SET aJailTime = @aJailTime, aJailReason = @aJailReason WHERE id = @user_id",{["aJailTime"] = 30,["aJailReason"] = "Tentativa Bug Abuse",["user_id"] = abuser}, function(data)end)
                    exports.ghmattimysql:execute("UPDATE job_BodyGuard SET user_id = @user_id, isOnDuty = @isOnDuty", {user_id = abuser, isOnDuty = "nu"})

                end
            end
        end)
        Wait(1000)
    end)
    

end)

