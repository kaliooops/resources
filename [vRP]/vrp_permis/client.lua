vRPCpermis = {}
Tunnel.bindInterface("vrp_permis",vRPCpermis)
Proxy.addInterface("vrp_permis",vRPCpermis)
vRPSpermis = Tunnel.getInterface("vrp_permis","vrp_permis")
vRP = Proxy.getInterface("vRP")

local errs = {actual = 0,max = 3}
local intest = false
local secondPart = false
local kmh = 3.6
onTestEvent = 0
local speed = kmh
local speed_limit_resi = 50.0
local speed_limit_town = 80.0
local speed_limit_freeway = 120
maxErrors = 4
Error = 0

Citizen.CreateThread(function()
    local limitaViteza = CreateRuntimeTxd("limitaViteza")
    CreateRuntimeTextureFromImage(limitaViteza, "limitaViteza", "assets/limitaViteza.png")
    local limitaViteza1 = CreateRuntimeTxd("limitaViteza1")
    CreateRuntimeTextureFromImage(limitaViteza1, "limitaViteza1", "assets/limitaViteza1.png")
end)

function EndDTest()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn( ped, false )
    if Error >= maxErrors then
        drawNotification("Ai picat\nAi acumulat: ~r~".. Error.." ~w~greseli")
        vRPSpermis.picat({})
        vRPSpermis.scoatevworld({})
        DeleteEntity(vehicle)
        DeleteVehicle(vehicle)
        EndTestTasks()
        intest = false
    else
        drawNotification("Ai trecut\nAi acumulat: ~g~".. Error.." ~w~greseli")	
        vRPSpermis.trecut({})
        vRPSpermis.scoatevworld({})
        vRPSpermis.finishPermis({})
        DeleteEntity(vehicle)
        DeleteVehicle(vehicle)
        EndTestTasks()
        intest = false
    end
end

function EndTestTasks()
    onTestBlipp = nil
    onTestEvent = 0
    DamageControl = 0
    Error = 0
    TaskLeaveVehicle(GetPlayerPed(-1), veh, 0)
    Wait(1000)
    DeleteEntity(licenseNpc)
    CarTargetForLock = GetPlayersLastVehicle(GetPlayerPed(-1))
    lockStatus = GetVehicleDoorLockStatus(CarTargetForLock)
    SetVehicleDoorsLocked(CarTargetForLock, 2)
    SetVehicleDoorsLockedForPlayer(CarTargetForLock, PlayerId(), false)
    SetEntityAsMissionEntity(CarTargetForLock, true, true)
    Wait(2000)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( CarTargetForLock ) )
end

local function DrawText3D(x,y,z, text, scl) 
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

function vRPCpermis.playerSpawned(permisel)
    arepermis = permisel
end

local function Draw3DText(x,y,z, text,font,scl)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local scale = scl or 0.5
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
local coordonate = {x=219.47709655762,y=-1390.5911865234,z=30.587512969971}
InArea = false

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(219.47709655762,-1390.5911865234,30.587512969971)
    SetBlipSprite(blip, 498)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Scoala de Soferi")
    EndTextCommandSetBlipName(blip)
    ticks = 1000
    while true do
        Wait(ticks)
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(ped)
        if #(vector3(coords.x,coords.y,coords.z) - vector3(coordonate.x,coordonate.y,coordonate.z)) <= 5 then
            ticks = 1
            InArea = true
            DrawMarker(1, coordonate.x, coordonate.y, coordonate.z-1.00, 0, 0, 0, 0, 0, 0, 0.6901,0.6901,0.2301, 36, 113, 38, 200, 0, 0, 0, 1, 0, 0, 0)
            msg("APASA ~g~E ~w~PENTRU A ~r~INCEPE",4,0.45,0.89,0.50,255,255,255,255)
            Draw3DText(coordonate.x, coordonate.y, coordonate.z, 'Scoala de soferi',0,0.4) 
            if IsControlJustPressed(0, 38) then
                if not arepermis then 
                    vRPSpermis.vworld({})
                    cameraTransition(171.94692993164, -1011.8137207031, 29.333057403564)
                else
                    SetNotificationTextEntry("STRING")
                    AddTextComponentString("~r~Ai deja permis !")
                    DrawNotification(true, false)
                end
            end
        else
            ticks = 1000
            InArea = false
        end
    end
