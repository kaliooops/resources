-- Tunnel = module("vrp", "lib/Tunnel")
-- Proxy = module("vrp", "lib/Proxy")
-- vRP = Proxy.getInterface("vRP")

-- local function buildPaulMenu(player)
--     local menu = {name = "Paul",css={top="75px",header_color="rgba(0,125,255,0.75)"}}
--     menu.name = "Paul"

--     local function ch_mustang(player,choice)
--         local user_id = vRP.getUserId({player})
--         if user_id ~= nil then
--             a = vRP.getInventoryItemAmount({user_id,"aphone"})
--             if a > 9 then
--                 TriggerEvent("paul:giveMustang", player)
--             end
--             vRP.closeMenu({player})
--         end
--     end
--     menu['Mustang'] = {ch_mustang,"10 aphone"}

-- 	vRP.openMenu({player,menu})
-- end
-- RegisterServerEvent("Paul:openMenu")
-- AddEventHandler("Paul:openMenu", function(name)
-- 	local user_id = vRP.getUserId({source})
--     buildPaulMenu(source)
-- end)

-- RegisterServerEvent("paul:giveMustang", function(player)
--     local user_id = vRP.getUserId({player})
--     if user_id ~= nil then
--         vRP.giveInventoryItem({user_id,"tarnacop",1})
--     end
-- end)