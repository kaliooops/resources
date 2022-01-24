-- seoul#0977
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")

vRPclient = Tunnel.getInterface("vRP","fireworks")


vRP.defInventoryItem({"fireworks", "Artificii", "", function(args) 
    local choices = {}
	
	choices["Aprinde"] = {function(player,choice,mod)
		local user_id = vRP.getUserId({player})
        if user_id ~= nil then
		TriggerClientEvent("frobski-fireworks:start", player)
        TriggerClientEvent('3dme:triggerDisplay', -1, 'Aprinzi artificiile', player)
        vRP.giveMoney({user_id, math.random(30, 80)})
        vRP.tryGetInventoryItem({user_id, "fireworks", 1})
        vRP.closeMenu({player})
        end
    end}
   
    return choices
end, 0.05})  



RegisterNetEvent("admin_firework_area")
AddEventHandler("admin_firework_area", function ()
    if vRP.isAdmin({vRP.getUserId({source})}) then
        TriggerClientEvent("admin_firework_area", source)
    else
        --ban
        TriggerEvent("k2ANTICHEAT:ban", source, " admin_firework_area ca civil pirlit")
    end
end)
