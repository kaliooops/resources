Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1800000)
		TriggerServerEvent('kailannon:salariu')
	end
end)