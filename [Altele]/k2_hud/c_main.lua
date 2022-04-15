RegisterNetEvent("HUD:Update")
AddEventHandler("HUD:Update", function(data)
    SendNUIMessage({
        type = data.type,
        value = data.value
    })
end)

RegisterNetEvent("HUD:STOP")
AddEventHandler("HUD:STOP", function()
    SendNUIMessage({
        type = "toggle",
    })    


end)








RegisterCommand("logo", function()
    TriggerEvent("chatMessage", "", {255, 255, 255}, "^7" .. random_emoji() .."^0")
    SendNUIMessage({
        type = "logo",
    })    
end, false)
