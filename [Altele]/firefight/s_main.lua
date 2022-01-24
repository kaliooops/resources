-- --import all vrp
-- local Tunnel = module("vrp", "lib/Tunnel")
-- local Proxy = module("vrp", "lib/Proxy")

-- vRP = Proxy.getInterface("vRP")

-- local event_finished = 0
-- local dmg_source = 0
-- local dmg_type = 0
-- local dmg_target = 0
-- AddEventHandler("weaponDamageEvent", function (source, data)
--     if event_finished == 0 then
--         dmg_source = source       
--         dmg_type = data.damageType
--         wep_type = data.weaponType
--         wep_dmg = data.weaponDamage
--     elseif event_finished == 1 then
--         dmg_target = source
        
--         if wep_dmg == 1 then
--             TriggerClientEvent("shakemycam", dmg_target, 5.0)    
--         else
--             TriggerClientEvent("shakemycam", dmg_target, 0.04)
--         end
        
--     else
--         event_finished = 0
--         dmg_source = 0
--         dmg_target = 0
--     end
--     event_finished = event_finished + 1
-- end)
