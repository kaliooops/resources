
local cfg = {}

-- PCs positions
cfg.pcs = {
	{1853.21, 3689.51, 34.2671},
	{459.76513671875,-988.984375,24.914863586426},
 	{-1097.0952148438,-818.59350585938,19.036138534546},
  	{-448.97076416016,6012.4208984375,31.71639251709}
}

-- vehicle tracking configuration
cfg.trackveh = {
  	min_time = 300, -- min time in seconds
  	max_time = 600, -- max time in seconds
  	service = "Politia Romana", -- service to alert when the tracking is successful
}

-- wanted display 
cfg.wanted = {
  	blipid = 458,
  	blipcolor = 38,
  	service = "Politia Romana",
}

-- illegal items (seize)
cfg.seizable_items = {
	"lemonhaze",
	"kush",
	"purplehaze",
	"mdma",
	"speed",
	"cristal",
	"scoobysnaks",
	"bonzai",
	"jamaika",
	"wbody|WEAPON_MG",
	"wbody|WEAPON_SPECIALCARBINE",
	"wammo|WEAPON_MG",
	"wammo|WEAPON_SPECIALCARBINE",
	"dirty_money",
	"tramadol",
	"wbody|WEAPON_DAGGER",
	"Armura",
	"wbody|WEAPON_BAT",
	"wbody|WEAPON_KNUCKLE",
	"wbody|WEAPON_MACHETE",
	"wbody|WEAPON_PISTOL50",
	"wbody|WEAPON_SWITCHBLADE",
	"wbody|WEAPON_PISTOL",
	"wbody|WEAPON_COMBATPISTOL",
	"wbody|WEAPON_SNSPISTOL",
	"wbody|WEAPON_VINTAGEPISTOL",
	"wbody|WEAPON_REVOLVER",
	"wbody|WEAPON_DOUBLEACTION",
	"wbody|WEAPON_MICROSMG",
	"wbody|WEAPON_SMG",
	"wbody|WEAPON_ASSAULTSMG",
	"wbody|WEAPON_CARBINERIFLE",
	"wbody|WEAPON_ASSAULTRIFLE",
	"wbody|WEAPON_GUSENBERG",
	"wammo|WEAPON_PISTOL",
	"wammo|WEAPON_PISTOL50",
	"wammo|WEAPON_COMBATPISTOL",
	"wammo|WEAPON_SNSPISTOL",
	"wammo|WEAPON_VINTAGEPISTOL",
	"wammo|WEAPON_REVOLVER",
	"wammo|WEAPON_MICROSMG",
	"wammo|WEAPON_SMG",
	"wammo|WEAPON_ASSAULTSMG",
	"wammo|WEAPON_CARBINERIFLE",
	"wammo|WEAPON_ASSAULTRIFLE",
	"wammo|WEAPON_GUSENBERG",
	"wammo|WEAPON_DOUBLEACTION",
	"wammo|WEAPON_RPG",
	"wbody|WEAPON_RPG",
	"explozibil"
}

cfg.seizable_weapons = {
	"WEAPON_APPISTOL",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTSMG",
	"WEAPON_CARBINERIFLE",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_COMBATPISTOL",
	"WEAPON_FLARE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_SMG",
	"WEAPON_NIGHTSTICK",
	"WEAPON_PETROLCAN",
	"WEAPON_MICROSMG",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_MG",
	"WEAPON_AIRSTRIKE_ROCKET",
	"WEAPON_KNIFE",
	"WEAPON_MG",
	"WEAPON_BAT",
	"WEAPON_STICKYBOMB",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_PISTOL",
	"WEAPON_ASSAULTSMG",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_MINIGUN",
	"WEAPON_GRENADE",
	"WEAPON_BZGAS",
	"AMMO_PISTOL",
	"AMMO_MG",
	"AMMO_SMG",
	"AMMO_RIFLE",
	"AMMO_SHOTGUN",
	"AMMO_SNIPER",
	"AMMO_SNIPER_REMOTE",
	"AMMO_PETROLCAN",
	"AMMO_MINIGUN",
	"AMMO_GRENADELAUNCHER",
	"AMMO_STICKYBOMB",
	"AMMO_SMOKEGRENADE",
	"AMMO_BZGAS",
	"AMMO_FLARE",
	"AMMO_MOLOTOV"
}

-- fines
-- map of name -> money
cfg.fines = {
  	[",Nuditate:"] = 5000,
  	[",Burnout / drift:"] = 2500,
  	[",Viteza:"] = 15000,
  	[",Parcare neregulamentara:"] = 2500,
  	[",Conducere imprudenta:"] = 2500,
  	[",Geamuri Fumurii:"] = 2500,
  	[",Neoane:"] = 2500,
  	[",Blocarea soselei:"] = 2500,
  	[",Traversare ilegala:"] = 2500,
  	[",Nerespectarea culorii rosie:"] = 2500,
  	[",Deranjarea linistii publice:"] = 2500,
  	[",Fuga de politie:"] = 2500,
  	[",Vandalism:"] = 2500,
  	[",Furt auto:"] = 7500,
  	[",Abuzul liniei de urgenta:"] = 2500,
  	[",Conducerea fara permis:"] = 2500,
  	[",Esecul identificarii:"] = 2500,
  	[",Conducerea unui autovehicul neinmatriculat:"] = 2500,
  	[",Fara asigurare:"] = 5000,
  	[",Posesie roti antiglont:"] = 7500,
  	[".Crima:"] = 5000,
  	[".Tentativa de omor:"] = 5000,
  	[".Asalt cu o arma mortala:"] = 5000,
  	[".Posesia unei arme de calibru mare:"] = 5000,
  	[".Posesia unei arme de foc:"] = 3000,
  	[".Posesia unei arme albe:"] = 2000,
  	["/Tentativa unui jaf la banca:"] = 5000,
  	["/Jefuirea unei banci:"] = 10000,
  	["/Jefuirea unui civil:"] = 7500,
  	["/Rapirea unui civil:"] = 7500,
  	["/Rapirea unui om al legii:"] = 20000,
  	["?Folosirea claxonului intr-un mod nejustificat:"] = 2000,
  	["?Neconformarea oridinelor:"] = 3000,
  	["?Oferire mita:"] = 5000,
  	["?Rezistenta la arest:"] = 3500,
  	["?Ofensarea unui om al legii:"] = 3500
}

return cfg
