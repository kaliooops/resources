function tvRP.washTheCar(dirt)
	local user_id = vRP.getUserId(source)
	if parseFloat(dirt) > parseFloat(1.0) then
		if vRP.tryPayment(user_id,1500) then
			vRPclient.washSuccess(source, {})
			vRPclient.notify(source,{"~g~Ai platit ~r~1500$."})
	  	else
			vRPclient.notify(source,{"~r~Nu ai destui bani!"})
	  	end	
	else
		vRPclient.notify(source,{"~g~Vehiculul este deja curat!"})
	end
end