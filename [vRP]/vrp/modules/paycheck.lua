local Proxy = module("vrp", "lib/Proxy")

RegisterServerEvent('paychecknozy:salarynozy')
AddEventHandler('paychecknozy:salarynozy', function()
	local user_id = vRP.getUserId(source)
	local factionPayday = 0
	
	if(vRP.hasUserFaction(user_id))then
		local theFaction = vRP.getUserFaction(user_id) or ""
		local theRank = vRP.getFactionRank(user_id) or ""
		local thePay = vRP.getFactionRankSalary(theFaction, theRank)
		if(thePay > 0)then
			factionPayday = thePay
		end
	end
	vRP.salariuSound(source)
	if(factionPayday > 0) and (vRP.hasGroup(user_id,"onduty"))then
		vRP.giveBankMoney(user_id, factionPayday)
		local msg = "Salariu "..theFaction.." "..vRP.formatMoney(factionPayday).."$"
		vRPclient.salariuAnnouncement(source, {msg})
	end

	if vRP.isUserInFaction(user_id,"Politie") or vRP.isUserInFaction(user_id,"SWAT") or vRP.isUserInFaction(user_id,"Smurd") then
		vRP.addUserGroup(user_id,"Somer")
	else
		if vRP.hasGroup(user_id,"Mechanic") then
			vRP.giveBankMoney(user_id,350)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Mecanic",false,"Salariu: ~g~$ ~w~300"})
		end

		if vRP.hasGroup(user_id,"UBER") then
			vRP.giveBankMoney(user_id,200)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"UBER",false,"Salariu: ~g~$ ~w~200"})
		end

		if vRP.hasGroup(user_id,"Avocat") then
			vRP.giveBankMoney(user_id,150)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Avocat",false,"Salariu: ~g~$ ~w~150"})
		end

		if vRP.hasGroup(user_id,"Livrari") then
			vRP.giveBankMoney(user_id,250)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Livrari",false,"Salariu: ~g~$ ~w~250"})
		end

		if vRP.hasGroup(user_id,"Somer") then
			vRP.giveBankMoney(user_id,100)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Civil",false,"Salariu: ~g~$ ~w~100"})
		end

		if vRP.hasGroup(user_id,"Sofer Banci") then
			vRP.giveBankMoney(user_id,250)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Sofer Banci",false,"Salariu: ~g~$ ~w~250"})
		end

		if vRP.hasGroup(user_id,"Cargo Pilot") then
			vRP.giveBankMoney(user_id,200)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Cargo Pilot",false,"Salariu: ~g~$ ~w~200"})
		end

		if vRP.hasGroup(user_id,"Pilot Aerian") then
			vRP.giveBankMoney(user_id,200)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Pilot Aerian",false,"Salariu: ~g~$ ~w~200"})
		end

		if vRP.hasGroup(user_id,"Pizza") then
			vRP.giveBankMoney(user_id,300)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Pizza",false,"Salariu: ~g~$ ~w~300"})
		end

		if vRP.hasGroup(user_id,"Constructor") then
			vRP.giveBankMoney(user_id,350)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Constructor",false,"Salariu: ~g~$ ~w~350"})
		end

		if vRP.hasGroup(user_id,"Livrari Tigari") then
			vRP.giveBankMoney(user_id,200)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Livrari Tigarii",false,"Salariu: ~g~$ ~w~200"})
		end

		if vRP.hasGroup(user_id,"Traficant Organe") then
			vRP.giveBankMoney(user_id,200)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Traficant Organe",false,"Salariu: ~g~$ ~w~200"})
		end

		if vRP.hasGroup(user_id,"Hooker") then
			vRP.giveBankMoney(user_id,200)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Hooker",false,"Salariu: ~g~$ ~w~200"})
		end

		if vRP.hasGroup(user_id,"Braconier") then
			vRP.giveBankMoney(user_id,200)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Braconier",false,"Salariu: ~g~$ ~w~200"})
		end

		if vRP.hasGroup(user_id,"Ciuperci Stiinta") then
			vRP.giveBankMoney(user_id,200)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Ciuperci Stiinta",false,"Salariu: ~g~$ ~w~200"})
		end

		if vRP.hasGroup(user_id,"UPS") then
			vRP.giveBankMoney(user_id,200)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"UPS Companie",false,"Salariu: ~g~$ ~w~200"})
		end

		if vRP.hasGroup(user_id,"Fan Courier") then
			vRP.giveBankMoney(user_id,349)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Fan Courier",false,"Salariu: ~g~$ ~w~340.999"})
		end

  		if vRP.hasGroup(user_id,"Curva") then
			vRP.giveBankMoney(user_id,400)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Curva",false,"Salariu: ~g~$ ~w~400"})
		end

  		if vRP.hasGroup(user_id,"Electrician") then
			vRP.giveBankMoney(user_id,350)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Electrician",false,"Salariu: ~g~$ ~w~350"})
		end

  		if vRP.hasGroup(user_id,"Speish Livrari") then
			vRP.giveBankMoney(user_id,350)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Speish",false,"Salariu: ~g~$ ~w~350"})
		end

  		if vRP.hasGroup(user_id,"Fotograf") then
			vRP.giveBankMoney(user_id,320)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Fotograf",false,"Salariu: ~g~$ ~w~320"})
		end

  		if vRP.hasGroup(user_id,"Culegator") then
			vRP.giveBankMoney(user_id,320)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Culegator",false,"Salariu: ~g~$ ~w~320"})
		end

  		if vRP.hasGroup(user_id,"Fabricant Steroizi") then
			vRP.giveBankMoney(user_id,320)
			vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Fabricant Steroizi",false,"Salariu: ~g~$ ~w~320"})
		end
	end

	if vRP.isUserDiamondVip(user_id) then
		vRP.giveBankMoney(user_id,1500)
		vRP.giveBankMoney(user_id,500)
		vRPclient.notifyPicture(source,{"CHAR_MP_MORS_MUTUAL",1,"VIP Diamond",false,"Bonus de ~b~BitCoin~w~: ~b~4\n~w~Bonus: ~g~$ ~w~5.000\nBani: ~g~$ ~w~150"})
	elseif vRP.isUserGoldVip(user_id) then
		vRP.giveBankMoney(user_id,1000)
		vRP.giveBankMoney(user_id,500)
		vRPclient.notifyPicture(source,{"CHAR_MP_MORS_MUTUAL",1,"VIP GOLD",false,"Bonus de ~b~BitCoin~w~: ~b~3\n~w~Bonus: ~g~$ ~w~5.000\nBani: ~g~$ ~w~100"})
	elseif vRP.isUserSilverVip(user_id) then
		vRP.giveBankMoney(user_id,500)
		vRP.giveBankMoney(user_id,500)
		vRPclient.notifyPicture(source,{"CHAR_MP_MORS_MUTUAL",1,"VIP SILVER",false,"Bonus de ~b~BitCoin~w~: ~b~2\n~w~Bonus: ~g~$ ~w~5.000\nBani: ~g~$ ~w~500"})
	elseif vRP.isUserBronzeVip(user_id) then
		vRP.giveBankMoney(user_id,250)
		vRP.giveBankMoney(user_id,500)
		vRPclient.notifyPicture(source,{"CHAR_MP_MORS_MUTUAL",1,"VIP BRONZE",false,"Bonus de ~b~BitCoin~w~: ~b~1\n~w~Bonus: ~g~$ ~w~50\nBani: ~g~$ ~w~250"})
	end

	if(user_id)then
		vRP.giveBankMoney(user_id,30)
		vRP.getMoney(user_id,120)
		vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1,"Diamond",false,"Cadou: ~g~$~w~30\nTaxa Mechanic: ~w~R~g~$ ~w~-120!"})
	end
