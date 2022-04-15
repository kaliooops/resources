RegisterNUICallback("closemenu", function(data)
    closeGui()
end)

open = false
function openGui()
    open = true
    SendNUIMessage({open = true})
end

function closeGui()
    SendNUIMessage({open = false})
    open = false
end

function updateGui(progress, title, description)
    SendNUIMessage({
        type="update",
        progress=progress,
        title=title,
        description=description
    })
end