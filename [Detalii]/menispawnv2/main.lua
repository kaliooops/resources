local open = false
CreateThread(function()
    local panel_coords = {x = 229.11395263672, y = -898.34521484375, z = 30.699993133545}
    while true do
        Wait(1000)
    
        while Vdist(panel_coords.x, panel_coords.y, panel_coords.z, GetEntityCoords(PlayerPedId())) < 10.0 do
            --draw
            DrawMarker(30, panel_coords.x, panel_coords.y, panel_coords.z+1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 2.0001, 0, 500, 255, 100, 1, 0, 0, 1)
            DrawText3Ds(panel_coords.x, panel_coords.y, panel_coords.z+0.5, "Deschide panoul informativ")
            
            Wait(0)
            if IsControlJustPressed(1, 51) then
                TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "In primarie, este la stanga intrarii un panou informativ.")
                if open then
                    closeGui()
                else
                    openGui()
                end
            end

            if open then
                local ply = GetPlayerPed(-1)
                local active = true
                DisableControlAction(0, 1, active) -- LookLeftRight
                DisableControlAction(0, 2, active) -- LookUpDown
                DisableControlAction(0, 24, active) -- Attack
                DisablePlayerFiring(ply, true) -- Disable weapon firing
                DisableControlAction(0, 142, active) -- MeleeAttackAlternate
                DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
            end
        end
    end
end)


RegisterNUICallback("closemenu", function(data)
    closeGui()
end)
  
RegisterNUICallback("selectPanel", function(data)
    if data.group ~= nil then
        TriggerServerEvent("vrp_panou:selectPanel", data.group)
    end
end)

RegisterNetEvent("vrp_panou:notification")
AddEventHandler("vrp_panou:notification", function(message)
    nuiNotification(message)
end)

function openGui()
    open = true
    SetNuiFocus(true, true)
    SendNUIMessage({open = true})
end

function closeGui()
    SetNuiFocus(false, false)
    SendNUIMessage({open = false})
    open = false
end

function nuiNotification(message) 
    SendNUIMessage({
        notification = true,
        notification_msg = message
    })
end
AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        if open then
        closeGui()
        end
    end
end)


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
  end
  
  function ply_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
  end