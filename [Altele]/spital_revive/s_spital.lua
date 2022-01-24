local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")



-- RegisterServerEvent("spital_heal")
-- AddEventHandler("spital_heal", function()
--     local user_id = vRP.getUserId({source})
--     local price = 500

--     if vRP.tryPayment(user_id,price) then
--         TriggerClientEvent("cspital_heal")
--         TriggerClientEvent("toasty:Notify", player , {type = "error", title="Doctor", message = "Ai fost tratat, ai grija de tine :*"})
--     else
--         print("n-are bani")
--         TriggerClientEvent("toasty:Notify", player , {type = "error", title="Doctor", message = "Nu ai destui 💵"})
--     end

-- end)