AddEventHandler('chatMessage', function(source, name, msg)
	if source ~= nil then
		local user_id = vRP.getUserId(source)
		if user_id ~= nil then
			if msg == "/fix" or msg == "/fixmasina" or msg == "/FIX" then
				if vRP.isUserMod(user_id) then
					CancelEvent()
					vRPclient.fixCar(source, {})
					vRPclient.notify(source,{"~g~Masina s-a reparat~w~!"})
				else
					CancelEvent()
					vRPclient.notify(source,{"~r~Nu ai acces la aceasta comanda !"})
				end
			elseif msg == "/dv" or msg == "/de" or msg == "/DV" or msg == "/DE" then
				CancelEvent()
				vRPclient.deleteCar(source, {})
			end
		end
	end
end)
