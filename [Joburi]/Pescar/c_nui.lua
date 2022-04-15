RegisterNUICallback("closemenu", function(data)
    closeGui()
    ExecuteCommand("e c")
end)

RegisterNUICallback("updateadancime", function(data)
    updateAdancime()
    if get_last_gZ() <= -50 then
        TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Descopera adancime de 50m cu ajutorul sonarului.")
    end
end)



open = false
function updateAdancime()
    SendNUIMessage({
        type = "updateadancime",
        adancime = get_last_gZ() + math.random(0, 3)
    })
end

function openGui()
    open = true
    SetNuiFocus(true, true)
    SendNUIMessage({open = true})
end

function closeGui()
    SetNuiFocus(false, false)
    SendNUIMessage({open = false})
    open = false
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        if open then
        closeGui()
        end
    end
end)