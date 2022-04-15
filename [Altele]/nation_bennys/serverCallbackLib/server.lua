vRPTuning={}
vRPTuning.ServerCallbacks={}


RegisterServerEvent('vRPTuning:triggerServerCallback')
AddEventHandler('vRPTuning:triggerServerCallback',function(a,b,...)
    local c=source

    vRPTuning.TriggerServerCallback(a,requestID,c,function(...)
        TriggerClientEvent('vRPTuning:serverCallback',c,b,...)end,...)
    end)
        
        
    
vRPTuning.RegisterServerCallback = function(a,t)
    vRPTuning.ServerCallbacks[a]=t 
end
                    
vRPTuning.TriggerServerCallback = function(a,b,source,t,...)
    if vRPTuning.ServerCallbacks[a]~=nil then 
        vRPTuning.ServerCallbacks[a](source,t,...)
    else 
        print('TriggerServerCallback => ['..a..'] does not exist')
    end 
end