local bool = false
RegisterCommand("hud", function()

    bool = not bool
    TriggerServerEvent("DisableHud", bool)
    TriggerEvent("HUD:STOP")
    TriggerEvent("FOOD:STOP")
    CreateThread(function()  
        TriggerEvent("showviata")
        while bool do
            HideHudAndRadarThisFrame()
            Wait(0)
        end
    end)


end, false)



