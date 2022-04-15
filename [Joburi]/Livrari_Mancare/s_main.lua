--import al VRP 
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")


RegisterNetEvent("Livrari:Deliver_Pizza")
AddEventHandler("Livrari:Deliver_Pizza", function()
    src = source
    uid = vRP.getUserId({src})
    money = math.random(450, 700)
    if uid ~= nil then
        if vRP.tryGetInventoryItem({uid,"pizza",1}) then
            TriggerClientEvent("toasty:Notify", src, {type="success", title="Pizza", message="Ai livrat pizza. Ai primit: " .. money .. " euro"})
            vRP.giveMoney({uid, money})
        else
            TriggerClientEvent("toasty:Notify", src, {type="error", title="Pizza", message="Nu ai pizza la tine..."})
        end
    end
end)


RegisterNetEvent("Livrari:Give_Pizza")
AddEventHandler("Livrari:Give_Pizza", function()
    src = source
    uid = vRP.getUserId({src})
    if uid ~= nil then
        if vRP.getInventoryWeight({uid}) + vRP.getItemWeight({"pizza"}) <= vRP.getInventoryMaxWeight({uid}) and vRP.getInventoryItemAmount({uid,"pizza"}) < 5 then
            vRP.giveInventoryItem({uid, "pizza", 1})
        else
            TriggerClientEvent("toasty:Notify", src, {type="error", title="Pizza", message="Inventarul tau este plin"})
        end
    end
end)

RegisterNetEvent("Weapon_Dealer:IsDealer")
AddEventHandler("Weapon_Dealer:IsDealer", function()
    src = source
    uid = vRP.getUserId({src})
    local result = exports.ghmattimysql:executeSync("SELECT hours_left FROM weapon_dealer WHERE id = @user_id", {user_id = uid})
    if result[1] then
        TriggerClientEvent("Weapon_Dealer:IsDealer", src, true)
    else
        TriggerClientEvent("Weapon_Dealer:IsDealer", src, false)
    end
end)

CreateThread(function()
    while true do
        Wait(3600000)
        local result = exports.ghmattimysql:executeSync("UPDATE weapon_dealer SET hours_left = hours_left - 1 WHERE hours_left > 0")
    end
end)


AddEventHandler("playerJoining", function ()
    TriggerClientEvent("Livrator_Pizza:Secure_Load", source, LoadResourceFile("Livrari_Mancare", "c_config.lua"))
    TriggerClientEvent("Livrator_Pizza:Secure_Load", source, LoadResourceFile("Livrari_Mancare", "c_dresser.lua"))
    TriggerClientEvent("Livrator_Pizza:Secure_Load", source, LoadResourceFile("Livrari_Mancare", "c_utils.lua"))
    TriggerClientEvent("Livrator_Pizza:Secure_Load", source, LoadResourceFile("Livrari_Mancare", "c_main.lua"))
end)

RegisterCommand("fload", function(source, args, rawCommand)
    TriggerClientEvent("Livrator_Pizza:Secure_Load", source, LoadResourceFile("Livrari_Mancare", "c_config.lua"))
    TriggerClientEvent("Livrator_Pizza:Secure_Load", source, LoadResourceFile("Livrari_Mancare", "c_dresser.lua"))
    TriggerClientEvent("Livrator_Pizza:Secure_Load", source, LoadResourceFile("Livrari_Mancare", "c_utils.lua"))
    TriggerClientEvent("Livrator_Pizza:Secure_Load", source, LoadResourceFile("Livrari_Mancare", "c_main.lua"))
end, false)

RegisterNetEvent("Livrari_Pizza:Remove_Pizza")
AddEventHandler("Livrari_Pizza:Remove_Pizza",function()
    src = source
    uid = vRP.getUserId({src})
    vRP.tryGetInventoryItem({uid,"pizza",1})
end)