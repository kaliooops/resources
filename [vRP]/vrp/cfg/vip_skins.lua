
-- this file configure the cloakrooms on the map

local cfg = {}

-- prepare surgeries customizations
local spider_male = { model = "Spider-Man2007", price = 5}
local mk47_male = { model = "MK47", price = 7}
local panter = { model = "Panter", price = 10}
local dpol = { model = "Dpool", price =  7}
local tron = { model = "TRON", price =  10}
local myers = { model = "MMyers", price =  8}
local jason = { model = "Jason", price =  5}
local harley = { model = "HarleyB", price =  5}
local spider_civil = { model = "spiderman(civilwar)", price =  7}
local deadshot = { model = "Deadshot", price =  5}
local wonder = { model = "Wonder", price =  7}
local flash = { model = "Flash", price =  10}
local capitan_america = { model = "ca", price =  10}
local spiderman2002 = { model = "Spider-Man2002", price =  5}
local docstm = { model = "Docstm", price =  7}
local cwArrowS4 = { model = "CWArrowS4", price =  7}
local light = { model = "cwlightning", price =  10}
local lunvas = { model = "lunav", price =  10}
local jack = { model = "JackSparrow", price =  10}
local acuarno = { model = "acuarno", price =  10}
local racer = { model = "racer", price =  10}
local liomesi = { model = "LioMessiCiv", price =  5}
local dearthvader = { model = "DarthVader", price =  10}
local batmanelite = { model = "BatmanElite", price =  10}
local ebony = { model = "EbonyMaw", price =  5}
local flash2 = { model = "flash52", price =  10}
local cyborg = { model = "CyborgElite", price =  10}
local ezio = { model = "ACUEzio", price =  10}
local predatorbatman = { model = "PredatorBatmanElite", price =  10}
local proxima = { model = "Proxima", price =  5}
local starlord = { model = "starlord", price =  10}
local cull = { model = "CullObsidian", price =  10}
local Aquaman = { model = "Aquaman", price =  9}
local KingThor = { model = "King_Thor", price =  8}
local Onyx = { model = "Onyx", price =  9}
local jug = { model = "jug", price =  5}
local StandardNanosuit = { model = "StandardNanosuit", price =  10}
local hela = { model = "hela", price =  10}
local Cindy = { model = "cindy", price =  8}
local WarMachinemk3 = { model = "WarMachinemk3", price =  8}
local WMmk2 = { model = "WMmk2", price =  8}
local visual = { model = "V", price =  8}
local NightWing = { model = "nightwing", price =  5}
local jacob = { model = "Jacob", price =  10}
local templar = { model = "11thTemplar", price =  7}
local soulst = { model = "SoulstealerDoctorFateUpdated", price =  5}
local soulste = { model = "SoulstealerDoctorFateElite", price =  6}
local arnoparty = { model = "ArnoParty", price =  5}
local DeadPoolhd = { model = "DeadPool", price =  10}
local reverseflash = { model = "ReverseFlashUpdated", price =  8}
local reverseflashelite = { model = "ReverseFlashElite", price =  10}
local tmwf = { model = "tmwf", price =  5}
local soldier76 = { model = "soldier76", price =  5}
local MK50 = { model = "MK50", price =  5}
local SupermanElite = { model = "SupermanElite", price =  7}
local ArmoredSupermanElite = { model = "ArmoredSupermanElite", price =  7}
local starfire = { model = "starfire", price =  5}
local Grootz = { model = "Grootz", price =  15}


cfg.vip_skins = {
  ["V.I.P"] = {
		_config = { permissions = {"vip.skins"} },
		["Spider Man"] = spider_male,
		["Iron Man MK47"] = mk47_male,
		[" Panther"] = panter,
		["Dead pool"] = dpol,
		["Tron"] = tron,
		["Myers"] = myers,
		["Jason"] =jason,
		["Harley Queen"] = harley,
		["Spider CivilWar"] = spider_civil,
		["DeadShot"] = deadshot,
		["Wonder Woman"] = wonder,
		["Flash"] = flash,
		["Spiderman 2002"] = spiderman2002,
		["Doctor Strange"] = docstm,
		["Capitan America"] = capitan_america,
		["ArrowS4"] = cwArrowS4,
		["Lightning"] = light,
		["LunaV"] = lunvas,
		["JackSparrow"] = jack,
		[" Racer"] = racer,
		["Assassin Creed"] = acuarno,
		["Lio Messi Civ"] = liomesi,
		["DarthVader"] = dearthvader,
		["BatmanElite"] = batmanelite,
		["EbonyMaw"] = ebony,
		["Flash Electro"] = flash2,
		["CyborgElite"] = cyborg,
		["Assassin Creed 2"] = ezio,
		["PredatorBatmanElite"] = predatorbatman,
		["Proxima"] = proxima,
		["StarLord"] = starlord,
		["Aquaman"] = Aquaman,
		["King_Thor"] = KingThor,
		["Onyx"] = Onyx,
		["Jug"] = jug,
		["Crysis 3"] = StandardNanosuit,
		["Hela"] = hela,
		["Cindy"] = Cindy,
		["Iron Man Mk3"] = WarMachinemk3,
		["Iron Man Mk2"] = WMmk2,
		["Cyber Female"] = V,
		["Night Wing"] = NightWing,
		["Jacob"] = jacob,
		["Templar"] = templar,
		["Soul Stealer Doctor"] = soulst,
		["Soul Stealer Elite"] = soulste,
		["Arno Party"] = arnoparty,
		["DeadPool HD"] = DeadPoolhd,
		["Reverse Flash Default"] = reverseflash,
		["Reverse Flash Elite"] = reverseflashelite,
		["Banderola neagra"] = tmwf,
		["Soldier 76"] = soldier76,
		["Superman Elite"] = SupermanElite,
		["Armored Superman Elite"] = ArmoredSupermanElite,
		["Starfire"] = starfire,
		["Big Groot"] = Grootz
	}
}

cfg.vipskins = {
	{"V.I.P", -321.46612548828,220.11378479004,87.884178161621}
}

return cfg
