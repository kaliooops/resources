--import all necesarry vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vRP = Proxy.getInterface("vRP")

cfg = {
    Fleeca_Centrala = {
        name = "Fleeca Centrala",
        secunde_ramase = 5,
    },
    Fleeca_Highway = {
        name = "Fleeca Highway",
        secunde_ramase = 5,
    },


}

--send cop data
CreateThread(function ()
    while true do
        Wait(30000)

        local cop_n = #vRP.getOnlineUsersByFaction({"Politia Romana"})
        --triger client event for everyone to know cop number
        TriggerClientEvent("get_cop_number", -1, cop_n)
    end
end)



CreateThread(function ()
    local waittime = 1000
    while true do
        Wait(waittime)
        --for each bank in cfg, send to everyone bank name and secunde_ramse
        for _,bank in pairs(cfg) do
            bank.secunde_ramase = bank.secunde_ramase - 1
            TriggerClientEvent("get_wait_time_for_bank", -1, bank.name, bank.secunde_ramase)
        end
    end
end)

RegisterServerEvent('get:panou')
AddEventHandler('get:panou', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.tryGetInventoryItem({user_id,"sudura", 1}) then
     TriggerClientEvent("actions:panou", -1)
else
end
end)

RegisterServerEvent('get:balamale')
AddEventHandler('get:balamale', function()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.tryGetInventoryItem({user_id,"sudura", 1}) then
     TriggerClientEvent("actions:balamale", -1)
else
end
end)

RegisterNetEvent("bank_robbed")
AddEventHandler("bank_robbed", function (t_bank)
    for _, bank in pairs(cfg) do
        if bank.name == t_bank.name then
            --trigger chat message to everyone
            TriggerClientEvent("chatMessage", -1, "", {255,255,255}, bank.name .. " este jefuita!")
            bank.secunde_ramase = 300
            TriggerClientEvent("get_wait_time_for_bank", -1, bank.name, bank.secunde_ramase)            
            break
        end
    end
end)

RegisterNetEvent("rob_finished")
AddEventHandler("rob_finished", function (t_bank)

    if t_bank == nil then
        --trigger event ban
        TriggerEvent("k2ANTICHEAT:ban", source, " ROB_FINISHED nil")
    end

    for _, bank in pairs(cfg) do
        if bank.name == t_bank.name then
            --trigger chat message to everyone
            TriggerClientEvent("chatMessage", -1, "", {255,255,255}, bank.name .. " a fost jefuita!")
            bank.secunde_ramase = 3600
            TriggerClientEvent("get_wait_time_for_bank", -1, bank.name, bank.secunde_ramase)            

            local user = vRP.getUserId({source})

            --give dity money random ammount
            local money = math.random(3500, 50000)
            vRP.giveInventoryItem({user, "dirty_money", money,true})
            
            TriggerEvent("k2ANTICHEAT:logger", "banks.txt", "ROB_FINISHED " .. bank.name .. " " .. money .. " " .. GetPlayerName(source))
            break
        end
    end
end)

RegisterNetEvent("rob_failed")
AddEventHandler("rob_failed", function (t_bank)
    if t_bank == nil then
        --trigger event ban
        TriggerEvent("k2ANTICHEAT:ban", source, " ROB_FINISHED nil")
    end

    for _, bank in pairs(cfg) do
        if bank.name == t_bank.name then
            --trigger chat message to everyone
            TriggerClientEvent("chatMessage", -1, "", {255,255,255}, bank.name .. " a fost salvata multumit organelor de justitie interna!")
            bank.secunde_ramase = 3600
            TriggerClientEvent("get_wait_time_for_bank", -1, bank.name, bank.secunde_ramase)  
       break
        end
    end
    end)