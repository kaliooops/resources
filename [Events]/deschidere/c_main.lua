-- --show random popup tips from the list
-- CreateThread(function ()
--     while true do
--         TriggerEvent("toasty:Notify", {type = "info", title="Incepator", message = info[math.random(1, #info)]})
--         Wait(300000)
--     end
-- end)

-- CreateThread(function()
--     while true do
--         local coords = GetEntityCoords(PlayerPedId())
--         local r_coords  = getRandomCoordinates(coords.x, coords.y, coords.z, 20.0)
--         local firework = objSpawn(r_coords, -1118757580)
--         TriggerEvent("toasty:Notify", {type = "info", title="[Artificii]", message = "Se afla artificii in preajma ta"})
        


--         CreateThread(function ()
--             local notified = false
--             local t = GetGameTimer()

--             while DoesEntityExist(firework) do
--                 coords = GetEntityCoords(PlayerPedId())
--                 Wait(0)

--                 if GetGameTimer() - t > 5000 then
--                     notified = false
--                     t = GetGameTimer()
--                 end

--                 local d = Vdist(coords.x, coords.y, coords.z, r_coords.x, r_coords.y, r_coords.z)
--                 if d < 20.0 then
--                     k_draw3DText(r_coords.x, r_coords.y, r_coords.z+1.0, "[~r~Artificii~w~]")
                    
--                     if d < 1.5 and not IsPedInAnyVehicle(PlayerPedId(), false) then
--                         local amount = math.random(1, 5)
--                         TriggerServerEvent("deschidere:vreauArtificii", amount)
--                         ExecuteCommand("e pickup")
--                         Wait(2500)
--                         ClearPedTasksImmediately(PlayerPedId())
--                         DeleteEntity(firework)
--                         DeleteObject(firework)
--                         break
--                     end
--                 else
--                     -- if d < 15 and not notified then
--                     --     notify("Esti mai aproape de artificii!")
--                     --     notified = true
--                     -- end

--                     -- if d > 20 and not notified then
--                     --     notify("Ai plecat de langa artificii...")
--                     --     notified = true
--                     -- end
    
--                 end
                

                

--             end
--         end)

--         Wait(60000)
--         DeleteEntity(firework)
--         DeleteObject(firework)

        
--     end
-- end)
