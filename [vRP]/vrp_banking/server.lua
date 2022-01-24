local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_banking")

vRPlogs = Proxy.getInterface("vRP_logs")

vRPbanking = {}
Tunnel.bindInterface("vRP_banking",vRPbanking)
Proxy.addInterface("vRP_banking",vRPbanking)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local walletMoney = vRP.getMoney({user_id})
	local bankMoney = vRP.getBankMoney({user_id})
	if(tonumber(amount))then
		if(vRP.tryPayment({user_id, amount}))then
			vRP.setBankMoney({user_id, bankMoney+amount})
			vRP.setMoney({user_id, walletMoney-amount})
			vRPclient.notify(thePlayer, {"~g~Ai depus ~y~$"..amount.." ~g~in banca!"})
			logText = GetPlayerName(thePlayer).."("..user_id..") a depus |"..amount.." BANI| in banca"
			TriggerEvent("k2ANTICHEAT:logger", "bank.txt", logText)
			vRPlogs.createLog({user_id,logText,"Depunere Banca"})
		else
			vRPclient.notify(thePlayer, {"~r~Nu ai destui bani la tine!"})
		end
	else
		vRPclient.notify(thePlayer, {"~r~Numar invalid!"})
	end
end)


RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local walletMoney = vRP.getMoney({user_id})
	local bankMoney = vRP.getBankMoney({user_id})
	if(tonumber(amount))then	
		amount = tonumber(amount)
		if(amount > 0 and amount <= bankMoney)then
			vRP.setBankMoney({user_id, bankMoney-amount})
			vRP.setMoney({user_id, walletMoney+amount})
			vRPclient.notify(thePlayer, {"~g~Ai retras ~y~$"..amount.." ~g~din banca!"})
			logText = GetPlayerName(thePlayer).."("..user_id..") a retras |"..amount.." BANI| din banca"
			vRPlogs.createLog({user_id,logText,"Retragere Banca"})
		else
			vRPclient.notify(thePlayer, {"~r~Nu ai destui bani in banca!"})
		end
	else
		vRPclient.notify(thePlayer, {"~r~Numar invalid!"})
	end
end)


RegisterServerEvent('bank:withdraw_incasari')
AddEventHandler('bank:withdraw_incasari', function(amount)
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local walletMoney = vRP.getMoney({user_id})

	exports.ghmattimysql:execute("SELECT incasari FROM Joburi WHERE patron = @user_id", {user_id = user_id}, function(rows)   
		local money = rows[1].incasari or 0
		if(tonumber(amount))then	
			amount = tonumber(amount)
			if(amount > 0 and amount <= money)then
				exports.ghmattimysql:execute("UPDATE Joburi SET incasari = incasari - @amount WHERE patron = @patron", {amount = amount, patron = user_id})
				vRP.setMoney({user_id, walletMoney+amount})
				vRPclient.notify(thePlayer, {"~g~Ai retras ~y~$"..amount.." ~g~din incasari!"})
			else
				vRPclient.notify(thePlayer, {"~r~Nu ai destui bani in incasari!"})
			end
		else
			vRPclient.notify(thePlayer, {"~r~Numar invalid!"})
		end
	end)

end)







-- RegisterServerEvent('bank:balance')
-- AddEventHandler('bank:balance', function()
-- 	local thePlayer = source
	
-- 	local user_id = vRP.getUserId({thePlayer})
-- 	local bankMoney = vRP.getBankMoney({user_id})
-- 	TriggerClientEvent('currentbalance1', thePlayer, bankMoney)
-- end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local thePlayer = source
	
	local user_id = vRP.getUserId({thePlayer})
	local bankMoney = vRP.getBankMoney({user_id})
	local incasari = 0
	exports.ghmattimysql:execute("SELECT incasari FROM Joburi WHERE patron = @user_id", {user_id = user_id}, function(rows)   
		if rows[1] == nil then
			incasari = 0
		else
			incasari = rows[1].incasari
		end
		TriggerClientEvent('currentbalance1', thePlayer, {bankMoney, incasari})	
	end)
end)











RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amount)
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if(tonumber(to)  and to ~= "" and to ~= nil)then
		to = tonumber(to)
		theTarget = vRP.getUserSource({to})
		if(theTarget)then
			if(thePlayer == theTarget)then
				vRPclient.notify(thePlayer, {"~r~Nu iti poti transfera bani tie!"})
			else
				if(tonumber(amount) and tonumber(amount) > 0 and amount ~= "" and amount ~= nil)then
					amount = tonumber(amount)
					bankMoney = vRP.getBankMoney({user_id})
					if(bankMoney >= amount)then
						newBankMoney = tonumber(bankMoney - amount)
						vRP.setBankMoney({user_id, newBankMoney})
						vRP.giveBankMoney({to, amount})
						vRPclient.notify(thePlayer, {"~g~Ai transferat ~y~$"..amount.." ~g~lui ~b~"..GetPlayerName(theTarget)})
						vRPclient.notify(theTarget, {"~y~"..GetPlayerName(thePlayer).." ~g~ti-a transferat ~b~$"..amount})
						logText = GetPlayerName(thePlayer).."("..user_id..") ia transferat |"..amount.." BANI| in banca lui "..GetPlayerName(theTarget).."("..to..")"
						vRPlogs.createLog({user_id,logText,"Transfer Banca"})
					else
						vRPclient.notify(thePlayer, {"~r~Nu ai destui bani in banca!"})
					end
				else
					vRPclient.notify(thePlayer, {"~r~Numar invalid!"})
				end
			end
		else
			vRPclient.notify(thePlayer, {"~r~Jucatorul nu a fost gasit"})
		end
	end
end)