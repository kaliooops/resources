
local cfg = {}
-- list of weapons for sale
-- for the native name, see https://wiki.fivem.net/wiki/Weapons (not all of them will work, look at client/player_state.lua for the real weapon list)
-- create groups like for the garage config
-- [native_weapon_name] = {display_name,body_price,ammo_price,description}
-- ammo_price can be < 1, total price will be rounded

-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the shop)

cfg.gunshop_types = {
  

  ["Politia Romana"] = {
    _config = {blipid=110, blipcolor=74, faction = "Politia Romana"},
    ["WEAPON_PETROLCAN"] = {"Petrol",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",0,0,""},
    ["WEAPON_FLASHLIGHT"] = {"Lanternă",0,0,""},
    ["WEAPON_SMOKEGRENADE"] = {"Smoke Grenade",0,0,""},
--    ["WEAPON_FLARE"] = {"Flare",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Bulan",0,0,""},
    ["WEAPON_STUNGUN"] = {"Tazer",0,0,""},
    ["WEAPON_ASSAULTSMG"] = {"Assault SMG",0,0,""},
    ["WEAPON_CARBINERIFLE"] = {"Carbine Rifle",0,0,""}, 
    ["WEAPON_APPISTOL"] = {"APPISTOL",0,0,""},
    ["WEAPON_HEAVYSNIPER"] = {"Sniper Rifle",0,0,""},
    ["WEAPON_COMBATPISTOL"] = {"Combat Pistol",0,0,""},
    ["WEAPON_PISTOL50"] = {"Pistol .50",0,0,""}
  },

  
  ["SMURD"] = {
    _config = {blipid=446, blipcolor=74, faction = "Smurd"},
    -- ["WEAPON_PETROLCAN"] = {"Petrol",0,0,""},
  --  ["WEAPON_FLAREGUN"] = {"Flare Gun",0,0,""},
    ["WEAPON_FLASHLIGHT"] = {"Lanternă",0,0,""},
  --  ["WEAPON_FLARE"] = {"Flare",0,0,""},
    ["WEAPON_NIGHTSTICK"] = {"Bulan",0,0,""},
    ["WEAPON_STUNGUN"] = {"Tazer",0,0,""}
 },
 

  ["KMN Gang"] = {
    _config = {blipid=110, blipcolor=40, faction = "KMN Gang"},
    ["WEAPON_PETROLCAN"] = {"Petrol",0,0,""},
    ["WEAPON_PUMPSHOTGUN"] = {"Pump Shotgun",0,0,""},
    ["WEAPON_DOUBLEACTION"] = {"Double Action",0,0,""},
    ["WEAPON_CARBINERIFLE"] = {"Lanternă",0,0,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"Shot Gun",0,0,""},
    ["WEAPON_APPISTOL"] = {"Pistol",0,0,""},
    ["WEAPON_COMBATPISTOL"] = {"Combat Pistol",0,0,""},
    ["WEAPON_PISTOL50"] = {"Pistol .50",0,0,""},
    ["WEAPON_ASSAULTRIFLE"] = {"Assault Rifle",0,0,""},
    ["WEAPON_HEAVYSHOTGUN"] = {"Heavy Shotgun",0,0,""},
    ["WEAPON_ASSAULTSHOTGUN"] = {"Assault Shotgun",0,0,""},
    ["WEAPON_SPECIALCARBINE"] = {"Special Carabine",0,0,""},
    ["WEAPON_KNUCKLE"] = {"Knuckle",0,0,""},
    ["WEAPON_KNIFE"] = {"Knife",0,0,""}
  },

-- list of gunshops positions

cfg.gunshops == {
  {"SMURD", 232.89363098145,-1368.3338623047,39.534381866455}, -- spawn hospital

  -- {"Hitman", 1401.134399414,1132.1010742188,114.3337020874},--hitman agency
  -- {"SRI", 140.59307861328,-749.37939453125,258.14547729492},

  {"Normal", 21.726160049438,-1106.9970703125,29.797023773193},
  {"Normal", 251.66534423828,-50.003204345703,69.941062927246},
  
  {"Politia Romana", -1088.2150878906,-819.1337890625,11.036247253418},--- main pd
  -- {"S.I.A.S", -1086.9737548828,-821.89978027344,11.035857200623}, -- Baza SWAT Life Invader   
  -- {"SRI", 139.31553649902,-763.01232910156,258.1520690918},


  -- Mafii NOI
	{"KMN Gang", -3028.6284179688,73.328544616699,12.902225494385},
},
}

return cfg
