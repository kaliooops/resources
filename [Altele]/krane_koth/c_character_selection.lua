local display_timer = false
RegisterNetEvent("krane_koth:Open_Character_Selection_Screen")
AddEventHandler("krane_koth:Open_Character_Selection_Screen", function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type="show_ui"
    })

end)

RegisterNetEvent("krane_koth:Close_Character_Selection_Screen")
AddEventHandler("krane_koth:Close_Character_Selection_Screen", function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        type="hide_ui"
    })
end)
