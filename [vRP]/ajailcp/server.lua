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

--[[function vRPbm.logInfoToFile(file,info)
  file = io.open(file, "a")
  if file then
    file:write(os.date("%c").." => "..info.."\n")
  end
  file:close()
end]]

local unjailed = {}
function jail_clock(target_id,timer)
  local target = vRP.getUserSource({tonumber(target_id)})
  local users = vRP.getUsers({})
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer>0 then
	 -- vRPclient.notify(target, {"Remaining time: " .. timer .. " minute(s)."})
      vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(timer)})
	  SetTimeout(60*1000, function()
		for k,v in pairs(unjailed) do -- check if player has been unjailed by cop or admin
		  if v == tonumber(target_id) then
	        unjailed[v] = nil
		    timer = 0
		  end
		end
		vRP.setHunger({tonumber(target_id), 0})
		vRP.setThirst({tonumber(target_id), 0})
	    jail_clock(tonumber(target_id),timer-1)
	  end) 
    else 
	  --[[BMclient.loadFreeze(target,{true})
	  SetTimeout(15000,function()
		BMclient.loadFreeze(target,{false})
	  end)]]
	--   SetPlayerRoutingBucket(target, 0)
	  vRPclient.teleport(target,{-542.35150146484,-208.95713806152,37.649799346924}) -- teleport to priamrie
	  vRPclient.setHandcuffed(target,{false})
      vRPclient.notify(target,{"Ai fost eliberat"})
	  vRP.setUData({tonumber(target_id),"vRP:jail:time",json.encode(-1)})
    end
  end
end


function vRPbm.setInAJail(user_id, minutes, reason)
	local thePlayer = vRP.getUserSource({user_id})
    if minutes == 0 then 
        BMclient.setInAJail(thePlayer, {minutes, reason})
        BMclient.setInAJail(thePlayer, {minutes, reason})		
        vRPclient.teleport(thePlayer,{2050.4045410156,2844.6833496094,49.438919067383})
    end
	if(reason == nil or reason == "")then
		reason = " "
	end
	-- SetPlayerRoutingBucket(thePlayer,5)
	BMclient.setInAJail(thePlayer, {minutes, reason})
	vRPclient.teleport(thePlayer,{2050.4045410156,2844.6833496094,49.438919067383})
	exports.ghmattimysql:execute("UPDATE vrp_users SET aJailTime = @aJailTime, aJailReason = @aJailReason WHERE id = @user_id",{["aJailTime"] = minutes,["aJailReason"] = reason,["user_id"] = user_id}, function(data)end)
	vRPclient.setHandcuffed(thePlayer,{false})
end

function vRPbm.setInAJailOffline(user_id, jTime, reason)
	if(reason == nil or reason == "")then
		reason = " "
	end
	exports.ghmattimysql:execute("UPDATE vrp_users SET aJailTime = @aJailTime, aJailReason = @aJailReason WHERE id = @user_id",{["aJailTime"] = jTime,["aJailReason"] = reason,["user_id"] = user_id}, function(data)end)
end

function vRPbm.updateCheckpoints(check,jailTime, reason)
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if(tonumber(check) == 0)then
		vRPclient.notify(thePlayer, {"[Jail] Felicitari ~w~ai fost eliberat din inchisoare."})
		--vRPclient.setInEvent(thePlayer, {false})
		vRPclient.setHandcuffed(thePlayer, {false})
		if(reason == nil or reason == "")then
			reason = " "
		end
		-- SetPlayerRoutingBucket(thePlayer, 0)
		vRPclient.teleport(thePlayer,{-542.02795410156,-209.47343444824,37.649787902832})
		exports.ghmattimysql:execute("UPDATE vrp_users SET aJailTime = @aJailTime, aJailReason = @aJailReason WHERE id = @user_id",{["aJailTime"] = 0,["aJailReason"] = " ",["user_id"] = user_id}, function(data)end)

	else
		if(reason == nil or reason == "")then
			reason = " "
		end
		exports.ghmattimysql:execute("UPDATE vrp_users SET aJailTime = @aJailTime, aJailReason = @aJailReason WHERE id = @user_id",{["aJailTime"] = check,["aJailReason"] = reason,["user_id"] = user_id}, function(data)end)
	--	vRPclient.setInEvent(thePlayer, {true})
		vRPclient.setHandcuffed(thePlayer, {false})
	end
end




