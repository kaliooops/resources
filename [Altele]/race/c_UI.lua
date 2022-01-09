local display = false

RegisterCommand("race", function (source)
    SetDisplay(true)
    
end, false)

local l_myid = nil

RegisterNetEvent("race:GetLocalPlayerUserID")
AddEventHandler("race:GetLocalPlayerUserID", function(myid)
    l_myid = myid
end)

RegisterNUICallback("race_main", function(data)
    SetDisplay(true)
    local advanced_lobby = {}
    
    --build player data
    for player, bet in pairs(data.lobby) do
        if tonumber(bet) < 0 then 
            TriggerServerEvent("banMe", "bet de te doare capu")
            return
        end
        table.insert(advanced_lobby, {id = player, ready = false, bet = bet, game_mode = data.game_mode})
        print(player, bet, data.game_mode)
    end
    TriggerServerEvent("race:GetLocalPlayerUserID")
    while l_myid == nil do Wait(0) end
    table.insert(advanced_lobby, {id = l_myid, ready = false, bet = advanced_lobby[1].bet, game_mode = data.game_mode})
    TriggerServerEvent("race:send_data_to_lobby_members", {lobby = advanced_lobby})
end)

RegisterNUICallback("error", function (data)
    DropPlayer(PlayerId(), data)
end)

RegisterNUICallback("exit", function (data)
    SetDisplay(false)
end)


function SetDisplay(bool)
    display = bool
    SetNuiFocus(display, display)
    SendNUIMessage({
        type = "raceui",
        status = bool
    })
    CreateThread(function() 
        while display do
            Wait(0)
            DisableControlAction(0, 1, display)
            DisableControlAction(0, 2, display)
            DisableControlAction(0, 142, display)
            DisableControlAction(0, 18, display)
            DisableControlAction(0, 322, display)
            DisableControlAction(0, 106, display)

        end
    end)
    
end