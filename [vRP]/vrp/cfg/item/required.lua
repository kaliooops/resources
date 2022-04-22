local items = {}

items["medkit"] = {"Kit Medical", "Folosit Sa Aduca La Viata Oameni Lesinati.",function(x,y,z)
  print(json.encode(x), json.encode(y), json.encode(z))
end,0.5,"pocket"}
items["dirty_money"] = {"Bani Murdari", "Bani Castigati Murdar.",nil,0.0,"pocket"}
items["repairkit"] = {"Kit Reparati", "Folosit Sa Repare Multe Chestii.",nil,0.5,"pocket"}
items["Cadouri"] = {"Cadouri", "Pune cadourile sub bradut",nil,1.0,"pocket"}
items["cigpack_pallmall"] = {"PallMall", "Un packet de tigari PallMall!",nil,0.1,"pocket"}
items["cigpack_marlboro"] = {"Marlboro", "Un packet de tigari Marlboro!",nil,0.1,"pocket"}
items["permis_doc"] = {"Permis", "Nu il pierde!",nil,0.1,"pocket"}
items["picamar"] = {"Picamar", "Pentru a da gauri in asfalt",nil,5.0,"pocket"}
items["lemonhaze"] = {"Lemon Haze", "Cannabis sativa cu gust de lamaie",nil,0.01,"pocket"}
items["kush"] = {"Kush", "Cannabis Indica pentru calmare",nil,0.01,"pocket"}
items["purplehaze"] = {"Purple Haze", "Cannabis sativa purpurie",nil,0.01,"pocket"}
items["tramadol"] = {"Tramadol Capsule", "Pastile pentru energie",nil,0.3,"pocket"}
items["tilidin"] = {"Tilidin Capsule", "Calmante foarte puternice",nil,0.3,"pocket"}
items["croquettes"] = {"croquettes", "Mancarica pentru catei",nil,0.5,"pocket"}
items["speed"] = {"Speed", "Praf de amfetamina",nil,0.01,"pocket"}
items["mdma"] = {"MDMA", "Praf de MDMA",nil,0.01,"pocket"}
items["extazy"] = {"Extazy", "Pastile Extazy",nil,0.01,"pocket"}
items["cocaina"] = {"Cocaina", "Praf de Coca",nil,0.01,"pocket"}
items["ammo-pistol"] = {"Gloante-Pistol",nil,0.01,"pocket"}
items["ammo-rifle"] = {"Gloante-Rifle",nil,0.03, "pocket"}
items["cristal"] = {"Cristal", "Praf de Metamfetamina",nil,0.01,"pocket"}
items["scoobysnaks"] = {"ScoobySnaks", "Ierburi Etnobotanice",nil,0.01,"pocket"}
items["bonzai"] = {"bonzai", "Etnobotanice",nil,0.01,"pocket"}
items["jamaika"] = {"JamaikaGoldExtreme", "Ierburi Etnobotanice",nil,0.01,"pocket"}
items["ananas"] = {"Pinapple Juice", "Bauturi racoritoare, iti ofera un plus de viata si comfort.",nil,0.01,"pocket"}
items["strawberry"] = {"Strawberry Juice", "Bauturi racoritoare, iti ofera un plus de viata si comfort.",nil,0.01,"pocket"}
items["limonada"] = {"Limonada", "Bauturi racoritoare, iti ofera un plus de viata si comfort.",nil,0.01,"pocket"}
items["kiwi"] = {"Kiwi Juice", "Bauturi racoritoare, iti ofera un plus de viata si comfort.",nil,0.01,"pocket"}
items["orange"] = {"Orange Juice", "Bauturi racoritoare, iti ofera un plus de viata si comfort.",nil,0.01,"pocket"}
items["pizza"] = {"Pizza", "Mancare de la Pizza Hot",nil,0.5,"pocket"}
items["diavola"] = {"Pizza Diavola", "Mancare de la Pizza Ana",nil,0.5,"pocket"}
items["romaneasca"] = {"Pizza Romaneasca", "Mancare de la Pizza Ana",nil,0.5,"pocket"}
items["taraneasca"] = {"Pizza Taraneasca", "Mancare de la Pizza Ana",nil,0.5,"pocket"}
items["bigmac"] = {"Big Mac", "Mancare de la Mc Donald`s",nil,0.5,"pocket"}
items["cheeseburger"] = {"Cheeseburger", "Mancare de la Mc Donald`s",nil,0.5,"pocket"}
items["hamburger"] = {"Hamburger", "Mancare de la Mc Donald`s",nil,0.5,"pocket"}

