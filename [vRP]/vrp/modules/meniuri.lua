vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}
	
		if(vRP.hasGroup(user_id, "silver"))then
			choices["Meniu Silver"] = {function(player,choice)
				vRP.buildMenu("silver", {player = player}, function(menu)
					menu.name = "Meniu Silver"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.closeMenu(player) end	
					menu["Kit Arme"] = {function(player, choice)
						vRPclient.giveWeapons(player,{{
							["WEAPON_Switchblade"] = {ammo=1},
							["WEAPON_BULLPUPSHOTGUN"] = {ammo=200},
							["WEAPON_MICROSMG"] = {ammo=200}
						}})
						vRPclient.notify(player, {"~g~Ti-ai dat un kit de arme!"})
					end, "Da-ti un kit de arme"}
					vRP.openMenu(player,menu)
				end)
			end}
		end
		add(choices)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
			if(vRP.hasGroup({i, "silver"})) and (spUtils[i] == true)then
				spUtils[i] = nil
				vRPclient.notify(v, {"^9[SILVER] ~b~Acum iti poti folosi meniul SILVER!"})
			end
		end
	end
end)




vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}
	
		if(vRP.hasGroup(user_id, "gold"))then
			choices["Meniu Gold"] = {function(player,choice)
				vRP.buildMenu("gold", {player = player}, function(menu)
					menu.name = "Meniu Gold"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.closeMenu(player) end	
					menu["Kit Arme"] = {function(player, choice)
						vRPclient.giveWeapons(player,{{
							["WEAPON_Switchblade"] = {ammo=1},
							["WEAPON_SNS_Pistol_Mk_II"] = {ammo=200},
							["WEAPON_MICROSMG"] = {ammo=200},
							["WEAPON_KNUCKLE"] = {ammo=1},
							["WEAPON_ASSAULTSHOTGUN"] = {ammo=200},
							["WEAPON_BULLPUPRIFLE"] = {ammo=200}
						}})
						vRPclient.notify(player, {"~g~Ti-ai dat un kit de arme!"})
					end, "Da-ti un kit de arme"}
					vRP.openMenu(player,menu)
				end)
			end}
		end
		add(choices)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
			if(vRP.hasGroup({i, "gold"})) and (spUtils[i] == true)then
				spUtils[i] = nil
				vRPclient.notify(v, {"~y~[GOLD] ~b~Acum iti poti folosi meniul GOLD!"})
			end
		end
	end
end)


vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}
	
		if(vRP.hasGroup(user_id, "diamond"))then
			choices["Meniu Diamond"] = {function(player,choice)
				vRP.buildMenu("diamond", {player = player}, function(menu)
					menu.name = "Meniu Diamond"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.closeMenu(player) end	
					menu["Kit Arme"] = {function(player, choice)
						vRPclient.giveWeapons(player,{{
							["WEAPON_Switchblade"] = {ammo=1},
							["WEAPON_SNS_Pistol_Mk_II"] = {ammo=200},
							["WEAPON_MICROSMG"] = {ammo=200},
							["WEAPON_KNUCKLE"] = {ammo=1},
							["WEAPON_ASSAULTSHOTGUN"] = {ammo=200},
							["WEAPON_REVOLVER"] = {ammo=200}, 
							["WEAPON_HEAVYSNIPER_MK2"] = {ammo=200},
							["WEAPON_GUSENBERG"] = {ammo=200},
							["WEAPON_BULLPUPRIFLE"] = {ammo =200},
							["WEAPON_MACHINEPISTOL"] = {ammo=200}
						}})
						vRPclient.notify(player, {"~g~Ti-ai dat un kit de arme!"})
					end, "Da-ti un kit de arme"}
					vRP.openMenu(player,menu)
				end)
			end}
		end
		add(choices)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
			if(vRP.hasGroup({i, "diamond"})) and (spUtils[i] == true)then
				spUtils[i] = nil
				vRPclient.notify(v, {"~b~[DIAMOND] ~b~Acum iti poti folosi meniul DIAMOND!"})
			end
		end
	end
end)