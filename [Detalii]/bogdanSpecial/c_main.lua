-- local x,y,z = -1137.83, 4872.70, 215.17
-- function load_model()
--     CreateThread(function ()
--         model = 0x570462B9
--         while not HasModelLoaded(model) do
--             RequestModel(model)
--             Wait(10)
--         end       
--         local ped = CreatePed(1, 0x570462B9, x,y,z-1.0, 337.0, false, false)
--         TaskStartScenarioInPlace(ped, "WORLD_HUMAN_MUSCLE_FLEX", 0, 0)
--         SetEntityInvincible(ped, true)
--         FreezeEntityPosition(ped, true)
--     end)
-- end

-- load_model()


-- CreateThread(function()
--     while true do
--         Wait(1000)
--         while Vdist(x,y,z, GetEntityCoords(PlayerPedId())) < 10 do
--             Draw3DText(x,y,z+1.0, "~r~CANTA ~b~BOGDAN")
--             drawSubtitleText("Apasa [~g~E~w~] sa te colinde bogdan")
--             Wait(0)
--             if IsControlJustPressed(1,51) then
--                 TriggerServerEvent("CANTABOGDANE")
--                 ExecuteCommand("e dance")
--                 --use animation dance from dpemotes for the ped
--             end
--         end
--     end
-- end)

-- function drawSubtitleText(text)
--     SetTextEntry_2("STRING")
--     AddTextComponentString(text)
--     DrawSubtitleTimed(3000, 1)
-- end

-- function Draw3DText(x,y,z,text)
--     local onScreen,_x,_y=World3dToScreen2d(x,y,z)
--     local px,py,pz=table.unpack(GetGameplayCamCoords())
--     local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
--     local scale = (1/dist)*2
--     local fov = (1/GetGameplayCamFov())*100
--     local scale = scale*fov
   
--     if onScreen then
--         SetTextScale(0.0*scale, 0.55*scale)
--         SetTextFont(0)
--         SetTextProportional(1)
--         SetTextColour(255, 255, 255, 255)
--         SetTextDropshadow(0, 0, 0, 0, 255)
--         SetTextEdge(2, 0, 0, 0, 150)
--         SetTextDropShadow()
--         SetTextOutline()
--         SetTextEntry("STRING")
--         SetTextCentre(1)
--         AddTextComponentString(text)
--         DrawText(_x,_y)
--     end
-- end