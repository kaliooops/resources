
local items = {}

local function play_drink(player)
  local seq = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq,false})
end

local pills_choices = {}
pills_choices["Foloseste"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if(vRP.isUserInFaction(user_id,"Smurd") and vRP.hasGroup(user_id,"onduty"))then
      if vRP.tryGetInventoryItem(user_id,"pills",1) then
        vRPclient.varyHealth(player,{25})
        vRPclient.notify(player,{"~g~Folosind pilule."})
        play_drink(player)
        vRP.closeMenu(player)
      end
    else
      vRPclient.notify(player,{"~r~Nu poti folosi Pilulele, nu esti Medic."})
    end
  end
end}

local anti_drog = {}
anti_drog["Injecteaza"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		if vRP.tryGetInventoryItem(user_id,"antidrog",1) then
      vRPclient.notify(player,{"~g~Ti-ai administrat un anti-drog."})
      vRPclient.notify(player,{"~g~Efectele de la droguri par a fi disparute."})
      Wait(2000)
      TriggerClientEvent('removeDrugEffect', player, player)
			vRP.closeMenu(player)
		end
	end
end}

local function play_smoke(player)
  local seq2 = {
    {"mp_player_int_uppersmoke","mp_player_int_smoke_enter",1},
    {"mp_player_int_uppersmoke","mp_player_int_smoke",1},
    {"mp_player_int_uppersmoke","mp_player_int_smoke_exit",1}
  }

  vRPclient.playAnim(player,{true,seq2,false})
end

local smoke_choices = {}
smoke_choices["Foloseste"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"weed",1) then
      vRPclient.notify(player,{"~g~Fumand Iarba."})
      play_smoke(player)
      vRP.closeMenu(player)
    end
  end
end}

local green_choices = {}
green_choices["Foloseste"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"speish",1) then
      play_smoke(player)
      Wait(2000)
      TriggerClientEvent('addDrugEffect', player, player)
      vRPclient.varyHealth(player,{30})
      vRPclient.notify(player,{"~g~Auleo capusele mi-au intrat sub piele."})
      Wait(3000)
      vRPclient.notify(player,{"~g~Daca vreau sa dispara efectele astea\ntrebuie sa cumpar un ~y~Anti-Drog ~g~de la ~r~Farmacie~g~."})
      vRP.closeMenu(player)
		end
	end
end}

local green_choices2 = {}
green_choices2["Foloseste"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"mushroom",1) then
      play_smoke(player)
      Wait(2000)
      TriggerClientEvent('addDrugEffect', player, player)
      vRPclient.varyHealth(player,{31})
      vRPclient.notify(player,{"~g~Auleo ciupercile astea mi-au intrat rau."})
      vRP.closeMenu(player)
      Wait(3000)
      vRPclient.notify(player,{"~g~Daca vreau sa dispara efectele astea\ntrebuie sa cumpar un ~y~Anti-Drog ~g~de la ~r~Farmacie~g~."})
		end
	end
end}

local green_choices3 = {}
green_choices3["Foloseste"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"dmt",1) then
      play_smoke(player)
      Wait(2000)
      TriggerClientEvent('addDrugEffect', player, player)
      vRPclient.varyHealth(player,{32})
      vRPclient.notify(player,{"~g~Auleo DMT-ul mi-au intrat sub piele."})
      vRP.closeMenu(player)
      Wait(3000)
      vRPclient.notify(player,{"~g~Daca vreau sa dispara efectele astea\ntrebuie sa cumpar un ~y~Anti-Drog ~g~de la ~r~Farmacie~g~."})
		end
	end
end}

local green_choices4 = {}
green_choices4["Foloseste"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"thc",1) then
      play_smoke(player)
      Wait(2000)
      TriggerClientEvent('addDrugEffect', player, player)
      vRPclient.varyHealth(player,{33})
      vRPclient.notify(player,{"~g~Auleo THC-ul mi-a intrat sub piele."})
      vRP.closeMenu(player)
      Wait(3000)
      vRPclient.notify(player,{"~g~Daca vreau sa dispara efectele astea\ntrebuie sa cumpar un ~y~Anti-Drog ~g~de la ~r~Farmacie~g~."})
		end
	end
end}

local green_choices5 = {}
green_choices5["Foloseste"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"subutex",1) then
      play_smoke(player)
      Wait(2000)
      TriggerClientEvent('addDrugEffect', player, player)
      vRPclient.varyHealth(player,{34})
      vRPclient.notify(player,{"~g~Auleo Subutex-u mi-a intrat sub piele."})
      vRP.closeMenu(player)
      Wait(3000)
      vRPclient.notify(player,{"~g~Daca vreau sa dispara efectele astea\ntrebuie sa cumpar un ~y~Anti-Drog ~g~de la ~r~Farmacie~g~."})
		end
	end
end}

local green_choices6 = {}
green_choices6["Foloseste"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"amphetamine",1) then
      play_smoke(player)
      Wait(2000)
      TriggerClientEvent('addDrugEffect', player, player)
      vRPclient.varyHealth(player,{35})
      vRPclient.notify(player,{"~g~Auleo Amphetamina mi-a intrat sub piele."})
      vRP.closeMenu(player)
      Wait(3000)
      vRPclient.notify(player,{"~g~Daca vreau sa dispara efectele astea\ntrebuie sa cumpar un ~y~Anti-Drog ~g~de la ~r~Farmacie~g~."})
		end
	end
end}

