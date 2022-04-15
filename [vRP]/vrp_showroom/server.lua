local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","esk_showroom")
vRPCshowroom = Tunnel.getInterface("esk_showroom","esk_showroom")
vRPshowroom = {}
Tunnel.bindInterface("esk_showroom",vRPshowroom)
Proxy.addInterface("esk_showroom",vRPshowroom)

local prefix = {
	["AB"] = "Alba",
	["AR"] = "Arad",
	["AG"] = "Arges",
	["BC"] = "Bacau",
	["BH"] = "Bihor",
	["BN"] = "Bistrita-Nasaud",
	["BT"] = "Botosani",
	["BR"] = "Braila",
	["BV"] = "Brasov",
	["BZ"] = "Buzau",
	["CL"] = "Calarasi",
	["CS"] = "Caras-Severin",
	["CJ"] = "Cluj",
	["CT"] = "Constanta",
	["CV"] = "Covasna",
	["DB"] = "Dambovita",
	["DJ"] = "Dolj",
	["GL"] = "Galati",
	["GR"] = "Giurgiu",
	["GJ"] = "Gorj",
	["HR"] = "Harghita",
	["HD"] = "Hunedoara",
	["IL"] = "Ialomita",
	["IS"] = "Iasi",
	["IF"] = "Ilfov",
	["MM"] = "Maramures",
	["MH"] = "Mehedinti",
	["MS"] = "Mures",
	["NT"] = "Neamt",
	["OT"] = "Olt",
	["PH"] = "Prahova",
	["SJ"] = "Salaj",
	["SM"] = "Satu Mare",
	["SB"] = "Sibiu",
	["SV"] = "Suceava",
	["TR"] = "Teleorman",
	["TM"] = "Timis",
	["TL"] = "Tulcea",
	["VL"] = "Valcea",
	["VS"] = "Vaslui",
	["VN"] = "Vrancea",
	["B"] = "Bucuresti"
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
        {numeVehicul = "c63a",price = 51000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "c63 w204 amg", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "c63b",price = 107000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "c63 w204 Black Series", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "b63s",price = 200000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "c63 w204 Brabus", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "amggts2016",price = 110000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "AMG GT S 2017", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [5] = {
        tablename = 'VW',
        {numeVehicul = "scijo",price = 5500, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Scirocco 2010", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "golfgti",price = 5500, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Golf V GTI", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
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
        {numeVehicul = "s15",price = 37000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Nissan Silvia S15", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodskyline",price = 105000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "GT-R Nismo Skyline", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "370z16",price = 51000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "370Z Nismo", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [8] = {
        tablename = 'Toyota',
        {numeVehicul = "toysuya",price = 150000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Supra RaceV", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "toyotasj",price = 93999, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Land Cruiser V8 2017", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [9] = {
        tablename = 'Mitsubishi',
        {numeVehicul = "mitgalant92",price = 2900, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Mitsubishi Galant", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "lanex400",price = 37000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Lancer X 400", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [10] = {
        tablename = 'Ford',
        {numeVehicul = "mgt",price = 22000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Mustang GT 2015", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "focusrs",price = 36000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Focus RS", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "rmodfordgt",price = 25000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Mustang GT 2011", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [11] = {
        tablename = 'Chevrolet',
        {numeVehicul = "camaro90",price = 12000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Camaro '90'", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "czr1",price = 47000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Corvette ZR1", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    }, 
    [12] = {
        tablename = 'Porsche',
        {numeVehicul = "cayman16",price = 45000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Cayman '16", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "panamera17turbo",price = 200000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Panamera Turbo 17", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "pts21",price = 221000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "911 Turbo S 2021", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "pcs18",price = 66800, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Cayenne 18", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "cayenne",price = 12000, speed = 80, acceleration = 73, brakes = 70, hp = 100,numemasina = "Cayenne 16", maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
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
        {numeVehicul = "lp670sv",price = 3000000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Lamborghini Murcielago 2009" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},

    },
    [15] = {
        tablename = 'Street Illegal',
         {numeVehicul = "rm3e36",price = 32000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "E36 StreetCustom" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
         {numeVehicul = "m1procar",price = 586000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "BMW M1 ProCar" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
         {numeVehicul = "r8lms",price = 400000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Audi R8 LMS Ultra" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
         {numeVehicul = "rmodgtr",price = 125000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Nissan GT-R" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
         {numeVehicul = "lp570",price = 125000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Lambo Gallardo Spyder" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
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
    [18] = {
        tablename = 'Diverse',
        {numeVehicul = "veln",price = 31000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Hyundai Veloster N" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "300srt8",price = 28000, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "hrysler 300 SRT8" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
        {numeVehicul = "contgt13",price = 120333, speed = 70, acceleration = 55, brakes = 75, hp = 100,numemasina = "Bentley Continental" , maxspeed= 200, maxspeedbar = 91, tip = 'Premium'},
    },
    [19] = {
        tablename = 'Dube',
        {numeVehicul = "master19",price = 31000, speed = 60, acceleration = 55, brakes = 75, hp = 100,numemasina = "Renault Master 2019" , maxspeed= 175, maxspeedbar = 91, tip = 'Premium'},
    },

}

function vRPshowroom.cumparaMasina(model,pret,selectie,categorie,tuning)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})


	function findVehsIds()
		theLastID = 0
		local pvehicles = exports.ghmattimysql:executeSync("SELECT id FROM vrp_user_vehicles ORDER BY id DESC LIMIT 1")
		if #pvehicles > 0 then
			theLastID = tonumber(pvehicles[1].id)
		else
			theLastID = 0
		end
		Citizen.Wait(100)
		return theLastID
	end

	local vehID = findVehsIds()+1
	if vehID < 10 then
		vehID = "0000"..vehID
	elseif vehID <= 99 and vehID > 9 then
		vehID = "000"..vehID
	elseif vehID <= 999 and vehID > 99 then
		vehID = "00"..vehID
	elseif vehID <= 9999 and vehID > 999 then
		vehID = "0"..vehID
	elseif vehID <= 99999 and vehID > 9999 then
		vehID = vehID
	end
	
	local cityPrefix = {}
	for i, v in pairs(prefix) do
		table.insert(cityPrefix, i)
	end
	local thePlate = cityPrefix[math.random(#cityPrefix)].." "..vehID

    if vehicles[categorie][selectie].numeVehicul == model then
        if vehicles[categorie][selectie].price == pret then
            
            exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle", {['@user_id'] = user_id, ['@vehicle'] = model}, function (haveCar)
                if #haveCar > 0 then
                    vRPclient.notify(player,{"Ai deja aceasta masina!"})
                else
                    if vRP.tryFullPayment({user_id,pret}) then
    

                            exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,upgrades,vehicle_plate) VALUES(@user_id,@vehicle,@upgrades,@vehicle_plate)", {
                                ['@user_id'] = user_id,
                                ['@vehicle'] = model,
                                ['@upgrades'] = json.encode(tuning),
                                ['@vehicle_plate'] = thePlate
                            }, function (rows) end)
                            TriggerEvent("Achievements:UP_Current_Progress", user_id, "La showroom se poate cumpara un vehicul.")
                            
                            vRPclient.notify(player, {"Ai platit ~g~$"..pret.."~w~ pentru acest vehicul!\nDu-te la un garaj pentru a-l scoate!"})
                    else
                        vRPclient.notify(player, {"~r~Nu ai suficienti bani"})
                    end
                end
            end)
        else
            vRPclient.notify(player,{"Pretul acestei masini nu corespunde cu cel selectat! Contacteaza un fondator!"})
        end
    end
end