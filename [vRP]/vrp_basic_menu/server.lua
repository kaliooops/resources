local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local htmlEntities = module("vrp", "lib/htmlEntities")

vRPbm = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_basic_menu")
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")
vRPbsC = Tunnel.getInterface("vRP_barbershop","vRP_basic_menu")
Tunnel.bindInterface("vRP_basic_menu",vRPbm)

local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})

function sendToDiscord(name, message)
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest('https://discord.com/api/webhooks/924203579441549353/zUeJ27Q2lr_WRjqblH6br9XYVHixChvWmqVWBny272tuloTPv5uAReBHXWiQw65lNSz6', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end

-- teleport waypoint
local choice_tptowaypoint = {function(player,choice)
	sendToDiscord(GetPlayerName(player), "Teleport to waypoint din k")
  	TriggerClientEvent("TpToWaypoint", player)
end, "Teleporteaza-te La Point-ul Setat."}

--toggle blips
local ch_blips = {function(player,choice)
	sendToDiscord(GetPlayerName(player), "Toggle blips din k")
  	TriggerClientEvent("showBlips", player)
end, "Porneste Blip-surile."}

local fixcharacter = {function(ply)
	TriggerClientEvent("raid_clothes:incarcaHainele",ply)
end, "Reparati Caracterul"}	

local jucator_check = {function(player,choice)
  	vRPclient.getNearestPlayer(player,{5},function(nplayer)
    	local nuser_id = vRP.getUserId({nplayer})
		if nuser_id ~= nil then
			vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
				if handcuffed then
    		  		vRPclient.notify(nplayer,{lang.police.menu.check.checked()})
    		  		vRPclient.getWeapons(nplayer,{},function(weapons)
    		    		-- prepare display data (money, items, weapons)
    		    		local money = vRP.getMoney({nuser_id})
    		    		local weapons_info = ""
    		    		for k,v in pairs(weapons) do
    		      			weapons_info = weapons_info.."<br />"..k.." ("..v.ammo..")"
    		    		end
			
    		    		vRPclient.setDiv(player,{"police_check",".div_police_check{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",lang.police.menu.check.info2({money,weapons_info})})
    		    		-- request to hide div
    		    		vRP.request({player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
    		      			vRPclient.removeDiv(player,{"police_check"})
    		    		end})
    		  		end)
    			else
    		  		vRPclient.notify(player,{"~r~Nu este incatusat!"})
				end
			end)
		else
			vRPclient.notify(player,{lang.common.no_player_near()})
		end
  	end)
end, "Perchezitioneaza cel mai apropiat jucator si vezi Banii si Armele de pe el!"}

hacktimes = {}
local ch_hack = {function(player,choice)
  	local user_id = vRP.getUserId({player})
  	if user_id ~= nil then
    	vRPclient.getNearestPlayer(player,{25},function(nplayer)
      		if nplayer ~= nil then
        	local nuser_id = vRP.getUserId({nplayer})
        		if nuser_id ~= nil then
					if(hacktimes[user_id] == nil)then
						vRPclient.notify(player, {"~b~[HACK] ~w~Asteapta 10 secunde!"})
						hacktimes[user_id] = true
		  				local nbank = vRP.getBankMoney({nuser_id})
          				local amount = math.floor(nbank*0.01)
						local nvalue = nbank - amount
						SetTimeout(10000, function()
		  					if math.random(1,100) == 1 then
								vRP.setBankMoney({nuser_id,nvalue})
								vRPclient.notify(nplayer,{"~b~[HACK] ~w~Ai hackuit ~r~".. amount .."$."})
								vRPclient.notify(player,{"~b~[HACK] ~r~Cineva te a hackuit! cu ~w~"..amount.."$!"})
								vRP.giveInventoryItem({user_id,"dirty_money",amount,true})
								vRP.logInfoToFile({"HackLogs.txt","["..user_id.."] "..vRP.getPlayerName({player}).." l-a hackuit pe ["..nuser_id.."] "..vRP.getPlayerName({nplayer}).." pentru "..amount.." $ Bani Murdari"})
		  					else
            					vRPclient.notify(nplayer,{"~g~Cineva a incercat sa te hackuiasca ai grija!!"})
            					vRPclient.notify(player,{"~b~[HACK] ~r~Hackuit metoda esuata!"})
							end
							hacktimes[user_id] = nil
						end)
					else
						vRPclient.notify(player,{"~b~[HACK] ~r~Ai dat deja Hack!"})
          	  			return
					end
        		else
          			vRPclient.notify(player,{lang.common.no_player_near()})
        		end
      		else
        		vRPclient.notify(player,{lang.common.no_player_near()})
      		end
    	end)
  	end
end,"Hack-uieste Cel Mai Apropiat Om."}

