function objSpawn(coords, modelname)
    local model = modelname
    if not tryLoadModel(model) then return end
    
    if HasModelLoaded(model) then
        obj = CreateObject(GetHashKey('ind_prop_firework_03'), coords.x, coords.y, coords.z, true, false, false)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)


        return obj
    end
end
function tryLoadModel(model)
    RequestModel(model)
    local i = 0
    while not HasModelLoaded(model) do
        Wait(300)
        i = i +1
        if (i == 5) then print("Failed loading model: " .. model) return false  end
    end
    return true
end



-- get random coordinates around a point
function getRandomCoordinates(x, y, z, radius)
    local bool, z1 = GetGroundZFor_3dCoord(x, y, z+250.0, false)
    local x1 = x + math.random(-radius, radius)
    local y1 = y + math.random(-radius, radius)
    if math.abs(z1 - z) > 10.0 then
    end
    return { x= x1, y = y1, z = z1}
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

function notify(msg)
    TriggerEvent("toasty:Notify", {type = "info", title="[Job Center]", message = msg})
end