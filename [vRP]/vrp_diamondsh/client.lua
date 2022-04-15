vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","esk_diamondsh")
vRPdiamondsh = Tunnel.getInterface("esk_diamondsh","esk_diamondsh")
vRPdiamondshC = {}
Tunnel.bindInterface("esk_diamondsh",vRPdiamondshC)
vRPserver = Tunnel.getInterface("esk_diamondsh","esk_diamondsh")


local coordonateOpendiamondsh = {-795.77972412109,-219.84957885742,37.079654693604}
local coordonateIndiamondsh = {-782.90612792969,-223.22090148926,37.321521759033}


local indiamondsh = false
local vehicles = {}
local cam = nil
local categorie = 1
local selectie = 1
vRP.addBlip({-795.77972412109,-219.84957885742,37.079654693604,595,26,'Luxury Showroom'})

local camHacks = {
    ['onvehicle'] = {
        offsetX = -3.0,
        offsetY = 5.0,
        offsetZ = 1.3,
        pointCamAtCoordX = 0.0,
        pointCamAtCoordY = 1.5,
        pointCamAtCoordZ = 0.5
    }
}


local vehicles = {
    [1] = {
        tablename = 'Bugatti',
        {numeVehicul = "bvit",price = 200, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "Veyron Vitesse", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
    }, 
    [2] = {
        tablename = 'Lambo',
        {numeVehicul = "500gtrlam",price = 500, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "Diablo GTR", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
    }, 
    [3] = {
        tablename = 'BMW',
        {numeVehicul = "ocni422spe",price = 200, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "BMW i4 2022", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
        {numeVehicul = "bmwg07",price = 150, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "BMW X7 2021", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
        {numeVehicul = "m422",price = 200, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "BMW M4 2022", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
    }, 
    [4] = {
        tablename = 'Chevrolet',
        {numeVehicul = "16ss",price = 200, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "Camaro SS 2016", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
    }, 
    [5] = {
        tablename = 'Ford',
        {numeVehicul = "mache",price = 100, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "Mustang Mach E", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
    }, 
    [6] = {
        tablename = 'Mercedes',
        {numeVehicul = "sjamg",price = 150, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "E63 AMG", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
        {numeVehicul = "gle21",price = 150, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "GLE 63S 2021", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
        {numeVehicul = "22g63",price = 150, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "G63 AMG 2022", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
    },
    [7] = {
        tablename = 'Nissan',
        {numeVehicul = "gtr50",price = 100, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "GT-R50 2021", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
    }, 

}

Citizen.CreateThread(function()
    while true do
        Wait(350)
        while Vdist2(GetEntityCoords(PlayerPedId()),  table.unpack(coordonateOpendiamondsh)) <= 10  do
            Wait(0)
            DrawMarker(21, -782.90612792969,-223.22090148926,37.321521759033-0.1, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.60, 255, 255, 255, 165, 0, 0, 0, 1)
            if indiamondsh ~= true then
                drawTxt("APASA ~b~E~w~ PENTRU A INTRA IN LUXURY SHOWROOM",4,0.5,0.93,0.50,255,255,255,180)
                if ( IsControlJustReleased(0,51) )then
                    TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Viziteaza showroomul cu diamante (/gps)")
                    opendiamondsh()
                end
            end
        end
    end
end)

--[[Citizen.CreateThread(function()
    while true do
        Wait(350)
        while Vdist2(GetEntityCoords(PlayerPedId()),  table.unpack(coordonateOpendiamondsh)) <= 5  do
            Wait(0)
            if indiamondsh ~= true then
                text = "Apasa ~INPUT_CONTEXT~ pentru intra in diamondsh"
                HelpText(text)
                if ( IsControlJustReleased(0,51) )then
                    opendiamondsh()
                end
            end
        end
    end
end)]]--


-- function CreationCamHead(part)
--     if camHacks[part] ~= nil then
--         cam = CreateCam('DEFAULT_SCRIPTED_CAMERA')

--         local coordsCam = GetOffsetFromEntityInWorldCoords(PlayerPedId(), camHacks[part].offsetX, camHacks[part].offsetY,camHacks[part].offsetZ)
--         local coordsPly = GetEntityCoords(PlayerPedId())
--         SetCamCoord(cam, coordsCam)
--         PointCamAtCoord(cam, coordsPly['x']+camHacks[part].pointCamAtCoordX, coordsPly['y']+camHacks[part].pointCamAtCoordY, coordsPly['z']+camHacks[part].pointCamAtCoordZ)

--         SetCamActive(cam, true)
--         RenderScriptCams(true, true, 500, true, true)
--     else
--         print('====================================================================')
--         print('[diamondsh] EROARE LA COMANDA CreationCamHead(). PARTEA ESTE invalida! ')
--         print('====================================================================')
--     end
-- end

function CreationCamHead(part)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coordonateIndiamondsh[1],coordonateIndiamondsh[2]-6.0,coordonateIndiamondsh[3]+1.3)
    RenderScriptCams(1, 0, 0, 1, 1)
end

local categoriile = {}
function opendiamondsh()
    indiamondsh = true
    SetEntityCoords(GetPlayerPed(-1), -782.90612792969,-223.22090148926,37.321521759033)
    SetEntityVisible(GetPlayerPed(-1), false)
    Wait(100)
    SetNuiFocus(true, true)
    CreationCamHead()
    for k,v in pairs (vehicles) do
        table.insert(categoriile,'<a onclick="schimbaCategoria('..k..')">'..v.tablename..'</a>')
    end
    SendNUIMessage({
        action = "deschidediamondshlolxd",
        categorii = categoriile
    })
end

local vehiculele = {}
RegisterNUICallback('changeCategory', function(data,cb)
    categorie = data.categorieSelectata
    if #vehiculele == 0 then
        adaugaMasinileIndiamondsh()
    else
        for k in pairs(vehiculele) do
            vehiculele[k] = nil
        end
        adaugaMasinileIndiamondsh()
    end
end)

RegisterNUICallback('spawnVehicle', function(data,cb)
    selectie = data.idSelectie
    spawnRablament(vehicles[categorie][selectie].numeVehicul)
end)

function adaugaMasinileIndiamondsh()
    for k,v in pairs(vehicles) do
        if categorie == k then
            for i,p in pairs(v) do
                if p.numeVehicul ~= nil then
                    if vehiculele ~= nil then
                        insert = '<button onclick="spawnMasina('..i..')" class="button">'..p.numemasina..'</button>'
                        table.insert(vehiculele,insert)
                    end
                end
            end
        end
    end
    SendNUIMessage({
        action = "adaugaMasinile",
        masinile = vehiculele
    })
end

function spawnRablament(model)
    RequestModel(model)
    local timpfake = 0
    while not HasModelLoaded(model) and timpfake < 500 do
        Wait(0)
        SetNuiFocus(false, false)
        timpfake = timpfake + 1
    end
    SetNuiFocus(true, true)
    rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
    if rablactuala == nil then
        local nveh = CreateVehicle(model, -782.90612792969,-223.22090148926,37.321521759033+0.5, 120.0, false, false)
        SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
        SetVehicleEngineOn(nveh,false,false,0)
        SetVehicleDirtLevel(nveh,0.0)
    else
        DeleteEntity(rablactuala)
        local nveh = CreateVehicle(model, -782.90612792969,-223.22090148926,37.321521759033+0.5, 120.0, false, false)
        SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
        SetVehicleEngineOn(nveh,false,true,true)
        SetVehicleDirtLevel(nveh,0.0)
    end
    maxspeed = math.floor(GetVehicleModelMaxSpeed(GetHashKey(vehicles[categorie][selectie].numeVehicul))*3.6)
    SendNUIMessage({
        action = "adaugaInfoDespremasina",
        numemasina = vehicles[categorie][selectie].numemasina,
        pret = vehicles[categorie][selectie].price,
        hp = vehicles[categorie][selectie].hp,
        acceleration = vehicles[categorie][selectie].acceleration,
        brakes = vehicles[categorie][selectie].brakes,
        -- maxspeed = vehicles[categorie][selectie].maxspeed,
        maxspeed = maxspeed,
        maxspeedbar = vehicles[categorie][selectie].maxspeedbar,
        tipvehicul = vehicles[categorie][selectie].tip,
    })
end


RegisterNUICallback('exitdiamondsh', function(data, cb)
    rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
    DeleteEntity(rablactuala)
    DestroyCam(cam, false)
    SetCamActive(cam, false)
    RenderScriptCams(0, false, 100, false, false)
    SetNuiFocus(false, false)
    indiamondsh = false
    SetEntityCoords(GetPlayerPed(-1), table.unpack(coordonateOpendiamondsh))
    SetEntityVisible(GetPlayerPed(-1), true)
    for k in pairs(vehiculele) do
        vehiculele[k] = nil
    end
    for k in pairs(categoriile) do
        categoriile[k] = nil
    end
end)

RegisterNUICallback('schimbaCuloare', function(data, cb)
    if indiamondsh == true then
        rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
        if data.culoareselectata == 1 then
            r,g,b,r2,g2,b2 = 255, 255, 255, 0,0,0
        elseif data.culoareselectata == 2 then
            r,g,b,r2,g2,b2 = 0, 0, 0, 0,0,0
        elseif data.culoareselectata == 3 then
            r,g,b,r2,g2,b2 = 78, 78, 78, 0,0,0
        elseif data.culoareselectata == 4 then
            r,g,b,r2,g2,b2 = 255, 251, 0, 0,0,0
        elseif data.culoareselectata == 5 then
            r,g,b,r2,g2,b2 = 0, 255, 0, 0,0,0
        elseif data.culoareselectata == 6 then
            r,g,b,r2,g2,b2 = 194, 30, 30, 0,0,0
        elseif data.culoareselectata == 7 then
            r,g,b,r2,g2,b2 = 10, 101, 221, 0,0,0
        elseif data.culoareselectata == 8 then
            r,g,b,r2,g2,b2 = 200, 24, 171, 0,0,0
        elseif data.culoareselectata == 9 then
            r,g,b,r2,g2,b2 = 0, 247, 255, 0,0,0
        elseif data.culoareselectata == 10 then
            r,g,b,r2,g2,b2 = 86, 6, 110, 0,0,0
        elseif data.culoareselectata == 11 then
            r,g,b,r2,g2,b2 = 184, 132, 12, 0,0,0
        elseif data.culoareselectata == 12 then
            r,g,b,r2,g2,b2 = 255, 94, 0, 0,0,0
        end
        if rablactuala ~= nil then
            SetVehicleCustomPrimaryColour(rablactuala, r, g, b)
        end
    end
end)


function getTuning()
    local GP = function(value)
        if value then
          return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
        else
          return nil
        end
    end
    myveh = {}
    veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
    SetVehicleModKit(veh,0)
    myveh.vehicle = veh
    myveh.plate = GP(GetVehicleNumberPlateText(veh))
    myveh.model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
    myveh.modelhash = GetEntityModel(veh)
    r,g,b = GetVehicleCustomPrimaryColour(veh)
    r2,g2,b2 = GetVehicleCustomSecondaryColour(veh)
    myveh.color =  table.pack(r,g,b,r2,g2,b2)
    myveh.extracolor = table.pack(GetVehicleExtraColours(veh))
    nr,ng,nb = GetVehicleNeonLightsColour(veh)
    myveh.neoncolor = table.pack(nr,ng,nb)
    myveh.neon = {}
    myveh.smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
    myveh.plateindex = GetVehicleNumberPlateTextIndex(veh)
    myveh.mods = {}
    for i = 0, 48 do
        myveh.mods[i] = {mod = nil}
    end
    for i,t in pairs(myveh.mods) do
        if i == 22 or i == 18 then
            if IsToggleModOn(veh,i) then
                t.mod = 1
            else
                t.mod = 0
            end
        elseif i == 23 or i == 24 then
            t.mod = GetVehicleMod(veh,i)
            t.variation = GetVehicleModVariation(veh, i)
        else
            t.mod = GetVehicleMod(veh,i)
        end
    end
    if GetVehicleWindowTint(veh) == -1 or GetVehicleWindowTint(veh) == 0 then
        myveh.windowtint = false
    else
        myveh.windowtint = GetVehicleWindowTint(veh)
    end
    myveh.headlightscolor = GetVehicleHeadlightsColour(veh)
    myveh.wheeltype = GetVehicleWheelType(veh)
    myveh.bulletProofTyres = GetVehicleTyresCanBurst(veh)

    myveh.neon.left = IsVehicleNeonLightEnabled(veh,0)
    myveh.neon.right = IsVehicleNeonLightEnabled(veh,1)
    myveh.neon.front = IsVehicleNeonLightEnabled(veh,2)
    myveh.neon.back = IsVehicleNeonLightEnabled(veh,3)

    --Menu stuff
    local chassis,interior,bumper,fbumper,rbumper = false,false,false,false

    for i = 0,48 do
        if GetNumVehicleMods(veh,i) ~= nil and GetNumVehicleMods(veh,i) ~= false and GetNumVehicleMods(veh,i) > 0 then
            if i == 1 then
                bumper = true
                fbumper = true
            elseif i == 2 then
                bumper = true
                rbumper = true
            elseif (i >= 42 and i <= 46) or i == 5 then
                chassis = true
            elseif i >= 27 and i <= 37 then
                interior = true
            end
        end
    end
    return myveh
end


RegisterNUICallback('cumparaMasina', function(data, cb)
    if indiamondsh == true then
        tuning = getTuning()
        vRPdiamondsh.cumparaMasina({vehicles[categorie][selectie].numeVehicul,vehicles[categorie][selectie].price,selectie,categorie,tuning})
        inchidediamondsh()
    end
end)

function inchidediamondsh()
    rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
    DeleteEntity(rablactuala)
    DestroyCam(cam, false)
    SetCamActive(cam, false)
    RenderScriptCams(0, false, 100, false, false)
    SendNUIMessage({
        action = "inchidediamondsh2",
    })
    SetNuiFocus(false, false)
    indiamondsh = false
    SetEntityCoords(GetPlayerPed(-1), table.unpack(coordonateOpendiamondsh))
    SetEntityVisible(GetPlayerPed(-1), true)
    for k in pairs(categoriile) do
        categoriile[k] = nil
    end
end

RegisterNUICallback('testeazaMasina', function(data, cb)
    if indiamondsh == true then
        rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
        DeleteEntity(rablactuala)
        DestroyCam(cam, false)
        SetCamActive(cam, false)
        RenderScriptCams(0, false, 100, false, false)
        SetNuiFocus(false, false)
        SetEntityVisible(GetPlayerPed(-1), true)
        SendNUIMessage({
            action = "inchidediamondsh"
        })
        local timp = 30
    
        Wait(10)

        spawntestvehicle()
        CreateThread(function()
            while true do
                Wait(1000)
                timp = timp - 1
                if timp == 0 then
                    rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
                    DeleteEntity(rablactuala)
                    for k in pairs(categoriile) do
                        categoriile[k] = nil
                    end
                    opendiamondsh()
                    inTestDrive = false
                    spawnRablament(vehicles[categorie][selectie].numeVehicul)
                    break
                end
            end
        end)
    end
end)

function spawntestvehicle()
    inTestDrive = true
    local testcar = CreateVehicle(vehicles[categorie][selectie].numeVehicul, -911.39739990234,-3289.1572265625,13.944427490234+0.5, 130.0, true, false)
    SetPedIntoVehicle(GetPlayerPed(-1),testcar,-1)
    SetVehicleEngineOn(testcar,false,false,0)
    SetVehicleDirtLevel(testcar,0.0)
end


HelpText = function(msg)
    AddTextEntry(GetCurrentResourceName(), msg)
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end