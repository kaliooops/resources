spawned_objects = {}
function kSpawnObject(hash, coords, heading)
    local object = CreateObject(hash, coords[1], coords[2], coords[3], true, true, true)
    SetEntityHeading(object, heading)
    table.insert(spawned_objects, object)
    return object
end

function kCleanUp()
    for k, o in pairs(spawned_objects) do    
        pcall(DeleteEntity, o)
    end
    spawned_objects = {}
end


function return_Items(uID)
    if #player_inventories[uID] > 0 then
        for k, v in pairs(player_inventories[uID]) do
            if k ~= nil then
                vRP.giveInventoryItem({uID, k, player_inventories[uID][k]['amount']})
            end
        end
    end
end

function string_has_substring(string, substring)
    return string.find(string, substring) ~= nil
end