    
function get_players_in_range(range)
    local players = {}
    for _, player in pairs(GetActivePlayers()) do
        if Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(player))) <= range then
            table.insert(players, player)
        end
    end
    return players
end


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
	AddTextComponentString("Aprovizionat")
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


function get_p_clothes()
    local ped = PlayerPedId()
    local clothes = {}
    clothes.hat = {model = GetPedPropIndex(ped, 0), texture = GetPedPropTextureIndex(ped, 0), pos = 0 }
    clothes.jacket = {model = GetPedDrawableVariation(ped, 11), texture = GetPedTextureVariation(ped, 11), pos = 11 }
    clothes.undershirt = {model = GetPedDrawableVariation(ped, 8), texture = GetPedTextureVariation(ped, 8), pos = 8 }
    clothes.armsgloves = {model = GetPedDrawableVariation(ped, 3), texture = GetPedTextureVariation(ped, 3), pos = 3 }
    clothes.pants = {model = GetPedDrawableVariation(ped, 4), texture = GetPedTextureVariation(ped, 4), pos = 4 }
    clothes.shoes = {model = GetPedDrawableVariation(ped, 6), texture = GetPedTextureVariation(ped, 6), pos = 6 }
    clothes.mask = {model = GetPedDrawableVariation(ped, 1), texture = GetPedTextureVariation(ped, 1), pos = 1 }

    return clothes
end



