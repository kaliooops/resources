RegisterNetEvent("vip:notify")
AddEventHandler("vip:notify", function(title, text)

    TriggerEvent("toasty:Notify", {type = "info", title=title, message = text})

end)