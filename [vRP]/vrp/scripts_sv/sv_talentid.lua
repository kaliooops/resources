AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
	if first_spawn then
		local users = vRP.getUsers()
		for k,v in pairs(users) do
			TriggerClientEvent("id:initPlayer", source, v, k)
			TriggerClientEvent("id:initPlayer", v, source, user_id)
		end
	end
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	TriggerClientEvent("id:removePlayer", -1, source)
end)