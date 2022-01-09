vRP.registerMenuBuilder("main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}
	
		if(vRP.hasGroup(user_id, "youtuber"))then
			choices["YouTuber Menu"] = {function(player,choice)
				vRP.buildMenu("ytmenu", {player = player}, function(menu)
					menu.name = "YouTuber Menu🎤 "
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.closeMenu(player) end
					menu["Revive"] = {function(player, choice)
						vRPclient.isInComa(player,{}, function(in_coma)
							if in_coma then
								vRPclient.varyHealth(player,{100}) 
								SetTimeout(1000, function()
									vRPclient.varyHealth(player,{100})
								end)
								vRPclient.notify(player,{"~g~Ti-ai dat revive!"})
							else
								vRPclient.notify(player,{"~r~Nu esti mort"})
							end
						end)
					end, "Da-ti revive"}
					
					menu["Fix Masina"] = {function(player, choice)
						vRPclient.fixeNearestVehicle(player,{7})
						vRPclient.notify(player, {"~g~Ai reparat vehiculul!"})
					end, "Repara vehiculul in care te afli"}
					
					menu["Kit Arme"] = {function(player, choice)
						vRPclient.giveWeapons(player,{{
							["WEAPON_PISTOL50"] = {ammo=200},
							["WEAPON_MACHETE"] = {ammo=1},
							["WEAPON_STUNGUN"] = {ammo=1},
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