--------------pescar-----------------
items["sonar"] = {"Sonar", "Detecteaza Bancuri cu Pesti",nil,0.1,"pocket"}
items["undita1m"] = {"Undita 1M", "Undita de 1M",nil,0.2,"pocket"}
items["undita2m"] = {"Undita 2M", "Undita de 2M",nil,0.3,"pocket"}
items["undita3m"] = {"Undita 3M", "Undita de 3M",nil,0.4,"pocket"}
items["undita4m"] = {"Undita 4M", "Undita de 4M",nil,0.5,"pocket"}
items["undita5m"] = {"Undita 5M", "Undita de 5M",nil,0.6,"pocket"}
items["undita6m"] = {"Undita 6M", "Undita de 6M",nil,0.7,"pocket"}
items["Platica"] = {"Platica","Peste",nil,2.1,"pocket"}
items["Somn"] = {"Somn","Peste",nil,1.1,"pocket"}
items["Caras"] = {"Caras","Peste",nil,1.1,"pocket"}
items["Pui de rechin"] = {"Pui de Rechin","Peste",nil,5.1,"pocket"}
items["Bocanc"] = {"Bocanc","Peste",nil,0.1,"pocket"}
items["Cutie de metal"] = {"Cutie de Metal","Peste",nil,1.1,"pocket"}
items["Caracatita"] = {"Caracatita","Peste",nil,3.1,"pocket"}
items["Banuti de aur"] = {"Banuti de Aur","Peste",nil,0.1,"pocket"}
items["Pui de balena"] = {"Pui de Balena","Peste",nil,5.1,"pocket"}
items["Obiect suspicios"] = {"Obiect Suspicios","Peste",nil,1.1,"pocket"}
items["Sturion"] = {"Sturion", "Peste",nil,1.1,"pocket"}
items["explozibil"] = {"Explozibil", "C4",nil, 1.0,"pocket"}

-------mancare ---
items["gogoasa"] = {"Gogoasa","O gogoasa delicioasa cu ciocolata",nil,0.1,"pocket"}
items["cola"] = {"Coca Cola","Coca Cola rece",nil,0.5,"pocket"}


