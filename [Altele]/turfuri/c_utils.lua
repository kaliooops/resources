local drawing = false
function draw_turfs()
    print("drawing turfs")
    turfs_activ = not turfs_activ
    drawing = not drawing
    for _, t in pairs(turfuri) do
        t.x = t.x + 0.0
        t.y = t.y + 0.0
        t.z = t.z + 0.0
        t.radius = t.radius + 0.0
        t.x_Centru = t.x_Centru + 0.0
        t.y_Centru = t.y_Centru + 0.0
        t.z_Centru = t.z_Centru + 0.0

        cblip = AddBlipForRadius(t.x_Centru, t.y_Centru, t.z_Centru, 300.0)
        SetBlipColour(cblip, 59)
        SetBlipAlpha(cblip, 128)


        ablip = AddBlipForRadius(t.x, t.y, t.z, t.radius)
        SetBlipColour(ablip, 68)
        SetBlipAlpha(ablip, 128)
        
       

        CreateThread(function()
            while drawing do
                Wait(0)
                for _, t in pairs(turfuri) do
                    
                    if am_I_InsideTurf(t) then
                        drawHudText(0.5, 0.1, 0.0, 0.2, 0.5, "~r~" .. t.owner .. "~w~: ~b~" .. t.score, 255, 255, 255, 255, true, 4, true)
                    end
                end
            end
        end)
        
    end
end

RegisterCommand("turfs", function()
    draw_turfs()

end, false)


function am_I_InsideTurf(turf)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
    d=  GetDistanceBetweenCoords(x, y, z, turf.x, turf.y, turf.z)
    if GetDistanceBetweenCoords(x, y, z, turf.x, turf.y, turf.z) < turf.radius then
        return true
    end
    
    return false
end


function drawHudText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    
    SetTextCentre(center)
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end