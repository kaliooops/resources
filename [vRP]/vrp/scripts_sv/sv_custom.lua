function tvRP.getUserID()
	return vRP.getUserId(source)
end

function tvRP.getUserFaction()
	user_id = vRP.getUserId(source)
	if vRP.hasUserFaction(user_id) then
		local theFaction = vRP.getUserFaction(user_id)
		return theFaction
	else
		return "Civil"
	end
end


RegisterServerEvent('vk_handsup:getSurrenderStatus')
AddEventHandler('vk_handsup:getSurrenderStatus', function(event,targetID)
	TriggerClientEvent("vk_handsup:getSurrenderStatusPlayer",targetID,event,source)
end)

RegisterServerEvent('vk_handsup:sendSurrenderStatus')
AddEventHandler('vk_handsup:sendSurrenderStatus', function(event,targetID,handsup)
	TriggerClientEvent(event,targetID,handsup)
end)

RegisterServerEvent('vk_handsup:reSendSurrenderStatus')
AddEventHandler('vk_handsup:reSendSurrenderStatus', function(event,targetID,handsup)
	TriggerClientEvent(event,targetID,handsup)
end)