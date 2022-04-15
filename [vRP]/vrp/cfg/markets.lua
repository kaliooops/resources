
local cfg = {}

-- define market types like garages and weapons
-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the market)

cfg.market_types = {
    -------------Lege
    ["Police Market"] = {
      _config = {faction = "Politia Romana"},
      ["Armura"] = 400,
      ["key_pd"] = 1,
      ["WEAPON_APPISTOL"] = 1000,
      ["WEAPON_STUNGUN"] = 200,
      ["WEAPON_NIGHTSTICK"] = 100,
      ["WEAPON_CARBINERIFLE"] = 5000,
      ["WEAPON_ASSAULTSMG"] = 3500,
      ["WEAPON_ASSAULTSHOTGUN"] = 5000,
      ["WEAPON_HEAVYSNIPER"] = 10000,
      ["ammo-shotgun"] = 12,
      ["ammo-rifle"] = 12,
      ["ammo-pistol"] = 4,
    },
    ["Echipament Medical"] = {
      _config = {blipid=51, blipcolor=68, fType = "Lege"},
      ["medkit"] = 0,
      ["paracetamol"] = 50,
      ["repairkit"] = 500,
    },



  -----------Arme Mafii

  ["Gang Shop"] = {
    _config = {fType= "Gang"},
    ["WEAPON_SWITCHBLADE"] = 50,
    ["WEAPON_BAT"] = 50,
	  ["WEAPON_SNSPISTOL"] = 100,
    ["WEAPON_COMBATPISTOL"] = 200,
    ["ammo-pistol"] = 5,
  },

["Arme Bloods"] = {
  _config = {faction = "Bloods"},
  ["explozibil"] = 5000,
  ["ammo-pistol"] = 5,
  ["WEAPON_DOUBLEACTION"] = 10000,
  ["WEAPON_DAGGER"] = 100,
  ["WEAPON_BAT"] = 60,
  ["WEAPON_HATCHET"] = 60,
  ["WEAPON_KNUCKLE"] = 30,
  ["WEAPON_KNIFE"] = 50,
  ["WEAPON_MACHETE"] = 300,
  ["WEAPON_PISTOL50"] = 1500,
  ["WEAPON_ASSAULTRIFLE"] = 13000,
  ["WEAPON_SWITCHBLADE"] = 70,
  ["WEAPON_MICROSMG"] = 3900,
  ["WEAPON_SMG"] = 5500,
  ["ammo-rifle"] = 15,
},

["Armele Tiganilor"] = {
    _config = {faction = "Clanu` Tiganilor"},
    ["explozibil"] = 5000,
    ["ammo-pistol"] = 5,
    ["WEAPON_DOUBLEACTION"] = 10000,
    ["WEAPON_DAGGER"] = 100,
    ["WEAPON_BAT"] = 60,
    ["WEAPON_HATCHET"] = 60,
    ["WEAPON_KNUCKLE"] = 30,
    ["WEAPON_KNIFE"] = 50,
    ["WEAPON_MACHETE"] = 300,
    ["WEAPON_PISTOL50"] = 1500,
    ["WEAPON_ASSAULTRIFLE"] = 13000,
    ["WEAPON_SWITCHBLADE"] = 70,
    ["WEAPON_MICROSMG"] = 3900,
    ["WEAPON_SMG"] = 5500,
    ["ammo-rifle"] = 15,
  },

["Farmacie LV"] = {
  _config = {faction = "Los Vagos"},
  ["paracetamol"] = 20,
  ["Armura"] = 1500,
},

------------Diamond Pack
["Arme Crips"] = {
  _config = {faction = "Crips"},
  ["explozibil"] = 5000,
  ["WEAPON_DAGGER"] = 100,
  ["WEAPON_BAT"] = 60,
  ["WEAPON_HATCHET"] = 60,
  ["WEAPON_KNUCKLE"] = 30,
  ["WEAPON_KNIFE"] = 50,
  ["WEAPON_MACHETE"] = 100,
  ["WEAPON_PISTOL50"] = 1500,
  ["WEAPON_SWITCHBLADE"] = 70,
  ["WEAPON_PISTOL"] = 1000,
  ["WEAPON_COMBATPISTOL"] = 1500,
  ["WEAPON_SNSPISTOL"] = 900,
  ["WEAPON_VINTAGEPISTOL"] = 1500,
  ["WEAPON_REVOLVER"] = 2100,
  ["WEAPON_MICROSMG"] = 3600,
  ["WEAPON_SMG"] = 4500,
  ["WEAPON_ASSAULTSMG"] = 6000, 
  ["WEAPON_CARBINERIFLE"] = 9000,
  ["WEAPON_SPECIALCARBINERIFLE"] = 9000,
  ["WEAPON_ASSAULTRIFLE"] = 13000,
  ["WEAPON_GUSENBERG"] = 6000,
  ["WEAPON_PUMPSHOTGUN"] = 9000,
  ["WEAPON_ASSAULTSHOTGUN"] = 15000,
  ["WEAPON_DOUBLEACTION"] = 4500,
  ["ammo-pistol"] = 9,
  ["ammo-rifle"] = 15,
},

  ["Arme LV"] = {
    _config = {faction = "Los Vagos"},
    ["explozibil"] = 5000,
    ["ammo-pistol"] = 5,
    ["WEAPON_DAGGER"] = 100,
    ["WEAPON_BAT"] = 60,
    ["WEAPON_HATCHET"] = 60,
    ["WEAPON_KNUCKLE"] = 30,
    ["WEAPON_KNIFE"] = 50,
    ["WEAPON_DOUBLEACTION"] = 10000,
    ["WEAPON_MACHETE"] = 300,
    ["WEAPON_PISTOL50"] = 1500,
    ["WEAPON_ASSAULTRIFLE"] = 13000,
    ["WEAPON_SWITCHBLADE"] = 70,
    ["WEAPON_MICROSMG"] = 3900,
    ["WEAPON_SMG"] = 5500,
    ["ammo-rifle"] = 15,
  },

  ["Arme Ballas"] = {
    _config = {faction = "Ballas"},
    ["explozibil"] = 5000,
    ["ammo-pistol"] = 5,
    ["WEAPON_DAGGER"] = 100,
    ["WEAPON_BAT"] = 60,
    ["WEAPON_HATCHET"] = 60,
    ["WEAPON_KNUCKLE"] = 30,
    ["WEAPON_KNIFE"] = 50,
    ["WEAPON_DOUBLEACTION"] = 10000,
    ["WEAPON_MACHETE"] = 300,
    ["WEAPON_PISTOL50"] = 1500,
    ["WEAPON_ASSAULTRIFLE"] = 13000,
    ["WEAPON_SWITCHBLADE"] = 70,
    ["WEAPON_MICROSMG"] = 3900,
    ["WEAPON_SMG"] = 5500,
    ["ammo-rifle"] = 15,
  },

  ["Arme KMN"] = {
    _config = {faction = "KMN Gang"},
    ["explozibil"] = 5000,
    ["Armura"] = 400,
    ["WEAPON_RPG"] = 100,
    ["ammo-rpg"] = 1,
    ["WEAPON_DAGGER"] = 100,
    ["WEAPON_BAT"] = 60,
    ["WEAPON_HATCHET"] = 60,
    ["WEAPON_KNUCKLE"] = 30,
    ["WEAPON_KNIFE"] = 50,
    ["WEAPON_MACHETE"] = 100,
    ["WEAPON_PISTOL50"] = 1500,
    ["WEAPON_SWITCHBLADE"] = 70,
    ["WEAPON_PISTOL"] = 1000,
    ["WEAPON_COMBATPISTOL"] = 1500,
    ["WEAPON_SNSPISTOL"] = 900,
    ["WEAPON_VINTAGEPISTOL"] = 1500,
    ["WEAPON_REVOLVER"] = 2100,
    ["WEAPON_MICROSMG"] = 3600,
    ["WEAPON_SMG"] = 4500,
    ["WEAPON_ASSAULTSMG"] = 6000, 
    ["WEAPON_CARBINERIFLE"] = 9000,
    ["WEAPON_SPECIALCARBINERIFLE"] = 9000,
    ["WEAPON_ASSAULTRIFLE"] = 13000,
    ["WEAPON_GUSENBERG"] = 6000,
    ["WEAPON_PUMPSHOTGUN"] = 9000,
    ["WEAPON_ASSAULTSHOTGUN"] = 15000,
    ["WEAPON_DOUBLEACTION"] = 4500,
    ["ammo-pistol"] = 9,
    ["ammo-rifle"] = 15,
  },
  ----------Afaceri

  ["Cannabis"] = {
    _config = {faction= "Los Vagos"},
  ["kush"] = 5,
	["lemonhaze"] = 6,
	["purplehaze"] = 7,
  },

  ["Chimicale"] = {
    _config = {faction= "KMN Gang"},
  ["bonzai"] = 5,
	["jamaika"] = 5,
	["scoobysnaks"] = 5,
  },

  ["Pet Shop"] = {
    _config = {},
    ["croquettes"] = 15,
    ["wbody|WEAPON_BALL"] = 10,
  },

  ["Droguri Medicinale"] = {
    _config = {faction= "Smurd"},
  ["tilidin"] = 4,
	["tramadol"] = 6,
  },
}
-- list of markets {type,x,y,z}

