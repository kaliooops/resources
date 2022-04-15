RegisterNetEvent("mosnicoale:notify")
AddEventHandler("mosnicoale:notify", function(text)

    TriggerEvent("toasty:Notify", {type = "info", title="Mos Craciun", message = text})

end)