--------------------------Arme-------------------------
items["wbody|WEAPON_RPG"] = {"RPG", "Lansator de Rachete.",nil,5,"pocket"}
items["wammo|WEAPON_RPG"] = {"Rockets", "Rachete pentru Lansator",nil,2,"pocket"}
items["wbody|WEAPON_PETROLCAN"] = {"Canistra","Umple rezervorul.",nil,0.1,"pocket"}
items["wammo|WEAPON_PETROLCAN"] = {"Benzina","Umple rezervorul.",nil,0.1,"pocket"}
items["wbody|WEAPON_DAGGER"] = {"Dagger","O sabiuta.",nil,0.7,"pocket"}
items["wbody|WEAPON_BAT"] = {"Bata","O bata de baseball.",nil,1.0,"pocket"}
items["wbody|WEAPON_FLASHLIGHT"] = {"Lanterna","O lanterna pentru luminat.",nil,0.5,"pocket"}
items["wbody|WEAPON_HATCHET"] = {"Topor","Topor pentru spart lemne.",nil,1.0,"pocket"}
items["wbody|WEAPON_KNUCKLE"] = {"Rozeta","Rozeta buna pentru bataie.",nil,0.5,"pocket"}
items["wbody|WEAPON_KNIFE"] = {"Cutit","Un cutit de bucatarie.",nil,0.5,"pocket"}
items["wbody|WEAPON_MACHETE"] = {"Maceta","",nil,0.2,"pocket"}
items["wbody|WEAPON_PISTOL50"] = {"Pistol50","Un Deagle de calitate.",nil,1.0,"pocket"}
items["wbody|WEAPON_SWITCHBLADE"] = {"Briceag","Un cutitas mic care se deschide.",nil,0.3,"pocket"}
items["wbody|WEAPON_HEAVYSNIPER"] = {"Sniper","Arma cu luneta",nil,2.4,"pocket"}
items["wbody|WEAPON_MG"] = {" MG","Arma cu luneta",nil,3.6,"pocket"}
items["wbody|WEAPON_NIGHTSTICK"] = {"Pulan","Pulan de politist.",nil,0.7,"pocket"}
items["wbody|WEAPON_PISTOL"] = {"Pistol","Ai grija cum il folosesti.",nil,1.0,"pocket"}
items["wbody|WEAPON_COMBATPISTOL"] = {"Combat Pistol","Ai grija cum il folosesti.",nil,0.2,"pocket"}
items["wbody|WEAPON_STUNGUN"] = {"Taser","Pistol cu electricitate.",nil,0.6,"pocket"}
items["wbody|WEAPON_SNSPISTOL"] = {"Pistol SnS","Pentru autoaparare.",nil,1.0,"pocket"}
items["wbody|WEAPON_VINTAGEPISTOL"] = {"Vintage Pistol","Licina flori indiene.",nil,1.2,"pocket"}
items["wbody|WEAPON_REVOLVER"] = {"Revolver","Pistol foarte puternic.",nil,2.0,"pocket"}
items["wbody|GADGET_PARACHUTE"] = {"Parasuta","E puna pentru sarituri.",nil,2.2,"pocket"}
items["wbody|WEAPON_FIREEXTINGUISHER"] = {"Exstinctor","Stinge focul.",nil,2.2,"pocket"}
items["wbody|WEAPON_MICROSMG"] = {"Micro-SMG","Un uzzi semi automat.",nil,0.2,"pocket"}
items["wbody|WEAPON_SMG"] = {"SMG","Mitraliera semi automata.",nil,3.2,"pocket"}
items["wbody|WEAPON_ASSAULTSMG"] = {"Assault SMG","Mitraliera semi automata mare.",nil,4.2,"pocket"}
items["wbody|WEAPON_CARBINERIFLE"] = {"Carabina","O arma foarte grea.",nil,4.3,"pocket"}
items["wbody|WEAPON_ASSAULTRIFLE"] = {"AK47","Arma produsa in rusia.",nil,4.2,"pocket"}
items["wbody|WEAPON_GUSENBERG"] = {"Gunsenberg","Mitraliera din 1997.",nil,4.2,"pocket"}
items["wbody|WEAPON_BALL"] = {"Mingiuta", "Mingiuta pentru catei",nil,4.2,"pocket"}
items["wbody|WEAPON_DOUBLEACTION"] = {"Double Action", "Un revolver foarte puternic",nil,1.7,"pocket"}
items["wammo|WEAPON_DOUBLEACTION"] = {"Gloante DB","Gloante pentru DB.",nil,0.1,"pocket"}

------- Ammo
items["wammo|WEAPON_PISTOL"] = {"Munitie Pistol","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_PISTOL50"] = {"Munitie Pistol50","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_COMBATPISTOL"] = {"Munitie Combatpistol","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_SNSPISTOL"] = {"Munitie SNS","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_VINTAGEPISTOL"] = {"Gunsenberg","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_REVOLVER"] = {"Munitie Revolver","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_HEAVYSNIPER"] = {"Munitie Sniper","Arma cu luneta",nil,0.2,"pocket"}
items["wammo|WEAPON_MG"] = {"Munitie MG","Arma cu luneta",nil,0.2,"pocket"}
items["wammo|WEAPON_FIREEXTINGUISHER"] = {"Gunsenberg","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_MICROSMG"] = {"Munitie MicroSMG","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_SMG"] = {"Munitie SMG","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_ASSAULTSMG"] = {"Munitie AssaultSMG","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_COMBATPDW"] = {"Munitie","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_CARBINERIFLE"] = {"Munitie CarbineRifle","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_ASSAULTRIFLE"] = {"Munitie AK47","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_GUSENBERG"] = {"Munitie Gusenberg","Mitraliera din 1997.",nil,0.1,"pocket"}

-------------------------------Rob---------------------------------------

items["ciocan"] = {"Ciocan","Folosit pentru a repara case.",nil,0.5,"pocket"}
items["sudura"] = {"Aparat Sudura", "Folosit pentru a lipii sau arde metalul",nil,0.5,"pocket"}
items["camera"] = {"Camera cu Raze", "Folosita pentru a vedea prin obiecte",nil,0.3,"pocket"}
items["stick"] = {"Stick Malware", "Un stick de la hackeri cu un malware",nil,0.3,"pocket"}
items["hackphone"] = {"Hack Phone", "Un telefon care foloseste Kali Linux",nil,0.3,"pocket"}
items["accescard"] = {"Acces Card", "Un card de acces de la Fleeca",nil,0.3,"pocket"}
items["tableta"] = {"Hack Tablet", "Tableta care foloseste Back Track",nil,0.3,"pocket"}

