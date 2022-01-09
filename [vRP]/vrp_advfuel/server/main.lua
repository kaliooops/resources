local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_alogin")

RegisterServerEvent('LegacyFuel:PayFuel')
AddEventHandler('LegacyFuel:PayFuel', function(price)
	local user_id = vRP.getUserId({source})
	local amount  = math.floor(price)

	if vRP.tryPayment({user_id, amount}) then end
end)

local Vehicles = {
	{ plate = 'Test Car', fuel = 100}
}

RegisterCommand('fuel', function(source, args, msg)
	local user_id = vRP.getUserId({source})
	if vRP.isUserHelper({user_id}) then
		local fuel = msg:sub(6)
		if fuel:len() >= 1 then
			fuel = tonumber(fuel)
			TriggerClientEvent('cmdSetFuel', source, math.floor(tonumber(fuel)))
		else
			TriggerClientEvent('chatMessage', source, "^1Syntax^7:  /fuel <procent>!")
		end
	else
		TriggerClientEvent('chatMessage', source, "^1Eroare^7: Nu ai acces la aceasta comanda!")
	end
end)

RegisterServerEvent('LegacyFuel:UpdateServerFuelTable')
AddEventHandler('LegacyFuel:UpdateServerFuelTable', function(plate, fuel)
	local found = false

	for i = 1, #Vehicles do
		if Vehicles[i].plate == plate then
			found = true

			if fuel ~= Vehicles[i].fuel then
				table.remove(Vehicles, i)
				table.insert(Vehicles, {plate = plate, fuel = fuel})
			end
			break
		end
	end

	if not found then
		table.insert(Vehicles, {plate = plate, fuel = fuel})
	end
end)

RegisterServerEvent('LegacyFuel:CheckServerFuelTable')
AddEventHandler('LegacyFuel:CheckServerFuelTable', function(plate)
	for i = 1, #Vehicles do
		if Vehicles[i].plate == plate then
			local vehInfo = {plate = Vehicles[i].plate, fuel = Vehicles[i].fuel}

			TriggerClientEvent('LegacyFuel:ReturnFuelFromServerTable', source, vehInfo)

			break
		end
	end
end)

RegisterServerEvent('LegacyFuel:CheckCashOnHand')
AddEventHandler('LegacyFuel:CheckCashOnHand', function()
	local user_id = vRP.getUserId({source})
	local cb 	  	= vRP.getMoney({user_id})

	TriggerClientEvent('LegacyFuel:RecieveCashOnHand', source, cb)
end)

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end
