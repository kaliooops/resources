RegisterServerEvent("cumparapermis")
AddEventHandler("cumparapermis", function()
  local user_id = vRP.getUserId(source)
  local thePlayer = source
  local price = 200
  local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dosar_dmv")*1
  if new_weight <= vRP.getInventoryMaxWeight(user_id) then
    if vRP.tryPayment(user_id, price) then
		vRP.giveInventoryItem(user_id,'dosar_dmv',1,true)
        vRPclient.notify(thePlayer,{"Acum cauta un politist cu care sa dai testul practic! \n\n~r~Nu ai voie sa suni la politie"})
    else 
      vRPclient.notify(thePlayer,{"~r~Nu ai destui bani pentru achizitiona un Dosar DMV"})
    end
  else
    vRPclient.notify(thePlayer,{"~r~Nu ai destul spatiu in inventar"})
  end
end)

-- local choice_oferapermis = {function(player,choice)
--  -- local user_id = vRP.getUserId(source)
-- 	vRPclient.getNearestPlayers(player,{15},function(nplayers) 
--     local user_id = vRP.getUserId(nplayers)
-- 	  local user_list = ""
-- 	  for k,v in pairs(nplayers) do
-- 		user_list = user_list .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
-- 	  end 
-- 	  if user_list ~= "" then
-- 		vRP.prompt(player,"Players Nearby:" .. user_list,"",function(player,target_id) 
-- 		  local target_id = parseInt(target_id)
-- 		  if target_id ~= nil then
-- 			nplayer = vRP.getUserSource(target_id)
-- 			exports.ghmattimysql:execute("UPDATE vrp_users SET permis = 1 WHERE id = @user_id",{["user_id"] = target_id}, function(data)end)
-- 			vRPclient.notify(player,{"~g~I-ai oferit permisul de conducere lui "..GetPlayerName(nplayer)})
-- 			vRPclient.notify(nplayer,{"~g~Ai primit permisul de conducere de catre "..GetPlayerName(player)})
-- 		  end
-- 		end)
-- 	  end
-- 	end)
-- end,"Ofera permisul de conducere la cel mai apropriat jucator!"}

local cere_permis = {function(player,choice) 
    local user_id = vRP.getUserId(source)
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
        local nuser_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
            vRPclient.notify(player,{"Ceri ~g~licenta~w~..."})
            vRP.request(nplayer,"Vrei sa ii arati politstului licenta ?",15,function(nplayer,ok)
                if ok then
					exports.ghmattimysql:execute('SELECT * FROM `vrp_users` WHERE id = @user_id', {["user_id"] = nuser_id}, function(permise)
                        if permise[1].permis == 1 then
                            vRPclient.notify(player,{"PERMIS : ~g~DA"})
                        else
                            vRPclient.notify(player,{"PERMIS : ~r~NU"})
                        end
                    end)
                else
                    vRPclient.notify(player,{"A refuzat sa iti arate licenta"})
                end
            end)
        else
            vRPclient.notify(player,{"Ceri ~g~permisul ~w~jucatorului"})
        end
    end)
end,"Cere licenta de condus unui jucator"}

local confisca_permis = {function(player,choice) 
    local user_id = vRP.getUserId(source)
    vRPclient.getNearestPlayer(player,{10},function(nplayer)
        local nuser_id = vRP.getUserId(nplayer)
        local user_id = vRP.getUserId(nplayer)
        if nuser_id ~= nil then
            vRP.request(player,"Vrei sa confisti licenta lui : "..nuser_id.." ?",15,function(player,ok)
                if ok then
                    exports.ghmattimysql:execute("UPDATE vrp_users SET permis = 0 WHERE id = @user_id",{["user_id"] = nuser_id}, function(data)end)
                    vRPclient.notify(nplayer,{"Ti-a fost confiscata licenta de condus"})
                else
                    vRPclient.notify(player,{"Ai anulat"})
                end
            end)
        end
    end)
end,"Confisca licenta de condus celui mai apropriat jucator"}

vRP.registerMenuBuilder("police", function(add,data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
	  local choices = {}
	  if vRP.isUserInFaction(user_id,"Politia Romana") then
        choices["Cere permisul"] = cere_permis
        choices["Confisca permisul"] = confisca_permis
		-- choices["Ofera Permis"] = choice_oferapermis
	  end
	  add(choices)
	end
  end)