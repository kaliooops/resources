--import all vrp 
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

capturers = {}

turfs = {}

RegisterNetEvent("turfuri:Mortaciune")
AddEventHandler("turfuri:Mortaciune", function(t)
    mortaciune_src = source
    mortaciune_id = vRP.getUserId({mortaciune_src})
    mortaciune_faction = vRP.getUserFaction({mortaciune_id})
    print("Semnal mortaciune: " .. mortaciune_id .. mortaciune_faction)
    if vRP.getFactionType({mortaciune_faction}) == "Mafie" then
        turf_id = t.id
        mortaciune(turf_id, mortaciune_faction)
    end
end)

RegisterNetEvent("turfuri:Capture")
AddEventHandler("turfuri:Capture", function(t)
    capturer_src = source
    capturer_id = vRP.getUserId({capturer_src})
    capturer_faction = vRP.getUserFaction({capturer_id})

    if vRP.getFactionType({capturer_faction}) == "Mafie" then
        turf_id = t.id


        -- append to capturers the faction of the capturer id, and the time it started, if any member of that same
        -- faction tries to capture dont take it into consideration only after 1second passed
        -- if not capturers[capturer_faction] then
        --     capturers[capturer_faction] = {
        --         faction = capturer_faction,
        --         time = GetGameTimer()
        --     }
        -- end
    
        -- if capturers[capturer_faction].faction then
            -- if GetGameTimer() - capturers[capturer_faction].time > 1000 then
                Capture(turf_id, capturer_faction)
                -- capturers[capturer_faction].time = GetGameTimer()
            -- end
        -- end
    
    end

end)

function Get_Current_Score_and_Faction(turf_id) 
    local result = exports.ghmattimysql:executeSync("select * from turfuri where id = @id", {id = turf_id})
    return result[1].score, result[1].owner
end

function Add_Score(turf_id) 
    exports.ghmattimysql:execute("update turfuri set score = score + 1 where id = @id", {id = turf_id})
end

function Subtract_Score(turf_id)
    exports.ghmattimysql:execute("update turfuri set score = score - 1 where id = @id", {id = turf_id})
end

function mortaciune(turf_id, my_faction)
    score, owner = Get_Current_Score_and_Faction(turf_id)

    print("mortaciunea: " .. my_faction .. " owneru turfului: " .. owner)

    if owner == my_faction then
        exports.ghmattimysql:execute("update turfuri set score = score - 100 where id = @id", {id = turf_id})
    else
        exports.ghmattimysql:execute("update turfuri set score = score + 100 where id = @id", {id = turf_id})
    end

end

function Change_Ownership(turf_id, capturer_faction) 
    exports.ghmattimysql:execute("update turfuri set owner = @owner, score = 0 where id = @id", {owner = capturer_faction, id = turf_id})
end


function Add_Money(turf_id) 
    exports.ghmattimysql:execute("update turfuri set bani = bani + 1 where id = @id", {id = turf_id})    
end

function Reset_Money(turf_id)
    exports.ghmattimysql:execute("update turfuri set bani = 0 where id = @id", {id = turf_id})
end


function Capture(turf_id, my_faction)
    score, faction = Get_Current_Score_and_Faction(turf_id)

    if faction ~= my_faction then
        if score > 1 then
            Subtract_Score(turf_id)
        else
            Change_Ownership(turf_id, my_faction)
            -- TriggerClientEvent("chatMessage", -1, "[^3 Turfuri ^0] Zona ^2" .. turf_id .. "^0 este atacata de ^1" .. my_faction)
            Reset_Money(turf_id)
        end
    else
        if score < 86400 then
            Add_Score(turf_id)
        else
            Add_Money(turf_id)
        end
    end
end



RegisterCommand("seif", function(source, args, x)
    src = source
    id = vRP.getUserId({src})
    faction = vRP.getUserFaction({id})
    local result = exports.ghmattimysql:executeSync("select * from turfuri where owner = @owner", {owner = faction})

    for k, v in pairs(result) do
        TriggerClientEvent("chatMessage", src, "[^3 Bani-Turfuri ^0] In zona ^1" .. v.id .. "^0 ai " .. v.bani .. " euro")
    end


end, false)




RegisterNetEvent("turfuri:Get_Turfs")
AddEventHandler("turfuri:Get_Turfs", function()
    src = source
    local result = exports.ghmattimysql:executeSync("select * from turfuri")
    TriggerClientEvent("turfuri:Get_Turfs", src, result)
end)