vehicles = {
    [1] = {
        tablename = 'Low Cost',
        {numeVehicul = "aerox155",price = 350, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "Scuter AeroXR", maxspeed= 69420, maxspeedbar = 60, tip = 'Premium'},
        {numeVehicul = "cliov6",price = 500, speed = 40, acceleration = 43, brakes = 40, hp = 100,numemasina = "Renault Clio", maxspeed= 69420, maxspeedbar = 44, tip = 'Premium'},
        {numeVehicul = "206lo",price = 600, speed = 40, acceleration = 43, brakes = 40, hp = 100,numemasina = "Peugeot 206", maxspeed= 69420, maxspeedbar = 44, tip = 'Premium'},
    }, 
    [2] = {
        tablename = 'BMW',
        {numeVehicul = "rmodm4gts",price = 130000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "M4 GTS" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodmi8lb",price = 100000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "BMW I8" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodx6",price = 88000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "X6M Breithaus" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodm4",price = 65000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "M4" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},

    },
    [3] = {
        tablename = 'Audi',
        {numeVehicul = "ocnetrongt",price = 120000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "E-trone GT", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "audquattros",price = 12500, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Quattro", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rs6avant20",price = 95000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "RS6 Avant", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "2013rs7",price = 40000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "RS7 ABT", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},

    }, 
    [4] = {
        tablename = 'Mercedes',
        {numeVehicul = "rmodgt63",price = 110000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "AMG GT63", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "c63s",price = 50000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "C63 Coupe", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [5] = {
        tablename = 'VolksWagen',
        {numeVehicul = "scijo",price = 5500, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Scirocco 2010", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "golfmk6",price = 10000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Golf MK6", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [6] = {
        tablename = 'Dodge',
        {numeVehicul = "demon",price = 80000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Challanger Demon SRT", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [7] = {
        tablename = 'Nissan',
        {numeVehicul = "skyline",price = 33000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Skyline GT-R34", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodskyline",price = 105000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "GT-R Nismo Skyline", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [8] = {
        tablename = 'Toyota',
        {numeVehicul = "toysuya",price = 150000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Supra RaceV", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [9] = {
        tablename = 'Mitsubishi',
        {numeVehicul = "lanex400",price = 37000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Lancer X 400", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [10] = {
        tablename = 'Ford',
        {numeVehicul = "mgt",price = 22000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Mustang GT 2015", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodfordgt",price = 25000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Mustang GT 2011", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [11] = {
        tablename = 'Chevrolet',
        {numeVehicul = "camaro90",price = 12000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Camaro '90'", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [12] = {
        tablename = 'Porsche',
        {numeVehicul = "cayman16",price = 45000, speed = 80, acceleration = 73, brakes = 70, hp = 592,numemasina = "Cayman '16", maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [13] = {
        tablename = 'Motociclete',
        {numeVehicul = "africat",price = 19000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "Honda CRF1000L" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "bmws",price = 20000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "BMW S1000 RR" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "zx10r",price = 27000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "Kawasaki Ninja" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},

    },
    [14] = {
        tablename = 'Legendary',
        {numeVehicul = "bugatti",price = 1300000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "Bugatti Veyron" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodlp770",price = 400000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "Lamborghini Centenario" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "lp700",price = 450000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "Lamborghini Aventador" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodlp570",price = 3600000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "Lamborghini Gallardo" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodveneno",price = 3600000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "Lamborghini Veneno" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},

    },
    [15] = {
        tablename = 'Street Illegal',
         {numeVehicul = "rm3e36",price = 32000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "E36 StreetCustom" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
         {numeVehicul = "m1procar",price = 586000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "BMW M1 ProCar" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
         {numeVehicul = "r8lms",price = 400000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "Audi R8 LMS Ultra" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
         {numeVehicul = "rmodgtr",price = 125000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "Nissan GT-R" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
    },
    [16] = {
        tablename = 'SUV',
        {numeVehicul = "g63amg6x6",price = 451010, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "G63 AMG 6x6" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "audsq517",price = 30000, speed = 70, acceleration = 55, brakes = 75, hp = 365,numemasina = "Audi SQ5" , maxspeed= 69420, maxspeedbar = 91, tip = 'Premium'},

    },
}

colors = {
    {0,"Metallic Black"},
{1,"Metallic Graphite Black"},
{2,"Metallic Black Steal"},
{3,"Metallic Dark Silver"},
{4,"Metallic Silver"},
{5,"Metallic Blue Silver"},
{6,"Metallic Steel Gray"},
{7,"Metallic Shadow Silver"},
{8,"Metallic Stone Silver"},
{9,"Metallic Midnight Silver"},
{10,"Metallic Gun Metal"},
{11,"Metallic Anthracite Grey"},
{12,"Matte Black"},
{13,"Matte Gray"},
{14,"Matte Light Grey"},
{15,"Util Black"},
{16,"Util Black Poly"},
{17,"Util Dark silver"},
{18,"Util Silver"},
{19,"Util Gun Metal"},
{20,"Util Shadow Silver"},
{21,"Worn Black"},
{22,"Worn Graphite"},
{23,"Worn Silver Grey"},
{24,"Worn Silver"},
{25,"Worn Blue Silver"},
{26,"Worn Shadow Silver"},
{27,"Metallic Red"},
{28,"Metallic Torino Red"},
{29,"Metallic Formula Red"},
{30,"Metallic Blaze Red"},
{31,"Metallic Graceful Red"},
{32,"Metallic Garnet Red"},
{33,"Metallic Desert Red"},
{34,"Metallic Cabernet Red"},
{35,"Metallic Candy Red"},
{36,"Metallic Sunrise Orange"},
{37,"Metallic Classic Gold"},
{38,"Metallic Orange"},
{39,"Matte Red"},
{40,"Matte Dark Red"},
{41,"Matte Orange"},
{42,"Matte Yellow"},
{43,"Util Red"},
{44,"Util Bright Red"},
{45,"Util Garnet Red"},
{46,"Worn Red"},
{47,"Worn Golden Red"},
{48,"Worn Dark Red"},
{49,"Metallic Dark Green"},
{50,"Metallic Racing Green"},
{51,"Metallic Sea Green"},
{52,"Metallic Olive Green"},
{53,"Metallic Green"},
{54,"Metallic Gasoline Blue Green"},
{55,"Matte Lime Green"},
{56,"Util Dark Green"},
{57,"Util Green"},
{58,"Worn Dark Green"},
{59,"Worn Green"},
{60,"Worn Sea Wash"},
{61,"Metallic Midnight Blue"},
{62,"Metallic Dark Blue"},
{63,"Metallic Saxony Blue"},
{64,"Metallic Blue"},
{65,"Metallic Mariner Blue"},
{66,"Metallic Harbor Blue"},
{67,"Metallic Diamond Blue"},
{68,"Metallic Surf Blue"},
{69,"Metallic Nautical Blue"},
{70,"Metallic Bright Blue"},
{71,"Metallic Purple Blue"},
{72,"Metallic Spinnaker Blue"},
{73,"Metallic Ultra Blue"},
{74,"Metallic Bright Blue"},
{75,"Util Dark Blue"},
{76,"Util Midnight Blue"},
{77,"Util Blue"},
{78,"Util Sea Foam Blue"},
{79,"Util Lightning blue"},
{80,"Util Maui Blue Poly"},
{81,"Util Bright Blue"},
{82,"Matte Dark Blue"},
{83,"Matte Blue"},
{84,"Matte Midnight Blue"},
{85,"Worn Dark blue"},
{86,"Worn Blue"},
{87,"Worn Light blue"},
{88,"Metallic Taxi Yellow"},
{89,"Metallic Race Yellow"},
{90,"Metallic Bronze"},
{91,"Metallic Yellow Bird"},
{92,"Metallic Lime"},
{93,"Metallic Champagne"},
{94,"Metallic Pueblo Beige"},
{95,"Metallic Dark Ivory"},
{96,"Metallic Choco Brown"},
{97,"Metallic Golden Brown"},
{98,"Metallic Light Brown"},
{99,"Metallic Straw Beige"},
{100,"Metallic Moss Brown"},
{101,"Metallic Biston Brown"},
{102,"Metallic Beechwood"},
{103,"Metallic Dark Beechwood"},
{104,"Metallic Choco Orange"},
{105,"Metallic Beach Sand"},
{106,"Metallic Sun Bleeched Sand"},
{107,"Metallic Cream"},
{108,"Util Brown"},
{109,"Util Medium Brown"},
{110,"Util Light Brown"},
{111,"Metallic White"},
{112,"Metallic Frost White"},
{113,"Worn Honey Beige"},
{114,"Worn Brown"},
{115,"Worn Dark Brown"},
{116,"Worn straw beige"},
{117,"Brushed Steel"},
{118,"Brushed Black steel"},
{119,"Brushed Aluminium"},
{120,"Chrome"},
{121,"Worn Off White"},
{122,"Util Off White"},
{123,"Worn Orange"},
{124,"Worn Light Orange"},
{125,"Metallic Securicor Green"},
{126,"Worn Taxi Yellow"},
{127,"police car blue"},
{128,"Matte Green"},
{129,"Matte Brown"},
{130,"Worn Orange"},
{131,"Matte White"},
{132,"Worn White"},
{133,"Worn Olive Army Green"},
{134,"Pure White"},
{135,"Hot Pink"},
{136,"Salmon pink"},
{137,"Metallic Vermillion Pink"},
{138,"Orange"},
{139,"Green"},
{140,"Blue"},
{141,"Mettalic Black Blue"},
{142,"Metallic Black Purple"},
{143,"Metallic Black Red"},
{144,"hunter green"},
{145,"Metallic Purple"},
{146,"Metaillic V Dark Blue"},
{147,"MODSHOP BLACK1"},
{148,"Matte Purple"},
{149,"Matte Dark Purple"},
{150,"Metallic Lava Red"},
{151,"Matte Forest Green"},
{152,"Matte Olive Drab"},
{153,"Matte Desert Brown"},
{154,"Matte Desert Tan"},
{155,"Matte Foilage Green"},
{156,"DEFAULT ALLOY COLOR"},
{157,"Epsilon Blue"},
{158,"Pure Gold"},
{159,"Brushed Gold"},
}