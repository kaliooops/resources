vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","esk_showroom")
vRPshowroom = Tunnel.getInterface("esk_showroom","esk_showroom")
vRPshowroomC = {}
Tunnel.bindInterface("esk_showroom",vRPshowroomC)
vRPserver = Tunnel.getInterface("esk_showroom","esk_showroom")


local coordonateOpenShowroom = {-30.029813766479,-1105.0632324219,26.42234992981,159.56788635254}
local coordonateInShowroom = {-973.08752441406,-2994.966796875,13.945077896118}


local inShowroom = false
local vehicles = {}
local cam = nil
local categorie = 1
local selectie = 1
vRP.addBlip({-30.081178665162,-1104.896850586,26.422359466552,595,26,'Showroom'})

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
        tablename = 'Low Cost',
        {numeVehicul = "aerox155",price = 299, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "Scuter AeroXR", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
        {numeVehicul = "cliov6",price = 499, speed = 40, acceleration = 43, brakes = 40, hp = 100,numemasina = "Renault Clio", maxspeed= 200, maxspeedbar = 44, tip = 'Premium'},
        {numeVehicul = "seatl",price = 699, speed = 40, acceleration = 43, brakes = 40, hp = 100,numemasina = "Seat Leon", maxspeed= 200, maxspeedbar = 44, tip = 'Premium'},
        {numeVehicul = "206lo",price = 599, speed = 40, acceleration = 43, brakes = 40, hp = 100,numemasina = "Peugeot 206", maxspeed= 200, maxspeedbar = 44, tip = 'Premium'},
        {numeVehicul = "e34",price = 4999, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "M3 E34" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [2] = {
        tablename = 'BMW',
        {numeVehicul = "rmodm4gts",price = 130000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "M4 GTS" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodmi8lb",price = 100000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "BMW I8" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodx6",price = 88000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "X6M Breithaus" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "bmwe65",price = 19000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "E65" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "m3e46",price = 20000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "M3 E46" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "bmw1",price = 16333, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Seria 1" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "m2",price = 61999, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "M2" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    },
    [3] = {
        tablename = 'Audi',
        {numeVehicul = "ocnetrongt",price = 120000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "E-trone GT", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "audquattros",price = 12500, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Quattro", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rs6avant20",price = 95000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "RS6 Avant", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "2013rs7",price = 40000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "RS7 ABT", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},

    }, 
    [4] = {
        tablename = 'Mercedes',
        {numeVehicul = "rmodgt63",price = 119999, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "AMG GT63", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "c63s",price = 59999, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "C63 S Coupe", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "c63w205",price = 75999, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "C63 Coupe", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "s500w222",price = 69999, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "S500 w222", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "sjbenz250",price = 69999, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "CLA 250", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [5] = {
        tablename = 'VW',
        {numeVehicul = "scijo",price = 5500, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Scirocco 2010", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "golfmk6",price = 10000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Golf MK6", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [6] = {
        tablename = 'Dodge',
        {numeVehicul = "demon",price = 80000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Challanger Demon SRT", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "16charger",price = 35000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Dodge Charger 2016", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [7] = {
        tablename = 'Nissan',
        {numeVehicul = "skyline",price = 75000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Skyline GT-R34", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodskyline",price = 105000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "GT-R Nismo Skyline", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [8] = {
        tablename = 'Toyota',
        {numeVehicul = "toysuya",price = 150000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Supra RaceV", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [9] = {
        tablename = 'Mitsubishi',
        {numeVehicul = "lanex400",price = 37000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Lancer X 400", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [10] = {
        tablename = 'Ford',
        {numeVehicul = "mgt",price = 22000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Mustang GT 2015", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodfordgt",price = 25000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Mustang GT 2011", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [11] = {
        tablename = 'Chevrolet',
        {numeVehicul = "camaro90",price = 12000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Camaro '90'", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [12] = {
        tablename = 'Porsche',
        {numeVehicul = "cayman16",price = 45000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Cayman '16", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [13] = {
        tablename = 'Motoare',
        {numeVehicul = "africat",price = 19000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Honda CRF1000L" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "bmws",price = 20000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "BMW S1000 RR" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "zx10r",price = 27000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Kawasaki Ninja" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "xre300",price = 10000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Honda XRE 300" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},

    },
    [14] = {
        tablename = 'Legendary',
        {numeVehicul = "bugatti",price = 1300000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Bugatti Veyron" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodlp770",price = 400000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Lamborghini Centenario" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "lp700",price = 450000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Lamborghini Aventador" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodlp570",price = 3600000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Lamborghini Gallardo" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "divo",price = 5000000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Bugatti Divo" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "2019chiron",price = 3000000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Bugatti Chiron" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},

    },
    [15] = {
        tablename = 'Street Illegal',
         {numeVehicul = "rm3e36",price = 32000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "E36 StreetCustom" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
         {numeVehicul = "m1procar",price = 586000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "BMW M1 ProCar" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
         {numeVehicul = "r8lms",price = 400000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Audi R8 LMS Ultra" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
         {numeVehicul = "rmodgtr",price = 125000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Nissan GT-R" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    },
    [16] = {
        tablename = 'SUV',
        {numeVehicul = "g63amg6x6",price = 451010, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "G63 AMG 6x6" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "audsq517",price = 30000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Audi SQ5" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "ram2500",price = 85000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Dodge RAM 2500" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "trx",price = 150000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Dodge Ram TRX" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "mlbrabus",price = 40000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Brabus ML" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "x5e53",price = 30000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "BMW X5 e53" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "g65amg",price = 250000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "G65 AMG" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "1016urus",price = 250000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Lamborghini Urus Top Car" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    },

    [17] = {
        tablename = 'Rolls Royce',
        {numeVehicul = "wraith19",price = 4551010, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Wraith 2019" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    },

}

Citizen.CreateThread(function()
    while true do
        Wait(350)
        while Vdist2(GetEntityCoords(PlayerPedId()),  table.unpack(coordonateOpenShowroom)) <= 10  do
            Wait(0)
            DrawMarker(21, 106.12724304199,6435.7470703125,37.956539154053-0.1, 0, 0, 0, 0, 0, 0, 0.60, 0.60, 0.60, 255, 255, 255, 165, 0, 0, 0, 1)
            if inShowroom ~= true then
                drawTxt("APASA ~b~E~w~ PENTRU A INTRA IN SHOWROOM",4,0.5,0.93,0.50,255,255,255,180)
                if ( IsControlJustReleased(0,51) )then
                    openShowroom()
                end
            end
        end
    end
end)

--[[Citizen.CreateThread(function()
    while true do
        Wait(350)
        while Vdist2(GetEntityCoords(PlayerPedId()),  table.unpack(coordonateOpenShowroom)) <= 5  do
            Wait(0)
            if inShowroom ~= true then
                text = "Apasa ~INPUT_CONTEXT~ pentru intra in showroom"
                HelpText(text)
                if ( IsControlJustReleased(0,51) )then
                    openShowroom()
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
--         print('[SHOWROOM] EROARE LA COMANDA CreationCamHead(). PARTEA ESTE invalida! ')
--         print('====================================================================')
--     end
-- end

function CreationCamHead(part)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coordonateInShowroom[1],coordonateInShowroom[2]-6.0,coordonateInShowroom[3]+1.3)
    RenderScriptCams(1, 0, 0, 1, 1)
end

local categoriile = {}
function openShowroom()
    inShowroom = true
    SetEntityCoords(GetPlayerPed(-1), -973.08752441406,-2994.966796875,13.945077896118)
    SetEntityVisible(GetPlayerPed(-1), false)
    Wait(100) -- IMPORTANT, LASA-L AICI DETAH CA POATE IAR FUTI CEVA!!!
    SetNuiFocus(true, true)
    CreationCamHead()
    for k,v in pairs (vehicles) do
        table.insert(categoriile,'<a onclick="schimbaCategoria('..k..')">'..v.tablename..'</a>')
    end
    SendNUIMessage({
        action = "deschideShowroomlolxd",
        categorii = categoriile
    })
end

local vehiculele = {}
RegisterNUICallback('changeCategory', function(data,cb)
    categorie = data.categorieSelectata
    if #vehiculele == 0 then
        adaugaMasinileInShowroom()
    else
        for k in pairs(vehiculele) do
            vehiculele[k] = nil
        end
        adaugaMasinileInShowroom()
    end
end)

RegisterNUICallback('spawnVehicle', function(data,cb)
    selectie = data.idSelectie
    spawnRablament(vehicles[categorie][selectie].numeVehicul)
end)

function adaugaMasinileInShowroom()
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
        local nveh = CreateVehicle(model, -973.08752441406,-2994.966796875,13.945077896118+0.5, 120.0, false, false)
        SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1)
        SetVehicleEngineOn(nveh,false,false,0)
        SetVehicleDirtLevel(nveh,0.0)
    else
        DeleteEntity(rablactuala)
        local nveh = CreateVehicle(model, -973.08752441406,-2994.966796875,13.945077896118+0.5, 120.0, false, false)
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


RegisterNUICallback('exitshowroom', function(data, cb)
    rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
    DeleteEntity(rablactuala)
    DestroyCam(cam, false)
    SetCamActive(cam, false)
    RenderScriptCams(0, false, 100, false, false)
    SetNuiFocus(false, false)
    inShowroom = false
    SetEntityCoords(GetPlayerPed(-1), table.unpack(coordonateOpenShowroom))
    SetEntityVisible(GetPlayerPed(-1), true)
    for k in pairs(vehiculele) do
        vehiculele[k] = nil
    end
    for k in pairs(categoriile) do
        categoriile[k] = nil
    end
end)

RegisterNUICallback('schimbaCuloare', function(data, cb)
    if inShowroom == true then
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
    if inShowroom == true then
        tuning = getTuning()
        vRPshowroom.cumparaMasina({vehicles[categorie][selectie].numeVehicul,vehicles[categorie][selectie].price,selectie,categorie,tuning})
        inchideShowroom()
    end
end)

function inchideShowroom()
    rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
    DeleteEntity(rablactuala)
    DestroyCam(cam, false)
    SetCamActive(cam, false)
    RenderScriptCams(0, false, 100, false, false)
    SendNUIMessage({
        action = "inchideShowroom2",
    })
    SetNuiFocus(false, false)
    inShowroom = false
    SetEntityCoords(GetPlayerPed(-1), table.unpack(coordonateOpenShowroom))
    SetEntityVisible(GetPlayerPed(-1), true)
    for k in pairs(categoriile) do
        categoriile[k] = nil
    end
end

RegisterNUICallback('testeazaMasina', function(data, cb)
    if inShowroom == true then
        rablactuala = GetVehiclePedIsUsing(GetPlayerPed(-1))
        DeleteEntity(rablactuala)
        DestroyCam(cam, false)
        SetCamActive(cam, false)
        RenderScriptCams(0, false, 100, false, false)
        SetNuiFocus(false, false)
        SetEntityVisible(GetPlayerPed(-1), true)
        SendNUIMessage({
            action = "inchideShowroom"
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
                    openShowroom()
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