end)

function msg(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end


function Masina(x,y,z,heading) 
	local hash = GetHashKey("x6m")
    local n = 0
    while not HasModelLoaded(hash) and n < 500 do
        RequestModel(hash)
        Citizen.Wait(10)
        n = n+1
    end
    if HasModelLoaded(hash) then
        veh = CreateVehicle(hash,x,y,z,heading,true,false)
		SetVehicleNumberPlateText(veh,"DRPCIV")
        SetModelAsNoLongerNeeded(veh)
        SetVehicleFuelLevel(veh, 100.0)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1),veh,-1)
        SetVehRadioStation(veh, "OFF")
        SetVehicleRadioEnabled(veh, false)
    end    
end

function cameraTransition(x,y,z)
    NetworkOverrideClockTime(09, 0, 0)
    local a4 = GetRenderingCam()
    local ped = GetPlayerPed(-1)
    FreezeEntityPosition(ped, true)
    local a5 = NetworkGetPlayerCoords(ped)
    SetFocusPosAndVel(239.4198, -1392.593, 35.75024)
    local a6 = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", 239.4198, -1392.593, 35.75024, 0.0, 0.0, 0.0, 65.0, 0,2)
    PointCamAtCoord(a6, 218.9802, -1390.47, 30.57727)
    SetCamActive(a6, true)
    RenderScriptCams(true, true, 0, 1, 0, 0)
    vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Introducere","","Acesta este vehiculul dvs. în care veti fi ~b~examinat~w~.",6)
    Wait(7000)
    local a7 = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", 218.7297, -1370.44, 32.96997, 0.0, 0.0, 0.0, 65.0, 0, 2)
    PointCamAtCoord(a7, x,y,z)
    SetCamActiveWithInterp(a7, a6, 10000, 5, 5)
    vehShow = CreateVehicle("t20", 216.56478881836,-1360.2951660156,30.58749961853, 229.14, false, false)
    vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Introducere","","Acesta este vehiculul dvs. în care veti fi ~b~examinat~w~.",6)
    Wait(10000)
    DestroyCam(a6, 0)
    DestroyCam(a7, 0)
    RenderScriptCams(false, true, 3000, 1, 0, 0)
    DeleteEntity(vehShow)
    Masina(216.56478881836,-1360.2951660156,30.58749961853, 229.14)
    --Wait(1000)
    ClearFocus()
    FreezeEntityPosition(ped, false)
    vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Introducere","","Va rugam sa asteptati ~b~examinatorul~w~.",6)
    samafutineldenpc()
end 

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function samafutineldenpc()
    local model = 0x5E3DA4A4
    local ped = GetPlayerPed(-1)
    RequestModel(model)
    while (not HasModelLoaded(model)) do
      Citizen.Wait(1)
    end
    licenseNpc = CreatePed(1, model, 216.09582519531,-1378.4829101562,30.577869415283-1.0, 0.0, false, false)
    SetModelAsNoLongerNeeded(model)
    FreezeEntityPosition(veh, true)
    SetVehicleEngineOn(veh, false, true, true)
    SetEntityInvincible(licenseNpc, true)
    TaskGoStraightToCoord(licenseNpc, 217.96560668945,-1363.2104492188,30.587511062622  , 2.0, 5.0, 5.0, 5.0)
    Wait(5000)
    RequestAnimDict("amb@medic@standing@tendtodead@base")
    while not HasAnimDictLoaded("amb@medic@standing@tendtodead@base") do
      Wait(1)
    end  
    TaskPlayAnim(licenseNpc,"amb@medic@standing@tendtodead@base","base",8.0,0.0,-1,1,0,0,0,0)
    Wait(5000)
    ClearPedTasksImmediately(licenseNpc)
    TaskEnterVehicle(licenseNpc,veh,10.0,0,5.0,0,0)
    vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Instructor","","Salut, ma numesc Double si voi fii instructorul tau astazi.",6)
    vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Instructor","","Cand esti pregatit, te rog sa urmezi traseul.",6)
    Wait(5000)
    SetVehicleEngineOn(veh, true, true, false)
    SetVehicleFuelLevel(veh, 100.0)
    FreezeEntityPosition(veh, false)
    intest = true
    onTestEvent = 1
    onTestBlipp = AddBlipForCoord(217.82102966309,-1410.5201416016,28.292112350464)
    N_0x80ead8e2e1d5d52e(onTestBlipp)
    --SetBlipRoute(onTestBlipp, 1)
    SetBlipRoute(onTestBlipp,1)
    SetBlipSprite(onTestBlipp, 523)
    SetBlipRouteColour(onTestBlipp,38)