local ch_drag = {function(player,choice)
  	local user_id = vRP.getUserId({player})
  	if user_id ~= nil then
    	vRPclient.getNearestPlayer(player,{10},function(nplayer)
      		if nplayer ~= nil then
        		local nuser_id = vRP.getUserId({nplayer})
        		if nuser_id ~= nil then
		  			vRPclient.isHandcuffed(nplayer,{},function(handcuffed)
						if handcuffed then
							TriggerClientEvent("dr:drag", nplayer, player)
						else
							vRPclient.notify(player,{"Jucatorul nu este incatusat."})
						end
		  			end)
        		else
          			vRPclient.notify(player,{lang.common.no_player_near()})
        		end
      		else
        		vRPclient.notify(player,{lang.common.no_player_near()})
     	 	end
    	end)
  	end
end, "Ia pe sus cel mai apropiat jucator."}

storedWeps = {}
local choice_store_weapons = {function(player, choice)
    local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRPclient.isInComa(player,{}, function(in_coma)
			if in_coma then
				vRPclient.notify(player,{"~r~Esti lesinat!, Nu mai stochezi nici o arma!"})
			else
				vRPclient.isHandcuffed(player,{}, function(handcuffed)
					if handcuffed then
						vRPclient.notify(player,{"~r~Esti incatusat!, Nu mai stochezi nici o arma!"})
					else
        				if(storedWeps[user_id] == nil)then
           	 				vRPclient.notify(player, {"~g~Vei primii armele intr-un minut!"})
           					storedWeps[user_id] = true
							SetTimeout(60000, function()
               	 				vRPclient.getWeapons(player,{},function(weapons)
                	    			for k,v in pairs(weapons) do
                        				-- convert weapons to parametric weapon items
                        				vRP.giveInventoryItem({user_id, "wbody|"..k, 1, true})
                        				if v.ammo > 0 then
                            				vRP.giveInventoryItem({user_id, "wammo|"..k, v.ammo, true})
										end
									end
					  				vRPclient.giveWeapons(player,{{},true})
								end)
            					storedWeps[user_id] = nil
          		  			end)
        				else
            				vRPclient.notify(player,{"~r~Ai dat deja sa strangi armele!"})
          	  				return
        				end
					end
				end)
			end
		end)
	end
end, lang.police.menu.store_weapons.description()}

