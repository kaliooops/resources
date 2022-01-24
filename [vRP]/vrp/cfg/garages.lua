local cfg = {}
-- define garage types with their associated vehicles
-- (vehicle list: https://wiki.fivem.net/wiki/Vehicles)

-- each garage type is an associated list of veh_name/veh_definition 
-- they need a _config property to define the blip and the vehicle type for the garage (each vtype allow one vehicle to be spawned at a time, the default vtype is "default")
-- this is used to let the player spawn a boat AND a car at the same time for example, and only despawn it in the correct garage
-- _config: vtype, blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.sell_factor = 0.5 -- sell for 50% of the original price

cfg.garage_types = {
  	["Barci"] = {
    _config = {vtype="boat",blipid=427,blipcolor=28,icon=35,iconColor={41,234,23},hasbuy=true,tosell=true},
    ["dinghy"] = {"Barca",350, "Barca ta favorita!"},
	["seashark"] = {"Jett Sky",200, "Distractie pe val!"}
	},
	  


  	["Civil"] = {
<<<<<<< HEAD
		_config = {vtype="car",blipid=357,blipcolor=64,blipcolor=2},
=======
		_config = {vtype="car",blipid=357,blipcolor=64,blipcolor=2},icon=36,iconColor={217,2,125},
>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657
		["ocnetrongt"] = {"Audi E-trone GT",60000, ""}, 
		["aerox155"] = {"AeroX 155",230, ""}, 
		["cliov6"] = {"Clio V6",230, ""}, 
		["206lo"] = {"Peugeot 206",300, ""}, 
		["m2"] = {"BMW M2",30000, ""}, 
		["bmw1"] = {"BMW Seria 1",10000, ""}, 
		["Imola"] = {"Pagani Imola", 1, ""},
		["rmodgt63"] = {"Mercedes AMG GT63",60000, ""}, 
		["scijo"] = {"Volkswagen Scirocco",2000, ""}, 
		["demon"] = {"Dodge Demon SRT",40000, ""}, 
		["skyline"] = {"Nissan Skyline R34",30000, ""},
		["toysuya"] = {"Toyota Supra",75000, ""}, 
		["lanex400"] = {"Lancer X400",17000, ""}, 
		["camaro90"] = {"Camaro '90",6000, ""}, 
		["cayman16"] = {"Porsche Cayman",22000, ""}, 
		["africat"] = {"Honda CFR1000L",8000, ""}, 
		["m135i"] = {"BMW Seria 1",12000,""},
		["bmws"] = {"BMW S1000 RR",10000, ""}, 
		["rmodlp770"] = {"Lamborghini Centenario",250000, ""}, 
		["rm3e36"] = {"e36 StreetCustom",15000, ""}, 

		---- preturile sunt facute pana aici
		["c63s"] = {"Mercedes C63 Coupe",200000, ""},
		["rmodmi8lb"] = {"BMW I8",200000, ""},
		["rmodx6"] = {"BMW X6M Breithaus",200000, ""},
		["benzsl63"] = {"Mercedes Benz SL63",200000, ""},
		["g63amg6x6"] = {"G63 AMG 6x6",200000, ""},
		["lp700"] = {"Lamborghini Aventador",200000, ""},
		["rmodveneno"] = {"Lamborghini Veneno",200000, ""},
		["2013rs7"] = {"Audi RS7 ABT",200000, ""},
		["rs6avant20"] = {"Audi RS6 C8",200000, ""},
		["audquattros"] = {"Audi Quattro",200000, ""},
		["zx10r"] = {"Kawasaki Ninja",200000, ""},
		["audsq517"] = {"Audi SQ5",200000, ""},
		["mgt"] = {"Ford Mustang 2016",200000, ""},
		["golfmk6"] = {"Volkswagen Golf Mk6",200000, ""},
		["rmodm4gts"] = {"BMW M4 GTS", 20000, ""},
		["lb750sv"] = {"Aventador lp750sv", 20000, ""},
		["rmodlp570"] = {"Gallardo lp570", 20000, ""},
		["rmodfordgt"] = {"Mustang GT 2011", 20000, ""},
		["rmodgtr"] = {"Nissan GT-R", 20000, ""},
		["rmodm4"] = {"BMW M4", 20000, ""},
		["rmodskyline"] = {"Nissan GT-R Nismo", 20000, ""},
		["m1procar"] = {"BMW M1 ProCar", 20000, ""},
		["r8lms"] = {"Audi R8 LMS", 20000, ""},
		["bugatti"] = {"Bugatti Veyron", 2000, ""},
		["bati"] = {"Yamaha XJ6", 2000, ""},
		["polo2018"] = {"Polo Craciun", 2000, ""},
		["bmwg20"] = {"Bmw G20 Hamann", 0, ""},
		["s500w222"] = {"Mercedes S500 w222",35000,""},
		["baller2"] = {"BMW x6m 50i",0,""},
		["seatl"] = {"Seat Leon",250,""},
		["sjbenz250"] = {"Mercedes Cla250",15000,""},
		["scaldarsi"] = {"Maybach Emperor", 0, ""},
		["mansrr"] = {"Range Rover Vogue",0,""},
		["wald2018"] = {"Lexus LX570",0,""},
		["610DTM"] = {"Kboom Lambo",0, ""},
		["mbbs20"] = {"Kboom Mercedes",0, ""},


		--------------New cars
		["divo"] = {"Bugatti Divo", 2000, ""},
		["ram2500"] = {"Dodge Ram", 2000, ""},
		["trx"] = {"Dodge Ram TRX", 2000, ""},
		["x5e53"] = {"BMW X5 e53", 2000, ""},
		["bmwe65"] = {"BMW e65", 2000, ""},
		["g65amg"] = {"Mercedes G65 AMG", 2000, ""},
		["e34"] = {"BMW E34", 2000, ""},
		["m3e46"] = {"BMW M3 E46", 2000, ""},
		["x6m"] = {"BMW X6", 2000, ""},
		["brabus700"] = {"Brabus 700", 2000, ""},
		["mlbrabus"] = {"Brabus ML", 2000, ""},
		["2019chiron"] = {"Bugatti Chiron 2019", 2000, ""},
		["16charger"] = {"Dodge Charger 2016", 2000, ""},
		["1016urus"] = {"Lamborghini Urus TopCar", 2000, ""},
		["c63w205"] = {"Mercedes C63 Coupe", 2000, ""},
		["wraith19"] = {"Rolls-Royce Wraith", 250000, ""},

		---Motoare noi
		["xre300"] = {"Honda XRE 300", 2000, ""},
		["r11998"] = {"Yamaha R1", 2000, ""},
		["rrphantom"] = {"Rolce Roys Phantom", 200000,""},

		----Showroom cu Diamante
		["chargerf8"] = {"Dodge Charger Overpower", 2000, ""},
		["720s"] = {"McLaren 720s", 2000, ""},
		["gt63s"] = {"gt63s", 2000, ""},
		["bmwg20"] = {"BMW G20", 2000, ""},
		["rc16"] = {"RC16", 2000, ""},
	},
	
	---------------[ VIP ]------------------------------[ VIP ]------------------------------[ VIP ]---------------
	 ["Sponsor"] = {
	_config = {vtype="car",blipid=410,blipcolor=26, sponsor=4, hasbuy=true,tosell=true, iconColor = {0,255,0}},
	  ["yaluxe"] = {"Yacht Sponsor", 0, ""},
	 },
	 

	["VIP4"] = {
		_config = {vtype="car",blipid=56,blipcolor=5,icon=36, hasbuy=true,tosell=true,iconColor={0, 151, 255},vip=4},
		["bs17"] = {"BMW S 2017", 0,""},
		["nightblade2"] = {"NightBlade", 0,""},
		["r6"] = {"Kawasaki R6", 0,""},
		["c63w205"] = {"Mercedes C63 W205", 0,""},
		["i8"] = {"BMW I8", 0, ""},
		["17m760i"] = {"BMW M760i", 0, ""},
		["cls2015"] = {"Mercedes CLS", 0, ""},
		["macla"] = {"Mercedes Macla", 0, ""},
		["brabus850"] = {"Brabus 850", 0, ""},
		["gle450"] = {"Mercedes GLE", 0, ""},
		["2019chiron"] = {"Bugatti Chiron", 0,""},
		["vip8"] = {"Dodge Viper", 0, ""},
		["ghis2"] = {"Maseratti Ghibili", 0, ""},
		["mlnovitec"] = {"Maseratti Levante", 0, ""},
		["levante"] = {"Maseratti Levante", 0, ""},
		["mcst"] = {"McLaren Speedtail", 0, ""},
		["ben17"] = {"Bentley Supersport", 0, ""},
  	},
  	["VIP3"] = {
		_config = {vtype="car",blipid=56,blipcolor=1,icon=36, hasbuy=true,tosell=true,iconColor={255, 178, 0},vip=3},
	    ["c63w205"] = {"Mercedes C63 W205", 0,""},
		["i8"] = {"BMW I8", 0, ""},
		["17m760i"] = {"BMW M760i", 0, ""},
		["cls2015"] = {"Mercedes CLS", 0, ""},
		["macla"] = {"Mercedes Macla", 0, ""},
		["brabus850"] = {"Brabus 850", 0, ""},
		["gle450"] = {"Mercedes GLE", 0, ""},
		["2019chiron"] = {"Bugatti Chiron", 0,""},
		["vip8"] = {"Dodge Viper", 0, ""},
		["ghis2"] = {"Maseratti Ghibili", 0, ""},
		["mlnovitec"] = {"Maseratti Levante", 0, ""},
		["levante"] = {"Maseratti Levante", 0, ""},
		["mcst"] = {"McLaren Speedtail", 0, ""},
		["ben17"] = {"Bentley Supersport", 0, ""},
   },
   ["VIP2"] = {
    _config = {vtype="car",blipid=56,blipcolor=26,icon=36, hasbuy=true,tosell=true,iconColor={191, 191, 191},vip=2},
	["c63w205"] = {"Mercedes C63 W205", 0,""},
	["i8"] = {"BMW I8", 0, ""},
	["17m760i"] = {"BMW M760i", 0, ""},
	["cls2015"] = {"Mercedes CLS", 0, ""},
	["macla"] = {"Mercedes Macla", 0, ""},
	["brabus850"] = {"Brabus 850", 0, ""},
	["ben17"] = {"Bentley Supersport", 0, ""},
	["gle450"] = {"Mercedes GLE", 0, ""},
    },
  	["VIP1"] = {
    	_config = {vtype="car",blipid=56,blipcolor=26,icon=36, hasbuy=true,tosell=true,iconColor={178, 140, 75},vip=1},
		["i8"] = {"BMW I8", 0, ""},
		["17m760i"] = {"BMW M760i", 0, ""},
		["cls2015"] = {"Mercedes CLS", 0, ""},
		["macla"] = {"Mercedes Macla", 0, ""},
    },
	---------------[ VIP ]------------------------------[ VIP ]------------------------------[ VIP ]---------------

	---------------[ MAFII ]------------------------------[ MAFII ]------------------------------[ MAFII ]---------------

	["Politia Romana - Elicopter"] = {
		_config = {vtype="lopitie",blipcolor=40,icon=36, iconColor={23, 41, 234},faction="Politia Romana", hasbuy = true, tosell = false},
		["supervolito"] = {"Elicopter", 0,""}
	},

	["Politia Romana"] = {
		_config = {vtype="lopitie", blipid=56, blipcolor=38, icon=36, iconColor={23, 41, 234}, faction = "Politia Romana", hasbuy = true},
		["arteonpolitie"] = {"Arteon Politie", 0,""},
		["dusterpn"] = {"Duster Politie", 0,""},
		["loganpolitie"] = {"Logan Politie", 0, ""},
		["pd_escalader"] = {"Escalade", 0, ""},
		["polp1"] = {"McLaren Senna", 0, ""},
		["wmfenyrcop"] = {"Fenyr Politie", 0, ""},  
		["um18durango"] = {"Dodge Durango Nemarcat", 0,""},
		["fbi"] = {"VW Passat Nemarcat", 0,""},
		["um16fpiu"] = {"Ford police interceptor", 0,""},     
		["polchiron"] = {"Chiron Politie",0,""},
		["polgs350"] = {"Lexus Politie",0,""},
		["polopolitie"] = {"Lexus Politie",0,""},
		["SPC2"] = {"Interceptor Politie",0,""},
	},
	  
	["SMURD"] = {
		_config = {vtype="smurd",blipid=50,blipcolor=3,icon=36,iconColor={255,0,0},faction="Smurd", hasbuy = true, tosell = false},
		["ambulance"] = {"Ambulanta Mercedes",0, "Smurd"},
		["insurgent2"] = {"Ambulanta de Teren",0, "Smurd"},	
	},
	["Taxi"] = {
		_config = {vtype="car",blipid=198,blipcolor=5,hasbuy=true,faction="Taxi"},
		["taxi"] = {"Masina Taxi",0, "Masina Taxi"}
	  },
	---------------[ MAFII ]------------------------------[ MAFII ]------------------------------[ MAFII ]---------------

	["KMN Gang"] = {
		_config = {vtype="car", hasbuy = true, faction="KMN Gang", tosell=true, tosell = true, iconColor = {0,255,0}},
		["lanex400"] = {"Mitsubishi Lancer X",0, ""},
    	["rmodx6"] = {"BMW X6 Breithaus",0, ""},
		["brabus700"] = {"Brabus 6x6", 0, ""},
	},

	["Groove Street"] = {
		_config = {vtype="car", hasbuy = true, faction="Groove Street", tosell=true, tosell = true, iconColor = {0,255,0}},
		["lanex400"] = {"Mitsubishi Lancer X",0, ""},
    	["rmodx6"] = {"BMW X6 Breithaus",0, ""},
		["brabus700"] = {"Brabus 6x6", 0, ""},
	},
	["Triadele"] = {
		_config = {vtype="car", hasbuy = true, faction="Triadele", tosell=true, tosell = true, iconColor = {0,255,0}},
		["lanex400"] = {"Mitsubishi Lancer X",0, ""},
    	["rmodx6"] = {"BMW X6 Breithaus",0, ""},
		["GODzMANURUS"] = {"LV Urus",0, ""},
	},

<<<<<<< HEAD
=======
	["Bloods"] = {
		_config = {vtype="car", hasbuy = true,icon=36, faction="Bloods", tosell=true, tosell = true, iconColor = {255,0,0}},
		["lanex400"] = {"Mitsubishi Lancer X",0, ""},
    	["rmodx6"] = {"BMW X6 Breithaus",0, ""},
		["rmodgt63"] = {"AMG GT63",0, ""},
	},

>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657
	["No Mercy"] = {
		_config = {vtype="car", hasbuy = true, faction="No Mercy", tosell=true, tosell = true, iconColor = {0,255,0}},
		["lanex400"] = {"Mitsubishi Lancer X",0, ""},
    	["rmodx6"] = {"BMW X6 Breithaus",0, ""},
		["dominator"] = {"Mustang No Mercy",0, ""},
	},


	["Y.A.D"] = {
		_config = {vtype="car", hasbuy = true, faction="Y.A.D", tosell=true, tosell = true, iconColor = {0,255,0}},
		["lanex400"] = {"Mitsubishi Lancer X",0, ""},
    	["x6m"] = {"BMW X6 Breithaus",0, ""},
		["dominator"] = {"Mustang Y.A.D",0,""}
	},

	["Personal"] = {
		_config = {vtype="car"},
		["ocnetrongt"] = {"Audi E-trone GT",200000, ""}, 
		["aerox155"] = {"AeroX 155",200000, ""}, 
		["cliov6"] = {"Clio V6",200000, ""}, 
		["206lo"] = {"Peugeot 206",200000, ""}, 
		["m2"] = {"BMW M2",200000, ""}, 
		["rmodm4gt"] = {"BMW M4 GT",200000, ""}, 
		["rmodgt63"] = {"Mercedes AMG GT63",200000, ""}, 
		["scijo"] = {"Volkswagen Scirocco",200000, ""}, 
		["demon"] = {"Dodge Demon SRT",200000, ""}, 
		["skyline"] = {"Nissan Skyline R34",200000, ""},
		["toysuya"] = {"Toyota Supra",200000, ""}, 
		["lanex400"] = {"Lancer X400",200000, ""}, 
		["camaro90"] = {"Camaro '90",200000, ""}, 
		["cayman16"] = {"Porsche Cayman",200000, ""}, 
		["africat"] = {"Honda CFR1000L",200000, ""}, 
		["bmws"] = {"BMW S1000 RR",200000, ""}, 
		["rmodlp770"] = {"Lamborghini Centenario",200000, ""}, 
		["rm3e36"] = {"e36 StreetCustom",200000, ""}, 
		["c63s"] = {"Mercedes C63 Coupe",200000, ""},
		["rmodmi8lb"] = {"BMW I8",200000, ""},
		["rmodx6"] = {"BMW X6M Breithaus",200000, ""},
		["benzsl63"] = {"Mercedes Benz SL63",200000, ""},
		["g63amg6x6"] = {"G63 AMG 6x6",200000, ""},
		["lp700"] = {"Lamborghini Aventador",200000, ""},
		["rmodveneno"] = {"Lamborghini Veneno",200000, ""},
		["2013rs7"] = {"Audi RS7 ABT",200000, ""},
		["rs6avant20"] = {"Audi RS6 C8",200000, ""},
		["audquattros"] = {"Audi Quattro",200000, ""},
		["zx10r"] = {"Kawasaki Ninja",200000, ""},
		["audsq517"] = {"Audi SQ5",200000, ""},
		["mgt"] = {"Ford Mustang 2016",200000, ""},
		["golfmk6"] = {"Volkswagen Golf Mk6",200000, ""},
		["rmodm4gts"] = {"BMW M4 GTS", 20000, ""},
		["lb750sv"] = {"Aventador lp750sv", 20000, ""},
		["rmodlp570"] = {"Gallardo lp570", 20000, ""},
		["rmodfordgt"] = {"Mustang GT 2011", 20000, ""},
		["rmodgtr"] = {"Nissan GT-R", 20000, ""},
		["rmodm4"] = {"BMW M4", 20000, ""},
		["rmodskyline"] = {"Nissan GT-R Nismo", 20000, ""},
		["m1procar"] = {"BMW M1 ProCar", 20000, ""},
		["r8lms"] = {"Audi R8 LMS", 20000, ""},
		["bugatti"] = {"Bugatti Veyron", 2000, ""},
		["bati"] = {"Yamaha XJ6", 2000, ""},

		--------------New cars
		["divo"] = {"Bugatti Divo", 2000, ""},
		["ram2500"] = {"Dodge Ram", 2000, ""},
		["trx"] = {"Dodge Ram TRX", 2000, ""},
		["x5e53"] = {"BMW X5 e53", 2000, ""},
		["bmwe65"] = {"BMW e65", 2000, ""},
		["g65amg"] = {"Mercedes G65 AMG", 2000, ""},
		["e34"] = {"BMW E34", 2000, ""},
		["m3e46"] = {"BMW M3 E46", 2000, ""},
		["x6m"] = {"BMW X6", 2000, ""},
		["brabus700"] = {"Brabus 700", 2000, ""},
		["mlbrabus"] = {"Brabus ML", 2000, ""},
		["2019chiron"] = {"2019chiron", 2000, ""},
		["16charger"] = {"Dodge Charger 2016", 2000, ""},
		["urus2018"] = {"Lamborghini Urus 2018", 2000, ""},
		["c63w205"] = {"Mercedes C63 Coupe", 2000, ""},

		---Motoare noi
		["xre300"] = {"Honda XRE 300", 2000, ""},
		["r11998"] = {"Yamaha R1", 2000, ""},

		----Showroom cu Diamante
		["chargerf8"] = {"Dodge Charger Overpower", 2000, ""},
		["720s"] = {"McLaren 720s", 2000, ""},
		["gt63s"] = {"gt63s", 2000, ""},
		["bmwg20"] = {"BMW G20", 2000, ""},
		["rc16"] = {"RC16", 2000, ""},
	},



}

cfg.garages = {

	{"Civil", 375.57852172852,-952.65881347656,29.303903579712},
	{"Civil", -1389.433959961,54.771816253662,53.614196777344},
	{"Civil", -1391.0025634766,75.92488861084,53.713275909424},
	{"Civil", -76.366134643555,-1113.4710693359,25.846193313599},
	{"Civil", -460.65780639648,-272.83093261719,35.779720306396},
	{"Civil", -515.75280761719,-294.91445922852,35.228485107422},
	{"Civil", -1141.4610595703,-751.74798583984,19.337697982788},
    {"Civil", -1428.6118164062,-580.90869140625,30.586967468262},
	{"Civil", 234.18142700196,-805.33782958984,30.4269657135},
	{"Civil", 216.70803833008,-798.72082519532,30.793273925782},
    {"Civil", -1170.982055664,-880.27178955078,14.11164188385},
    {"Civil", 58.290782928466,6469.6743164062,31.425275802612},
    {"Civil", -1194.3387451172,-1499.53125,4.3698906898498},
	{"Civil", 898.25299072266,-8.0972652435302,78.76400756836},
	{"Civil", 1403.3891601562,-2066.2561035156,51.998558044434},
	{"Civil", 819.5590209961,-1614.3935546875,31.662776947022},
	{"Civil", 1885.314453125,3720.2377929688,32.857303619384},
    {"Civil", -2208.5334472656,4246.4555664062,47.586261749268},
    {"Civil", -3088.9167480468,340.89965820312,7.4056878089904},
    {"Civil", -334.51531982422,-750.99737548828,33.968509674072},
    {"Civil", 132.3705291748,-1081.783569336,29.193662643432},
    {"Civil", -1513.7176513672,87.345321655274,55.995357513428},
    {"Civil", 1209.0102539062,2643.6870117188,37.829063415528},
	{"Civil", 312.71334838868,-1373.949584961,31.833408355712},
	{"Civil", 281.92529296875,-146.60832214356,65.08748626709},
	{"Civil", -1899.1114501953,2036.3107910156,140.74145507812},
	{"Barci", -1954.9178466797,-765.73950195313,0.1003846898675},
	{"VIP1", -526.35528564454,-268.17568969726,35.270038604736},
	{"VIP1", 880.70782470704,-18.447584152222,78.764114379882},
	{"VIP1", -1404.0068359375,61.781967163086,53.057273864746},
	{"VIP2", -11.361285209656,-1100.771484375,26.672071456909},
	{"VIP2", 879.01300048828,-21.424383163452,78.764114379882},
	{"VIP2", -1403.6710205078,56.577396392822,53.07308959961},
	{"VIP2", -528.77465820312,-269.29467773438,35.243022918702},
	{"VIP3", -12.715141296387,-1104.2685546875,26.672071456909},
	{"VIP3", 877.2241821289,-24.860038757324,78.764114379882},
	{"VIP3", -1402.9387207032,51.35557937622,53.10506439209},
	{"VIP3", -531.5376586914,-270.37728881836,35.214950561524},
	{"VIP4", -14.845561981201,-1109.0201416016,26.672071456909},
	{"VIP4", -534.88916015625,-271.34869384766,35.182270050048},
	{"VIP4", 875.6845703125,-27.366172790528,78.764114379882},
	{"VIP4", -1402.2899169922,46.118141174316,53.104801177978},
	{"VIP4", -1564.9090576172,-56.107627868652,56.492191314697},
	{"VIP1", 226.64241027832,-854.25366210938,29.955741882324},
	{"VIP2", 222.16816711426,-852.75659179688,30.067743301392},
	{"VIP3", 217.17408752442,-851.30432128906,30.191707611084},
	{"VIP4", 234.36589050292,-857.3080444336,29.760124206542},
	--Mafii 

	{"Groove Street", 109.73039245605,-1946.0203857422,20.783407211304},
	-- {"Crips",-246.86389160156,492.12530517578,125.94523620605},
	{"Personal", -1546.5185546875,888.16491699218,181.3410949707},
	{"Y.A.D", -1146.9575195312,-1544.7224121094,4.3218159675598},
	{"No Mercy", 693.12426757812,-1005.3084716796,22.889644622802},
	{"Triadele", -670.97570800782,910.7855834961,230.29754638672},
<<<<<<< HEAD
=======
	{"Bloods", -1562.7171630859,-391.04425048828,41.981338500977},
>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657


	----Lege
	{"Politia Romana", 453.38272094726,-1016.3025512696,28.45029258728},
	{"Jandarmerie", 453.75817871094,-1022.5184936524,28.426095962524}, 
	{"Politia Romana - Elicopter", 449.32089233398,-980.9716796875,43.69169998169}, 
	{"Mecanic", 497.976, -1334.08, 29.3304},
	{"Tirist", 57.033767700195,-2455.9523925781,6.0044388771057},  
	{"SRI", 155.25375366211,-738.04028320313,33.133323669434},    
	{"SRI - Elicopter", 202.20816040039,-719.11120605469,47.076972961426},
	{"Taxi", 918.765625,-167.1266784668,74.649322509766},
	{"SMURD", -264.513, 6340.98, 32.4262},
	{"SMURD", 329.529, -1469.79, 29.7358},
	{"SMURD", 1805.98, 3681.34, 34.2242},
	{"SMURD", 291.22592163086,-609.42211914062,43.364826202392}

}

return cfg
