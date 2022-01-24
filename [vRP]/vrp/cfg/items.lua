-- define items, see the Inventory API on github

local cfg = {}
cfg.items = {
	["tigara"] = {"Tigara","Fumatul dauneaza grav sanatatii.", nil,0.1,"pocket"},
	----------------ALTELE
	["lighter"] = {"Bricheta", "O bricheta tip vintage",nil,0.5,"pocket"},
	["aphone"] = {"Mobil &#x1F4F1;", "Call and send SMS.", nil, 0},
	["vodka"] = {"Vodka", "Bautura ruseasca",nil,0.5,"pocket"},
  ["Armura"] = {"Armura", "Vesta Anti Glont",nil,5.0,"pocket"},
	----------------ROLEPLAY
	["id_doc"] = {"Buletin","Un buletin cu numele si informatiile tale pe el! Nu il pierde",nil,0,"pocket"},
	["gunpermit_doc"] = {"Permis Port-Arma","Un permis ce te lasa sa ai asupra ta arme de foc",nil,0,"pocket"},
    ["permis"] = {"Permis de conducere","",nil,0,"pocket"},
	["asigurare_masina"] = {"Asigurare de Masina","O Asigurare de masina pe care o puteti oferi la altii sau pastra pentru masina voastra",nil,0,"pocket"},
  ["key_pd"] = {"🔑 Cheie", "", nil, 0.01},
  ["key_pd_boss"] = {"🔑 Cheie", "", nil, 0.01},
  ["key_grove_house"] = {"🔑 Cheie", "", nil, 0.01},
}

-- load more items function
local function load_item_pack(name)
  local items = module("cfg/item/"..name)
  if items then
    for k,v in pairs(items) do
      cfg.items[k] = v
    end
  else
    print("[vRP] item pack ["..name.."] not found")
  end
end

-- PACKS
load_item_pack("required")
load_item_pack("drugs")

return cfg
