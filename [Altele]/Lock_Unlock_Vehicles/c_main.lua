RegisterNetEvent("CarLock:Toggle")
AddEventHandler("CarLock:Toggle", function(id)
    local dict = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    local veh = id

    if not IsPedInAnyVehicle(PlayerPedId(), true) then
        TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
    end
    
    SetVehicleLights(veh, 2)
    Citizen.Wait(150)
    TriggerServerEvent('InteractSound_SV:PlayOnSource','carLock',0.8)
    SetVehicleLights(veh, 0)
    --  TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.0, "carLock", 0.8)
    Citizen.Wait(150)
    SetVehicleLights(veh, 2)
    Citizen.Wait(150)
    SetVehicleLights(veh, 0)

    local locked = GetVehicleDoorLockStatus(veh) >= 2

    if locked then
        SetVehicleDoorsLockedForAllPlayers(veh, false)
        SetVehicleDoorsLocked(veh,1)
        SetVehicleDoorsLockedForPlayer(veh, PlayerId(), false)
        TriggerEvent("toasty:Notify", {type="success", title='[Cheie]', message="Usile au fost descuiate"})
    else
        SetVehicleDoorsLocked(veh,2)
        SetVehicleDoorsLockedForAllPlayers(veh, true)
        TriggerEvent("toasty:Notify", {type="success", title='[Cheie]', message="Usile au fost incuiate"})

    end
end)

CreateThread(function()
    while true do -- bubuie cpu
        Wait(0)
        if IsControlJustPressed(1, 289) then
            TriggerServerEvent("CarLock:Toggle")
        end
    end
end)