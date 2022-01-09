
RegisterNetEvent("k2ANTICHEAT:ecranul_tau_a_fost_pozat")
AddEventHandler("k2ANTICHEAT:ecranul_tau_a_fost_pozat", function(debug)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), 0,0,0, 0,0,0, false)
    TriggerEvent("chat:clear")
    TriggerEvent('chat:addMessage', { -- notify player
    color = {255, 0, 0}, -- red
    multiline = true, -- multiline
    args = {"[^1WARNING]", "^0Ecranul tau a fost pozat si urmeaza sa fie investigat, trimite un mesaj de urgenta lui Kalioops#0931 cu un screenshot la ecranul tau si explica situatia, model: " .. debug.model} -- args
    })
    TriggerEvent('chat:addMessage', { -- notify player
    color = {255, 0, 0}, -- red
    multiline = true, -- multiline
    args = {"[^1WARNING]", "^0REFUZUL DE A CONTACTA REZULTA IN ^1BAN^0 PENTRU TENTATIVA DE EXPLOATARE ANTICHEAT"} -- args
    })

end)
