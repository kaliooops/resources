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

function k_draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*4
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


play_area_blip = nil
function drawPlayableArea()
    play_area_blip = AddBlipForArea(pubg_cfg.playable_area.center_point[1], pubg_cfg.playable_area.center_point[2], pubg_cfg.playable_area.center_point[3], pubg_cfg.playable_area.width, pubg_cfg.playable_area.height)
    SetBlipRotation(play_area_blip, 0)
    SetBlipColour(play_area_blip, 67)
    SetBlipAlpha(play_area_blip, 64)

end

function reDrawPlayableArea()
    DestryPlayableArea()
    play_area_blip = AddBlipForArea(pubg_cfg.playable_area.center_point[1], pubg_cfg.playable_area.center_point[2], pubg_cfg.playable_area.center_point[3], pubg_cfg.playable_area.width, pubg_cfg.playable_area.height)
    SetBlipRotation(play_area_blip, 0)
    SetBlipColour(play_area_blip, 67)
    SetBlipAlpha(play_area_blip, 64)

end

function DestryPlayableArea()
    RemoveBlip(play_area_blip)
    play_area_blip = nil
end


function isInPlayableArea(coords)
    local x = coords.x
    local y = coords.y
    local z = coords.z
    
    local width = pubg_cfg.playable_area.width
    local height = pubg_cfg.playable_area.height
    local center_x = pubg_cfg.playable_area.center_point[1]
    local center_y = pubg_cfg.playable_area.center_point[2]

    if x > center_x - width/2 and x < center_x + width/2 and y > center_y - height/2 and y < center_y + height/2 then
        return true
    else
        return false
    end
    
    
end