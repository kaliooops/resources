--
RegisterServerEvent("esx_uber:pay")
AddEventHandler("esx_uber:pay",function(a)
    local b=source;
    local c=vRP.getUserId({b})
    vRP.giveMoney({c,tonumber(a)})
end)


RegisterServerEvent("uber:esyaSil")
AddEventHandler("uber:esyaSil",function(a)
    local b=source;
    local c=vRP.getUserId({b})
    vRP.tryGetInventoryItem({c,a,1})
end)