------------Minerit--------------
items["fireworks"] = {"Artificii", "Explodeaza frumos pe cer",nil,1.0,"pocket"}
items["tarnacop"] = {"Tarnacop", "Tarnacop pentru minerit",nil,1.0,"pocket"}
items["minereu_de_fier"] = {"Minereu de Fier","Minereu de Fier", nil, 0.1, "pocket"}
items["minereu_de_aur"] = {"Minereu de Aur","Minereu de Aur", nil, 0.1, "pocket"}
items["minereu_de_argint"] = {"Minereu de Argint","Minereu de Argint",nil,0.1,"pocket"}
items["bucata_de_aur"] = {"Bucata de Aur","Bucata de Aur", nil, 0.1, "pocket"}
items["bucata_de_argint"] = {"Bucata de Argint","Bucata de Argint",nil,0.1, "pocket"}
items["bucata_de_fier"] = {"Bucata de Fier","Bucata de Fier", nil, 0.1, "pocket"}


items["cutter"] = {"Cutter Ascutit","Folosit Pentru Taia Franghia De La Persoanele Legate La Maini",function(args)
	local choices = {}
	local idname = args[1]

	choices["Foloseste"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
		if user_id ~= nil then
			vRPheadbag.cutCuffs({player})
		end
	end}
	return choices
end,0.5,"pocket"}

items["franghie"] = {"Franghie Groasa","Folosita Pentru A Lega Persoana Respectiva De Maini",function(args)
	local choices = {} 
	local idname = args[1]

	choices["Foloseste"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
		if user_id ~= nil then
			vRPheadbag.cuffHands({player})
		end
	end}
	return choices
end,1.0,"pocket"}

items["head_bag"] = {"Punga de Hartie","Folosita Pentru Puneri Pe Cap",function(args)
	local choices = {} 
	local idname = args[1]

	choices["Foloseste"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
		if user_id ~= nil then
			vRPheadbag.useHeadBag({player})
		end
	end}
	return choices
end,1.0,"pocket"}

items["cigarettee"] = {"Tigara", "O tigara cu tutun columbian",function(args)
	local choices = {}
	local idname = args[1]
		
	choices["Aprinde"] = {function(player,choice,mod)
		local user_id = vRP.getUserId(player)
		if user_id ~= nil then
			if(vRP.getInventoryItemAmount(user_id,"lighter") > 0)then
				if(vRP.tryGetInventoryItem(user_id, idname, 1, false))then
					vRPclient.isInComa(player,{}, function(in_coma)
						if(in_coma)then
							vRPclient.notify(player, {"~r~Eu cred ca esti lesinat"})
						else
							vRPclient.playAnim(player, {true, {task="WORLD_HUMAN_SMOKING"}, false})
							SetTimeout(20000, function()
								vRPclient.stopAnim(player, {})
								vRPclient.varyHealth(player,{10})
							end)
						end
					end)
					vRPclient.notify(player, {"~g~Ti-ai aprins tigara!"})
				else
					vRPclient.notify(player, {"~r~Nu ai bricheta!"})
				end
			else
				vRPclient.notify(player, {"~r~Nu ai bricheta!"})
			end
			vRP.closeMenu(player)
		end
	end}
	return choices
end,0.05,"pocket"}

for i, v in pairs(items) do
	if(string.match(i, "cigpack"))then
		v[3] = function(args)
			local choices = {}
			local idname = args[1]
			
			choices["Scoate 20 Tigari"] = {function(player,choice,mod)
				local user_id = vRP.getUserId(player)
				if user_id ~= nil then
					if(vRP.tryGetInventoryItem(user_id, idname, 1, false))then
						vRP.giveInventoryItem(user_id,"cigarettee",20,true)
						vRPclient.notify(player, {"~g~Ai scos o tigara din pachet!"})
					end
					vRP.closeMenu(player)
				end
			end}
			return choices
		end
	end
end

