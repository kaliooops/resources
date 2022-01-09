--import all vrp relatled
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

RegisterNetEvent("jailaplayer")
AddEventHandler("jailaplayer", function (source, id, time)
    local s_id = vRP.getUserId({source})
    local s_faction = vRP.getUserFaction({s_id})
    id = tonumber(id)
    time = tonumber(time)
    if s_faction == "Politia Romana" then
        local player = vRP.getUserSource({id})
        TriggerClientEvent("pdjailme", player)
        TriggerEvent("k2ANTICHEAT:logger", "jail_pd.txt", s_id .. " a dat pdjail lu " .. id)

        exports.ghmattimysql:execute("INSERT INTO pd_jail (player_id, time) VALUES (@id, @time)", {
            ['@time'] = time,
            ['@id'] = id
        })
    else
        TriggerEvent("k2ANTICHEAT:ban", source, " pdjail fara acces")
    end
end)


CreateThread(function()
    while true do
        exports.ghmattimysql:execute("SELECT * FROM pd_jail", {}, function(data)
            for k,v in pairs(data) do
                local id = v.player_id
                local time = v.time
                local player = vRP.getUserSource({id})
                if player then
                    TriggerClientEvent("pdjailtime", player, time)
                    


                    if time <= 0 then
                        TriggerClientEvent("pdjailrelease", player)
                        exports.ghmattimysql:execute("DELETE FROM pd_jail WHERE player_id = @id", {
                            ['@id'] = id
                        })
                    end
                    
                end
            end
        end)
        Wait(15000)

        --update current jail time minutes 30 seconds
        exports.ghmattimysql:execute("UPDATE pd_jail SET time = time - 15 WHERE time > 0", {})



    end

end)


