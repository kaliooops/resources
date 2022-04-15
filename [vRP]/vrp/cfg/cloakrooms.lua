
-- this file configure the cloakrooms on the map

local cfg = {}

-- prepare surgeries customizations
local default_male = {model = "mp_m_freemode_01"}
local default_female = {model = "mp_f_freemode_01"}
local emergency_female = {model = "s_f_y_scrubs_01"}
local emergency_male = {model = "s_m_m_paramedic_01"}
local emergency_doctor = {model = "s_m_m_Doctor_01"}
local emergency_doctor2 = {model = "s_m_y_autopsy_01"}
local emergency_doctor3 = {model = "s_m_m_scientist_01"}
local swat_1 = {model = "s_m_y_ops_03"}
local swat_2 = {model = "s_m_y_swat_01"}
local swat_3 = {model = "s_m_y_fibswat_01"}
local swat_4 = {model = "s_m_y_ops_02"}
local detective_male = {model = "s_m_m_ciasec_01"}
local officer_male = {model = "s_m_y_cop_02"}
local cop_male = {model = "s_m_y_cop_01"}
local officer_female = {model = "s_f_y_cop_01"}
local officer3_male = {model = "s_m_y_cop_03"}
local officer2_male = {model = "s_m_y_cop_02"}
local ofitersef_male = {model = "s_m_y_fibcop_01"}
local lieutenant_male = {model = "s_m_y_ops_01"}
local deputy_male = {model = "s_m_y_hwaycop_01"}
local chief_male = {model = "s_m_m_marine_02"}
local inspector_male = {model = "s_m_y_sheriff_01"}
local curva_female1 = {model = "a_f_y_Juggalo_01"}
local curva_female2 = {model = "s_f_y_Stripper_02"}
local curva_female3 = {model = "s_f_y_Stripper_01"}
local curva_travest1 = {model = "a_m_m_TranVest_01"}
local curva_travest2 = {model = "a_m_m_TranVest_02"}
local puscarias = {model = "s_m_y_prismuscl_01"}
local puscarias2 = {model = "s_m_y_prisoner_01"}
local puscarias3 = {model = "u_m_y_prisoner_01"}
local hitman_male = {model = "ig_bankman"}
local copil1 = {model = "u_m_y_abner"}
local chestor = {model = "s_m_m_marine_02"}
local hidr0 = {model = "demod_dzieciak1"}
local staff1 = {model = "s_m_m_chemsec_01"}
local staff2 = {model = "csb_mweather"}
local Us = {model = "AmongUs"}
local Us1 = {model = "AmongUsBlue"}
local Us2 = {model = "AmongUsBrown"}
local Us3 = {model = "AmongUsGreen"}
local Us4 = {model = "AmongUsLightblue"}
local Us5 = {model = "AmongUsLightGreen"}
local Us6 = {model = "AmongUsOrange"}
local Us7 = {model = "AmongUsPurple"}
local Us8 = {model = "AmongUsRed"}
local Us9 = {model = "AmongUsRoze"}
local Us10 = {model = "AmongUsWhite"}
local Us11 = {model = "AmongUsYellow"}



local sias1 = {model = "sias1"}
local sias2 = {model = "sias2"}
local sias3 = {model = "sias3"}
local sias4 = {model = "sias4"}
local sias5 = {model = "s_m_y_swat_01"}

local sri1 = {model = "sri1"}
local sri2 = {model = "sri2"}
local sri3 = {model = "sri3"}
local sri4 = {model = "s_m_m_ciasec_01"}

--s_m_m_paramedic_01
--s_f_y_scrubs_01
--mp_m_freemode_01
--mp_f_freemode_01

for i=0,19 do
  default_female[i] = {0,0}
  default_male[i] = {0,0}
end

