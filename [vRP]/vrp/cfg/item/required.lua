local items = {}

items["medkit"] = {"Kit Medical", "Folosit Sa Aduca La Viata Oameni Lesinati.",nil,0.5,"pocket"}
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

------- Ammo
items["wammo|WEAPON_PISTOL"] = {"Munitie Pistol","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_PISTOL50"] = {"Munitie Pistol50","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_COMBATPISTOL"] = {"Munitie Combatpistol","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_SNSPISTOL"] = {"Munitie SNS","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_VINTAGEPISTOL"] = {"Gunsenberg","Mitraliera din 1997.",nil,0.1,"pocket"}
items["wammo|WEAPON_REVOLVER"] = {"Munitie Revolver","Mitraliera din 1997.",nil,0.1,"pocket"}
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
