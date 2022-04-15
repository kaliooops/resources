--import vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
CreateThread(function()
    while true do
        Wait(1000)
        for _, p in pairs(vRP.getUsers()) do
            uid = vRP.getUserId({p})
            bank_money = vRP.getBankMoney({uid})
            wallet_money = vRP.getMoney({uid})
            diamonds = vRP.getKRCoins({uid})
            data1 = {
                type = "money",
                value = wallet_money
            }
            data2 = {
                type = "bankmoney",
                value = bank_money
            }
            data3 = {
                type = "diamante",
                value = diamonds
            }

            TriggerClientEvent("HUD:Update", p, data1)
            TriggerClientEvent("HUD:Update", p, data2)
            TriggerClientEvent("HUD:Update", p, data3)
        end
    end
end)