cfg.markets = {
  {"Magazin Alimentar",128.1410369873, -1286.1120605469, 29.281036376953},
  {"Magazin Alimentar",-47.522762298584,-1756.85717773438,29.4210109710693},
  {"Magazin Alimentar",25.7454013824463,-1345.26232910156,29.4970207214355}, 
  {"Magazin Alimentar",1135.57678222656,-981.78125,46.4157981872559}, 
  {"Magazin Alimentar",1163.53820800781,-323.541320800781,69.2050552368164}, 
  {"Magazin Alimentar",374.190032958984,327.506713867188,103.566368103027}, 
  {"Magazin Alimentar",2555.35766601563,382.16845703125,108.622947692871}, 
  {"Magazin Alimentar",2676.76733398438,3281.57788085938,55.2411231994629}, 
  {"Magazin Alimentar",1960.50793457031,3741.84008789063,32.3437385559082},
  {"Magazin Alimentar",1393.23828125,3605.171875,34.9809303283691}, 
  {"Magazin Alimentar",1166.18151855469,2709.35327148438,38.15771484375}, 
  {"Magazin Alimentar",547.987609863281,2669.7568359375,42.1565132141113}, 
  {"Magazin Alimentar",1698.30737304688,4924.37939453125,42.0636749267578}, 
  {"Magazin Alimentar",1729.54443359375,6415.76513671875,35.0372200012207}, 
  {"Magazin Alimentar",-3243.9013671875,1001.40405273438,12.8307056427002}, 
  {"Magazin Alimentar",-2967.8818359375,390.78662109375,15.0433149337769}, 
  {"Magazin Alimentar",-3041.17456054688,585.166198730469,7.90893363952637},
  {"Magazin Alimentar",-1820.55725097656,792.770568847656,138.113250732422}, 
  {"Magazin Alimentar",-1486.76574707031,-379.553985595703,40.163387298584}, 
  {"Magazin Alimentar",-1223.18127441406,-907.385681152344,12.3263463973999}, 
  {"Magazin Alimentar",-707.408996582031,-913.681701660156,19.2155857086182},
  {"Magazin Alimentar",-2281.7209472656,359.91287231446,174.60174560546},
  {"Pet Shop", 561.84252929688,2750.8684082031,42.877098083496},

  ------------Arme Mafii
  {"Arme KMN",-3022.5773925782,39.314754486084,10.117791175842},
  {"Arme Bloods", -1804.8969726563,427.60131835938,128.50762939453},
  {"Arme Crips", -25.978132247924,-588.06829833984,90.123512268066},
  {"Arme LV", -1079.77, -1678.86, 4.58},
  {"Arme Ballas", 114.1884765625,-1960.845703125,21.334177017212},
  {"Farmacie LV", -1076.25,-1678.53,4.58},
  {"Armele Tiganilor", -1568.9676513672,-96.810523986816,54.528999328614},
  
  ---------Droage
  -- {"Chimicale",-1799.3887939453,414.82180786133,128.30772399902},
  {"Cannabis",1521.5688476563,6331.1420898438,24.152729034424},
  {"Droguri Medicinale",3608.380859375,3740.1166992188,28.690101623535},
  {"Gang Shop",18.061412811279,-1110.8276367188,29.797023773193},
  -------Lege
  {"Echipament Medical",311.61114501953,-597.52630615234,43.284008026123}, -- spawn
  {"Echipament Medical",1841.4317626953,3673.5891113281,34.276752471924}, -- Sandy Shores
  {"Echipament Medical",-243.3074798584,6326.2265625,32.426181793213}, -- Paleto Bay
  {"Police Market",460.98709106445,-982.67279052734,30.689584732056},

}

return cfg
