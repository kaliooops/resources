vRPTuning = {}
vRPTuning.CurrentRequestId          = 0
vRPTuning.ServerCallbacks           = {}

vRPTuning.TriggerServerCallback = function(name, cb, ...)
	vRPTuning.ServerCallbacks[vRPTuning.CurrentRequestId] = cb

	TriggerServerEvent('vRPTuning:triggerServerCallback', name, vRPTuning.CurrentRequestId, ...)

	if vRPTuning.CurrentRequestId < 65535 then
		vRPTuning.CurrentRequestId = vRPTuning.CurrentRequestId + 1
	else
		vRPTuning.CurrentRequestId = 0
	end
end

RegisterNetEvent('vRPTuning:serverCallback')
AddEventHandler('vRPTuning:serverCallback', function(requestId, ...)
	vRPTuning.ServerCallbacks[requestId](...)
	vRPTuning.ServerCallbacks[requestId] = nil
end)