items["money"] = {"Bani", "Bani infasurati cu elastic.",function(args)
  local choices = {}
  local idname = args[1]

  choices["Despacheteaza"] = {function(player,choice,mod)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, idname)
      vRP.prompt(player, "Cat de mult sa despachetezi ? (max "..amount..")", "", function(player,ramount)
        ramount = parseInt(ramount)
        if vRP.tryGetInventoryItem(user_id, idname, ramount, true) then -- unpack the money
          vRP.giveMoney(user_id, ramount)
          vRP.closeMenu(player)
        end
      end)
    end
  end}

  return choices
end,0,"pocket"}

items["money_binder"] = {"Bani legati","Folosit sa lege 1000$ impreuna.",function(args)
  local choices = {}
  local idname = args[1]

  choices["Leaga Bani"] = {function(player,choice,mod) -- bind the money
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local money = vRP.getMoney(user_id)
      if money >= 1000 then
        if vRP.tryGetInventoryItem(user_id, idname, 1, true) and vRP.tryPayment(user_id,1000) then
          vRP.giveInventoryItem(user_id, "money", 1000, true)
          vRP.closeMenu(player)
        end
      else
        vRPclient.notify(player,{vRP.lang.money.not_enough()})
      end
    end
  end}

  return choices
end,0,"pocket"}

-- parametric weapon items
-- give "wbody|WEAPON_PISTOL" and "wammo|WEAPON_PISTOL" to have pistol body and pistol bullets

local get_wname = function(weapon_id)
  local name = string.gsub(weapon_id,"WEAPON_","")
  name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
  return name
end

--- weapon body
local wbody_name = function(args)
  return get_wname(args[2]).." body"
end

local wbody_desc = function(args)
  return ""
end

local wbody_choices = function(args)
  local choices = {}
  local fullidname = joinStrings(args,"|")

  choices["Echipeaza"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      if vRP.tryGetInventoryItem(user_id, fullidname, 1, true) then -- give weapon body
        local weapons = {}
        weapons[args[2]] = {ammo = 0}
        vRPclient.giveWeapons(player, {weapons})

        vRP.closeMenu(player)
      end
    end
  end}

  return choices
end

local wbody_weight = function(args)
  return 2.50
end

items["wbody"] = {wbody_name,wbody_desc,wbody_choices,wbody_weight,"gun"}

--- weapon ammo
local wammo_name = function(args)
  return get_wname(args[2]).." ammo"
end

local wammo_desc = function(args)
  return ""
end

local wammo_choices = function(args)
  local choices = {}
  local fullidname = joinStrings(args,"|")

  choices["Incarca"] = {function(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
      local amount = vRP.getInventoryItemAmount(user_id, fullidname)
      vRP.prompt(player, "Suma de incarcare ? (max "..amount..")", "", function(player,ramount)
        ramount = parseInt(ramount)

        vRPclient.getWeapons(player, {}, function(uweapons)
          if uweapons[args[2]] ~= nil then -- check if the weapon is equiped
            if vRP.tryGetInventoryItem(user_id, fullidname, ramount, true) then -- give weapon ammo
              local weapons = {}
              weapons[args[2]] = {ammo = ramount}
              vRPclient.giveWeapons(player, {weapons,false})
              vRP.closeMenu(player)
            end
          end
        end)
      end)
    end
  end}

  return choices
end

local wammo_weight = function(args)
  return 0.01
end

items["wammo"] = {wammo_name,wammo_desc,wammo_choices,wammo_weight,"gun"}

local supressor_choices = {}
supressor_choices["Echipeaza"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"supressor",1) then
      TriggerClientEvent('alex:supp', player)
    end
  end
end}

local flash_choices = {}
flash_choices["Echipeaza"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"flash",1) then
      TriggerClientEvent('alex:flashlight', player)
    end
  end
end}

local yusuf_choices = {}
yusuf_choices["Echipeaza"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"yusuf",1) then
      TriggerClientEvent('alex:yusuf', player)
    end
  end
end}

local grip_choices = {}
grip_choices["Echipeaza"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"grip",1) then
      TriggerClientEvent('alex:grip', player)
    end
  end
end}

items["supressor"] = {"Suppressor Arma","",function(args) return supressor_choices end,0.5}
items["flash"] = {"Flashlight Arma","",function(args) return flash_choices end,0.5}
items["yusuf"] = {"Paint Arma","",function(args) return yusuf_choices end,0.5}
items["grip"] = {"Grip Arma","",function(args) return grip_choices end,0.5}

return items
