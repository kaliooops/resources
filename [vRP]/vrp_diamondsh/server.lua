local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","esk_diamondsh")
vRPCdiamondsh = Tunnel.getInterface("esk_diamondsh","esk_diamondsh")
vRPdiamondsh = {}
Tunnel.bindInterface("esk_diamondsh",vRPdiamondsh)
Proxy.addInterface("esk_diamondsh",vRPdiamondsh)

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
        {numeVehicul = "gle21",price = 250, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "GLE 63S 2021", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
        {numeVehicul = "22g63",price = 180, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "G63 AMG 2022", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
    },
    [7] = {
        tablename = 'Nissan',
        {numeVehicul = "gtr50",price = 250, speed = 40, acceleration = 53, brakes = 60, hp = 100,numemasina = "GT-R50 2021", maxspeed= 200, maxspeedbar = 60, tip = 'Premium'},
    }, 
}

function vRPdiamondsh.cumparaMasina(model,pret,selectie,categorie,tuning)
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
                    if vRP.getKRCoins({user_id}) > pret then
                        vRP.setKRCoins({user_id, vRP.getKRCoins({user_id}) - pret})
    

                            exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,upgrades,vehicle_plate) VALUES(@user_id,@vehicle,@upgrades,@vehicle_plate)", {
                                ['@user_id'] = user_id,
                                ['@vehicle'] = model,
                                ['@upgrades'] = json.encode(tuning),
                                ['@vehicle_plate'] = thePlate
                            }, function (rows) end)
                            
                            vRPclient.notify(player, {"Ai platit ~g~Cristale "..pret.."~w~ pentru acest vehicul!\nDu-te la un garaj pentru a-l scoate!"})
                    else
                        vRPclient.notify(player, {"~r~Nu ai suficiente Cristale"})
                    end
                end
            end)
        else
            vRPclient.notify(player,{"Pretul acestei masini nu corespunde cu cel selectat! Contacteaza un fondator!"})
        end
    end
end