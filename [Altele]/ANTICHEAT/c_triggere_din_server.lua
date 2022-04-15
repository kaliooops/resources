
RegisterNetEvent("k2ANTICHEAT:ecranul_tau_a_fost_pozat")
AddEventHandler("k2ANTICHEAT:ecranul_tau_a_fost_pozat", function(debug)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), 0,0,0, 0,0,0, false)
    TriggerEvent("chat:clear")
    TriggerEvent('chat:addMessage', { -- notify player
    color = {255, 0, 0}, -- red
    multiline = true, -- multiline
    args = {"[^1WARNING]", "^0Ecranul tau a fost pozat si urmeaza sa fie investigat, model: " .. debug.model} -- args
    })

end)
