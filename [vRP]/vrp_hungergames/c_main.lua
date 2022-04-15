
vRPclient = Tunnel.getInterface("vRP", "vrp_hungergames")

drink = {
    "https://www.youtube.com/watch?v=A7Xvrq-WM9I",
    "https://www.youtube.com/watch?v=vFwH4F5igQY",
    "https://www.youtube.com/watch?v=HfJqnaNGXGM",
}

eat = {
    "https://www.youtube.com/watch?v=q8pU7oClnF8",
    "https://www.youtube.com/watch?v=7vFH9wY_SxM",
    "https://www.youtube.com/watch?v=Ezbkf_gNzIs",
}

function get_random_drink_sound()
    local random_drink_sound = math.random(1, #drink)
    return drink[random_drink_sound]
end

function get_random_eat_sound()
    local random_eat_sound = math.random(1, #eat)
    return eat[random_eat_sound]
end

local xSound = exports.xsound

Citizen.CreateThread(function()
	while true do
        TriggerServerEvent("hungergames:status3sec")
	  Citizen.Wait(3000)
	end
  end)

  Citizen.CreateThread(function()
	while true do
        TriggerServerEvent("hungergames:status60sec")
	  Citizen.Wait(60000)
	end
  end)

RegisterNetEvent("hungergames:heal")
AddEventHandler("hungergames:heal", function()
    if GetEntityHealth(PlayerPedId()) > 120 and GetEntityHealth(PlayerPedId()) < 200 then
		SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
	end
end)

RegisterNetEvent("hungergames:foame")
AddEventHandler("hungergames:foame", function()

    xSound:PlayUrlPos("foame", "https://www.youtube.com/watch?v=A4t-HkwiWqw", 0.5, GetEntityCoords(PlayerPedId()))
    xSound:Distance("foame", 5)
    if GetEntityHealth(PlayerPedId()) > 120 and GetEntityHealth(PlayerPedId()) < 200 then
    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 1)
    end
    
    ExecuteCommand("me ~r~ Simte ca moare de foame")
    if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
        for i = 1, 4 do
            ExecuteCommand("me ~r~ Simte ca moare de foame")
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
            Wait(2500)
        end
    end
end)


RegisterNetEvent("hungergames:sete")
AddEventHandler("hungergames:sete", function()

    if GetEntityHealth(PlayerPedId()) > 120 and GetEntityHealth(PlayerPedId()) < 200 then
    SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - 1)
    end
    ExecuteCommand("me ~r~ Simte ca moare de sete")
    if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
        ExecuteCommand("me ~r~ Simte ca moare de sete")
        for i = 1, 4 do
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
            Wait(2500)
        end
    end
end)

RegisterNetEvent("hungergames:drink")
AddEventHandler("hungergames:drink", function()

    xSound:PlayUrlPos("drink", get_random_drink_sound(), 1, GetEntityCoords(PlayerPedId()))
    xSound:Distance("drink", 10)


end)

RegisterNetEvent("hungergames:eat")
AddEventHandler("hungergames:eat", function()

    xSound:PlayUrlPos("eat", get_random_eat_sound(), 1, GetEntityCoords(PlayerPedId()))
    xSound:Distance("eat", 10)


end)

RegisterNetEvent("hungergames:foame80")
AddEventHandler("hungergames:foame80", function()

    xSound:PlayUrlPos("foame", "https://www.youtube.com/watch?v=A4t-HkwiWqw", 0.5, GetEntityCoords(PlayerPedId()))
    xSound:Distance("foame", 5)
end)

