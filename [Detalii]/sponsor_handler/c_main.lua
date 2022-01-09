RegisterNetEvent("sponsor:notify")
AddEventHandler("sponsor:notify", function(text)

    TriggerEvent("toasty:Notify", {type = "info", title="Sponsor", message = text})

end)