local inchiriat = false
local secunde = 600

RegisterServerEvent('vRP_rent: payment')
AddEventHandler('vRP_rent: payment', function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.tryPayment(user_id,30) then
		inchiriat = true
		TriggerClientEvent('vRP_Rent: spawncar', player)
		TriggerClientEvent('vRP_Rent: message', player)
		while inchiriat do
			Citizen.Wait(1000)
			secunde = secunde - 1
			if secunde == 0 then
				TriggerClientEvent('vRP_Rent: deleteveh', player)
				secunde = 600
				inchiriat = false
			end
		end
	else
		TriggerClientEvent('vRP_Rent: notenough', player)
	end
end)