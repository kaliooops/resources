RegisterNetEvent("equipBackpack")
AddEventHandler("equipBackpack", function()
    SetPedComponentVariation(PlayerPedId(), 0, 22, 0, 0)
end)

RegisterNetEvent("removeBackpack")
AddEventHandler("removeBackpack", function()
    SetPedComponentVariation(PlayerPedId(), 5, 0, 0,0 )
end)