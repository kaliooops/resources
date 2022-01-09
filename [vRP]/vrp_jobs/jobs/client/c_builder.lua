
local angajat = false
local Dresser = {
    DressBlip = {87.431465148926,-456.06900024414,37.552253723144},
    Dressed = false,    
    WorkClothes = {
        hat = {0, 152},
        jacket = {11, 344},
        armsgloves = {3, 0},
        pants = {4, 19},
        shoes = {6, 61}
    },
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

local function DressForJob()
    Dresser.Dressed = true
    ped = GetPlayerPed(-1)
    
    if GetEntityModel(PlayerPedId()) == -1667301416 then -- female
        SetPedPropIndex(ped, 150, 0, 0, false) -- hat
        SetPedComponentVariation(ped, 11, 464, 0, 0) -- jacket
        SetPedComponentVariation(ped, 3, 0, 0, 0) -- armsgloves
        SetPedComponentVariation(ped, 4, 149, 0, 0) -- pants
        SetPedComponentVariation(ped, 6, 80, 0, 0) -- shoes
        SetPedComponentVariation(ped, 8, 224, 0, 0) -- under
        -- SetPedComponentVariation(ped, 1, 111, 23, 0) -- mask    
        return
    end

    SetPedPropIndex(ped, Dresser.WorkClothes.hat[1], Dresser.WorkClothes.hat[2],0,0)
    --jackets 57
    SetPedComponentVariation(ped, Dresser.WorkClothes.jacket[1] ,Dresser.WorkClothes.jacket[2] ,2, 0)
    --arms gloves 17
    SetPedComponentVariation(ped, Dresser.WorkClothes.armsgloves[1], Dresser.WorkClothes.armsgloves[2], 0, 0)
    --pants 7
    SetPedComponentVariation(ped, Dresser.WorkClothes.pants[1], Dresser.WorkClothes.pants[2], 1, 0)
    --shoes 12
    SetPedComponentVariation(ped, Dresser.WorkClothes.shoes[1],Dresser.WorkClothes.shoes[2], 6, 0)

end

local function RevertClothing()
    Dresser.Dressed = false
    ped = GetPlayerPed(-1)
    SetPedPropIndex(ped, 0,Dresser.cleanClothes.hat, Dresser.cleanClothes.hat_tx,0)
    --jackets 57
    SetPedComponentVariation(ped, 11, Dresser.cleanClothes.jacket, Dresser.cleanClothes.jacket_tx, 0)
    --setpedcomponeent arms glovles
    SetPedComponentVariation(ped, 3, Dresser.cleanClothes.armsgloves, Dresser.cleanClothes.armsgloves_tx, 0)
    --setpedcomponeent pants
    SetPedComponentVariation(ped, 4, Dresser.cleanClothes.pants, Dresser.cleanClothes.pants_tx, 0)
    --setpedcomponeent shoes
    SetPedComponentVariation(ped, 6, Dresser.cleanClothes.shoes, Dresser.cleanClothes.shoes_tx, 0)


end


local locatii_job = {
	coordonate={76.428352355958,-459.25289916992,37.552280426026},
	locatii = {
   		{89.274536132812,-443.4533996582,37.552299499512,"Ciocan","hammerBuild"},
        {85.567359924316,-444.6286315918,37.552253723144,"Ciocan","hammerBuild"},

        {93.301902770996,-427.8625793457,37.552368164062,"Ciocan","hammerBuild"},
        {92.388374328614,-426.12661743164,37.552349090576,"Ciocan","hammerBuild"},
        {96.240844726562,-415.20205688476,37.552421569824,"Ciocan","hammerBuild"},
        {98.933517456054,-416.35174560546,37.5523147583,"Ciocan","hammerBuild"},

        {69.625366210938,-417.4995727539,37.396068572998,"Picammer","drillIcon"},
        {57.360702514648,-435.03713989258,37.55224609375,"Picammer","drillIcon"},
        {86.98119354248,-463.01528930664,37.895694732666,"Picammer","drillIcon"},
        {74.90737915039,-456.75,37.552295684814,"Picammer","drillIcon"},
        {65.397491455078,-453.40234375,37.55229568481,"Picammer","drillIcon"},
        {96.732276916504,-430.09622192382,37.552444458008,"Picammer","drillIcon"},


        {79.979591369628,-423.0883178711,37.5524559021,"Sudura","weldBuild"},
        {82.031051635742,-417.5132446289,37.552955627442,"Sudura","weldBuild"},
        {87.311325073242,-419.38192749024,37.55277633667,"Sudura","weldBuild"},
        {85.205368041992,-424.97854614258,37.552436828614,"Sudura","weldBuild"},

        {78.774612426758,-442.70574951172,37.55224609375,"Sudura","weldBuild"},
        {73.42308807373,-441.03225708008,37.55224609375,"Sudura","weldBuild"},
        {71.375762939454,-446.63000488282,37.55224609375,"Sudura","weldBuild"},

        {76.629417419434,-448.65234375,37.55224609375,"Sudura","weldBuild"}
	}
}

local incometotal = 0
local st_loc = {}
local vehicul = nil
local started_farm = nil
local licenseNpc = nil
local AngajatorNPC = nil
isBuilding = false
blips = false
barWidth = 0
progressHacking = 0



function doProgBar(bool)
    isBuilding = bool
    Citizen.CreateThread(function()
        while true do
            while isBuilding do
                DrawRect(0.5, 0.93, 0.2, 0.055, 0, 0, 0, 150)
                DrawRect(0.5, 0.93, barWidth, 0.045, 255, 180, 0, 170)
                drawTxtC(0.50,0.913 ,0.0,0.0,0.4, "~w~Progres Job: ~r~"..progressHacking.."%", 255,255,255,255, 1, 4, 1)
                Wait(0)
            end
            Wait(200)
        end
    end)
end



function vRPjobsC.stopFarm()
    started_farm = false
    vehicul = false
    cacat = false
    st_loc = {}
    --vRPSjobs.finishBuilderJob({})
    vRP.respectPlus({incometotal})
    --SetPedPropIndex(GetPlayerPed(-1),0,145,11,0)
    incometotal = 0
end

function DrawImage3D(name1, name2, x, y, z, width, height, rot, r, g, b, alpha) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, true)
  
    if onScreen then
    local width = (1/dist)*width
    local height = (1/dist)*height
    local fov = (1/GetGameplayCamFov())*100
    local width = width*fov
    local height = height*fov
  
    local CoordFrom = GetEntityCoords(PlayerPedId(), true)
        local RayHandle = StartShapeTestRay(CoordFrom.x, CoordFrom.y, CoordFrom.z, x, y, z, -1, PlayerPedId(), 0)
        local _, _, _, _, object = GetShapeTestResult(RayHandle)
    if(object == 0) or (object == nil)then
      DrawSprite(name1, name2, _x, _y, width, height, rot, r, g, b, alpha)
    end
  end
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