-- cloakroom types (_config, map of name => customization)
--- _config:
---- permissions (optional)
---- not_uniform (optional): if true, the cloakroom will take effect directly on the player, not as a uniform you can remove
cfg.cloakroom_types = {
  ["Default"] = {
    _config = { permissions = {"player.phone"} },
    ["Barbat"] = default_male,
    ["Femeie"] = default_female
  },
   ["Medic"] = {
    _config = { faction = "Smurd" },
    ["Doctorita"] = emergency_female,
    ["Doctor"] = emergency_male,
    ["Doctor 2"] = emergency_doctor,
    ["Doctor 3"] = emergency_doctor2,
    ["Doctor 4"] = emergency_doctor3
  },
  -- ["Puscarias"] = {
  --   ["Puscarias Negru"] = puscarias,
  --   ["Puscarias Caciula"] = puscarias2,
  --   ["Puscarias Alb"] = puscarias3
  -- },
  ["AmongUs"] = {
    _config = { permissions = {"copil.cloakroom"} },
    [""] = Us,
    ["Blue"] = Us1,
    ["Brown"] = Us2,
    ["Green"] = Us3,
    ["Light Blue"] = Us4,
    ["Light Green"] = Us5,
    ["Orange"] = Us6,
    ["Purple"] = Us7,
    ["Red"] = Us8,
    ["Rose"] = Us9,
    ["White"] = Us10,
    ["Yellow"] = Us11
  },
  ["Politia Romana"] = {
    _config = { faction = "Politia Romana" },
    ["Chestor General"] = chief_male,
    ["Ofiter Barbatesc"] = officer2_male,
    ["Ofiter Feminin"] = officer_female,
    ["Rutiera"] = cop_male,
    ["Ofiter 2 Barbatesc"] = officer3_male,
    ["Chestor"] = chestor
  },
  ["S.I.A.S"] = {
    _config = { faction = "S.I.A.S" },
    ["Skin 1"] = sias1,
    ["Skin 2"] = sias2,
    ["Skin 3"] = sias3,
    ["Skin 4"] = sias4,
    ["Skin 5"] = sias5
  },
  ["Hitman"] = {
    _config = { faction = "Hitman" },
    ["Hitman"] = hitman_male
  },
  ["SRI"] = {
    _config = { faction = "SRI" },
    ["Skin 1"] = sri1,
    ["Skin 2"] = sri2,
    ["Skin 3"] = sri3,
    ["Skin 4"] = sri4
  },

  -- ["Hidr0"] = {
  --   _config = { permissions = {"hidr0.cloakroom"} },
  --   ["Skin Hidr0"] = hidr0
  -- },

--   ["Staff Skins"] = {
--     _config = { permissions = {"staff.cloakroom"} },
--     ["Skin Staff Blue"] = staff1,
--     ["Skin Staff Red"] = staff2
--   },
  
--   ["Curva"] = {
--     _config = { permissions = {"curva.cloakroom"} },
--     ["Curva Lux"] = curva_female1,
--     ["Curva Forta"] = curva_female2,
-- 	  ["Curva Superb"] = curva_female3,
--     ["Travestitul Popa"] = curva_travest1,
--     ["Travestitul Marin"] = curva_travest2  
--   }
}

cfg.cloakrooms = {
  {"Politia Romana",-1092.3051757812,-826.09344482422,26.827438354492},
  -- {"Curva",-1382.2972412109,-631.76043701172,30.819564819336},

  -- {"S.I.A.S",-1096.3785400391,-830.58361816406,26.82434463501},
  -- {"SRI", 142.25526428222,-766.80932617188,45.752033233642},

  -- {"Staff Skins",-569.29443359375,-207.32815551758,47.546096801758},
  -- {"Hitman",1391.8916015625,1129.7053222656,114.33368682862}, --Hitman skin
  -- {"Puscarias",460.56777954102,-991.60461425782,24.914865493774},
  {"Medic",369.50106811524,-1402.96484375,32.95735168457},
  -- {"AmongUs",2336.4248046875,4859.2060546875,41.808200836182}
}

return cfg
