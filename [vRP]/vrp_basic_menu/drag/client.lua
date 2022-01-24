other = nil
drag = false
playerStillDragged = false

RegisterNetEvent("dr:drag")
AddEventHandler('dr:drag', function(pl)
    other = pl
    drag = not drag
end)

RegisterNetEvent("dr:undrag")
AddEventHandler('dr:undrag', function(pl)
	if(other == pl)then
		other = nil
		drag = false
	end
end)

Citizen.CreateThread(function()
    while true do
        Wait(2000)
        while drag and other ~= nil do
            Wait(0)
            local ped = GetPlayerPed(GetPlayerFromServerId(other))
            local myped = GetPlayerPed(-1)
            AttachEntityToEntity(myped, ped, 4103, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            playerStillDragged = true
        end

        if playerStillDragged then
            DetachEntity(GetPlayerPed(-1), true, false)
            playerStillDragged = false
        end
    end
end)