anims = {
	"Rampage",
	"DrugsMichaelAliensFightIn",
	"DrugsMichaelAliensFight",
	"DrugsMichaelAliensFightOut",
	"DrugsTrevorClownsFightIn",
	"DrugsTrevorClownsFight",
	"DrugsTrevorClownsFightOut",
	"DrugsDrivingIn",
	"DrugsDrivingOut",
	"RaceTurbo",
	"RampageOut"
}

animation = ""
drugged = false

RegisterNetEvent('addDrugEffect')
AddEventHandler('addDrugEffect', function(player)
	if not drugged then
		drugged = true
		index = math.random(1, #anims)
		times = math.random(30000, 180000)
		playerPed = GetPlayerPed(player)
		
		animation = anims[index]
		
		StartScreenEffect(animation, times, true)
		SetTimeout(times, function()
			drugged = false
		end)
	end
end)

RegisterNetEvent('removeDrugEffect')
AddEventHandler('removeDrugEffect', function(player)
	StopScreenEffect(animation)
	animation = ""
	drugged = false
end)