function drawSubtitleText(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	SetTextFont(fontId)
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function Draw3DText(x,y,z, text,scl) 

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

function round(n)
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end
  
function Draw3DTextC(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
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

local function interviu(angajatorped, myped)
    local frontofchair = {147.58291625977,-370.49291992188,43.256973266602}
    --notify client
    TriggerEvent("toasty:Notify", {type = "info", title="Builder", message = "Ia un loc pe scaun"})


    
    local terminat = false
    local sitting = false
    local moving = false
    FreezeEntityPosition(angajatorped, false)

    while not terminat do
        Wait(0)
        if (Vdist(GetEntityCoords(GetPlayerPed(-1)),frontofchair[1], frontofchair[2], frontofchair[3]) <= 1.0) and not sitting then
            SetEntityCoords(
                myped --[[ Entity ]], 
                frontofchair[1] --[[ number ]], 
                frontofchair[2] --[[ number ]], 
                frontofchair[3]-1.5 --[[ number ]], 
                false --[[ boolean ]], 
                false --[[ boolean ]], 
                false --[[ boolean ]], 
                false --[[ boolean ]]
            )
            SetEntityHeading(
                myped --[[ Entity ]], 
                90.0 --[[ number ]]
            )        
            FreezeEntityPosition(myped, true)

            sitting = true
            TaskStartScenarioInPlace(myped, "PROP_HUMAN_SEAT_CHAIR_DRINK", 0, false)

        end
        if not moving then
            TaskWanderInArea(
                angajatorped --[[ Ped ]], 
                147.05680847168,-371.80651855469,43.256973266602,
                5 --[[ number ]], 
                1 --[[ number ]], 
                1 --[[ number ]]
            )
            -- TaskFollowNavMeshToCoord(
            --     myped --[[ Ped ]], 
            --     147.05680847168,-371.80651855469,43.256973266602,
            --     10.0 --[[ number ]], 
            --     0 --[[ integer ]], 
            --     10.0 --[[ number ]], 
            --     true --[[ boolean ]], 
            --     1.0 --[[ number ]]
            -- )
            moving = true
        end

        if (Vdist(GetEntityCoords(angajatorped),147.05680847168,-371.80651855469,43.256973266602) <= 1.8) and moving then
            ClearPedTasks(angajatorped)
            Wait(1000)
            FreezeEntityPosition(angajatorped, true)
            Wait(300)
            TaskStartScenarioInPlace(angajatorped, "WORLD_HUMAN_CLIPBOARD", 0, false)
            moving = false
        end

        if sitting and not moving then break end
    end

    Wait(15000)
    FreezeEntityPosition(myped, false)
    ClearPedTasks(myped)
    ClearPedTasksImmediately(angajatorped)
    FreezeEntityPosition(angajatorped, false)
    
    local moveback = false
    while Vdist(GetEntityCoords(angajatorped),141.15771484375,-379.478515625,43.256965637207) >= 0.2 do
        Wait(100)
        if not moveback then
            TaskWanderInArea(
                angajatorped --[[ Ped ]], 
                141.15771484375,-379.478515625,43.256965637207,
                5 --[[ number ]], 
                1 --[[ number ]], 
                1 --[[ number ]]
            )
            moveback = true
            SetNewWaypoint(67.140213012696,-464.20462036132,40.92121887207)
            TriggerEvent("toasty:Notify", {type = "info", title="Builder", message = "Mergi si schimba-te"})
        end
    end

    FreezeEntityPosition(angajatorped, true)
    SetEntityInvincible(angajatorped, true)
    SetBlockingOfNonTemporaryEvents(angajatorped, true)
    SetEntityHeading(angajatorped, 90.0)

    TaskStartScenarioInPlace(angajatorped, "WORLD_HUMAN_GUARD_STAND", 1, false)
    
end

local function init_job()

    --create props to sit and talk
    Citizen.CreateThread(function()
        local scaunLoc = {147.58291625977,-370.49291992188,43.256973266602}
        local scaunModel = 437228694
        local scaun = CreateObject(scaunModel, scaunLoc[1], scaunLoc[2], scaunLoc[3]-1.0, false, false, false)
        FreezeEntityPosition(scaun, true)
        SetEntityHeading(
            scaun --[[ Entity ]], 
            300.0 --[[ number ]]
        )        

        local masaLoc = {147.05680847168,-371.80651855469,43.256973266602}
        local masaModel = -1462060028
        local masa = CreateObject(masaModel, masaLoc[1], masaLoc[2], masaLoc[3]-1.0, false, false, false)
        FreezeEntityPosition(masa, true)
        SetEntityHeading(
            masa --[[ Entity ]], 
            -20.0 --[[ number ]]
        )
        
    
    end)

    Citizen.CreateThread(function()
        local hammerBuild = CreateRuntimeTxd("hammerBuild")
        CreateRuntimeTextureFromImage(hammerBuild, "hammerBuild", "assets/hammerBuild.png")
        local drillIcon = CreateRuntimeTxd("drillIcon")
        CreateRuntimeTextureFromImage(drillIcon, "drillIcon", "assets/drillIcon.png")
        local weldBuild = CreateRuntimeTxd("weldBuild")
        CreateRuntimeTextureFromImage(weldBuild, "weldBuild", "assets/weldBuild.png")
    end)
   
    
    Citizen.CreateThread(function()
        if(licenseNpc == nil)then
            
            local model = -673538407
            RequestModel(model)
            while (not HasModelLoaded(model)) do
            Citizen.Wait(1)
            end
            licenseNpc = CreatePed(1, model, locatii_job.coordonate[1], locatii_job.coordonate[2], locatii_job.coordonate[3]-1.0, 0.0, false, false)
            SetModelAsNoLongerNeeded(model)
            --SetEntityHeading(licenseNpc, -50)
            FreezeEntityPosition(licenseNpc, true)
            SetEntityInvincible(licenseNpc, true)
            SetBlockingOfNonTemporaryEvents(licenseNpc, true)
            TaskStartScenarioInPlace(licenseNpc, "WORLD_HUMAN_GUARD_STAND", 1, false)
        end
        while true do
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),locatii_job.coordonate[1],locatii_job.coordonate[2],locatii_job.coordonate[3]) <= 15.0) do
                Draw3DTextC(locatii_job.coordonate[1],locatii_job.coordonate[2],locatii_job.coordonate[3]+1.0, "Sef De Santier", 0.9, 1)
                Draw3DTextC(locatii_job.coordonate[1],locatii_job.coordonate[2],locatii_job.coordonate[3]+0.9, "[ ~b~Constructor~w~ ]", 0.5, 4)
                Wait(0)
            end 
            Wait(2000)
        end
    end)

    