clearInv = {}
local clear_inventory = {function(player, choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRP.prompt({player, "SECURITY SYSTEM", "[STERGE si scrie 'CONFIRM' pentru a ARUNCA TOT DIN INVENTAR]", function(player,answer)
			answer = tostring(answer)
			if(string.lower(answer) == "confirm") then
				vRPclient.isInComa(player,{}, function(in_coma)
					if in_coma then
						vRPclient.notify(player,{"~b~[System]\n~w~Esti in coma, nu poti folosi aceasta functie."})
					else
						if(clearInv[user_id] == nil) then
							vRPclient.notify(player, {"~b~[System]\n~w~Inventarul tau se va sterge intr-un minut!"})
							clearInv[user_id] = true
							SetTimeout(60000, function()
								vRP.clearInventory({user_id})
								vRPclient.notify(player, {"~b~[System]\n~w~Inventarul tau a fost curatat cu succes."})
								clearInv[user_id] = nil
							end)
						else
							vRPclient.notify(player, {"~b~[System]\nAi folosit deja aceasta functie!"})
							return
						end
					end
				end)
			end
		end})
	end
end}

-- armor item
vRP.defInventoryItem({"body_armor","Armura","Armura de grad mare si calitate foarte buna, protectoare!..",function()
  	local choices = {}
  	choices["Echipeaza"] = {function(player,choice)
    	local user_id = vRP.getUserId({player})
    	if user_id ~= nil then
      		if vRP.tryGetInventoryItem({user_id, "body_armor", 1, true}) then
				BMclient.setArmour(player,{100,true})
        		vRP.closeMenu({player})
      		end
    	end
  	end}
  	return choices
end,5.00,"pocket"})


-- (server) called when a logged player spawn to check for vRP:jail in user_data

-- dynamic fine
local ch_fine = {function(player,choice) 
  	vRPclient.getNearestPlayers(player,{15},function(nplayers) 
		local user_list = ""
    	for k,v in pairs(nplayers) do
		  	user_list = user_list .. "[" .. vRP.getUserId({k}) .. "]" .. vRP.getPlayerName({k}) .. " | "
    	end 
		if user_list ~= "" then
	  		vRP.prompt({player,"Jucatori Apropiati:" .. user_list,"",function(player,target_id) 
	    		if target_id ~= nil and target_id ~= "" then 
	      			vRP.prompt({player,"Amenda Suma:","100",function(player,fine)
						if tonumber(fine) and fine ~= nil and fine ~= "" then 
	        				vRP.prompt({player,"Amenda Motiv:","",function(player,reason)
			    				if reason ~= nil and reason ~= "" then 
	        						local target = vRP.getUserSource({tonumber(target_id)})
									if target ~= nil then
										if((tonumber(fine) >= 1000000) and (fine ~= nil) and (fine ~= ""))then
  			    						 	fine = 1000000
										end
		        						if((tonumber(fine) <= 100) and (fine ~= nil) and (fine ~= ""))then
		        						  	fine = 100
		        						end
		        						if vRP.tryFullPayment({tonumber(target_id), tonumber(fine)}) then
           									vRP.insertPoliceRecord({tonumber(target_id), lang.police.menu.fine.record({reason,fine})})
            								vRPclient.notify(player,{lang.police.menu.fine.fined({reason,fine})})
           									vRPclient.notify(target,{lang.police.menu.fine.notify_fined({reason,fine})})
					  						local user_id = vRP.getUserId({player})
											vRP.logInfoToFile({"AmendaLogs.lua","["..user_id.."] "..vRP.getPlayerName({player}).." l-a amendat pe ["..target_id.."] "..vRP.getPlayerName({target}).." "..fine.."$ pentru "..reason})
											vRP.closeMenu({player})
            							else
              								vRPclient.notify(player,{lang.money.not_enough()})
            							end
				  					else
										vRPclient.notify(player,{"~r~Acel ID este invalid."})
				  					end
								else
				  					vRPclient.notify(player,{"~r~Nu poti amenda degeaba fara motiv."})
								end
	         	 			end})
						else
			  				vRPclient.notify(player,{"~r~Amenda ta trebuie sa fie o valoare."})
						end
	      			end})
        		else
          			vRPclient.notify(player,{"~r~Nici un jucator ID selectat."})
        		end 
	  		end})
    	else
      		vRPclient.notify(player,{"~r~Nici un jucator apropiat."})
    	end 
  	end)
end,"Amenda un jucator apropiat."}

local ch_spawnveh = {function(player,choice) 
	sendToDiscord(GetPlayerName(player), " a spawnat un vehicul k")
	local user_id = vRP.getUserId({player})
	vRP.prompt({player,"Model Vehicul:","",function(player,model)
		if model ~= nil and model ~= "" then
			BMclient.spawnVehicle(player,{model})
	  	else
			vRPclient.notify(player,{"~r~Trebuie sa pui un model de vehicul."})
		end
	end})
end,"Spawneaza un model vehicul."}

--[[local ch_askid = {function(player,choice)
	vRPclient.getNearestPlayer(player,{10},function(nplayer)
	  local nuser_id = vRP.getUserId({nplayer})
	  if nuser_id ~= nil then
		vRPclient.notify(player,{lang.police.menu.askid.asked()})
		vRP.request(nplayer,lang.police.menu.askid.request(),15,function(nplayer,ok)
		  if ok then
			vRP.getUserIdentity({nuser_id, function(identity)
			  if identity then
				-- display identity and business
				local name = identity.name
				local firstname = identity.firstname
				local age = identity.age
				local bname = ""
				local bcapital = 0
				local home = ""
				local number = ""
  
				vRP.getUserBusiness({nuser_id}, function(business)
				  if business then
					bname = business.name
					bcapital = business.capital
				  end
  
  
					local content = lang.police.identity.info({name,firstname,age,bname,bcapital})
					vRPclient.setDiv(player,{"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-weight: bold; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
					-- request to hide div
					vRP.request(player, lang.police.menu.askid.request_hide(), 1000, function(player,ok)
					  vRPclient.removeDiv(player,{"police_identity"})
					end)
				end})
			  end
		 	 end})
		  else
			vRPclient.notify(player,{lang.common.request_refused()})
		  end
		end)
	  else
		vRPclient.notify(player,{lang.common.no_player_near()})
	  end
	end)
  end, lang.police.menu.askid.description()}]]--

  local choice_revive = {function(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
	  vRPclient.isInComa(player,{}, function(in_coma)
		if in_coma then
		  vRPclient.notify(player,{"~r~Esti lesinat, nu poti ajuta persoana"})
		else
		  if vRP.isUserInFaction(user_id,"Smurd") then
			vRPclient.getNearestPlayer(player,{2},function(nplayer)
			  local nuser_id = vRP.getUserId({nplayer})
			  if nuser_id ~= nil then
				vRPclient.isInComa(nplayer,{}, function(in_coma)
				  if in_coma then
					if vRP.tryGetInventoryItem(user_id,"medkit",1,true) then
					  vRPclient.playAnim(player,{false,revive_seq,false})
					  SetTimeout(15000, function()
						vRPclient.varyHealth(nplayer,{100})
						Wait(10000)
						vRPclient.notify(nplayer,{"Se pare ca ai revenit pe pamant dar cu dureri de cap."})
						if in_coma then
						  vRPclient.varyHealth(nplayer,{100})
						end
					  end)
					end
				  else
					vRPclient.notify(player,{lang.emergency.menu.revive.not_in_coma()})
				  end
				end)
			  else
				vRPclient.notify(player,{lang.common.no_player_near()})
			  end
			end)
		  end
		end
	  end)
	else
	  vRPclient.notify(player,{"~r~Esti Off Duty Nu Poti Folosi Acest Lucru"})
	end
  end,lang.emergency.menu.revive.description()}


local ch_gps = {
	function(player, choice) 
		locatii = {
			["[Diamond Casino]"] = {935.09942626954,46.709300994874,81.095748901368},
			["[Spawn]"] = {-543.03784179688,-208.07373046875,37.649795532226},
			["[Job Center]"] = {-266.828125,-960.37939453125,31.223142623902},
			["[Showroom]"] = {-34.220481872558,-1102.599975586,26.422355651856},
			["[Car Rent Luxury]"] = {-573.86535644532,329.07540893554,84.58935546875},
			["[Paint Ball]"] = {-1085.5642089844,-1279.6027832032,5.6526222229004},
			["[Buletin]"] = {-539.47302246094,-215.08837890625,37.64979171753},
			["[Sala de Forte]"] = {256.39056396484,-263.98748779296,53.963500976562},
		  }
		  
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
		  local menu_gps = {}
		  for k, v in pairs(locatii) do
			menu_gps[k] = {function(player, choice)
			  vRPclient.setGPS(player, {v[1], v[2]})
			  vRP.closeMenu({player})
			end, ""}
		  end
		  vRP.openMenu({player, menu_gps})
		end
	end, "GPS"
}
local ch_player_menu = {function(player,choice)
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = "Jucator"
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
	menu.onclose = function(player) vRP.openMainMenu({player}) end

    if vRP.isUserInFaction({user_id,"S.I.A.S"}) then
		menu["Depoziteaza armele"] = choice_store_weapons
	end
	if vRP.isUserInFaction({user_id,"Smurd"})then 
		choices["Ofera Prim Ajutor"] = choice_revive
	end

	menu["Perchezitioneaza"] = jucator_check
	menu["Fixeaza Skin"] = fixcharacter
	menu["Curata tot inventarul"] = clear_inventory
	menu["Ask open trunk"] = ch_asktrunk
	menu["Cere Buletin"] = ch_askid
	
	vRP.openMenu({player, menu})
end}



-- REGISTER MAIN MENU CHOICES
vRP.registerMenuBuilder({"main", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
	local choices = {}

	choices["Jucator"] = ch_player_menu
	choices["GPS"] = ch_gps

    if vRP.hasGroup({user_id,"Hacker"}) then
    	choices["Hack"] = ch_hack --  1 in 100 chance of stealing 0.1% of nearest player bank
    end
	
    add(choices)
  end
end})

local ch_asktrunk = {function(player,choice) 
	vRPclient.getNearestPlayer(player,{10},function(nplayer)
	  local nuser_id = vRP.getUserId({nplayer})
	  if nuser_id ~= nil then
		vRPclient.notify(player,{lang.vehicle.asktrunk.asked()})
		vRP.request(nplayer,lang.vehicle.asktrunk.request(),15,function(nplayer,ok)
		  if ok then -- request accepted, open trunk
			vRPclient.getNearestOwnedVehicle(nplayer,{7},function(ok,vtype,name)
			  if ok then
				local chestname = "u"..nuser_id.."veh_"..string.lower(name)
				local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(name)] or cfg_inventory.default_vehicle_chest_weight
  
				-- open chest
				local cb_out = function(idname,amount)
				  vRPclient.notify(nplayer,{lang.inventory.give.given({vRP.getItemName(idname),amount})})
				end
  
				local cb_in = function(idname,amount)
				  vRPclient.notify(nplayer,{lang.inventory.give.received({vRP.getItemName(idname),amount})})
				end
  
				vRPclient.vc_openDoor(nplayer, {vtype,5})
				vRP.openChest(player, chestname, max_weight, function()
				  vRPclient.vc_closeDoor(nplayer, {vtype,5})
				end,cb_in,cb_out)
			  else
				vRPclient.notify(player,{lang.vehicle.no_owned_near()})
				vRPclient.notify(nplayer,{lang.vehicle.no_owned_near()})
			  end
			end)
		  else
			vRPclient.notify(player,{lang.common.request_refused()})
		  end
		end)
	  else
		vRPclient.notify(player,{lang.common.no_player_near()})
	  end
	end)
end,"Ask open trunk."}

local a_revive = {function(player,choice) 
	vRP.prompt({player,"ID:","",function(player,target_id) 
		if target_id ~= nil and target_id ~= "" then
			local nplayer = vRP.getUserSource({tonumber(target_id)})
			if nplayer ~= nil then
				vRPclient.isInComa(nplayer,{}, function(in_coma)
					if in_coma then
						vRPclient.varyHealth(nplayer,{100})
						SetTimeout(1000, function()
							vRPclient.varyHealth(nplayer,{100})
						end)
						vRPclient.notify(player,{"I-ai dat revive lui ~r~"..vRP.getPlayerName({nplayer})})
                		vRPclient.notify(nplayer,{"Ai primit revive de la ~r~"..vRP.getPlayerName({player})})
						vRP.sendStaffMessage({"^2"..vRP.getPlayerName({player}).." i-a dat revive lui "..vRP.getPlayerName({nplayer})})
					else
						vRPclient.notify(player,{"~r~[System]\n~w~Jucatorul nu este in coma."})
					end
				end)
			else
				vRPclient.notify(player,{"~r~[System]\n~w~Acest ID pare invalid."})
			end
		else
			vRPclient.notify(player,{"~r~[System]\n~w~Nu ai selectat niciun ID."})
		end 
	end})
end}


local muted = {}

local a_mute = {function(player,choice) 
  vRP.prompt({player,"ID Jucator:","",function(player,target_id) 
    if target_id ~= nil and target_id ~= "" then 
      local nplayer = vRP.getUserSource({tonumber(target_id)})
      if nplayer then
        vRP.prompt({player,"Timp:","",function(player,minutes) 
          if (tonumber(minutes)) then
            if(muted[nplayer] == nil)then
              muted[nplayer] = nplayer
              --TriggerClientEvent('chatMessage', player, "^4I-ai dat mute lui ^6"..GetPlayerName(nplayer).." ^3 pentru ^6"..minutes.." minute") 
			--   TriggerClientEvent('chatMessage', -1, "", {0,0,0}, "^4I-ai dat mute lui ^6"..GetPlayerName(nplayer).." ^3 pentru ^6"..minutes.." minute")
			--   TriggerClientEvent('chatMessage', -1, "", {0,0,0}, "^4Ai primit mute de la ^6"..GetPlayerName(player).." ^3 pentru ^6"..minutes.." minute")
			  PerformHttpRequest("https://discord.com/api/webhooks/924203579441549353/zUeJ27Q2lr_WRjqblH6br9XYVHixChvWmqVWBny272tuloTPv5uAReBHXWiQw65lNSz6", function(err, text, headers) end, 'POST', json.encode({content = ""..GetPlayerName(nplayer).."  a primit mute "..minutes.." minute de la "..GetPlayerName(player)}), { ['Content-Type'] = 'application/json' })
			--   TriggerClientEvent('chatMessage', -1, "", {0,0,0}, "^6"..GetPlayerName(nplayer).." ^3 a primit mute ^6"..minutes.." minute ^3de la ^6"..GetPlayerName(player))
              --TriggerClientEvent('chatMessage', nplayer, "^4Ai primit mute de la ^6"..GetPlayerName(player).." ^3 pentru ^6"..minutes.." minute") 
              --TriggerClientEvent('chatMessage', -1, "^6"..GetPlayerName(nplayer).." ^3 a primit mute ^6"..minutes.." minute ^3de la ^6"..GetPlayerName(player))
              SetTimeout(minutes*60000, function()
                if(muted[nplayer] ~= nil)then
                  muted[nplayer] = nil
                  --TriggerClientEvent('sonydamuielasclavi', nplayer, "^3Mute-ul ti-a expirat!") 
				  vRPclient.notify(nplayer,{"Mute-ul ti-a expirat!"})

                end
              end)
            else
              TriggerClientEvent('chatMessage', player, "^3Jucatorul are deja mute!") 
            end
          else
            vRPclient.notify(player,{"~r~Minutele trebuie sa fie numere!"})
          end
        end})
      else
        vRPclient.notify(player,{"~r~Nu a fost gasit niciun jucator!"})
      end
    else
      vRPclient.notify(player,{"~r~Niciun ID de jucator nu a fost selectat."})
    end 
  end})
end,"Mute Jucator"}

local a_unmute = {function(player,choice) 
  vRP.prompt({player,"ID Jucator:","",function(player,target_id) 
    if target_id ~= nil and target_id ~= "" then 
      local nplayer = vRP.getUserSource({tonumber(target_id)})
      if nplayer then
        if(muted[nplayer] ~= nil)then
          TriggerClientEvent('chatMessage', nplayer, "^3Mute-ul ti-a fost scos de catre ^6"..GetPlayerName(player)) 
          TriggerClientEvent('chatMessage', player, "^3I-ai scos mute-ul lui ^6"..GetPlayerName(nplayer))
		  PerformHttpRequest("https://discord.com/api/webhooks/924203579441549353/zUeJ27Q2lr_WRjqblH6br9XYVHixChvWmqVWBny272tuloTPv5uAReBHXWiQw65lNSz6", function(err, text, headers) end, 'POST', json.encode({content = ""..GetPlayerName(player).." ia dat unmute lui "..GetPlayerName(nplayer)..""}), { ['Content-Type'] = 'application/json' })
                    TriggerClientEvent('chatMessage', -1, "^6"..GetPlayerName(nplayer).." ^3 a primit unmute de la ^6"..GetPlayerName(player))              
          muted[nplayer] = nil
        else
          vRPclient.notify(player,{"~r~Acel jucator nu are mute."})
        end
      else
        vRPclient.notify(player,{"~r~Nu a fost gasit niciun jucator."})
      end
    else
      vRPclient.notify(player,{"~r~Niciun ID de jucator nu a fost selectat."})
    end 
  end})
end,"UnMute Jucator"}

AddEventHandler('chatMessage', function(thePlayer, color, message)
    if (muted[thePlayer] ~= nil) then
        TriggerClientEvent('chatMessage', thePlayer, "^0[Server] Nu poti vorbi, ai mute!")
    CancelEvent()
    end
end)

local spawn_scuter = {function(player,choice)
	TriggerClientEvent("admin:spawnScuter",player, "aerox155")
end, "Spawn Scuter"}


vRP.registerMenuBuilder({"admin", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}
	if vRP.isUserHeadOfStaff({user_id}) then
		choices["Blips"] = ch_blips
	end
	if vRP.isUserAdmin({user_id}) then
		choices["Scoate de la inchisoare"] = ch_unjail
		choices["SpawnVeh"] = ch_spawnveh
	end
	if vRP.isUserMod({user_id}) then
	end
	if vRP.isUserTrialHelper({user_id}) then
		choices["Admin Revive"] = a_revive
		choices["Mute"] = a_mute
		choices["UnMute"] = a_unmute
		choices['Scuter'] = spawn_scuter
	end

	
    add(choices)
  end
end})

local ch_radar = {function(player,choice)
	local user_id = vRP.getUserId({player})
	TriggerEvent("Politie:Radar", player)
end, "Seteaza radarul"}


local ch_jail = {function(player,choice)
	local user_id = vRP.getUserId({player})

	--prompt user to enter an id and print it
	vRP.prompt({player,"ID Jucator:","",function(player,target_id) 
		vRP.prompt({player,"Timp in secunde:","",function(player,secunde) 
			TriggerEvent("jailaplayer",player, target_id, secunde)
		end})		
	end})

end, "Trimite la inchisoare"}


vRP.registerMenuBuilder({"police", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
	local choices = {}
	
	--if vRP.hasGroup({user_id,"onduty"}) then
		if vRP.isUserInFaction({user_id,"Politia Romana"}) or vRP.isUserInFaction({user_id,"S.I.A.S"}) then
    		choices["Trimite la inchisoare"] = ch_jail
    		choices["Scoate de la inchisoare"] = ch_unjail
			choices["Amendeaza"] = ch_fine
			choices["Radar"] = ch_radar

		end
		if vRP.isUserInFaction({user_id,"Politia Romana"}) or vRP.isUserInFaction({user_id,"S.I.A.S"}) or vRP.isUserInFaction({user_id,"Y.A.D"}) or vRP.isUserInFaction({user_id,"SRI"}) or vRP.isUserInFaction({user_id,"Triadele"}) or vRP.isUserInFaction({user_id,"Groove Street"}) or vRP.isUserInFaction({user_id,"Bloods"}) or vRP.isUserInFaction({user_id,"KMN Gang"}) or vRP.isUserInFaction({user_id,"Mafia Albaneza"}) or vRP.isUserInFaction({user_id,"Mafia Siciliana"}) or vRP.isUserInFaction({user_id,"Sinaloa Cartel"}) or vRP.isUserInFaction({user_id,"Mafia Civila"}) or vRP.isUserInFaction({user_id,"La Famillia"}) or vRP.isUserInFaction({user_id,"Mafia Camorra"})  or vRP.isUserInFaction({user_id,"Mafia Ndrangheta"})  or vRP.isUserInFaction({user_id,"Mafia Yakuza"}) then
    		choices["Ridica"] = ch_drag
		end
		add(choices)
	--end
  end
end})

local shop_sponsor = {function(player,choice) 
	local src = player
	TriggerEvent("sponsor:activate", src)
end,"150 Diamante"}

local shop_VIP = {
	Bronze = {
		function(player,choice) 
			local src = player
			TriggerEvent("vip:activate", src, "VIP Bronze")
		
		end,"50 Diamante"
	},
	Silver = {
		function(player,choice)
			local src = player
			TriggerEvent("vip:activate", src, "VIP Silver")
		end,"100 Diamante"
	},
	Gold = {
		function(player,choice)
			local src = player
			TriggerEvent("vip:activate", src, "VIP Gold")
		end,"200 Diamante"
	},
	Diamond = {
		function(player,choice)
			local src = player
			TriggerEvent("vip:activate", src, "VIP Diamond")
		end,"400 Diamante"
	},

	Platinum = {
		function(player,choice)
			local src = player
			TriggerEvent("vip:activate", src, "VIP Platinum")
		end,"800 Diamante"
	}
}


local shop_Money = {function(player,choice)
	local src = player
	local user_id = vRP.getUserId({src})
	local diamonds = vRP.getKRCoins({user_id})
	if diamonds >= 100 then
		vRP.giveKRCoins({user_id, -100})
		vRP.giveMoney({user_id, 50000})
		vRPclient.notify(src,{"Ai platit ~g~100 Diamante ~w~pentru ~g~$50.000"})
		TriggerClientEvent('chatMessage', -1, "^6"..GetPlayerName(player).." ^3 a cumparat ^6$50.000^0 din ^6 shop")

	else
		vRPclient.notify(src,{"Nu ai destule diamante"})
	end

end,"100 Diamante"}

--using vrp build a new menu having a single choise "Sponsor"
vRP.registerMenuBuilder({"main", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
	local choices = {}
	
	choices["Shop"]= {function()
		--create new menu
		local menu = {name="Shop",css={top="75px",header_color="rgba(255,125,0,0.75)"}}
		menu['0.Sponsor'] = shop_sponsor
		menu['1.VIP Bronze'] = shop_VIP.Bronze
		menu['2.VIP Silver'] = shop_VIP.Silver
		menu['3.VIP Gold'] = shop_VIP.Gold
		menu['4.VIP Diamond'] = shop_VIP.Diamond
		menu['5.VIP Platinum'] = shop_VIP.Platinum
		menu['6.Bani $50.000'] = shop_Money


		--register choices and add them to the menu
		vRP.openMenu({data.player,menu})
		--close menu if esc is pressed
		menu.onclose = function(player) vRP.closeMenu({data.player}) end
		

	end, "Shop premium"}

	add(choices)
  end
end})



--[[local ch_player_menu = {function(player,choice)
	local user_id = vRP.getUserId({player})
	local menu = {}
	menu.name = "Jucator"
	menu.css = {top = "75px", header_color = "rgba(0,0,255,0.75)"}
    menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
	
    --if vRP.hasPermission({user_id,"player.store_money"}) then
    --  menu["Store money"] = choice_store_money -- transforms money in wallet to money in inventory to be stored in houses and cars
    --end
	--
    if vRP.hasPermission({user_id,"player.fix_haircut"}) then
      --menu["Fix Haircut"] = ch_fixhair
	  menu["Ask open trunk"] = ch_asktrunk
	  menu["Cere Buletin"] = ch_askid
    end
	--
    --if vRP.hasPermission({user_id,"player.userlist"}) then
    --  menu["User List"] = ch_userlist -- a user list for players with vRP ids, player name and identity names only.
    --end
	
    --if vRP.hasPermission({user_id,"player.store_weapons"}) then
		theFaction = vRP.getUserFaction({user_id})
		fType = vRP.getFactionType({theFaction})
		if(fType ~= "Lege")then
			menu["Store weapons"] = choice_store_weapons -- store player weapons, like police store weapons from vrp
		end
    --end
	
    if vRP.hasPermission({user_id,"player.store_armor"}) then
      menu["Store armor"] = choice_store_armor -- store player armor
    end
	
    if vRP.hasPermission({user_id,"player.check"}) then
      menu["Inspect"] = choice_player_check -- checks nearest player inventory, like police check from vrp
    end
	
	vRP.openMenu({player, menu})
end}

-- REGISTER MAIN MENU CHOICES
vRP.registerMenuBuilder({"main", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}
	
    if vRP.hasPermission({user_id,"player.player_menu"}) then
      choices["Jucator"] = ch_player_menu -- opens player submenu
    end
	
    add(choices)
  end
end})]]
