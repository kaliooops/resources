local c_kraneUtility = {}

function c_kraneUtility.DrawText3D(x,y,z, text, scale)
    if not scale then scale = 1.0 end
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*scale
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

function c_kraneUtility.Force_Model_Load(model)
    local modelhash = ""
    -- check if the model is a number
    if type(model) == "number" then
        modelhash = model
    else
        modelhash = GetHashKey(model)
    end
    RequestModel(modelhash)
    tries = 0
    while not HasModelLoaded(modelhash) do
        Wait(1000)
        tries = tries + 1
        if tries > 20 then
            return false
        end
    end
    return true
end

function c_kraneUtility.Get_Closest_Veh(x,y,z, range, hash)
    if not hash then hash = 0 end
    return GetClosestVehicle(x, y, z, range, hash, 2)
end

function c_kraneUtility.Is_In_Range(entity, x,y,z, distance)
    local x2,y2,z2 = table.unpack(GetEntityCoords(entity))
    local dist = Vdist(x,y,z, x2,y2,z2)
    if dist < distance then
        return true
    else
        return false
    end
end

function c_kraneUtility.Play_Animation(ped, animdict, animname)
    RequestAnimDict(animdict)
    while not HasAnimDictLoaded(animdict) do
        Wait(0)
    end
    TaskPlayAnim(ped, animdict, animname, 1.0, -1.0, 1.0, 0, 0, false, false, false)
end

function c_kraneUtility.Get_Pos_In_Front(ped, meters)
    x,y,z = 0,0,0
    local ped_x,ped_y,ped_z = table.unpack(GetEntityCoords(ped))
    local forward_x, forward_y, forward_z = table.unpack(GetEntityForwardVector(ped))
    x = ped_x + (forward_x * meters)
    y = ped_y + (forward_y * meters)
    z = ped_z + (forward_z * meters)
    return {x,y,z}


end

function c_kraneUtility.Get_Reverse_Heading(ped) --to look towards ped
    local ped_x,ped_y,ped_z = table.unpack(GetEntityCoords(ped))
    local ped_heading = GetEntityHeading(ped)
    local heading = ped_heading + 180
    if heading > 360 then
        heading = heading - 360
    end
    return heading
end

function c_kraneUtility.Get_Random_Coords_Around_Entity(entity,range)
    local x,y,z = table.unpack(GetEntityCoords(entity))
    
    local x_rand = math.random(-range,range)
    local y_rand = math.random(-range,range)

    local x_new = x + x_rand
    local y_new = y + y_rand

    return {x_new,y_new,z}
end

c_kraneUtility.rgb_rainbow = {r = 0, g = 0, b = 0}
function c_kraneUtility.Set_RGB_Rainbow(frequency)
    if not frequency then frequency = 1.0 end
    CreateThread(function()
        while true do
            Wait(0)
            local curtime = GetGameTimer() / 1000

            c_kraneUtility.rgb_rainbow.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
            c_kraneUtility.rgb_rainbow.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
            c_kraneUtility.rgb_rainbow.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
        end
    end)
end
CreateThread(function()
    Wait(1000)
    c_kraneUtility.Set_RGB_Rainbow()
end)



function c_kraneUtility.Generic_Marker(x,y,z,r,g,b)
    if not r and not g and not b then r = 255 g = 255 b = 255 end
    DrawMarker(1, x,y,z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, r,g,b, 100, false, true, 2, false, false, false, false)
end

c_kraneUtility.general_blip = nil
function c_kraneUtility.setRoute(x, y, z, blipname,r,g,b)
    if not r and not g and not b then r = 255 g = 255 b = 255 end
    if not blipname then blipname = "krane blip" end
    if c_kraneUtility.general_blip ~= nil then 
        RemoveBlip(c_kraneUtility.general_blip)
    end
    c_kraneUtility.general_blip = AddBlipForCoord(x, y, z)
    SetBlipRoute(c_kraneUtility.general_blip, true)
    SetBlipSprite(c_kraneUtility.general_blip,1)
	SetBlipColour(c_kraneUtility.general_blip,5)
	SetBlipAsShortRange(c_kraneUtility.general_blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(blipname)
	EndTextCommandSetBlipName(c_kraneUtility.general_blip)
	SetBlipRoute(c_kraneUtility.general_blip,true)

    CreateThread(function()
        while c_kraneUtility.general_blip ~= nil do
            Wait(0)
            if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) <= 15.0 then
                c_kraneUtility.Generic_Marker(x,y,z,r,g,b)

            end
            if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) <= 2.5 then
                c_kraneUtility.destroyRoute()
            end
        end
    end)
end

function c_kraneUtility.destroyRoute()
    if c_kraneUtility.general_blip ~= nil then 
        RemoveBlip(c_kraneUtility.general_blip)
        c_kraneUtility.general_blip = nil
    end
end

return c_kraneUtility