pulseImage = true
xFloat = 0
xDirection = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30)
		if(xFloat == 10)then
			xDirection = 1
		elseif(xFloat == 0)then
			xDirection = 0
		end
		if(xDirection == 0)then
			xFloat = xFloat + 1
		else
			xFloat = xFloat - 1
		end
	end
    end)

    aFloat = 0
    aDirection = 0
    xAlpha = 255
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(50)
            if(aFloat == 20)then
                aDirection = 1
            elseif(aFloat == 0)then
                aDirection = 0
            end
            if(aDirection == 0)then
                aFloat = aFloat + 1
                xAlpha = xAlpha - 10
            else
                aFloat = aFloat - 1
                xAlpha = xAlpha + 10
            end
        end
    end)
    Citizen.CreateThread(function()
        local angajator = {141.15771484375,-379.478515625,43.256965637207}
        
        Citizen.CreateThread(function ()
            if(AngajatorNPC == nil)then
                local model = -1868718465
                RequestModel(model)
                while (not HasModelLoaded(model)) do
                Citizen.Wait(1)
                end
                AngajatorNPC = CreatePed(1, model, angajator[1], angajator[2], angajator[3]-1.0, 90.0, false, false)
                
                SetModelAsNoLongerNeeded(model)
                FreezeEntityPosition(AngajatorNPC, true)
                SetEntityInvincible(AngajatorNPC, true)
                SetBlockingOfNonTemporaryEvents(AngajatorNPC, true)
                -- TaskStartScenarioInPlace(AngajatorNPC, "WORLD_HUMAN_GUARD_STAND", 1, false)
            end    
            
        end)
       
        Citizen.CreateThread(function ()
            while true do
                while(Vdist(GetEntityCoords(GetPlayerPed(-1)),angajator[1], angajator[2], angajator[3]) <= 5.0) do
                    local ax, ay, az = table.unpack(GetEntityCoords(AngajatorNPC))
                    Draw3DTextC(ax, ay, az+1.0, "Angajator", 0.9, 1)
                    Draw3DTextC(ax, ay, az+0.9, "[ ~b~Constructor~w~ ]", 0.5, 4)
                    if not angajat then
                        drawSubtitleText("Apasa ~g~[E]~w~ sa te ~r~ angajezi")
                    else
                        drawSubtitleText("Apasa ~g~[E]~w~ sa ~r~ demisionezi")
                    end
                    if IsControlJustPressed(1, 51)then

                        if angajat then 
                            TriggerServerEvent("DemisioneaazaBuilder")

                        else
                            TriggerServerEvent("AngajeazaBuilder")

                        end

                        interviu(AngajatorNPC, GetPlayerPed(-1))        
                        TriggerServerEvent("sendPlayerCurrentJob")
                    
                    
                        -- TaskStartScenarioInPlace(AngajatorNPC, "WORLD_HUMAN_CLIPBOARD", 0, false)
                        -- TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_SEAT_CHAIR_DRINK", 0, false)
                        
                        -- Wait(15000)
                        -- ClearPedTasksImmediately(AngajatorNPC)
                        -- ClearPedTasksImmediately(GetPlayerPed(-1))
                        
                    end
                    Wait(0)
                end 
                Wait(2000)
            end
            
        end)

        local blip = AddBlipForCoord(angajator[1], angajator[2], angajator[3])
        SetBlipSprite(blip, 566)
        SetBlipColour (blip, 5)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Constructor")
        EndTextCommandSetBlipName(blip)
    end)