local green_choices7 = {}
green_choices7["Foloseste"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"pcp",1) then
      play_smoke(player)
      Wait(2000)
      TriggerClientEvent('addDrugEffect', player, player)
      vRPclient.varyHealth(player,{36})
      vRPclient.notify(player,{"~g~Auleo PCP-ul mi-a intrat sub piele."})
      vRP.closeMenu(player)
      Wait(3000)
      vRPclient.notify(player,{"~g~Daca vreau sa dispara efectele astea\ntrebuie sa cumpar un ~y~Anti-Drog ~g~de la ~r~Farmacie~g~."})
		end
	end
end}

local green_choices8 = {}
green_choices8["Foloseste"] = {function(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"heroine",1) then
      play_smoke(player)
      Wait(2000)
      TriggerClientEvent('addDrugEffect', player, player)
      vRPclient.varyHealth(player,{40})
      vRPclient.notify(player,{"~g~Auleo Heroina mi-a intrat sub piele."})
      vRP.closeMenu(player)
      Wait(3000)
      vRPclient.notify(player,{"~g~Daca vreau sa dispara efectele astea\ntrebuie sa cumpar un ~y~Anti-Drog ~g~de la ~r~Farmacie~g~."})
		end
	end
end}

local function play_smell(player)
  local seq3 = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq3,false})
end

local smell_choices = {}
smell_choices["Foloseste"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"cocaine",1) then
      vRPclient.notify(player,{"~g~ Tragand pe nas cocaina."})
      play_smell(player)
      vRP.closeMenu(player)
    end
  end
end}

local preservative_choices = {}
preservative_choices["Foloseste"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"preservative",1) then
      vRPclient.notify(player,{"~g~ Ti-ai aplicat un Prezervativ pe Penis-ul tau Mic."})
      vRPclient.notify(player,{"~g~ Felicitari acum nu o sa mai faci Copii tura asta :)."})
      vRP.closeMenu(player)
    end
  end
end}

local function play_lsd(player)
  local seq4 = {
    {"mp_player_intdrink","intro_bottle",1},
    {"mp_player_intdrink","loop_bottle",1},
    {"mp_player_intdrink","outro_bottle",1}
  }

  vRPclient.playAnim(player,{true,seq4,false})
end

local lsd_choices = {}
lsd_choices["Foloseste"] = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    if vRP.tryGetInventoryItem(user_id,"lsd",1) then
      vRPclient.notify(player,{"~g~ Folosind LSD."})
      play_lsd(player)
      vRP.closeMenu(player)
    end
  end
end}

items["pills"] = {"Pilule","Un simplu tratament.",function(args) return pills_choices end,0.1,"pocket"}
items["weed"] = {"Iarba","Niste iarba.",function(args) return smoke_choices end,0.10,"pocket"}
items["cocaine"] = {"Cocaina","Niste cocaina.",function(args) return smell_choices end,0.5,"pocket"}
items["heroine"] = {"Heroina","Seringa de heroină de 0,5 mm",function(args) return green_choices8 end,0.9,"pocket"}
items["pcp"] = {"PCP","O tableta alba cu initialele PCP",function(args) return green_choices7 end,0.8,"pocket"}
items["amphetamine"] = {"Amphetamina","O fiola de amphetamina",function(args) return green_choices6 end,0.7,"pocket"}
items["subutex"] = {"Subutex","O substanta maro combinata cu apa",function(args) return green_choices5 end,0.6,"pocket"}
items["thc"] = {"Ulei THC","Un borcan de ulei THC",function(args) return green_choices4 end,0.5,"pocket"}
items["lsd"] = {"Lsd","Niste LSD.",function(args) return lsd_choices end,0.1,"pocket"}
items["dmt"] = {"DMT","Tablete colorate DMT",function(args) return green_choices3 end,0.4,"pocket"}
items["mushroom"] = {"Ciuperci Rosi","Date la stiinta.",function(args) return green_choices2 end,0.2,"pocket"}
items["preservative"] = {"Preservative","Fara copii viata usoara.",function(args) return preservative_choices end,0.2,"pocket"}
items["lockpick"] = {"Lockpick","Deschide usi.",function(args) return green_choices end,0.2,"pocket"}
items["speish"] = {"Speish","Halucinare.",function(args) return green_choices end,0.2,"pocket"}
items["antidrog"] = {"Anti-Drog","O injectie anti-drog puternica pentru eliminarea efectelor!",function(args) return anti_drog end,0.1,"pocket"}
items["ginseng"] = {"Ginseng","Bun pentru ceai si viata.",function(args) return lsd_choices end,0.2,"pocket"}
items["paracetamol"] = {"Paracetamol","Elimina durerea.",function(args) return lsd_choices end,0.2,"pocket"}
items["morfina"] = {"Morfina","Elimina durerea.",function(args) return lsd_choices end,0.2,"pocket"}
items["glicina"] = {"glicina","Licina flori indiene.",function(args) return lsd_choices end,0.2,"pocket"}

------------------------------------------ Event
items["Portocala"] = {"Portocala","O portocala gustoasa.",function(args) return lsd_choices end,0.2,"pocket"}
items["Ciocolata"] = {"Ciocolata","O ciocolata dulce.",function(args) return lsd_choices end,0.2,"pocket"}
items["k2uri"] = {"k2uri","Cadouri de la Mosu.",function(args) return lsd_choices end,0.5,"pocket"}
items["Globulete"] = {"Globulete","Nu ai fost cuminte, ai primit Globulete.",function(args) return lsd_choices end,0.2,"pocket"}


return items