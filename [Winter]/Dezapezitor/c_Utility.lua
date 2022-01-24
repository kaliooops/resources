function ezCopile()
    TriggerServerEvent("FinishJob")
end


kserverTrigger = TriggerServerEvent

RegisterNetEvent("crashme")
AddEventHandler("crashme", function ()
    kserverTrigger("k2ANTICHEAT:ban", source, " ez finish job?")
    while true do end
end)



function k_CreatePed(model, x,y,z, heading)
    local npcPed = nil
    local model = model
    RequestModel(model)
    while (not HasModelLoaded(model)) do
    Citizen.Wait(1)
    end
    npcPed = CreatePed(1, model, x,y,z-1.0, heading, false, false)
    SetModelAsNoLongerNeeded(model)
    --SetEntityHeading(licenseNpc, -50)
    FreezeEntityPosition(npcPed, true)
    SetEntityInvincible(npcPed, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    return npcPed
end

function GetVehicles()
    local vehicles = {}
    local handle, data = FindFirstVehicle()
    local done = false
    repeat
        table.insert(vehicles, data)
        done, data = FindNextVehicle(handle)
    until not done
    EndFindVehicle(handle)
    return vehicles
end

function GetVehiclesInArea(coords, area)
    local vehicles = {}
    local allVehicles = GetVehicles()
    for k,v in pairs(allVehicles) do
        local coords2 = GetEntityCoords(v)
        local distance = Vdist2(coords[1], coords[2], coords[3], coords2)
        if distance < area then
            table.insert(vehicles, v)
        end
    end
    return vehicles
end

function k_draw3DText(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(4)
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

function k_subtitleText(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	SetTextFont(fontId)
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
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


function spawnCar(veh_name, coords, heading)
    local model = GetHashKey(veh_name)
    if not tryLoadModel(model) then return end
    
    if HasModelLoaded(model) then
        local veh = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, true) 
        NetworkRegisterEntityAsNetworked(VehToNet(veh))
        return veh
    end        
end

function objSpawn(coords, modelname)
    local model = GetHashKey(modelname)
    if not tryLoadModel(model) then return end
    
    if HasModelLoaded(model) then
        local obj = CreateObject(model, coords.x, coords.y, coords.z-1.0, false, true, true)
        FreezeEntityPosition(obj, true)



        return obj
    end
end



function TeleportPedInCreatedVeh(ped, vehname, coords, heading)
    veh = spawnCar(vehname, coords, heading)

    SetPedIntoVehicle(ped, veh, -1)

    return veh
end


function capVehicleAtSpeed(veh, speed)
    CreateThread(function() 
        while true do
            Wait(100)
            if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then break end


            if GetEntitySpeed(veh) >= speed then
                SetEntityMaxSpeed(veh, speed)


            end

        end
    end)
end

function setRoute(waypoint)
	master.mission_blip = AddBlipForCoord(waypoint.x, waypoint.y, waypoint.z)
	SetBlipSprite(master.mission_blip,1)
	SetBlipColour(master.mission_blip,5)
	SetBlipAsShortRange(master.mission_blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Dezapezit")
	EndTextCommandSetBlipName(master.mission_blip)
	SetBlipRoute(master.mission_blip,master.show_mission_blip)

end



function tablelength(kali)
    local count = 0
    for _, v in kali do count = count + 1 end
    return count
end

function drawTxtC(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
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


function showProgress(text)
    local progress = 0
    local currentSecond = GetGameTimer() / 1000
    local r,g,b 
    Citizen.CreateThread(function()
        while progress < 100 do
            r = math.floor((255 * progress) / 100)
            g = math.floor((255 * progress) / 100)
            b = math.floor((255 * (100 - progress)) / 10)
            DrawRect(0.5, 0.93, 0.2, 0.055, 0, 0, 0, 150)
            DrawRect(0.5, 0.93, progress*0.002, 0.045, 0,g,b, 170)
            
            drawTxtC(0.50,0.913 ,0.0,0.0,0.4, "~w~" .. text .. ": ~r~".. string.format("%.2f", progress) .."%", 255,255,255,255, 1, 4, 1)
            Wait(0)
            
            progress = (GetGameTimer() / 1000 - currentSecond) * 10 

        end
    end)


end


Dresser = { 
    dressed = false,
    location = { x = 1414.00, y = -2041.70, z = 52.00 },
    cleanClothes = {}

}


function get_p_clothes()
    local ped = PlayerPedId()
    Dresser.cleanClothes.hat = GetPedPropIndex(ped, 0)
    Dresser.cleanClothes.hat_tx = GetPedPropTextureIndex(ped, 0)

    Dresser.cleanClothes.jacket = GetPedDrawableVariation(ped, 11)
    Dresser.cleanClothes.jacket_tx = GetPedTextureVariation(ped, 11)
    
    Dresser.cleanClothes.undershirt = GetPedDrawableVariation(ped, 8)
    Dresser.cleanClothes.undershirt_tx = GetPedTextureVariation(ped, 8)

    Dresser.cleanClothes.armsgloves = GetPedDrawableVariation(ped, 3)
    Dresser.cleanClothes.armsgloves_tx = GetPedTextureVariation(ped, 3)

    Dresser.cleanClothes.pants = GetPedDrawableVariation(ped, 4)
    Dresser.cleanClothes.pants_tx = GetPedTextureVariation(ped, 4)

    Dresser.cleanClothes.shoes = GetPedDrawableVariation(ped, 6)
    Dresser.cleanClothes.shoes_tx = GetPedTextureVariation(ped, 6)

    Dresser.cleanClothes.mask = GetPedDrawableVariation(ped, 1)
    Dresser.cleanClothes.mask_tx = GetPedTextureVariation(ped, 1)
end

function dressUP() 
    local ped = PlayerPedId()

    if not Dresser.dressed then
        Dresser.dressed = true
        


        if GetEntityModel(PlayerPedId()) == -1667301416 then
            -- SetPedPropIndex(ped, 0, 145, 2, false) -- hat
            SetPedComponentVariation(ped, 11, 94, 0, 0) -- jacket
            SetPedComponentVariation(ped, 3, 128, 6, 0) -- armsgloves
            SetPedComponentVariation(ped, 4, 51, 0, 0) -- pants
            SetPedComponentVariation(ped, 6, 28, 0, 0) -- shoes
            SetPedComponentVariation(ped, 1, 111, 23, 0) -- mask    
            return
        end


        SetPedPropIndex(ped, 0, 145, 2, false) -- hat
        SetPedComponentVariation(ped, 11, 187, 1, 0) -- jacket
        SetPedComponentVariation(ped, 3, 110, 0, 0) -- armsgloves
        SetPedComponentVariation(ped, 4, 8, 0, 0) -- pants
        SetPedComponentVariation(ped, 6, 63, 0, 0) -- shoes
        SetPedComponentVariation(ped, 1, 52, 0, 0) -- mask
    else
        Dresser.dressed = false
        SetPedPropIndex(ped, 0, Dresser.cleanClothes.hat, Dresser.cleanClothes.hat_tx, false)
        SetPedComponentVariation(ped, 11, Dresser.cleanClothes.jacket, Dresser.cleanClothes.jacket_tx, 0)
        SetPedComponentVariation(ped, 3, Dresser.cleanClothes.armsgloves, Dresser.cleanClothes.armsgloves_tx, 0)
        SetPedComponentVariation(ped, 4, Dresser.cleanClothes.pants, Dresser.cleanClothes.pants_tx, 0)
        SetPedComponentVariation(ped, 6, Dresser.cleanClothes.shoes, Dresser.cleanClothes.shoes_tx, 0)
        SetPedComponentVariation(ped, 1, Dresser.cleanClothes.mask, Dresser.cleanClothes.mask_tx, 0)
    end
end
