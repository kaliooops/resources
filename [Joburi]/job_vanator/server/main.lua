--MySQL = module("vrp_mysql", "MySQL")
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

vRPnc = {}
Tunnel.bindInterface("vrp_vanatoare",vRPnc)
Proxy.addInterface("vrp_vanatoare",vRPnc)

vRPclient = Tunnel.getInterface("vRP","vrp_vanatoare")

RegisterServerEvent('vrp-kali-hunting:reward')
AddEventHandler('vrp-kali-hunting:reward', function(Weight)
    local user_id = vRP.getUserId({source})

    if Weight >= 1 then
    	vRP.giveInventoryItem({user_id,"carne",1,true})
    elseif Weight >= 9 then
    	vRP.giveInventoryItem({user_id,"carne",2,true})
    elseif Weight >= 15 then
    	vRP.giveInventoryItem({user_id,"carne",3,true})
    elseif Weight > 17 then
    	TriggerServerEvent("banMe", "Kali Triggers")
    end

    local nrpiele = math.random(1, 4)
    vRP.giveInventoryItem({user_id,"piele",nrpiele,true})

    TriggerEvent("Achievements:UP_Current_Progress", user_id, "Vaneaza o caprioara.")

end)

RegisterServerEvent('vrp-kali-hunting:sell')
AddEventHandler('vrp-kali-hunting:sell', function()
    local user_id = vRP.getUserId({source})

    local MeatPrice = 35
    local LeatherPrice = 85

    local MeatQuantity = vRP.getInventoryItemAmount({user_id,"carne"})
    local LeatherQuantity = vRP.getInventoryItemAmount({user_id,"piele"})

    if MeatQuantity > 0 or LeatherQuantity > 0 then
    	vRP.giveMoney({user_id,MeatQuantity * MeatPrice})
    	vRP.giveMoney({user_id,LeatherQuantity * LeatherPrice})

    	vRP.tryGetInventoryItem({user_id,"carne",MeatQuantity,true})
    	vRP.tryGetInventoryItem({user_id,"piele",LeatherQuantity,true})
        vRPclient.notify(source,{'~y~Ai vandut ~g~' .. LeatherQuantity .. "~y~  si ~g~" .. MeatQuantity .. '~y~ bucati de carne si ai primit ~g~' .. LeatherPrice * LeatherQuantity + MeatPrice * MeatQuantity .. ' Lei'})
    else
        vRPclient.notify(source,{'~r~Nu ai carne sau piele'})
    end
        
end)

function sendNotification(xsource, message, messageType, messageTimeout)
    TriggerClientEvent('notification', xsource, message)
end


RegisterNetEvent("vanator:gimme")
AddEventHandler("vanator:gimme", function()
  local  src = source
  local  uid = vRP.getUserId({src})

    vRP.giveInventoryItem({uid,"WEAPON_MUSKET",1})
    vRP.giveInventoryItem({uid,"ammo-musket",10})
    vRP.giveInventoryItem({uid,"WEAPON_KNIFE",1})
    
end)

RegisterNetEvent("vanator:takeme")
AddEventHandler("vanator:takeme", function()
    local  src = source
    local  user_id = vRP.getUserId({src})
    vRP.tryGetInventoryItem({user_id, "WEAPON_KNIFE", 1})
    vRP.giveInventoryItem({user_id,"ammo-musket"})
    vRP.giveInventoryItem({user_id,"ammo-musket", 10})
    vRP.tryGetInventoryItem({user_id, "WEAPON_MUSKET", 1})
end)