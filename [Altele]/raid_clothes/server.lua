local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","raid_clothes")

vRPclothes = {}
Tunnel.bindInterface("raid_clothes",vRPclothes)
Proxy.addInterface("raid_clothes",vRPclothes)

function vRPclothes.getPlayerSkin()
    local thePlayer = source
    if thePlayer ~= nil then
        local user_id = vRP.getUserId({thePlayer})
        if user_id ~= nil then
            local result = exports.ghmattimysql:executeSync("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = user_id})
            local skinu = nil
            if result[1].skin ~= "New" then
                skinu = json.decode(result[1].skin)
            end
            return skinu
        end
    end
end

RegisterServerEvent('raid_clothes:save')
AddEventHandler('raid_clothes:save', function(data)
    local thePlayer = source
    if thePlayer ~= nil then
        local user_id = vRP.getUserId({thePlayer})
        if user_id ~= nil then
            exports.ghmattimysql:execute("UPDATE vrp_users SET skin = @data WHERE id = @user_id", {user_id = user_id, data = json.encode(data)})
        end
    end
end)

RegisterServerEvent("raid_clothes:checkMoney")
AddEventHandler("raid_clothes:checkMoney", function(menu,askingPrice)
    local thePlayer = source
    if thePlayer ~= nil then
        local user_id = vRP.getUserId({thePlayer})
        if user_id ~= nil then
            if tonumber(askingPrice) then
                if tonumber(askingPrice) >= 0 then
                    if not askingPrice then
                        askingPrice = 0
                    end
                    if (tonumber(vRP.getMoney({user_id})) >= askingPrice) then
                        vRP.tryFullPayment({user_id, askingPrice})
                        vRPclient.notify(thePlayer, {"Succes: Ai platit ~g~$"..askingPrice})
                        TriggerClientEvent("raid_clothes:hasEnough",thePlayer,menu)
                    else
                        vRPclient.notify(thePlayer, {"Eroare: ~r~Fonduri insuficiente!"})
                    end
                end
            end
        end
    end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,thePlayer,first_spawn)
    if first_spawn then
        exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @uid',{uid = user_id},function(rows)
            if #rows == 1 then
                if rows[1].skin ~= nil and rows[1].skin ~= 'New' and rows[1].skin ~= '' then
                    TriggerClientEvent('raid_clothes:loadclothes',thePlayer,json.decode(rows[1].skin))
                else
                    vRPclient.notify(thePlayer,{'~r~Nu ai imbracaminte, du-te la ~g~Magazinul de Haine~r~ si imbraca-te!'})
                    TriggerClientEvent('clothes:firstSpawn',thePlayer)
                end
            end
        end)
    end
end)