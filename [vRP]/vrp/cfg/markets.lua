
local cfg = {}

-- define market types like garages and weapons
-- _config: blipid, blipcolor, permissions (optional, only users with the permission will have access to the market)

cfg.market_types = {
  ["Magazin Alimentar"] = {
    _config = {blipid=52, blipcolor=2},
    ["vodka"] = 30,
	  ["preservative"] = 15,
    ["aphone"] = 230,
    ["tigara"] = 1,
    ["lighter"] = 2,
    ["croquettes"] = 15,
    ["wbody|WEAPON_PETROLCAN"] = 50,
    ["wammo|WEAPON_PETROLCAN"] = 2,
    ["wbody|WEAPON_BALL"] = 10,
    
	
  },
  ["Magazin De Unelte"] = {
	_config = {blipid=459, blipcolor=46},
	["sudura"] = 1300,
  ["picamar"] = 3000,
  ["ciocan"] = 100,
  },

  ["Hackeri"] = {
    _config = {blipid=525, blipcolor=2},
    ["hackphone"] = 3700,
    ["camera"] = 11999,
    ["tableta"] = 5300,
    ["stick"] = 2800,
    ["card"] = 1999,
    },

  ["Gun Shop"] = {
    _config = {blipid=567, blipcolor=46},
    ["wbody|WEAPON_BAT"] = 50,
    ["wbody|WEAPON_SWITCHBLADE"] = 50,
    ["wbody|WEAPON_STUNGUN"] = 100,
    },

    ["Farmacie"] = {
      _config = {blipid=61, blipcolor=75},
    ["paracetamol"] = 30,
    ["morfina"] = 300,
    },

    -------------Lege
    ["Police Market"] = {
      _config = {faction = "Politia Romana"},
      ["Armura"] = 400,
      ["key_pd"] = 1
      
    },
    ["Echipament Medical"] = {
      _config = {blipid=51, blipcolor=68, fType = "Lege"},
      ["medkit"] = 0,
      --["pills"] = 0,
    ["repairkit"] = 500
    },



  -----------Arme Mafii

  ["Gang Shop"] = {
    _config = {fType= "Gang"},
    ["wbody|WEAPON_SWITCHBLADE"] = 50,
    ["wbody|WEAPON_BAT"] = 50,
    ["wbody|WEAPON_PISTOL50"] = 400,
	  ["wbody|WEAPON_SNSPISTOL"] = 100,
    ["wbody|WEAPON_COMBATPISTOL"] = 200,
    ["wammo|WEAPON_PISTOL50"] = 2,
    ["wammo|WEAPON_COMBATPISTOL"] = 1,
    ["wammo|WEAPON_SNSPISTOL"] = 1,
  },


   ["Arme Triade"] = {
    _config = {faction = "Triadele"},
    ["wbody|WEAPON_DAGGER"] = 100,
    ["wbody|WEAPON_BAT"] = 60,
    ["wbody|WEAPON_DOUBLEACTION"] = 700,
    ["wbody|WEAPON_HATCHET"] = 60,
    ["wbody|WEAPON_KNUCKLE"] = 30,
    ["wbody|WEAPON_KNIFE"] = 50,
    ["wbody|WEAPON_MACHETE"] = 100,
    ["wbody|WEAPON_PISTOL50"] = 500,
    ["wbody|WEAPON_SWITCHBLADE"] = 70,
    ["wbody|WEAPON_MICROSMG"] = 1200,
    ["wbody|WEAPON_SMG"] = 1500,
    ["wammo|WEAPON_PISTOL50"] = 3,
    ["wammo|WEAPON_MICROSMG"] = 4,
    ["wammo|WEAPON_SMG"] = 4,
    ["wammo|WEAPON_DOUBLEACTION"] = 3,
},

["Arme Y.A.D"] = {
  _config = {faction = "Y.A.D"},
  ["wbody|WEAPON_DAGGER"] = 100,
  ["wbody|WEAPON_BAT"] = 60,
  ["wbody|WEAPON_HATCHET"] = 60,
  ["wbody|WEAPON_KNUCKLE"] = 30,
  ["wbody|WEAPON_KNIFE"] = 50,
  ["wbody|WEAPON_MACHETE"] = 100,
  ["wbody|WEAPON_PISTOL50"] = 500,
  ["wbody|WEAPON_SWITCHBLADE"] = 70,
  ["wbody|WEAPON_MICROSMG"] = 1200,
  ["wbody|WEAPON_SMG"] = 1500,
  ["wammo|WEAPON_PISTOL50"] = 3,
  ["wammo|WEAPON_MICROSMG"] = 4,
  ["wammo|WEAPON_SMG"] = 4,
},

  ["Arme Groove"] = {
    _config = {faction = "Groove Street"},
    ["Armura"] = 400,
    ["wbody|WEAPON_DAGGER"] = 100,
    ["wbody|WEAPON_BAT"] = 60,
    ["wbody|WEAPON_HATCHET"] = 60,
    ["wbody|WEAPON_KNUCKLE"] = 30,
    ["wbody|WEAPON_KNIFE"] = 50,
    ["wbody|WEAPON_MACHETE"] = 100,
    ["wbody|WEAPON_PISTOL50"] = 500,
    ["wbody|WEAPON_SWITCHBLADE"] = 70,
    ["wbody|WEAPON_PISTOL"] = 300,
    ["wbody|WEAPON_COMBATPISTOL"] = 400,
    ["wbody|WEAPON_SNSPISTOL"] = 200,
    ["wbody|WEAPON_REVOLVER"] = 700,
    ["wbody|WEAPON_MICROSMG"] = 1200,
    ["wbody|WEAPON_SMG"] = 1500,
    ["wbody|WEAPON_ASSAULTSMG"] = 2000, 
    ["wbody|WEAPON_CARBINERIFLE"] = 3000,
    ["wbody|WEAPON_ASSAULTRIFLE"] = 4000,
    ["wbody|WEAPON_GUSENBERG"] = 2000,
    ["wammo|WEAPON_PISTOL"] = 1,
    ["wammo|WEAPON_PISTOL50"] = 3,
    ["wammo|WEAPON_COMBATPISTOL"] = 2,
    ["wammo|WEAPON_SNSPISTOL"] = 1,
    ["wammo|WEAPON_MICROSMG"] = 4,
    ["wammo|WEAPON_SMG"] = 4,
    ["wammo|WEAPON_ASSAULTSMG"] = 4,
    ["wammo|WEAPON_REVOLVER"] = 4,
    ["wammo|WEAPON_CARBINERIFLE"] = 5,
    ["wammo|WEAPON_ASSAULTRIFLE"] = 5,
  },

  ["Arme KMN"] = {
    _config = {faction = "KMN Gang"},
    ["Armura"] = 400,
    ["wbody|WEAPON_DAGGER"] = 100,
    ["wbody|WEAPON_BAT"] = 60,
    ["wbody|WEAPON_HATCHET"] = 60,
    ["wbody|WEAPON_KNUCKLE"] = 30,
    ["wbody|WEAPON_KNIFE"] = 50,
    ["wbody|WEAPON_MACHETE"] = 100,
    ["wbody|WEAPON_PISTOL50"] = 500,
    ["wbody|WEAPON_SWITCHBLADE"] = 70,
    ["wbody|WEAPON_PISTOL"] = 300,
    ["wbody|WEAPON_COMBATPISTOL"] = 400,
    ["wbody|WEAPON_SNSPISTOL"] = 200,
    ["wbody|WEAPON_VINTAGEPISTOL"] = 500,
    ["wbody|WEAPON_REVOLVER"] = 700,
    ["wbody|WEAPON_MICROSMG"] = 1200,
    ["wbody|WEAPON_SMG"] = 1500,
    ["wbody|WEAPON_ASSAULTSMG"] = 2000, 
    ["wbody|WEAPON_CARBINERIFLE"] = 3000,
    ["wbody|WEAPON_ASSAULTRIFLE"] = 4000,
    ["wbody|WEAPON_GUSENBERG"] = 2000,
    ["wammo|WEAPON_PISTOL"] = 1,
    ["wammo|WEAPON_PISTOL50"] = 3,
    ["wammo|WEAPON_COMBATPISTOL"] = 2,
    ["wammo|WEAPON_SNSPISTOL"] = 1,
    ["wammo|WEAPON_VINTAGEPISTOL"] = 3,
    ["wammo|WEAPON_MICROSMG"] = 4,
    ["wammo|WEAPON_SMG"] = 4,
    ["wammo|WEAPON_ASSAULTSMG"] = 4,
    ["wammo|WEAPON_CARBINERIFLE"] = 5,
    ["wammo|WEAPON_ASSAULTRIFLE"] = 5,
  },
  ----------Afaceri

  ["Cannabis"] = {
    _config = {faction= "Groove Street"},
  ["kush"] = 4,
	["lemonhaze"] = 6,
	["purplehaze"] = 6
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
  {"Gun Shop",21.183559417724,-1106.3679199218,29.797018051148},
  {"Farmacie",312.84817504883,-593.02587890625,43.283988952637},
  {"Magazin De Unelte",245.3702545166,369.41763305664,105.73818206787},

  ------------Arme Mafii
  {"Arme Y.A.D", -1152.7413330078,-1516.723022461,10.632727622986},
  {"Arme Groove",84.986709594726,-1958.7644042968,21.121685028076},
  {"Arme KMN",-3022.5773925782,39.314754486084,10.117791175842},
  {"Arme Triade", 981.61541748046,-1805.7686767578,35.484539031982},

  ---------Droage
  {"Cannabis",1521.5688476563,6331.1420898438,24.152729034424},
  {"Droguri Medicinale",3608.380859375,3740.1166992188,28.690101623535},
  {"Gang Shop",18.061412811279,-1110.8276367188,29.797023773193},

  -------Lege
  {"Echipament Medical",311.61114501953,-597.52630615234,43.284008026123}, -- spawn
  {"Echipament Medical",1841.4317626953,3673.5891113281,34.276752471924}, -- Sandy Shores
  {"Echipament Medical",-243.3074798584,6326.2265625,32.426181793213}, -- Paleto Bay
  {"Police Market",460.98709106445,-982.67279052734,30.689584732056},
   ------------Hackeri
  {"Hackeri",1274.154296875,-1711.3488769531,54.771450042725},

}

return cfg
