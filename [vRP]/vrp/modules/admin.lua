local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")

local titles = { "Helper in teste", "Helper", "Moderator", "Super Moderator", "Admin", "Super Admin", "Head Of Staff", "Supporter", "Co-Fondator", "Fondator" }

function vRP.getUserTalentAdmin(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		talentLevel = tmp.talentLevel
	end
	return talentLevel or 0
end

function vRP.isAdmin(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		talentLevel = tmp.talentLevel
	end
	if (talentLevel > 0) then
		return true
	else
		return false
	end
end

function vRP.isUserTrialHelper(user_id)
	local talentLevel = vRP.getUserTalentAdmin(user_id)
	if(talentLevel >= 1)then
		return true
	else
		return false
	end
end

function vRP.isUserHelper(user_id)
	local talentLevel = vRP.getUserTalentAdmin(user_id)
	if(talentLevel >= 2)then
		return true
	else
		return false
	end
end

function vRP.isUserMod(user_id)
	local talentLevel = vRP.getUserTalentAdmin(user_id)
	if(talentLevel >= 3)then
		return true
	else
		return false
	end
end

function vRP.isUserModAvansat(user_id)
	local talentLevel = vRP.getUserTalentAdmin(user_id)
	if(talentLevel >= 4)then
		return true
	else
		return false
	end
end

function vRP.isUserAdmin(user_id)
	local talentLevel = vRP.getUserTalentAdmin(user_id)
	if(talentLevel >= 5)then
		return true
	else
		return false
	end
end

function vRP.isUserSuperAdmin(user_id)
	local talentLevel = vRP.getUserTalentAdmin(user_id)
	if(talentLevel >= 6)then
		return true
	else
		return false
	end
end

function vRP.isUserHeadOfStaff(user_id)
	local talentLevel = vRP.getUserTalentAdmin(user_id)
	if(talentLevel >= 7)then
		return true
	else
		return false
	end
end

function vRP.isUserSupporter(user_id)
	local talentLevel = vRP.getUserTalentAdmin(user_id)
	if(talentLevel >= 8)then
		return true
	else
		return false
	end
end

function vRP.isUserCoFondator(user_id)
	local talentLevel = vRP.getUserTalentAdmin(user_id)
	if(talentLevel >= 9)then
		return true
	else
		return false
	end
end

function vRP.isUserFondator(user_id)
	local talentLevel = vRP.getUserTalentAdmin(user_id)
	if(talentLevel >= 10)then
		return true
	else
		return false
	end
end

function vRP.getUserAdminTitle(user_id)
    local text = titles[vRP.getUserTalentAdmin(user_id)] or "Admin"
    return text
end

function vRP.setUserAdminLevel(user_id,admin)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.talentLevel = admin
	end
	exports.ghmattimysql:execute("UPDATE vrp_users SET adminLvl = @adminLevel WHERE id = @user_id", {user_id = user_id, adminLevel = admin}, function()end)
end

function vRP.getOnlineStaff()
	local oUsers = {}
	for k,v in pairs(vRP.rusers) do
		if vRP.isUserTrialHelper(tonumber(k)) then table.insert(oUsers, tonumber(k)) end
	end
	return oUsers
end

function vRP.salariuSound(source)
	TriggerClientEvent("InteractSound_CL:PlayOnOne", source, "salariu", 0.8)
end

function vRP.logInfoToFile(file,info)
  	file = io.open(file, "a")
  	if file then
  	  	file:write(os.date("%c").." => "..info.."\n")
  	end
  	file:close()
end

RegisterCommand("clr",function(source,args)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.isUserSuperAdmin(user_id) then
		TriggerClientEvent('chatMessage', -1, "^3k2:^0 "..GetPlayerName(source).." [^1"..user_id.."^0] a activat o stergere de Vehicule/Ped-uri/Entitati! Stergerea incepe in 30s")
          Wait(30000)
          for i,v in pairs(GetAllVehicles()) do 
            DeleteEntity(v)
         end
         for i,v in pairs(GetAllPeds()) do 
           DeleteEntity(v)
        end
        for i,v in pairs(GetAllObjects()) do
           DeleteEntity(v)
        end
		TriggerClientEvent('chatMessage', -1, "^3k2:^0 Toate vehiculele/enitatile/ped-urile au fost sterse")
        else 
        print(GetPlayerName(source) .. ' is cheating! He\'s triggering events without permission')
    end
end)

function vRP.sendStaffMessage(msg)
	for k, v in pairs(vRP.rusers) do
		local ply = vRP.getUserSource(tonumber(k))
		if vRP.isUserTrialHelper(k) and ply then
			TriggerClientEvent("chatMessage", ply, msg)
		end
	end
end

local function ch_addgroup(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
	  vRP.prompt(player,"User id: ","",function(player,id)
		id = parseInt(id)
		vRP.prompt(player,"Group to add: ","",function(player,group)
		  vRP.addUserGroup(id,group)
		  Wait(150)
		  vRPclient.notify(player,{group.." adaugat ID-ului "..id})
		  vRP.sendStaffMessage("^1"..vRP.getPlayerName(player).." ("..user_id..") l-a adaugat pe "..id.." in grupul '"..group.."'")
		end)
	  end)
	end
end

local function ch_removegroup(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID: ","",function(player,id)
			id = parseInt(id)
			nplayer = vRP.getUserSource(tonumber(id))
			if(tonumber(id)) and (id > 0) and (id ~= "") and (id ~= nil)then
				if nplayer ~= nil then
					vRP.prompt(player,"Grad de scos: ","",function(player,group)
						if group ~= nil then
							vRP.removeUserGroup(id,group)
							vRPclient.notify(player,{group.." scos ID-ului "..id})
							vRP.sendStaffMessage("^1"..vRP.getPlayerName(player).." ("..user_id.." ) i-a scos lui ^2"..id..", grupul '"..group.."'")
						end
					end)
				else
					vRPclient.notify(player,{"~r~Jucatorul nu este online!"})
				end
			else
				vRPclient.notify(player,{"~r~ID-ul pare invalid!"})
			end
		end)
	end
end


RegisterCommand("kick", function(src, args, x)
	if #args < 2 then
		TriggerClientEvent("chatMessage", src, "[^1K2^0] Usage: /kick [id] [reason]")
		return
	end
	local reason = table.concat(args, " ")
	reason = string.sub(reason, string.len(args[1]) + 2, -1)
	local id = vRP.getUserId(src)

	if vRP.isUserTrialHelper(id) and vRP.getUserSource(tonumber(args[1])) ~= nil then
		vRP.kick(tonumber(args[1]), reason)
		vRPclient.notify(player,{"[~y~K2~w~] Jucatorul a fost dat afara"})
	end
end, false)

RegisterCommand("ban", function(src, args, x)
	if #args < 3 then
		-- print("[DESYNC] Usage: /ban [user_id] [time] [reason]")
		TriggerClientEvent("chatMessage", src,"[^1K2^0] Usage: /ban [id] [zile] [motiv]")
		return
	end
	local reason = table.concat(args, " ")
	reason = string.sub(reason, string.len(args[2]) + 2, -1)
	local id = vRP.getUserId(src)
	local t_id = tonumber(args[1])
	
	if vRP.isUserHelper(id) and vRP.getUserSource(tonumber(args[1])) ~= nil then
		vRP.setBannedTemp(t_id,true,reason,src,tonumber(args[2]))
		DropPlayer(vRP.getUserSource(t_id), reason)
	end
end, false)


local function ch_kick(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID: ","",function(player,id)
			id = parseInt(id)
      		local source = vRP.getUserSource(id)
      		if(tonumber(id) and (id ~= "") and (id > 0))then
				if(id == 1)then
					vRPclient.notify(player,{"~r~Nu ai cum sa imi dai kick fraiere!"})
      			else
					vRP.prompt(player,"Motiv: ","",function(player,reason)
						if reason ~= "" then
							local source = vRP.getUserSource(id)
							if source ~= nil then
								TriggerClientEvent("chatMessage", -1, "^1Kick: "..vRP.getPlayerName(source).." a fost dat afara de catre ".. vRP.getPlayerName(player) ..", motiv: ".. reason)
								vRP.kick(source,reason)
        					else
          						vRPclient.notify(player,{"[~y~k2~w~] Jucatorul nu este online!"})
							end
						else
							vRPclient.notify(player,{"[~y~k2~w~] Trebuie sa completezi motivul."})
						end
        			end)
      			end
    		else
      			vRPclient.notify(player,{"[~y~k2~w~] ID-ul pare invalid!"})
			end
    	end)
	end
end

local function ch_ban(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID (BAN PERMANENT): ","",function(player,id)
      		id = parseInt(id)
      		local source = vRP.getUserSource(id)
      		if(tonumber(id) and (id ~= "") and (id > 0))then
				if(id == 1)then
					if(source ~= nil)then
						TriggerClientEvent('chatMessage', -1, "^3k2: ^0Bai ^8"..vRP.getPlayerName(player).."^0, sa ne bagam pula in tine, (a incercat sa ii dea ban lui HyPer <3)!")
					end
      			else
					vRP.prompt(player,"Motiv: ","",function(player,reason)
						if reason ~= "" then
							local source = vRP.getUserSource(id)
							if source ~= nil then
								theFaction = vRP.getUserFaction(id)
								if(theFaction ~= "user")then
									vRP.removeUserFaction(id,theFaction)
								end
								TriggerClientEvent("chatMessage", -1, "^1Ban Online: "..vRP.getPlayerName(source).." ("..id..") a fost banat permanent de "..vRP.getPlayerName(player).." ("..user_id.."), motiv: ".. reason)
								vRP.ban(source,reason,player)
								local embed = {
									{
									  ["color"] = 1234521,
									  ["title"] = "__".. "BAN".."__",
									  ["description"] = "Ban: ("..id..") a fost banat permanent de ("..user_id.."), motiv: ".. reason,
									  ["thumbnail"] = {
										["url"] = "https://i.imgur.com/Bi2iC6K.png",
									  },
									  ["footer"] = {
									  ["text"] = "",
									  },
									}
								  }
								  PerformHttpRequest('https://discord.com/api/webhooks/924111587328004096/Q3145No9FNr0ELFCQb_IorlIlmCa0_tYY_l82s8kfjtDzXE1BUkIKkif1HOEZ-EcHezU', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
							else
								exports.ghmattimysql:execute("SELECT username FROM vrp_users WHERE id = @user_id", {user_id = id}, function(rows)
								TriggerClientEvent("chatMessage", -1, "^1Ban Offline: "..tostring(rows[1].username).." ("..id..") a fost banat permanent de "..vRP.getPlayerName(player).." ("..user_id.."), motiv: ".. reason)
								vRP.setBanned(id,true,reason,player)
								local embed = {
									{
									  ["color"] = 1234521,
									  ["title"] = "__".. "BAN OFFLINE".."__",
									  ["description"] = "Ban: ("..id..") a fost banat permanent de ("..user_id.."), motiv: ".. reason,
									  ["thumbnail"] = {
										["url"] = "https://i.imgur.com/Bi2iC6K.png",
									  },
									  ["footer"] = {
									  ["text"] = "",
									  },
									}
								  }
								  PerformHttpRequest('https://discord.com/api/webhooks/924111587328004096/Q3145No9FNr0ELFCQb_IorlIlmCa0_tYY_l82s8kfjtDzXE1BUkIKkif1HOEZ-EcHezU', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
								end) 
							end
						else
							vRPclient.notify(player,{"~r~Trebuie sa completezi motivul."})
						end
       		 		end)
      			end
    		else
      			vRPclient.notify(player,{"~r~ID-ul pare invalid!"})
    		end
    	end)
	end
end

local function ch_banTemp(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID (BAN TEMPORAR): ","",function(player,id)
      		id = parseInt(id)
      		local source = vRP.getUserSource(id)
      		if(tonumber(id) and (id ~= "") and (id > 0))then
				if(id == 1)then
					if(source ~= nil)then
						TriggerClientEvent('chatMessage', -1, "^3k2: ^0Jucatorul ^8"..vRP.getPlayerName(player).."^0, Ai primit Ban!")
					end
      			else
					vRP.prompt(player,"Motiv: ","",function(player,reason)
						if reason ~= "" then
							vRP.prompt(player,"Timp (zile): ","",function(player,timp)
								timp = parseInt(timp)
								if tonumber(timp) and (timp ~= "") then
									if (timp > 0) and (timp <= 90) then
										local expireDate = vRP.getBannedExpiredDate(timp)
										local source = vRP.getUserSource(id)
										if source ~= nil then
											if(timp > 14)then
												theFaction = vRP.getUserFaction(id)
												if(theFaction ~= "user")then
													vRP.removeUserFaction(id,theFaction)
													vRP.removeUserGroup(id,"onduty")
												end
											end
											TriggerClientEvent("chatMessage", -1, "^1Ban Temporar Online: "..vRP.getPlayerName(source).." ("..id..") a fost banat temporar de "..vRP.getPlayerName(player).." ("..user_id..") pentru "..timp.." (de) zile, motiv: ".. reason)
											vRP.banTemp(source,reason,player,timp)
											local embed = {
												{
												  ["color"] = 1234521,
												  ["title"] = "__".. "BAN TEMPORAR".."__",
												  ["description"] = "Ban Temporar: ("..id..") a fost banat temporar de "..vRP.getPlayerName(player).." ("..user_id..") pentru "..timp.." (de) zile, motiv: ".. reason,
												  ["thumbnail"] = {
													["url"] = "https://i.imgur.com/Bi2iC6K.png",
												  },
												  ["footer"] = {
												  ["text"] = "",
												  },
												}
											  }
											  PerformHttpRequest('https://discord.com/api/webhooks/924111587328004096/Q3145No9FNr0ELFCQb_IorlIlmCa0_tYY_l82s8kfjtDzXE1BUkIKkif1HOEZ-EcHezU', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
										else
											exports.ghmattimysql:execute("SELECT username FROM vrp_users WHERE id = @user_id", {user_id = id}, function(rows)
											TriggerClientEvent("chatMessage", -1, "^1Ban Temporar Offline: "..tostring(rows[1].username).." ("..id..") a fost banat temporar de "..vRP.getPlayerName(player).." ("..user_id..") pentru "..timp.." (de) zile, motiv: ".. reason)
											vRP.setBannedTemp(id,true,reason,player,timp)
											local embed = {
												{
												  ["color"] = 1234521,
												  ["title"] = "__".. "BAN TEMPORAR OFFLINE".."__",
												  ["description"] = "Ban Temporar Offline: ("..id..") a fost banat temporar de "..vRP.getPlayerName(player).." ("..user_id..") pentru "..timp.." (de) zile, motiv: ".. reason,
												  ["thumbnail"] = {
													["url"] = "https://i.imgur.com/Bi2iC6K.png",
												  },
												  ["footer"] = {
												  ["text"] = "",
												  },
												}
											  }
											  PerformHttpRequest('https://discord.com/api/webhooks/924111587328004096/Q3145No9FNr0ELFCQb_IorlIlmCa0_tYY_l82s8kfjtDzXE1BUkIKkif1HOEZ-EcHezU', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
											end)
										end
									else
										vRPclient.notify(player,{"~r~Maxim 90 de zile (3 luni)"})
									end
								else
									vRPclient.notify(player,{"~r~Trebuie sa completezi perioada."})
								end
							end)
						else
							vRPclient.notify(player,{"~r~Trebuie sa completezi motivul."})
						end
       		 		end)
				end
    		else
      			vRPclient.notify(player,{"~r~ID-ul pare invalid."})
    		end
    	end)
	end
end

local function ch_unban(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
	  vRP.prompt(player,"ID (UNBAN): ","",function(player,id)
			id = parseInt(id)
		  if(tonumber(id) and (id ~= "") and (id > 0)) then
			  exports['ghmattimysql']:execute("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = id}, function(rows)
				PerformHttpRequest("https://discord.com/api/webhooks/924111587328004096/Q3145No9FNr0ELFCQb_IorlIlmCa0_tYY_l82s8kfjtDzXE1BUkIKkif1HOEZ-EcHezU", function(err, text, headers) end, 'POST', json.encode({content = ""..tostring(rows[1].username).." ("..id..") a fost debanat de catre "..vRP.getPlayerName(player).." ("..user_id..")"}), { ['Content-Type'] = 'application/json' })
				  TriggerClientEvent('chatMessage', -1, "^1"..tostring(rows[1].username).." ("..id..") a fost debanat de catre "..vRP.getPlayerName(player).." ("..user_id..")")
				  vRP.logInfoToFile("BanLogs.txt", vRP.getPlayerName(player).." ("..user_id..") l-a debanat pe "..tostring(rows[1].username).." ["..id.."]")		
				  vRP.setBannedTemp(id,false,"","",0)
			  end)
		  else
				vRPclient.notify(player,{"~r~ID-ul pare invalid."})
		   end
	  end)
	end
end

-- local function ch_kick(player,choice)
-- 	local user_id = vRP.getUserId(player)
-- 	if user_id ~= nil then
-- 		vRP.prompt(player,"ID-UL: ","",function(player,id)
-- 			id = parseInt(id)
-- 			vRP.prompt(player,"MOTIVUL: ","",function(player,reason)
-- 				local source = vRP.getUserSource(id)
-- 				if source ~= nil then	
-- 					TriggerClientEvent("chatMessage", -1, "[SYSTEM]", {255, 0, 0}, "^2Adminul ^3"..GetPlayerName(player).." ^2ia dat kick lui ^3"..GetPlayerName(source))
-- 					PerformHttpRequest("https://discord.com/api/webhooks/923356843957420072/qnIcyQDTtOyZxm49L9x13DqZSsPObCpXAkvTNPtZGzJ49ycJmI1a2hYMcr06fyhdI-pJ", function(err, text, headers) end, 'POST', json.encode({content = "Adminul "..GetPlayerName(player).." ia dat kick lui "..GetPlayerName(source)}), { ['Content-Type'] = 'application/json' })
-- 					TriggerClientEvent("chatMessage", -1, "[SYSTEM]", {255, 0, 0}, "^2Motiv: ^3"..reason)
-- 					vRP.kick(source,reason)
-- 					vRPclient.notify(player,{"kicked user "..id})
-- 				end
-- 			end)
-- 		end)
-- 	end
-- end

local function ch_coords(player,choice)
  	vRPclient.getPosition(player,{},function(x,y,z)
    	vRP.prompt(player,"Coordonate",x..","..y..","..z,function(player,choice) end)
  	end)
end

local function ch_tptome(player,choice)
  	vRPclient.getPosition(player,{},function(x,y,z)
    	vRP.prompt(player,"ID:","",function(player,user_id) 
     		local tplayer = vRP.getUserSource(tonumber(user_id))
      		if tplayer ~= nil then
        		vRPclient.teleport(tplayer,{x,y,z})
      		end
    	end)
  	end)
end

local function ch_tpto(player,choice)
  	vRP.prompt(player,"ID:","",function(player,user_id) 
    	local tplayer = vRP.getUserSource(tonumber(user_id))
    	if tplayer ~= nil then
      		vRPclient.getPosition(tplayer,{},function(x,y,z)
        		vRPclient.teleport(player,{x,y,z})
      		end)
    	end
  	end)
end

local function ch_tptocoords(player,choice)
  	vRP.prompt(player,"Coordonate X,Y,Z:","",function(player,fcoords) 
    local coords = {}
    for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
      	table.insert(coords,tonumber(coord))
    end

    	local x,y,z = 0,0,0
    	if coords[1] ~= nil then x = coords[1] end
    	if coords[2] ~= nil then y = coords[2] end
    	if coords[3] ~= nil then z = coords[3] end

    	vRPclient.teleport(player,{x,y,z})
  	end)
end

local function ch_givemoney(player,choice)
	local ID = vRP.getUserId(player)
	vRP.prompt(player, "ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource(user_id)
		if target ~= nil then
		vRP.prompt(player,"Suma:","",function(player,amount) 
			amount = parseInt(amount)
				if(tonumber(amount) ~= nil) and (tonumber(amount) ~= "")then
					if(tonumber(amount) > 0) and (tonumber(amount) <= 500000000)then
						vRP.giveMoney(user_id, amount)
						vRPclient.notify(player,{"~w~I-ai dat lui ~g~"..vRP.getPlayerName(target).." ~w~suma de ~g~".. vRP.formatMoney(amount) .." ~w~(de) €."})
						PerformHttpRequest("https://discord.com/api/webhooks/923356843957420072/qnIcyQDTtOyZxm49L9x13DqZSsPObCpXAkvTNPtZGzJ49ycJmI1a2hYMcr06fyhdI-pJ", function(err, text, headers) end, 'POST', json.encode({content = "".. vRP.getPlayerName(player) .." ia dat lui "..vRP.getPlayerName(target).." suma de ".. vRP.formatMoney(amount) ..""}), { ['Content-Type'] = 'application/json' })
						vRPclient.notify(target, {"~g~".. vRP.getPlayerName(player) .."~w~ ti-a dat ~g~".. vRP.formatMoney(amount) .." ~w~(de) €."})
					else
						vRPclient.notify(player, {"~w~Suma nu poate fii mai mare de 500.000.000 (de) €."})
					end
				else
					vRPclient.notify(player, {"~w~Suma introdusa trebuie sa fie formata doar din numere."})
				end
			end)
		else
			vRPclient.notify(player, {"~w~Jucatorul nu este online."})
		end
	end)
end

local function ch_takemoney(player,choice)
	local ID = vRP.getUserId(player)
	vRP.prompt(player, "ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource(user_id)
		if target ~= nil then
			vRP.prompt(player, "Suma: ", "", function(player, amount)
				amount = parseInt(amount)
				local tBani = tonumber(vRP.getMoney(user_id))
				if(tonumber(amount))then
					amount = tonumber(amount)
					if(tBani >= amount)then
						vRP.takeMoney(user_id,amount)
						vRPclient.notify(player,{"~w~I-ai luat lui ~g~"..vRP.getPlayerName(target).." ~w~suma de ~r~".. vRP.formatMoney(amount) .." ~w~(de) €."})
						vRPclient.notify(target, {"~g~".. vRP.getPlayerName(player) .."~w~ ti-a luat ~r~".. vRP.formatMoney(amount) .." ~w~(de) €."})
					else
						vRPclient.notify(player, {"~w~Jucatorul are doar ~b~"..vRP.formatMoney(tBani).." ~w~(de) €."})
					end
				else
					vRPclient.notify(player, {"~w~Suma introdusa trebuie sa fie formata doar din numere."})
				end
			end)
		else
			vRPclient.notify(player, {"~w~Jucatorul nu este online."})
		end
	end)
end

local function ch_takediamonds(player,choice)
	local ID = vRP.getUserId(player)
	vRP.prompt(player, "ID:", "", function(player, user_id)
		user_id = tonumber(user_id)
		local target = vRP.getUserSource(user_id)
		if target ~= nil then
			vRP.prompt(player, "Suma: ", "", function(player, amount)
				amount = parseInt(amount)
				local tBani = tonumber(vRP.getkrCoins(user_id))
				if(tonumber(amount))then
					amount = tonumber(amount)
					if(tBani >= amount)then
						vRP.takekrCoins(user_id,amount)
						vRPclient.notify(player,{"~w~I-ai luat lui ~g~"..vRP.getPlayerName(target).." ~w~suma de ~r~".. vRP.formatMoney(amount) .." ~w~(de) €."})
						vRPclient.notify(target, {"~g~".. vRP.getPlayerName(player) .."~w~ ti-a luat ~r~".. vRP.formatMoney(amount) .." ~w~(de) €."})
					else
						vRPclient.notify(player, {"~w~Jucatorul are doar ~b~"..vRP.formatMoney(tBani).." ~w~(de) €."})
					end
				else
					vRPclient.notify(player, {"~w~Suma introdusa trebuie sa fie formata doar din numere."})
				end
			end)
		else
			vRPclient.notify(player, {"~w~Jucatorul nu este online."})
		end
	end)
end

function vRP.createTicket(user_id)
	local players = {}
	local player = vRP.getUserSource(user_id)
	exports.ghmattimysql:execute('SELECT * FROM vrp_admin_tickets WHERE createdId = @user_id', {["user_id"] = user_id}, function(rows)
		if(#rows > 0)then
			vRPclient.notify(player,{"Ai facut recent un ticket!",2000,2})
		else
			vRPclient.notify(player,{"Ai apelat la asistenta unui admin.",2000,1})
			exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_admin_tickets(createdName,createdId,accepted) VALUES(@createdName,@createdId,@accepted)",{["createdName"] = GetPlayerName(player),["createdId"] = user_id, ["accepted"] = "Nu"})
			local all = vRP.getUsers()
  			for k,v in pairs(all) do
  			  local player = vRP.getUserSource(tonumber(k))
  			  if vRP.isUserTrialHelper(k) and player ~= nil then
  			    table.insert(players,player)
  			  end
  			end
		end
	end)
end

local ch_adminTicket = function(source,choice)
	local thePlayer = source
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		vRP.createTicket(user_id)
	end
end



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		spawnTickets()
	end
end)

function spawnTickets()
	local thePlayer = source
	local user_id = vRP.getUserId(source)
	exports.ghmattimysql:execute('SELECT * FROM vrp_admin_tickets', {["@id"] = user_id}, function(rows2)
		for i,p in pairs(rows2) do
			if p.accepted == "Nu" then
				vRPclient.setTickets(-1, {i})
			end
		end
	end)
end

ticksts = {}
targett = {}
tickete = {}
RegisterCommand("tk",function(source)
    local thePlayer = source
    local user_id = vRP.getUserId(thePlayer)
	isAdmin = vRP.isUserTrialHelper(user_id)
    if (isAdmin) then
		exports.ghmattimysql:execute('SELECT * FROM vrp_admin_tickets ORDER BY id ASC', {["@id"] = user_id}, function(rows)
			if #rows > 0 then
				for k,v in pairs(rows) do
					if v.accepted == "Nu" then
						ticksts = "Nu"
						targett = tonumber(v.createdId)
						target = vRP.getUserSource(tonumber(v.createdId))
						tickete = k
					else
						vRPclient.notify(thePlayer, {"Nu e nimeni care are nevoie de asistenta.",2000,2})
					end
				end
				if ticksts == "Nu" then
					vRPclient.getPosition(target, {}, function(x,y,z)
					vRPclient.teleport(thePlayer,{x,y,z})
						vRPclient.notify(thePlayer,{"Ai preluat un ticket administrativ",2000,1})
						vRP.sendStaffMessage("^3k2^0: ^0Ticketul lui ^1"..targett.." ^0a fost luat de ^1"..GetPlayerName(thePlayer))
						TriggerEvent("k2ANTICHEAT:logger", "tickets.txt", GetPlayerName(thePlayer) .. " a acceptat ticketul lui " ..targett)
						exports.ghmattimysql:execute("DELETE FROM vrp_admin_tickets WHERE createdId = @user_id",{["@user_id"] = targett})
						exports.ghmattimysql:execute("UPDATE `vrp_users` SET `raport` = `raport` + 1 WHERE `id` = @sender_id", {['@sender_id'] = user_id})
						for k,v in pairs(rows) do
							vRPclient.setTickets(-1, {k-1})
							if k <= 0 then
								vRPclient.setTickets(-1, {0})
							end
						end
					end)
				end
			else
				vRPclient.notify(thePlayer, {"Nu e nimeni care are nevoie de asistenta.",2000,2})
			end
		end)
    else
		vRPclient.notify(thePlayer, {"Nu ai acces la aceasta comanda.",2000,2})
    end
end)

local function ch_tptoplace(player,choice)
	local user_id = vRP.getUserId(source)
	vRP.prompt(player,"ID: ","",function(player,id) 
		local id = parseInt(id)
    vRP.prompt(player,"Unde vrei sa te teleportezi","[1] showroom, [2] spawn , [3] politie , [4] chilliad, [5] paleto, [6] spital, [7] fleeca",function(player,raspuns) 
			tp = parseInt(raspuns)
			if id ~= nil then
				local thePlayer = vRP.getUserSource(id)
				if thePlayer ~= nil then
					if tp == 1 then -- 150.85585021973,-1034.0541992188,29.34055519104
						vRPclient.notify(player,{"[TELEPORT] ~g~L-ai teleportat pe ~r~"..GetPlayerName(thePlayer).."~g~ la ~g~Showroom"})
						vRPclient.notify(thePlayer,{"[TELEPORT] ~g~Ai fost teleporat la ~g~Showroom~g~ de catre adminul ~r~"..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{-38.93639755249,-1110.4926757813,26.438550949097})
					elseif tp == 2 then
						vRPclient.notify(player,{"[TELEPORT] ~g~L-ai teleportat pe ~r~"..GetPlayerName(thePlayer).."~g~ la ~g~Spawn"})
						vRPclient.notify(thePlayer,{"[TELEPORT] ~g~Ai fost teleporat la ~g~Spawn~g~ de catre adminul ~r~"..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{-551.03076171875,-193.77301025391,38.219707489014})
					elseif tp == 3 then
						vRPclient.notify(player,{"[TELEPORT] ~g~L-ai teleportat pe ~r~"..GetPlayerName(thePlayer).."~g~ la ~g~Politie"})
						vRPclient.notify(thePlayer,{"[TELEPORT] ~g~Ai fost teleporat la ~g~Politie~g~ de catre adminul ~r~"..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{411.45886230469,-978.86260986328,30.391046524048})
					elseif tp == 4 then
						vRPclient.notify(player,{"[TELEPORT] ~g~L-ai teleportat pe ~r~"..GetPlayerName(thePlayer).."~g~ pe ~g~Chilliad"})
						vRPclient.notify(thePlayer,{"[TELEPORT] ~g~Ai fost teleporat pe ~g~Chilliad~g~ de catre adminul ~r~"..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{499.80303955078,5584.7534179688,793.84552001953})
					elseif tp == 5 then
						vRPclient.notify(player,{"[TELEPORT] ~g~L-ai teleportat pe ~r~"..GetPlayerName(thePlayer).."~g~ in ~g~Paleto"})
						vRPclient.notify(thePlayer,{"[TELEPORT] ~g~Ai fost teleporat in ~g~Paleto~g~ de catre adminul ~r~"..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{-115.30675506592,6457.3803710938,31.468444824219})
					elseif tp == 6 then
						vRPclient.notify(player,{"[TELEPORT] ~g~L-ai teleportat pe ~r~"..GetPlayerName(thePlayer).."~g~ la ~g~Spital"})
						vRPclient.notify(thePlayer,{"[TELEPORT] ~g~Ai fost teleporat la ~g~Spital~g~ de catre adminul ~r~"..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{-477.66040039063,-336.48040771484,34.38000869751})
					elseif tp == 7 then
						vRPclient.notify(player,{"[TELEPORT] ~g~L-ai teleportat pe ~r~"..GetPlayerName(thePlayer).."~g~ in ~g~Fleeca"})
						vRPclient.notify(thePlayer,{"[TELEPORT] ~g~Ai fost teleporat la ~g~Fleeca~g~ de catre adminul ~r~"..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{150.85585021973,-1034.0541992188,29.34055519104})
                                        elseif tp == 8 then
						vRPclient.notify(player,{"[TELEPORT] ~g~L-ai teleportat pe ~r~"..GetPlayerName(thePlayer).."~g~ in ~g~Fleeca"})
						vRPclient.notify(thePlayer,{"[TELEPORT] ~g~Ai fost teleporat la ~g~Fleeca~g~ de catre adminul ~r~"..GetPlayerName(player)})
						vRPclient.teleport(thePlayer,{333.1796875,166.22999572754,103.4575805664})

					end
				else
					vRPclient.notify(player,{"~r~Jucatorul nu este online!"})
				end
			else
				vRPclient.notify(player,{"~r~Jucatorul nu este online!"})
			end
		end)	
	end)
end

local function ch_givekrcoins(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
	  vRP.prompt(player,"ID:","",function(player,nplayer) 
		  if nplayer ~= "" or nplayer ~= nil then
			  target = vRP.getUserSource(tonumber(nplayer))
			  if target then
				  vRP.prompt(player,"Suma:","",function(player,amount) 
					  amount = parseInt(amount)
					  vRP.giveKRCoins(tonumber(nplayer), amount)
					  --vRPclient.notify(player,{"~w~I-ai dat lui "..vRP.getPlayerName(target)..", ~g~".. vRP.formatMoney(amount) .." ~w~(de) Diamante"})
					  vRPclient.notify(player,{"I-ai dat lui ~y~"..vRP.getPlayerName(target).." ~g~"..vRP.formatMoney(ammount).." ~w~diamante"})
				  end)
			  else
				  vRPclient.notify(player,{"Jucatorul nu a fost gasit."})
			  end
		  end
		end)
	 end
  end

local function ch_giveitem(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID:","",function(player,userID)
			userID = tonumber(userID)
			theTarget = vRP.getUserSource(userID)
			if(theTarget)then
				vRP.prompt(player,"Nume item:","",function(player,idname) 
					idname = idname or ""
					vRP.prompt(player,"Cantitate:","",function(player,amount) 
						amount = parseInt(amount)
						vRP.giveInventoryItem(userID, idname, amount, true)
					end)
				end)
			end
		end)
	end
end

local function ch_takeitem(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID:","", function(player,userID)
			userID = tonumber(userID)
			theTarget = vRP.getUserSource(userID)
			if(TheTarget) then
				vRP.prompt(player,"Nume item:","", function(player,idname)
					idname = idname or ""
					vRP.prompt(player,"Cantitate:","", function(player, amount)
						amount = parseInt(amount)
						vRP.tryGetInventoryItem(userID, idname, amount, true)
					end)	
				end)
			end
		end)
	end
end

local cfg_inventory = module("cfg/inventory")

function playerVehs(player,user_id)
	check_menu2 = {name="Vehicule",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
	local theVehicles = exports.ghmattimysql:executeSync("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id", {user_id = user_id})
	for i, v in pairs(theVehicles) do
		vehName, vehPrice = vRP.checkVehicleName(v.vehicle)
		check_menu2[vehName] = {function(player, choice) 
			local chestname = "u"..user_id.."veh_"..string.lower(v.vehicle)
			local max_weight = cfg_inventory.vehicle_chest_weights[string.lower(v.vehicle)] or cfg_inventory.default_vehicle_chest_weight
			
			vRP.adminCheckInventory(player, chestname, max_weight)
		end, "Model: <font color='green'>"..v.vehicle.."</font><br>Placuta: "..v.vehicle_plate.."<br>"}
	end
	vRP.closeMenu(player)
	SetTimeout(400, function()
		vRP.openMenu(player, check_menu2)
	end)
end

local function ch_checkplayer(player, choice)
	check_menu = {name="Verifica Jucator",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
	vRP.prompt(player, "Jucator ID:", "", function(player, user_id)
		user_id = parseInt(user_id)
		if(tonumber(user_id) and (user_id ~= "") and (user_id > 0)) then
			usrID = vRP.getUserId(player)
			if(user_id == 1)then
				TriggerClientEvent('chatMessage', -1, "[^3^0] ^0Prindeti-l pe ^1"..vRP.getPlayerName(source).." ^0strada, face muie gratis!")
				return
			else
				theTarget = vRP.getUserSource(user_id)
				if(theTarget)then
					user_id = vRP.getUserId(theTarget)
					wallet = vRP.getMoney(user_id)
					bank = vRP.getBankMoney(user_id)
					krcoins = vRP.getKRCoins(user_id)
					steamID = GetPlayerIdentifier(theTarget) or "Invalid"
					rsLicense = GetPlayerIdentifier(theTarget, 1) or "Invalid"
					theIP = GetPlayerEndpoint(theTarget) or "Invalid"
					vRP.getUserAddress(user_id, function(address)
						theAddress = ""
						if address ~= nil then
							theAddress = "<font color='green'>"..address.home.." ("..address.number..")</font>"
						else
							theAddress = "<font color='red'>Nu are</font>"
						end
						check_menu["[4] Casa"] = {function(player, choice) 
							chestname = "u"..user_id.."home"
							vRP.adminCheckInventory(player, chestname, 200)
						end, "Adresa: "..theAddress}
					end)

					check_menu["[1] Detalii"] = {function() end, "Nume: <font color='red'>"..vRP.getPlayerName(theTarget).."</font><br>ID: <font color='yellow'>"..user_id.."<br></font>SteamID: <font color='green'>"..steamID:gsub("%steam:", "").."</font><br>R* License: <font color='green'>"..rsLicense:gsub("%license:", "").."</font><br>IP: <font color='red'>"..theIP.."</font>"}
					check_menu["[2] Bani"] = {function() end, "Buzunar: <font color='green'>"..vRP.formatMoney(wallet).." (de) €</font><br>Banca: <font color='green'>"..vRP.formatMoney(bank).." (de) €</font><br>KR Coins: <font color='aqua'>"..vRP.formatMoney(krcoins).."</font> (de) Diamant(e)"}
					check_menu["[3] Vehicule"] = {function(player, choice) playerVehs(player,user_id) end, "Verifica vehiculele jucatorului"}
					check_menu["[5] Inventar"] = {function(player, choice) 
						vRP.closeMenu(player)
						SetTimeout(500, function()
							vRP.openMainInventory(player, theTarget)
						end)
					end, "Vezi inventarul jucatorilui"}
					vRP.closeMenu(player)
					SetTimeout(500, function()
						vRP.openMenu(player, check_menu)
					end)
				else
					local rows = exports.ghmattimysql:executeSync("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = user_id})
					DBbannedBy = rows[1].bannedBy or ""
					DBbannedReason = rows[1].bannedReason or ""
					DBBanTempZile = tonumber(rows[1].BanTempZile) or 0
					DBBanTempData = rows[1].BanTempData or ""
					DBBanTempExpire = rows[1].BanTempExpire or ""
					DBhoursPlayed = tonumber(rows[1].hoursPlayed) or 0
					DBwallet = tonumber(rows[1].bankMoney) or 0
					DBbank = tonumber(rows[1].walletMoney) or 0
					DBkrcoins = tonumber(rows[1].krCoins) or 0
					DBlast_login = rows[1].last_login or ""

					check_menu["[1] Detalii"] = {function() end, "ID: <font color='yellow'>"..user_id.."</font><br>Ore: <font color='green'>"..DBhoursPlayed.."</font><br>IP + Ultima Logare: <font color='yellow'>"..DBlast_login.."</font>"}
					if tonumber(rows[1].banned) == true then
						BanInfo = "Status: <font color='red'>PERMANENT</font><br>Banat de: <font color='yellow'>"..DBbannedBy.."</font><br>Motiv: <font color='yellow'>"..DBbannedReason.."</font>"
					elseif tonumber(rows[1].bannedTemp) > 0 then
						BanInfo = "Status: <font color='red'>TEMPORAR</font><br>Banat de: <font color='yellow'>"..DBbannedBy.."</font><br>Motiv: <font color='yellow'>"..DBbannedReason.."</font><br>Timp: <font color='yellow'>"..DBBanTempZile.." <font color='white'>(de) zile</font></font><br>Banat pe: <font color='yellow'>"..DBBanTempData.."</font><br>Expira pe data de: <font color='yellow'>"..DBBanTempExpire.."</font>"
					else
						BanInfo = "Status: <font color='green'>NU</font>"
					end
					check_menu["[2] Banat"] = {function() end, BanInfo}
					check_menu["[3] Bani"] = {function() end, "Buzunar: <font color='green'>"..vRP.formatMoney(DBwallet).." (de) €</font><br>Banca: <font color='green'>"..vRP.formatMoney(DBbank).." (de) €</font><br> Coins: <font color='aqua'>"..vRP.formatMoney(DBkrcoins).." (de) Diamant(e)</font>"}
					check_menu["[4] Vehicule"] = {function(player, choice) playerVehs(player,user_id) end, "Vezi masinile jucatorilui"}
					vRP.closeMenu(player)
					SetTimeout(500, function()
						vRP.openMenu(player, check_menu)
					end)
				end
			end
		end
	end)
end

function vRP.createTicket(user_id)
	local players = {}
	local player = vRP.getUserSource(user_id)
	exports.ghmattimysql:execute('SELECT * FROM vrp_admin_tickets WHERE createdId = @user_id', {["user_id"] = user_id}, function(rows)
		if(#rows > 0)then
			vRPclient.notify(player,{"Ai facut recent un ticket!",2000,2})
		else
			vRPclient.notify(player,{"Ai apelat la asistenta unui admin.",2000,1})
			exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_admin_tickets(createdName,createdId,accepted) VALUES(@createdName,@createdId,@accepted)",{["createdName"] = GetPlayerName(player),["createdId"] = user_id, ["accepted"] = "Nu"})
			local all = vRP.getUsers()
  			for k,v in pairs(all) do
  			  local player = vRP.getUserSource(tonumber(k))
  			  if vRP.isUserTrialHelper(k) and player ~= nil then
  			    table.insert(players,player)
  			  end
  			end
		end
	end)
end

local ch_adminTicket = function(source,choice)
	local thePlayer = source
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		--notify the user
		TriggerClientEvent("toasty:Notify", thePlayer , {type = "info", title="Admin Ticket", message = "Ai aplicat la asistenta unui admin!"})

		vRP.createTicket(user_id)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		spawnTickets()
	end
end)

function spawnTickets()
	local thePlayer = source
	local user_id = vRP.getUserId(source)
	exports.ghmattimysql:execute('SELECT * FROM vrp_admin_tickets', {["@id"] = user_id}, function(rows2)
		for i,p in pairs(rows2) do
			if p.accepted == "Nu" then
				vRPclient.setTickets(-1, {i})
			end
		end
	end)
end

local playersSpectating = {}
local playersToSpectate = {}
local playersCoordinatesSpec = {}

local function specPlayer(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		local target = playersToSpectate[choice]
		if(user_id == target)then
			vRPclient.notify(player,{"[~y~k2~w~] ~r~Nu te poti spectata pe tine!"})
		else
			local theTarget = vRP.getUserSource(target)
			if theTarget ~= nil then
				vRPclient.loadFreeze(player,{true})
				vRPclient.getPosition(player, {},function(x,y,z)
					vRPclient.getPosition(theTarget,{},function(x2,y2,z2)
						vRPclient.teleport(player,{x2,y2,z2+20})
					end)
					Wait(2500)
					vRPclient.spectatePlayer(player,{theTarget})
					Wait(2500)
					vRPclient.teleport(player,{x,y,z+20})
					playersCoordinatesSpec[user_id] = {x,y,z}
				end)
				vRPclient.notify(player,{"[~y~k2~w~] ~b~Acum il spectatezi pe ~r~"..vRP.getPlayerName(theTarget)})
				playersSpectating[user_id] = theTarget
			end
		end
		vRP.closeMenu(player)
	end
end

local function cancelSpec(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRPclient.spectatePlayer(player,{})
		vRPclient.notify(player,{"[~y~k2~w~] ~b~Ai ~r~oprit ~b~spectate-ul"})
		playersSpectating[user_id] = nil
		vRP.closeMenu(player)
		Wait(2500)
		vRPclient.loadFreeze(player,{false})
		local pos = playersCoordinatesSpec[user_id]
		vRPclient.teleport(player,{pos[1], pos[2], pos[3]})
		playersCoordinatesSpec[user_id] = nil
	end
end

RegisterCommand("spec", function(source, args)
	if source ~= nil then
		local user_id = vRP.getUserId(source)
		if user_id ~= nil then
			if vRP.isUserMod(user_id) then
				local target_id = parseInt(args[1])
				local target_src = vRP.getUserSource(target_id)
				if(target_id == user_id)then
					vRPclient.notify(source,{"[~y~k2~w~] ~r~Nu te poti spectata pe tine!"})
				else
					if target_src ~= nil then
						if(playersSpectating[user_id] == nil)then
							vRPclient.loadFreeze(source,{true})
							vRPclient.getPosition(source, {},function(x,y,z)
								vRPclient.getPosition(target_src,{},function(x2,y2,z2)
									vRPclient.teleport(source,{x2,y2,z2+20})
								end)
								Wait(2500)
								vRPclient.spectatePlayer(source,{target_src})
								Wait(2500)
								vRPclient.teleport(source,{x,y,z+20})
								playersCoordinatesSpec[user_id] = {x,y,z}
							end)
							playersSpectating[user_id] = target_src
							vRPclient.notify(source,{"[~y~k2~w~] ~b~Acum il spectatezi pe ~r~["..target_id.."] "..vRP.getPlayerName(target_src)})
						else
							vRPclient.spectatePlayer(source,{})
							playersSpectating[user_id] = nil
							vRPclient.notify(source,{"[~y~k2~w~] ~b~Acum nu il spectatezi pe ~r~["..target_id.."] "..vRP.getPlayerName(target_src)})
							Wait(2500)
							vRPclient.loadFreeze(source,{false})
							local pos = playersCoordinatesSpec[user_id]
							vRPclient.teleport(source,{pos[1], pos[2], pos[3]})
							playersCoordinatesSpec[user_id] = nil
						end
					else
						vRPclient.notify(source,{"[~y~k2~w~] ~r~Acest jucator nu este online!"})
					end
				end
			end
		end
	end
end, false)

local function ch_spec(player,choice)
	vRP.closeMenu(player)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		SetTimeout(600, function()
			vRP.buildMenu("Spectate Player", {player = player}, function(menu)
				menu.name = "Spectate Player"
				menu.css={top="75px",header_color="rgba(235,0,0,0.75)"}
				menu.onclose = function(player) vRP.openMainMenu(player) end
				if(playersSpectating[user_id] == nil)then
					local myName = tostring(vRP.getPlayerName(player))
					local users = vRP.getUsers()
					for k,v in pairs(users) do
						local playerName = tostring(vRP.getPlayerName(v))
						playersToSpectate[playerName] = tonumber(k)
						menu[playerName] = {specPlayer, "Spectateaza Un Jucator"}
					end
				else
					menu["Anuleaza Spectate-ul"] = {cancelSpec, "Anuleaza Spectate-ul Jucator-ului"}
				end
				vRP.openMenu(player, menu)
			end)
		end)
	end
end

local function ch_calladmin(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"Descrie problema pe care o ai:","",function(player,desc) 
		desc = desc or ""
			if desc ~= nil and desc ~= "" then
			local answered = false
			local players = {}
			for k,v in pairs(vRP.rusers) do
				local player = vRP.getUserSource(tonumber(k))
				if vRP.isUserTrialHelper(k) and player ~= nil then
					table.insert(players,player)
				end
			end
				for k,v in pairs(players) do
					local usrID = vRP.getUserId(v)
					local theAdmin = vRP.getUserSource(usrID)
					vRP.request(v,"Asistenta Staff ("..vRP.getPlayerName(player).." ["..user_id.."]), doresti sa-l preluezi?: "..htmlEntities.encode(desc), 60, function(v,ok)
						vRPclient.isHandcuffed(v,{}, function(handcuffed)
							if ok and handcuffed then 
							vRPclient.notify(v,{"~r~Nu poti prelua un ticket cu catusele puse."})
							elseif ok then
								if not answered then
									vRPclient.notify(player,{"~g~Un admin ti-a preluat ticket-ul."})
									vRPclient.getPosition(player, {}, function(x,y,z)
									vRPclient.teleport(v,{x,y,z})
								end)
								answered = true
								 local sender_id = vRP.getUserId(v)
								exports.ghmattimysql:execute("UPDATE `vrp_users` SET `raport` = `raport` + 1 WHERE `id` = @sender_id", {sender_id = sender_id},function()end)
								vRP.sendStaffMessage("^1 Ticket^0: ^2"..GetPlayerName(va).."^(^2"..sender_id_add.."^2)^0 i-a acceptat Ticket-ul lui: ^3"..GetPlayerName(player).."^3(^3"..user_id_add.."^3)^0 cu problema: "..htmlEntities.encode(desc))
								local embed_add = {
								  {
									["color"] = 1234521,
									["title"] = "__".. "Tickets LOGS".."__",
									["description"] = "[ "..GetPlayerName(v).." ] ( "..sender_id_add.." ) i-a acceptat ticketul pentru Add Group la  "..GetPlayerName(player).." ] ("..user_id_add.."). ",
									["thumbnail"] = {
									  ["url"] = "https://i.imgur.com/fpzxp8K.png",
									},
									["footer"] = {
									["text"] = "",
									},
								  }
						  }
						  PerformHttpRequest('https://discordapp.com/api/webhooks/861618801803001906/EG16vEAoJPvO_GJofG6lbfojt_6CmB_d_FTTPzyarSNjgOq--9n-5_0YfXKyO4O58MP_', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed_add}), { ['Content-Type'] = 'application/json' })
							else
							vRPclient.notify(v,{"[~y~k2~w~] Ticket-ul a fost deja preluat."})
							end
						end
					end)
				end)
			end
		else
				vRPclient.notify(player,{"[~y~k2~w~] Te rugam sa iti descrii problema pe care o ai."})
			end
		end)
	end
end

local function ch_calladmin_f(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"Descrie problema pe care o ai:","",function(player,desc) 
		desc = desc or ""
			if desc ~= nil and desc ~= "" then
			local answered = false
			local players = {}
			for k,v in pairs(vRP.rusers) do
				local player = vRP.getUserSource(tonumber(k))
				if vRP.isUserFondator(k) and player ~= nil then
					table.insert(players,player)
				end
			end
				for k,v in pairs(players) do
					local usrID = vRP.getUserId(v)
					local theAdmin = vRP.getUserSource(usrID)
					vRP.request(v,"Asistenta Fondator ("..vRP.getPlayerName(player).." ["..user_id.."]), doresti sa-l preluezi?: "..htmlEntities.encode(desc), 60, function(v,ok)
						vRPclient.isHandcuffed(v,{}, function(handcuffed)
							if ok and handcuffed then 
							vRPclient.notify(v,{"~r~Nu poti prelua un ticket cu catusele puse."})
							elseif ok then
								if not answered then
									vRPclient.notify(player,{"~g~Un admin ti-a preluat ticket-ul."})
									vRPclient.getPosition(player, {}, function(x,y,z)
									vRPclient.teleport(v,{x,y,z})
								end)
								answered = true
								 local sender_id = vRP.getUserId(v)
								exports.ghmattimysql:execute("UPDATE `vrp_users` SET `raport` = `raport` + 1 WHERE `id` = @sender_id", {sender_id = sender_id},function()end)
								vRP.sendStaffMessage("^1 Ticket^0: ^2"..GetPlayerName(va).."^(^2"..sender_id_add.."^2)^0 i-a acceptat Ticket-ul lui: ^3"..GetPlayerName(player).."^3(^3"..user_id_add.."^3)^0 cu problema: "..htmlEntities.encode(desc))
								local embed_add = {
								  {
									["color"] = 1234521,
									["title"] = "__".. "Tickets LOGS".."__",
									["description"] = "[ "..GetPlayerName(v).." ] ( "..sender_id_add.." ) i-a acceptat ticketul pentru Asistenta unui fondator la  "..GetPlayerName(player).." ] ("..user_id_add.."). ",
									["thumbnail"] = {
									  ["url"] = "https://i.imgur.com/fpzxp8K.png",
									},
									["footer"] = {
									["text"] = "",
									},
								  }
						  }
						  PerformHttpRequest('https://discordapp.com/api/webhooks/861618801803001906/EG16vEAoJPvO_GJofG6lbfojt_6CmB_d_FTTPzyarSNjgOq--9n-5_0YfXKyO4O58MP_', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed_add}), { ['Content-Type'] = 'application/json' })
							else
							vRPclient.notify(v,{"[ ~y~Electro~w~ ] Ticket-ul a fost deja preluat."})
							end
						end
					end)
				end)
			end
		else
				vRPclient.notify(player,{"[ ~y~Electro~w~ ] Te rugam sa iti descrii problema pe care o ai."})
			end
		end)
	end
end

local function ch_calladmin_add(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"Descrie problema pe care o ai:","",function(player,desc) 
		desc = desc or ""
			if desc ~= nil and desc ~= "" then
			local answered = false
			local players = {}
			for k,v in pairs(vRP.rusers) do
				local player = vRP.getUserSource(tonumber(k))
				if vRP.isUserSuperAdmin(k) and player ~= nil then
					table.insert(players,player)
				end
			end
				for k,v in pairs(players) do
					local usrID = vRP.getUserId(v)
					local theAdmin = vRP.getUserSource(usrID)
					vRP.request(v,"Asistenta ADD Group ("..vRP.getPlayerName(player).." ["..user_id.."]), doresti sa-l preluezi?: "..htmlEntities.encode(desc), 60, function(v,ok)
						vRPclient.isHandcuffed(v,{}, function(handcuffed)
							if ok and handcuffed then 
							vRPclient.notify(v,{"~r~Nu poti prelua un ticket cu catusele puse."})
							elseif ok then
								if not answered then
									vRPclient.notify(player,{"~g~Un admin ti-a preluat ticket-ul."})
									vRPclient.getPosition(player, {}, function(x,y,z)
									vRPclient.teleport(v,{x,y,z})
								end)
								answered = true
								 local sender_id = vRP.getUserId(v)
								exports.ghmattimysql:execute("UPDATE `vrp_users` SET `raport` = `raport` + 1 WHERE `id` = @sender_id", {sender_id = sender_id},function()end)
								vRP.sendStaffMessage("^1 Ticket^0: ^2"..GetPlayerName(va).."^(^2"..sender_id_add.."^2)^0 i-a acceptat Ticket-ul lui: ^3"..GetPlayerName(player).."^3(^3"..user_id_add.."^3)^0 cu problema: "..htmlEntities.encode(desc))
								local embed_add = {
								  {
									["color"] = 1234521,
									["title"] = "__".. "Tickets LOGS".."__",
									["description"] = "[ "..GetPlayerName(v).." ] ( "..sender_id_add.." ) i-a acceptat ticketul pentru Asistenta ADD Group la  "..GetPlayerName(player).." ] ("..user_id_add.."). ",
									["thumbnail"] = {
									  ["url"] = "https://i.imgur.com/fpzxp8K.png",
									},
									["footer"] = {
									["text"] = "",
									},
								  }
						  }
						  PerformHttpRequest('https://discordapp.com/api/webhooks/861618801803001906/EG16vEAoJPvO_GJofG6lbfojt_6CmB_d_FTTPzyarSNjgOq--9n-5_0YfXKyO4O58MP_', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed_add}), { ['Content-Type'] = 'application/json' })
							else
							vRPclient.notify(v,{"[ ~y~Electro~w~ ] Ticket-ul a fost deja preluat."})
							end
						end
					end)
				end)
			end
		else
				vRPclient.notify(player,{"[ ~y~Electro~w~ ] Te rugam sa iti descrii problema pe care o ai."})
			end
		end)
	end
end

RegisterCommand("cleararea", function(source, args)
	if source ~= nil then
		local user_id = vRP.getUserId(source)
		if vRP.isUserTrialHelper(user_id) then
			local raza = tonumber(args[1])
			if(tonumber(raza) and raza ~= nil and raza > 0 and raza <= 1000)then
				TriggerClientEvent("k2:curataStrada", source, raza)
			else
				vRPclient.notify(source,{"Eroare: ~r~Raza Invalida! 0 - 1000 Metri Max"})
			end
		end
	end
end, false)

RegisterCommand("cleanup", function(player,choice)
	local user_id = vRP.getUserId(player)
	if vRP.isUserAdmin(user_id) then
		TriggerClientEvent("ples:stergeToateMasinile", -1)
	end
end, false) 

function vRP.sendStaffMessage(msg)
	for k, v in pairs(vRP.rusers) do
		local ply = vRP.getUserSource(tonumber(k))
		if vRP.isUserTrialHelper(k) and ply then
			TriggerClientEvent("chatMessage", ply, msg)
		end
	end
end

local function ch_noclip(player, choice)
  	vRPclient.toggleNoclip(player, {})
end

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local rows = exports.ghmattimysql:executeSync("SELECT adminLvl FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	local talentLevel = tonumber(rows[1].adminLvl)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.talentLevel = talentLevel
	end
end)

local function ch_addAdmin(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"ID:","",function(player,id) 
			id = parseInt(id)
			local target = vRP.getUserSource(id)
			if(target)then
				vRP.prompt(player,"Admin Rank:","",function(player,rank) 
					rank = parseInt(rank)
					if(tonumber(rank))then
						if(rank <= 16) and (0 < rank)then
							if(target) then
								vRP.setUserAdminLevel(id,rank)
								Wait(150)
								vRPclient.notify(player,{"[~y~k2~w~] ~w~L-ai promovat pe ~b~"..vRP.getPlayerName(target).." ~w~la ~g~"..vRP.getUserAdminTitle(id).."~w~!"})
								vRPclient.notify(target,{"[~y~k2~w~] ~w~Ai fost promovat la ~b~"..vRP.getUserAdminTitle(id).." ~w~de catre ~g~"..vRP.getPlayerName(player)})
								PerformHttpRequest("webhook", function(err, text, headers) end, 'POST', json.encode({content = ""..vRP.getPlayerName(player).." i-a dat functia de "..vRP.getUserAdminTitle(id).." lui "..vRP.getPlayerName(target).."."}), { ['Content-Type'] = 'application/json' })
							else
								exports.ghmattimysql:execute("UPDATE vrp_users SET adminLvl = @adminLevel WHERE id = @user_id", {user_id = id, adminLevel = rank}, function()end)
								vRPclient.notify(player,{"[~y~k2~w~] ~w~L-ai promovat pe ID ~b~"..id.." ~w~la grad-ul ~g~"..rank.."~w~!"})
							end
						elseif(rank == 0)then
							if(target)then
								vRP.setUserAdminLevel(id,rank)
								Wait(150)
								vRPclient.notify(target,{"[~y~k2~w~] ~w~Functia ta a fost reziliata de catre ~b~"..vRP.getPlayerName(player).."~w~!"})
								vRPclient.notify(player,{"[~y~k2~w~] ~w~Ai reziliat functia de staff lui ~b~"..vRP.getPlayerName(target)})
							else
								exports.ghmattimysql:execute("UPDATE vrp_users SET adminLvl = @adminLevel WHERE id = @user_id", {user_id = id, adminLevel = rank}, function()end)
								vRPclient.notify(player,{"[~y~k2~w~] ~w~I-ai reziliat functia de staff ID-ului ~b~"..id})
							end
						end
					end
				end)
			else
				vRPclient.notify(player,{"[~y~k2~w~] Acest ID nu a fost gasit."})
			end
		end)
	end
end

local function ch_ann(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"Anunt:","",function(player,msg) 
			msg = tostring(msg)
			if(msg ~= "" and msg ~= nil)then
				vRPclient.notify(-1, {GetPlayerName(player).." ~y~a dat un anunt administrativ! Va aparea in 10 secunde!"})
				SetTimeout(10000, function()
					vRPclient.adminAnnouncement(-1, {msg})
				end)
			end
		end)
	end
end

local function ch_givevip(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"User ID:","",function(player,id) 
			id = parseInt(id)
			vRP.prompt(player,"VIP:","",function(player,vip) 
				vip = parseInt(vip)
				local target = vRP.getUserSource(id)
				if(target)then
					local name = vRP.getPlayerName(target)
					if(vip > 0)then
						vRP.setUserVip(id,vip)
						vipTitle = vRP.getUserVipTitle(id)
						vRPclient.notify(player,{"[~y~k2~w~] ~w~I-ai dat ~y~VIP "..vipTitle.." ~w~lui ~g~"..name..""})
						vRPclient.notify(target,{"[~y~k2~w~] ~w~Ai primit ~y~VIP "..vipTitle})
					else
						vRP.setUserVip(id,vip)
						vRPclient.notify(player,{"[~y~k2~w~] ~w~I-ai scos VIP-ul lui ~r~"..name..""})
						vRPclient.notify(target,{"[~y~k2~w~] ~b~VIP-ul ti-a fost scos!"})
					end
				end
			end)
		end)
	end
end

local function ch_givesponsor(player,choice)
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRP.prompt(player,"User ID:","",function(player,id) 
			id = parseInt(id)
			vRP.prompt(player,"SPONSOR:","",function(player,sponsor) 
				sponsor = parseInt(sponsor)
				local target = vRP.getUserSource(id)
				if(target)then
					local name = vRP.getPlayerName(target)
					if(sponsor > 0)then
						vRP.setUserSponsor(id,sponsor)
						sponsorTitle = vRP.getUserSponsorTitle(id)
						Wait(150)
						vRPclient.notify(player,{"~w~I-ai dat ~g~ "..sponsorTitle.." ~w~lui ~g~"..name..""})
						vRPclient.notify(target,{"~w~Ai primit ~g~"..sponsorTitle})
					else
						vRP.setUserSponsor(id,sponsor)
						vRPclient.notify(player,{"~w~I-ai scos SPONSOR-ul lui ~r~"..name..""})
						vRPclient.notify(target,{"~r~SPONSOR-ul ti-a fost scos!"})
					end
				end
			end)
		end)
	end
end

local function ch_fix(player, choice)
  	TriggerClientEvent('murtaza:fix', player)
end

vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}

    -- build admin menu
    choices["Admin"] = {function(player,choice)
      vRP.buildMenu("admin", {player = player}, function(menu)
        menu.name = "Admin"
        menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
        menu.onclose = function(player) vRP.closeMenu(player) end -- nest menu

		if vRP.isUserCoFondator(user_id) then
			menu["Adauga grup"] = {ch_addgroup}
			menu["Create Garage"] = {ch_createGarage}
			menu["Sterge grup"] = {ch_removegroup}
			menu["Create Garage"] = {ch_createGarage}
			menu["Add/Remove VIP"] = {ch_givevip}
			menu["Give Diamante"] = {ch_givekrcoins}
			menu["#Add/Remove Staff"] = {ch_addAdmin}
			menu["Add/Remove SPONSOR"] = {ch_givesponsor}
            menu["Give Money"] = {ch_givemoney}
			menu["Take money"] = {ch_takemoney}
			menu["Take Diamonds"] = {ch_takediamonds}
			-- menu["Give Halloween Coins"] = {ch_givehalloweencoins}
			menu["Adauga grup"] = {ch_addgroup}
		--	menu["Create Garage"] = {ch_createGarage}
			menu["Sterge grup"] = {ch_removegroup}
			menu["Give item"] = {ch_giveitem}
			menu["Take item"] = {ch_takeitem}
		end
		if vRP.isUserSupporter(user_id) then
			menu["Add/Remove VIP"] = {ch_givevip}
			menu["#Add/Remove Staff"] = {ch_addAdmin}
			menu["Give Diamante"] = {ch_givekrcoins}
			menu["Add/Remove SPONSOR"] = {ch_givesponsor}
           -- menu["Give Money"] = {ch_givemoney}
			menu["Take money"] = {ch_takemoney}
			menu["Take Diamonds"] = {ch_takediamonds}
			menu["Give item"] = {ch_giveitem}
		end
		if vRP.isUserAdmin(user_id) then
			menu["Ban permanent"] = {ch_ban}
			menu["TpLaCoordonate"] = {ch_tptocoords}
			menu["Anunt Admin"] = {ch_ann}
		end
		if vRP.isUserMod(user_id) or vRP.isUserModAvansat(user_id) then
			menu["Verifica jucator"] = {ch_checkplayer}
			menu["FixVeh"] = {ch_fix}
			menu["Kick"] = {ch_kick}
			menu["Ban temporar"] = {ch_banTemp}
            menu["Spec Player"] = {ch_spec}
			menu["#Noclip"] = {ch_noclip}
			menu["Unban"] = {ch_unban}
			menu["Coordonate"] = {ch_coords}
		end
		if vRP.isUserHelper(user_id) then
			menu["TpToMe"] = {ch_tptome}
			menu["TpTo"] = {ch_tpto}
		end
		menu["Admin Ticket"] = {ch_adminTicket}	
        vRP.openMenu(player,menu)
      end)
    end}

    add(choices)
  end
end)

function tvRP.isNoClipStaff()
	local user_id = vRP.getUserId(source)
	if vRP.isUserAdmin(user_id)then
		return true
	end
	return false
end

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    if first_spawn then 
      	if vRP.isUserTrialHelper(user_id) then
			vRPclient.setAdmin(source)
    	end
	end
end)

AddEventHandler('vRP:playerLeave', function(user_id, source)
	exports.ghmattimysql:execute('SELECT * FROM vrp_admin_tickets', {["@id"] = user_id}, function(rowsz)
		for k,v in pairs(rowsz) do
			exports.ghmattimysql:execute("DELETE FROM vrp_admin_tickets WHERE createdId = @user_id",{["@user_id"] = user_id})
			vRPclient.setTickets(-1, {k-1})
		end
	end)
end)