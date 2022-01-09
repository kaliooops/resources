local bool = false
RegisterCommand("hud", function()

    bool = not bool
    TriggerServerEvent("DisableHud", bool)

    CreateThread(function()  
        TriggerEvent("showviata")
        while bool do
            HideHudAndRadarThisFrame()
            Wait(0)
        end
    end)


end, false)



