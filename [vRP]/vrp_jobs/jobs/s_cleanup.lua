local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_cleanup")

RegisterCommand("cleanup", function(player, args)
	if player == 0 then
		local theSecs = parseInt(args[1]) or 0
		TriggerClientEvent("alex:delAllVehs", -1, theSecs)
	else
		local user_id = vRP.getUserId({player})
	    if vRP.isUserAdmin({user_id}) then
			local sec = parseInt(args[1]) or 0
			if sec >= 0 then
				TriggerClientEvent("chatMessage", -1, "^5[k2] Adminul "..vRP.getPlayerName({player}).." - ID [" ..user_id.. "] ^5folosit comanda pentru a sterge masinile neocupate!")
			    TriggerClientEvent("alex:delAllVehs", -1, sec)
			end
		else
			TriggerClientEvent("chatMessage", player, "^1Eroare^0: Nu ai acces la aceasta comanda")
		end
	end
end, false)