Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

vRPclient = Tunnel.getInterface("vRP", "vrp_pets_server")

local pets = {
	["Retriever"] = {
		name = "Retriever",
		price = 5000
	},
	["Husky"] = {
		name = "Husky",
		price = 1500
	},
	["Rottweiler"] = {
		name = "Rottweiler",
		price = 3000
	}
}

RegisterServerEvent("vrp_pets:animalname")
AddEventHandler("vrp_pets:animalname", function (source, method)
	local _source = source
	local player = vRP.getUserId({_source})
	MySQL.Async.fetchAll('SELECT * FROM vrp_users WHERE id = @id', {['@id'] = player}, function(result)
		if method == "callPet" then
			TriggerClientEvent("vrp_pets:callPet", _source, result[1].pet)
		elseif method == "orders" then
			TriggerClientEvent("vrp_pets:orders", _source, result[1].pet)
		end
	end)
end)

RegisterServerEvent("vrp_pets:dead")
AddEventHandler("vrp_pets:dead", function()
	local _source = source
	local player = vRP.getUserId({_source})
	
	MySQL.Async.execute('UPDATE vrp_users SET pet = NULL WHERE id = @id', {['@id'] = player})
end)

RegisterServerEvent('vrp_pets:startHarvest')
AddEventHandler('vrp_pets:startHarvest', function()
	local _source = source
	local player = vRP.getUserId({_source})
	vRP.tryGetInventoryItem({player, 'croquettes', 1})
end)

RegisterServerEvent('vrp_pets:takeanimal')
AddEventHandler('vrp_pets:takeanimal', function (source, petid, price)
	local _source = source
	local player = vRP.getUserId({_source})
	local playerMoney = vRP.getMoney({player})

	if playerMoney >= price then
		vRP.tryPayment({player, price})
		MySQL.Async.execute('UPDATE vrp_users SET pet = @pet WHERE id = @id', {['@id'] = player, ['@pet'] = petid})
		vRPclient.notify(_source, {"Ai cumparat un " .. pets[petid].name .. " pentru suma de " .. price})
	else
		vRPclient.notify(_source, {"~r~Nu ai destui bani!"})
	end
end)

RegisterServerEvent("vrp_pets:buypet")
AddEventHandler("vrp_pets:buypet", function ()
	local _source = source
	local player = vRP.getUserId({_source})
	local menudata = {}
	
	menudata.name = "Loja de Animais"
	menudata.css = "align = 'top-left'"

	for k, v in pairs(pets) do
		menudata[v.name] = {function (choice)
			TriggerEvent("vrp_pets:takeanimal", _source, k, v.price)
			vRP.closeMenu({_source})
		end, "$" .. v.price}
	end
	
	vRP.openMenu({_source, menudata})
end)

RegisterServerEvent("vrp_pets:petMenu")
AddEventHandler("vrp_pets:petMenu", function (status, come, isInVehicle)
	local _source = source
	local player = vRP.getUserId({_source})
	local menudata = {}

	menudata.name = "Managementul animalelor de companie"
	menudata.css = {align = 'top-left'}

	if come == 1 then
		menudata["Da mancare"] = {function (choice)
			local data = vRP.getUserDataTable({player})
			TriggerClientEvent("vrp_pets:givefood", _source, data.inventory)
			vRP.closeMenu({_source})
		end, "Foame :" .. status .. "%"}
		menudata["Attach/detach pet"] = {function (choice)
			TriggerClientEvent("vrp_pets:attachdetach", _source)
			vRP.closeMenu({_source})
		end}

		if isInVehicle then
			menudata["Spune-i animalutului să iasă din mașină"] = {function (choice)
				TriggerClientEvent("vrp_pets:enterleaveveh", _source)
				vRP.closeMenu({_source})
			end}
		else
			menudata["Spune-i animalutului să urce în mașină"] = {function (choice)
				TriggerClientEvent("vrp_pets:enterleaveveh", _source)
				vRP.closeMenu({_source})
			end}
		end

		menudata["Da-i un ordin"] = {function (choice)
			TriggerEvent("vrp_pets:animalname", _source, "orders")
			vRP.closeMenu({_source})
		end}
	else
		menudata["Cheama animalutul"] = {function (choice)
			if come == 0 then
				TriggerEvent("vrp_pets:animalname", _source, "callPet")
				vRP.closeMenu({_source})
			end
		end}
	end

	vRP.openMenu({_source, menudata})
end)

RegisterServerEvent("vrp_pets:ordersMenu")
AddEventHandler("vrp_pets:ordersMenu", function (data, model, inanimation)
	local _source = source
	local player = vRP.getUserId({_source})
	local menudata = {}

	menudata.name = "Comenzi pentru animalut"
	menudata.css = {align = 'top-left'}
	
	if not inanimation then
		if model ~= 1462895032 then
			menudata["Cauta mingea"] = {function (choice) -- balle
				TriggerClientEvent("vrp_pets:findball", _source)
				vRP.closeMenu({_source})
			end}
		end
		menudata["Urmeaza-ma"] = {function (choice) -- pied
			TriggerClientEvent("vrp_pets:followme", _source)
			vRP.closeMenu({_source})
		end}
		menudata["Trimite animalutul acasa"] = {function (choice) -- niche
			TriggerClientEvent("vrp_pets:goHome", _source)
			vRP.closeMenu({_source})
		end}
		
		if (data == "Rottweiler") then
			menudata["Sezi"] = {function (choice) -- assis
				TriggerClientEvent("vrp_pets:seat", _source, 1)
				vRP.closeMenu({_source})
			end}
			menudata["Ridica-te"] = {function (choice) -- coucher
				TriggerClientEvent("vrp_pets:laydown", _source, 1)
				vRP.closeMenu({_source})
			end}
		end
		if (data == "Husky") then
			menudata["Sezi"] = {function (choice) -- assis
				TriggerClientEvent("vrp_pets:seat", _source, 1)
				vRP.closeMenu({_source})
			end}
			menudata["Ridica-te"] = {function (choice) -- coucher
				TriggerClientEvent("vrp_pets:laydown", _source, 1)
				vRP.closeMenu({_source})
			end}
		end
		if (data == "Retriever") then
			menudata["Sezi"] = {function (choice) -- assis3
				TriggerClientEvent("vrp_pets:seat", _source, 3)
				vRP.closeMenu({_source})
			end}
		end
	else
		menudata["Ridica-te"] = {function (choice) -- debout
			TriggerClientEvent("vrp_pets:standup", _source)
			vRP.closeMenu({_source})
		end}
	end

	vRP.openMenu({_source, menudata})
end)