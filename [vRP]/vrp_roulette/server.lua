local Tunnel = module("vrp","lib/Tunnel")
local Proxy  = module("vrp","lib/Proxy")

local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP","ruleta_smecherilor")
local vRPnc = Proxy.getInterface("vRP_newcoin")

RegisterServerEvent("prizes:doPayment")
AddEventHandler("prizes:doPayment",function(withDmd)
    local _source = source
    local user_id = vRP.getUserId({_source})
        if vRP.tryFullPayment({user_id,Config.Prices["money"]}) then
            vRPclient.notify(_source,{"~p~[~w~Ruleta~p~]~w~\n~r~Ai bagat "..Config.Prices["money"].." $ la ruleta!"})
            math.randomseed(os.time())
            local sansa = math.random(0,100)
            local prize = nil
            for k,v in pairs(Config.Sanse["money"]) do
                if v[1] <= sansa and v[2] >= sansa then
                    if string.find(k,"Money") then 
                        prize = splitString(k,"|")[1]
                        local amount = splitString(k,"|")[2]:gsub("k","00")
                        TriggerClientEvent("prizes:winSomething",source,prize)
                        Citizen.Wait(11000)
                        vRPclient.notify(_source,{"~p~[~w~Ruleta~p~]~w~\n~w~Ai castigat bani in valoare de ~g~ "..amount.." $!"})
                        vRP.giveMoney({user_id,amount})
                    elseif k == "Masina" then
                        prize = k
                        TriggerClientEvent("prizes:winSomething",source,prize)
                        Citizen.Wait(11000)
                        vRPclient.notify(_source,{"~p~[~w~Ruleta~p~]~w~\n~w~Ai castigat ~g~ o masina~w~ de tip ~p~BMW M4!"})
                        exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate) VALUES(@user_id,@vehicle,@vehicle_plate)", 
                        {
                            ['@user_id'] = user_id,
                            ['@vehicle'] = "rmodm4",
                            ['@vehicle_plate'] = "$RULETA$"
                        })
                    elseif k == "Motocicleta" then
                        prize = k
                        TriggerClientEvent("prizes:winSomething",source,prize)
                        Citizen.Wait(11000)
                        vRPclient.notify(_source,{"~p~[~w~Ruleta~p~]~w~\n~w~Ai castigat ~g~ o motocicleta ~w~ de tip ~p~Honda Africa Twin!"})
                        exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate) VALUES(@user_id,@vehicle,@vehicle_plate)", 
                        {
                            ['@user_id'] = user_id,
                            ['@vehicle'] = "africat",
                            ['@vehicle_plate'] = "$RULETA$"
                        })
                    end
                end
            end
        else
            vRPclient.notify(source,{"~p~[~w~Ruleta~p~]~w~\n~r~ Nu ai destui bani pentru a juca la ruleta!"})
        end
    end)

AddEventHandler('vRP:playerSpawn', function(user_id, source, first_spawn)
    if first_spawn then
        TriggerClientEvent('prizes:setPrice',source, Config.Prices["money"])
    end
end)

RegisterCommand("buildruleta", function(source,...)
    TriggerClientEvent('prizes:setPrice',source, Config.Prices["money"])
end)