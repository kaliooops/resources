RegisterServerEvent('double:politai')
AddEventHandler('double:politai', function()
    local user_id = vRP.getUserId(source)
    if vRP.isUserInFaction(user_id,"Politia Romana") or vRP.isUserInFaction(user_id,"Jandarmerie")then 
        TriggerClientEvent("double:politie",source)
    else
        vRPclient.notify(source,{"~r~Nu ai acces la acest meniu !"})
    end
end)
RegisterServerEvent('double:smurdan')
AddEventHandler('double:smurdan', function()
    local user_id = vRP.getUserId(source)
    if vRP.isUserInFaction(user_id,"Smurd")then 
        TriggerClientEvent("double:smurd",source)
    else
        vRPclient.notify(source,{"~r~Nu ai acces la acest meniu !"})
    end
end)