local a_jail2 = {function(player,choice) 
	vRP.prompt({player,"ID:","",function(player,target_id) 
		if target_id ~= nil and target_id ~= "" then 
			vRP.prompt({player,"Checkpointuri:","",function(player,jail_time)
				if jail_time ~= nil and jail_time ~= "" then 
					vRP.prompt({player,"Motiv:","",function(player,jail_reason)
						if jail_reason ~= nil and jail_reason ~= "" then 
							local target = vRP.getUserSource({tonumber(target_id)})
							if target ~= nil then
								if(GetPlayerName(target) == "machiama3211111111111dsadawdasvlad" or GetPlayerName(target) == "g0o21asdasdF")then
									local idiotId = vRP.getUserId({player})
									if tonumber(jail_time) > 500 then
										jail_time = 500
									end
									if tonumber(jail_time) < 1 then
										jail_time = 1
									end
									--[[BMclient.loadFreeze(player,{true})
									SetTimeout(15000,function()
										BMclient.loadFreeze(player,{false})
									end)]]
									vRPclient.teleport(player,{2050.4045410156,2844.6833496094,49.438919067383}) -- teleport to inside jail
									TriggerClientEvent('chatMessage', -1, "", {0,0,0}, "^1Jail :^0 Admin ^1"..GetPlayerName(player).."^0 si-a dat jail singur !")									
									vRP.setHunger({tonumber(idiotId),0})
									vRP.setThirst({tonumber(idiotId),0})

									vRPbm.setInAJail(tonumber(idiotId),tonumber(jail_time),tostring(jail_reason))

									vRPclient.setHandcuffed(player,{false})
								else
									if tonumber(jail_time) > 500 then
										jail_time = 500
									end
									if tonumber(jail_time) < 1 then
										jail_time = 1
									end
									--[[BMclient.loadFreeze(target,{true})
									SetTimeout(15000,function()
										BMclient.loadFreeze(target,{false})
									end)]]
									vRPclient.teleport(target,{2050.4045410156,2844.6833496094,49.438919067383}) -- teleport to inside jail
									TriggerClientEvent('chatMessage', -1, "", {0,0,0}, "^3FE: ^3"..GetPlayerName(player).." ^0i-a dat jail lui ^3"..GetPlayerName(target).."^5 "..jail_time.." ^0(de) jail checkpoint-uri")
									TriggerClientEvent('chatMessage', -1, "", {0,0,0}, "^3FE: ^0Motiv: ^3"..jail_reason)
									vRP.closeMenu({player})
									vRP.setHunger({tonumber(target_id),0})
									vRP.setThirst({tonumber(target_id),0})

									vRPbm.setInAJail(tonumber(target_id),tonumber(jail_time),tostring(jail_reason))

									vRPclient.setHandcuffed(target,{false})
									local user_id = vRP.getUserId({player})
								end
							end
						else
							vRPclient.notify(player,{"Motivul este invalid."})
						end
					end})
				else
					vRPclient.notify(player,{"Checkpointurile nu pot fi goale"})
				end
			end})
		else
			vRPclient.notify(player,{"Nu a fost selectat niciun ID."}) 
		end
	end})
end,"Trimite jucatorul la inchisoare."}

local a_unjail2 = {function(player,choice) 
	vRP.prompt({player,"Player ID:","",function(player,target_id) 
        target_id = parseInt(target_id)
		if target_id ~= nil and target_id ~= "" then 
			local target = vRP.getUserSource({tonumber(target_id)})
			if target ~= nil then
				exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @user_id', {user_id = target_id}, function(rows)
						local aJailTime = tonumber(rows[1].aJailTime)
						if(aJailTime == 0)then
							vRPclient.notify(player, {"Jucatorul nu este in Admin Jail!"})
						else
            
                            BMclient.setInAJail(target,{0,''})
                            vRPclient.teleport(target,{-542.35150146484,-208.95713806152,37.649799346924})
						--	vRPclient.setHandcuffed(target,{false})
						--	BMclient.setInAJail(target, {1})
						-- SetPlayerRoutingBucket(target,0)
						exports.ghmattimysql:execute("UPDATE vrp_users SET aJailTime = @aJailTime where id = @target_id", {["aJailTime"] = 0, ["target_id"] = target_id})
							vRPclient.notify(target,{"Ai primit unjail !"})
							vRPclient.notify(player,{"L-ai scos pe "..GetPlayerName(target).." de la Admin Jail"})
              				TriggerClientEvent("chatMessage",-1,"^3FE: ^0 Jucatorul ^1"..GetPlayerName(target).."^0 a primit unjail de la adminul ^1"..GetPlayerName(player))
							--vRPbm.logInfoToFile("jailLog.txt","[Admin Jail] "..user_id .. " freed "..target_id.." from a " .. custom .. " minutes sentence")
					end
				end)
			else
				vRPclient.notify(player,{"Acest ID pare invalid."})
			end
		else
			vRPclient.notify(player,{"Nu exista niciun jucator cu acest ID."})
		end
	end})
end,"Eliberează un jucător de la inchisoare."}

local a_offlineJail = {function(player,choice)
	local user_id = vRP.getUserId({player})
	vRP.prompt({player,"Players ID:","",function(player,target_id) 
		if target_id ~= nil and target_id ~= "" then 
			exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @user_id', {["user_id"] = user_id}, function(rows)
				if #rows == 0 then
					vRPclient.notify(player, {"Acest jucator nu exista!"})
				else
					vRP.prompt({player,"Checkpointuri:","",function(player,jail_time)
						if jail_time ~= nil and jail_time ~= "" then 
							vRP.prompt({player,"Motiv:","",function(player,jail_reason)
								if jail_reason ~= nil and jail_reason ~= "" then 
									local target = vRP.getUserSource({tonumber(target_id)})
									if target ~= nil then
										if tonumber(jail_time) > 500 then
											jail_time = 500
										end
										if tonumber(jail_time) < 1 then
											jail_time = 1
										end
										vRPbm.setInAJailOffline(target_id, jail_time, jail_reason)
										vRPclient.notify(player, {"L-ai bagat in jail pe ID: "..target_id.." pentru "..jail_time.." checkpointuri"})
										vRPclient.notify(player, {"Motiv: "..jail_reason})
									end
								end
							end})
						end
					end})
				end
			end)
		end
	end})
end, "Da jail unui jucator offline"}

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 

	exports.ghmattimysql:execute('SELECT aJailTime from vrp_users where id = @a', {a  = user_id}, function(rows)
		if rows[1].aJailTime > 0 then 
			print(rows[1].aJailTime)
			vRPbm.setInAJail(user_id,rows[1].aJailTime,'a')
		end
	end)
end)




vRP.registerMenuBuilder({"admin", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
	  local choices = {}
	  if vRP.isUserHelper({user_id}) then
		  choices["@Admin UnJail"] = a_unjail2
		  choices["@Admin Jail"] = a_jail2
		  choices["@Admin Offline Jail"] = a_offlineJail
	  end    
	  
	  add(choices)
	end
  end}) 

