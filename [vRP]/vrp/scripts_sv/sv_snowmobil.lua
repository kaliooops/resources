local inchiriat = false
local secunde = 600000

RegisterServerEvent('vRP_ren: payment')
AddEventHandler('vRP_ren: payment', function()
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	if vRP.tryPayment(user_id,300) then
		inchiriat = true
		TriggerClientEvent('vRP_Ren: spawncar', player)
		TriggerClientEvent('vRP_Ren: message', player)
		while inchiriat do
			Citizen.Wait(1000)
			secunde = secunde - 1
			if secunde == 0 then
				TriggerClientEvent('vRP_Ren: deleteveh', player)
				secunde = 600000
				inchiriat = false
			end
		end
	else
		TriggerClientEvent('vRP_Ren: notenough', player)
	end
end)