end)


-- [[RegisterServerEvent('kailannon:salariu')
-- AddEventHandler('kailannon:salariu', function()
--     local user_id = vRP.getUserId(source)
--     local factionPayday = 0

--     if(vRP.hasUserFaction(user_id))then
--         local theFaction = vRP.getUserFaction(user_id) or ""
--         local theRank = vRP.getFactionRank(user_id) or ""
--         local thePay = vRP.getFactionRankSalary(theFaction, theRank)
--         if(thePay > 0)then
--             factionPayday = thePay
--         end
--     end

--     vRP.salariuSound(source)

--     if(factionPayday > 0) and (vRP.hasGroup(user_id,"onduty"))then
--         vRP.giveBankMoney(user_id, factionPayday)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"Salariu "..theFaction,false,"~w~Grad factiune: ~g~"..theRank.."\n~w~Bani: ~g~"..vRP.formatMoney(factionPayday).."€"})
--     end

--     if vRP.hasGroup(user_id, "Mecanic") then
--         vRP.giveBankMoney(user_id,150)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"Salariu Mecanic",false,"Bani: ~g~+50000"})
--     elseif vRP.hasGroup(user_id, "Pescar") then
--         vRP.giveBankMoney(user_id,150)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"Salariu Pescar",false,"Bani: ~g~+50000"})
--     elseif vRP.hasGroup(user_id, "Somer") then
--         vRP.giveBankMoney(user_id,150)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"Somaj",false,"Bani: ~g~+50000"})
--     elseif vRP.hasGroup(user_id, "Constructor") then
--         vRP.giveBankMoney(user_id,150)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"Salariu Constructor",false,"Bani: ~g~+50000"})
--     elseif vRP.hasGroup(user_id, "UBER") then
--         vRP.giveBankMoney(user_id,150)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"Salariu UBER",false,"Bani: ~g~+50000"})
--     elseif vRP.hasGroup(user_id, "Curier Glovo") then
--         vRP.giveBankMoney(user_id,150)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"Salariu Curier Glovo",false,"Bani: ~g~50000"})
--     elseif vRP.hasGroup(user_id, "Electrician") then
--         vRP.giveBankMoney(user_id,150)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"Salariu Electrician",false,"Bani: ~g~+50000"})
--     end


--     if vRP.isUserDiamondVip(user_id) then
--         vRP.giveBankMoney(user_id,500)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"VIP Diamond",false,"Bani: ~g~+1000000"})
--     elseif vRP.isUserPlatinumVip(user_id) then
--         vRP.giveBankMoney(user_id,700)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"VIP Platinum",false,"Bani: ~g~+500000€"})
--     elseif vRP.isUserGoldVip(user_id) then
--         vRP.giveBankMoney(user_id,900)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"VIP Gold",false,"Bani: ~g~+200000€"})
--     elseif vRP.isUserSilverVip(user_id) then
--         vRP.giveBankMoney(user_id,1100)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_FLEECA",1,"VIP Silver",false,"Bani: ~g~+50000€"})

--     end

--     if(user_id) then
--         vRP.giveBankMoney(user_id,1000)
--         vRP.tryFullPayment(user_id, 150)
--         vRPclient.notifyPicture(source,{"CHAR_BANK_MAZE",1," Romania",false,"Cadou: ~g~+500000€~w~\nTaxe stat: ~r~-150€"})
--     end
-- end)

-- function vRP.salariuSound(source)
--     TriggerClientEvent("InteractSound_CL:PlayOnOne", source, "salar", 0.5)
-- end