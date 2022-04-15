

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
function k_draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
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

function showProgress(text, time_to_finish)
    local finished = false
    local start_time_seconds = GetGameTimer() / 1000
    local progress = 0
    local r,g,b 
    CreateThread(function()
        while progress < 100 do
            local current_time_seconds = GetGameTimer() / 1000
            local time_passed_seconds = current_time_seconds - start_time_seconds
            progress = time_passed_seconds * 100 / time_to_finish

            r = math.floor((255 * progress) / 100)
            g = math.floor((255 * progress) / 100)
            b = math.floor((255 * (100 - progress)) / 10)
            DrawRect(0.5, 0.93, 0.2, 0.055, 0, 0, 0, 150)
            DrawRect(0.5, 0.93, progress*0.002, 0.045, 0,g,b, 170)
            
            drawTxtC(0.50,0.913 ,0.0,0.0,0.4, "~w~" .. text .. ": ~r~".. string.format("%.2f", progress) .."%", 255,255,255,255, 1, 4, 1)
            Wait(0)
        end
        finished = true
    end)
    while not finished do
        Wait(0)
    end
end


function Spawn_Prop(coords_table, model)

    local m = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
        print("waiting to load")
    end

    print("loaded")
    local o = CreateObject(m, coords_table.x, coords_table.y, coords_table.z, false, false, true)
    return o
end

function Exit_Meta()
    SetEntityCoords(PlayerPedId(), -1467.7224121094,-387.52474975586,38.767654418946, 0,0,0, 0)
end

function Enter_Meta()
    SetEntityCoords(PlayerPedId(), 997.85345458984,-3200.8715820312,-38.393653869629, 0,0,0, 0)
end

function Ia_Cutia()
    ExecuteCommand("e box")
end

function Masa_De_Lucru()
    --move the box on the table
    ExecuteCommand("e c")
    local box = Spawn_Prop({x=1011.9212036133,y=-3194.1833496094,z=-39.193125915527}, "hei_prop_heist_box")
    local ped = PlayerPedId()
    Wait(250)
    ExecuteCommand("e type")
    SetEntityHeading(ped, 2.07)
    FreezeEntityPosition(ped, true)
    Wait(1500)
    FreezeEntityPosition(ped, false)
    ExecuteCommand("e c")

    DeleteEntity(box)
    
    local jerry_can = Spawn_Prop({x=1011.9212036133,y=-3194.1833496094,z=-39.193125915527}, "prop_jerrycan_01a")
    
    -- local drug_package = Spawn_Prop({x=1012.9678344727,y=-3194.0986328125,z=-39.193141174316}, "prop_mp_drug_pack_blue")
    local drug_package = nil

    Wait(1000)
    
    AttachEntityToEntity(jerry_can, ped, GetPedBoneIndex(ped, 28422), 0.5, 0.0, 0.0, 0.0, 90.0, 180.0, 1, 1, 0, 1, 0, 1) 


    return {jerry_can = jerry_can, drug_package = drug_package}

end

function Toarna_Chimicale(jerry_can)
    FreezeEntityPosition(PlayerPedId(), true)
    showProgress("Toarna Chimicale", 5)
    DeleteEntity(jerry_can)
    FreezeEntityPosition(PlayerPedId(), false)
end

function Apasa_Pe_Buton()
    showProgress("Asteapta pana se prepara metamfetamina", 15)
    local product_box = Spawn_Prop({x=999.81585693359,y=-3200.1567382812,z=-39.993125915527}, "hei_prop_heist_box")
    return product_box
end

function Ia_Produsele(box)
    FreezeEntityPosition(PlayerPedId(), true)
    Wait(250)
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent("Metamfetamina:AdaugaProduse")
    DeleteEntity(box)

end