end

init_job()




local function job()

    Citizen.CreateThread(function()
        while true and angajat do
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)), Dresser.DressBlip[1], Dresser.DressBlip[2], Dresser.DressBlip[3]) <= 10.0) do
                Draw3DTextC(Dresser.DressBlip[1], Dresser.DressBlip[2], Dresser.DressBlip[3]+0.9, "[ ~b~Schimba-te [~g~E~g~~b~]~w~ ]", 2, 4)
                Wait(0)
                if IsControlJustPressed(1, 51) then
                    if not Dresser.Dressed then get_p_clothes() DressForJob() else RevertClothing() vRPjobsC.stopFarm() end
                    FreezeEntityPosition(PlayerPedId(), true)
                    ClearPedTasksImmediately(PlayerPedId())
                    ExecuteCommand("e adjust")
                    Wait(3000)
                    ExecuteCommand("e adjust")
                    Wait(3000)
                    ClearPedTasksImmediately(PlayerPedId())
                    FreezeEntityPosition(PlayerPedId(), false)
                end
            end 
            Wait(2000)
        end    
    end)

    
    Citizen.CreateThread(function()
        while true and angajat do
            Citizen.Wait(0)
                while Dresser.Dressed == false and angajat do 
                    Wait(0) 
                    if(Vdist(GetEntityCoords(GetPlayerPed(-1)),locatii_job.coordonate[1],locatii_job.coordonate[2],locatii_job.coordonate[3]) <= 10.0) then
                        Draw3DTextC(locatii_job.coordonate[1],locatii_job.coordonate[2],locatii_job.coordonate[3]+1.5, "Mergi si schimba-ti ~r~ hainele ~w~", 2, 1) 
                    end
                end
                local ped = PlayerPedId(-1)
                local coordsjuc = GetEntityCoords(GetPlayerPed(-1))
                if not started_farm then
                    if(Vdist(GetEntityCoords(GetPlayerPed(-1)),locatii_job.coordonate[1],locatii_job.coordonate[2],locatii_job.coordonate[3]) <= 15.0) then
                        if(Vdist(GetEntityCoords(GetPlayerPed(-1)),locatii_job.coordonate[1],locatii_job.coordonate[2],locatii_job.coordonate[3]) <= 4.0) then
                            drawSubtitleText("Apasa ~g~[E]~w~ pentru a incepe sa ~r~muncesti")
                            if IsControlJustPressed(1, 51) and not started_farm then
                                Citizen.Wait(120)
                                if(not vehicul) then
                                    for i,v in pairs(locatii_job.locatii) do
                                        table.insert(st_loc,{x=v[1],y=v[2],z=v[3],type=v[4],sprite=v[5]})
                                    end
                                    --SetPedPropIndex(GetPlayerPed(-1),0,145,0,0)
                                    started_farm = true
                                    cacat = true

                                end
                            end
                        end
                    end
                elseif started_farm then
                    for i,v in pairs(st_loc) do
                        if(pulseImage == true)then
                            theAlpha = xAlpha
                        else
                            theAlpha = 255
                        end
                        local theZ = v.z + (xFloat *0.004)
                        DrawImage3D(v.sprite, v.sprite, v.x,v.y,theZ - 0.2, 0.15, 0.25, 0.0, 255, 255, 255, theAlpha) 
                        DrawMarker(1, v.x,v.y,v.z-0.98, 0, 0, 0, 0, 0, 0, 0.9,0.9,0.3, 255,0,0, 200, false, true, 2, true, 0, 0, 0)
                        if(Vdist(coordsjuc.x,coordsjuc.y,coordsjuc.z,v.x,v.y,v.z) <= 2.0) then
                            drawSubtitleText("Apasa ~g~[E]~w~ pentru a lucra")
                            if(IsControlJustPressed(0,51))then
                                if v.type == "Picammer" then
                                    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CONST_DRILL', 0, true)
                                elseif v.type == "Sudura" then
                                    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_WELDING', 0, true)
                                elseif v.type == "Ciocan" then
                                    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_HAMMERING', 0, true)
                                end
                                doProgBar(true)
                                FreezeEntityPosition(GetPlayerPed(-1),true)
                                --SetTimeout(10000, function()
                                Wait(20000)
                                FreezeEntityPosition(GetPlayerPed(-1),false)
                                
                                barWidth = 0
                                progressHacking = 0
                                doProgBar(false)
                                --SetPedPropIndex(GetPlayerPed(-1),0,145,11,0)
                                --SetPedComponentVariation(GetPlayerPed(-1), 11, 223, 5, 0)
                                table.remove(st_loc,i)
                                --[[ money modules]]--
                                --bani = math.random(50,180)
                                --vRPSjobs.getMoney({bani})
                                --incometotal = incometotal + bani
                                ClearPedTasks(ped)
                                vRPSjobs.finishBuilderJob({})
                                if(#st_loc == 0) then
                                    vRPjobsC.stopFarm()
                                end
                            end
                        end
                    end
                end
            end
        end)
    Citizen.CreateThread(function()
        while true and angajat do 
            Citizen.Wait(200)
            if isBuilding then
                if(progressHacking < 100)then
                    progressHacking = progressHacking + 1
                    barWidth = barWidth + 0.00193
                elseif(progressHacking >= 100)then
                    barWidth = 0
                    progressHacking = 0
                end
            end
        end
    end)
        
end

TriggerServerEvent("sendPlayerCurrentJob")

RegisterNetEvent("getPlayerCurrentJob")
AddEventHandler("getPlayerCurrentJob", function(currentjob)
    if currentjob == "Constructor" then angajat = true else angajat = false end
    job()
end)