end

Citizen.CreateThread(function()
    local ticks = 100
    while true do
        Citizen.Wait(ticks)
        CarSpeed = GetEntitySpeed(GetVehiclePedIsUsing(GetPlayerPed(-1))) * speed
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and SpeedControl == 1 and CarSpeed >= speed_limit_resi then
			Error = Error + 1	
			Citizen.Wait(10000)
		elseif(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and SpeedControl == 2 and CarSpeed >= speed_limit_town then
			Error = Error + 1
			Citizen.Wait(10000)
		elseif(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and SpeedControl == 3 and CarSpeed >= speed_limit_freeway then
			Error = Error + 1
			Citizen.Wait(10000)
		end
	end
end)

Citizen.CreateThread(function()
    local ticks = 1000
    while true do
        Citizen.Wait(ticks)
		local ped = GetPlayerPed(-1)
        local veh = GetVehiclePedIsUsing(ped)
		if HasEntityCollidedWithAnything(veh) and DamageControl == 1 then			
			Citizen.Wait(1000)
			Error = Error + 1	
		elseif(IsControlJustReleased(1, 23)) and DamageControl == 1 then
            vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Instructor","","Nu puteti parasi vehiculul in timpul testului.",6)
    	end

        if onTestEvent == 1 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),217.82102966309,-1410.5201416016,28.292112350464, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,217.82102966309,-1410.5201416016,28.292112350464,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(178.55052185059,-1401.7551269531,28.725154876709)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Instructor","","Faceti o repriza rapida si opriti-va inainte de a intra in trafic.",6)
                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                FreezeEntityPosition(GetVehiclePedIsUsing(ped), true) -- Freeze Entity
                Citizen.Wait(6000)
                FreezeEntityPosition(GetVehiclePedIsUsing(ped), false) -- Freeze Entity
                vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Instructor","","~g~Foarte Bine~w~, acum fa dreapta si mergi pe banda din stanga.",6)
                SpeedControl = 2
                onTestEvent = 2
                Citizen.Wait(4000)
            end
        end	
        
        if onTestEvent == 2 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),178.55052185059,-1401.7551269531,27.725154876709, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,178.55052185059,-1401.7551269531,27.725154876709,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(113.16044616699,-1365.2762451172,28.725179672241)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Instructor","","Urmareste semafoarele din trafic.",6)
                onTestEvent = 3
            end
        end	
    
        if onTestEvent == 3 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),113.16044616699,-1365.2762451172,27.725179672241, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,113.16044616699,-1365.2762451172,27.725179672241,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(-73.542953491211,-1364.3355712891,27.789325714111)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                onTestEvent = 4
            end
        end		
            
        
        if onTestEvent == 4 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),-73.542953491211,-1364.3355712891,27.789325714111, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,-73.542953491211,-1364.3355712891,27.789325714111,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(-355.14373779297,-1420.2822265625,27.868143081665)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Instructor","","Asigurate ca te opresti pentru a trece masinile.",6)
                onTestEvent = 5
            end
        end			
        
        if onTestEvent == 5 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),-355.14373779297,-1420.2822265625,27.868143081665, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,-355.14373779297,-1420.2822265625,27.868143081665,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(-439.14846801758,-1417.1004638672,27.704095840454)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                onTestEvent = 6
            end
        end			
        
        if onTestEvent == 6 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),-439.14846801758,-1417.1004638672,27.704095840454, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,-439.14846801758,-1417.1004638672,27.704095840454,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(-453.79092407227,-1444.7265625,27.665870666504)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                onTestEvent = 7
            end
        end		
    
        if onTestEvent == 7 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),-453.79092407227,-1444.7265625,27.665870666504, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,-453.79092407227,-1444.7265625,27.665870666504,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(-463.23712158203,-1592.1785888672,37.519771575928)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Instructor","","E timpul sa iesim pe drum, sa urmaresti viteza si sa nu te prabusesti.",6)
                secondPart = true
                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                onTestEvent = 8
                SpeedControl = 3
                Citizen.Wait(4000)
            end
        end		
    
        if onTestEvent == 8 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),-463.23712158203,-1592.1785888672,37.519771575928, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,-463.23712158203,-1592.1785888672,37.519771575928,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(-900.64721679688,-1986.2814941406,26.109502792358)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                onTestEvent = 9
            end
        end
        
        if onTestEvent == 9 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),-900.64721679688,-1986.2814941406,26.109502792358, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,-900.64721679688,-1986.2814941406,26.109502792358,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(1225.7598876953,-1948.7922363281,38.718940734863)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                onTestEvent = 10
            end
        end	
        
        if onTestEvent == 10 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),1225.7598876953,-1948.7922363281,38.718940734863, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,1225.7598876953,-1948.7922363281,38.718940734863,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(209.54621887207,-1412.8677978516,29.652387619019)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                onTestEvent = 11
            end
        end	
        
        if onTestEvent == 11 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),1225.7598876953,-1948.7922363281,38.718940734863, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,1225.7598876953,-1948.7922363281,38.718940734863,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(1163.6030273438,-1841.7713623047,35.679168701172)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                secondPart = false
                intest = true
                vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Instructor","","Intram in oras, fii atent la viteza.",6)
                onTestEvent = 12
            end
        end		
        
        if onTestEvent == 12 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),1163.6030273438,-1841.7713623047,35.679168701172, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,1163.6030273438,-1841.7713623047,35.679168701172,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                onTestBlipp = AddBlipForCoord(235.28327941895,-1398.3292236328,28.921098709106)
                N_0x80ead8e2e1d5d52e(onTestBlipp)
                SetBlipRoute(onTestBlipp,1)
                SetBlipSprite(onTestBlipp, 523)
                SetBlipRouteColour(onTestBlipp,38)
                PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
                vRPCpermis.sendNotification("CHAR_MP_MEX_DOCKS",false,1,"Instructor","","Buna treaba, acum hai sa ne întoarcem de unde am plecat.",6)
                SpeedControl = 2
                onTestEvent = 13
            end
        end		
    
        if onTestEvent == 13 then
            if GetDistanceBetweenCoords(GetEntityCoords(ped),235.28327941895,-1398.3292236328,28.921098709106, true) > 4.0001 then
                ticks = 1
               DrawMarker(1,235.28327941895,-1398.3292236328,28.921098709106,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
            else
                if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
                    Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
                end
                EndDTest()
            end
        end		
    end
end)

Citizen.CreateThread(function()
    local ticks = 1000
    while true do 
        Citizen.Wait(ticks)
        if intest then 
            ticks = 1
            DrawSprite("limitaViteza","limitaViteza",0.90, 0.700,0.08,0.12,0.0,255,255,255,255)
        end
        if secondPart then 
            intest = false
            ticks = 1
            DrawSprite("limitaViteza1","limitaViteza1",0.90, 0.700,0.08,0.12,0.0,255,255,255,255)
        end
    end
end)

function vRPCpermis.sendNotification(icon,flash,type,sender,senderTitle,text,notifColor)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, flash, type, sender, senderTitle, text)
    DrawNotification(false, true)
end

function drawSubtitleText(m_text, showtime)
    ClearPrints()
    SetTextEntry_2("STRING")
    SetTextFont(fontId)
    AddTextComponentString(m_text)
    DrawSubtitleTimed(showtime, 1)
end