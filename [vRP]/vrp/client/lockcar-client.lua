-- Citizen.CreateThread(function()
--   while true do
--     Citizen.Wait(1)
--     local ped = GetPlayerPed(-1)
      
    
--     ok, veh, name = tvRP.getNearestOwnedVehicle(10)

--     if veh ~= nil and veh ~= 0 and veh ~= 1 then
--       local lock = GetVehicleDoorLockStatus(veh)

--       if IsControlJustPressed(1, 51) and ok then
--         local dict = "anim@mp_player_intmenu@key_fob@"
--         RequestAnimDict(dict)
--         while not HasAnimDictLoaded(dict) do
--             Citizen.Wait(0)
--         end
    
--         if not IsPedInAnyVehicle(PlayerPedId(), true) then
--           TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
--         end
--         TriggerServerEvent('InteractSound_SV:PlayOnSource','carLock',0.8)


--         if lock == 1 or lock == 0 then
--           SetVehicleDoorsLocked(veh, 2)
--           SetVehicleDoorsLockedForAllPlayers(veh, true)
--         elseif lock == 2 then
        
--           SetVehicleDoorsLocked(veh, 1)
--           SetVehicleDoorsLockedForAllPlayers(veh, false)

--         end
--       end
--     end
--   end
-- end)