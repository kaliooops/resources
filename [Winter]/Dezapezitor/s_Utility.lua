function getUserID(source)
    identifier = GetPlayerIdentifier(source, 0)
    local user_id = -1
    exports.ghmattimysql:execute("SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier", {identifier = identifier}, function(rows)    
        user_id = rows[1].user_id
    end)

    while user_id == -1 do Wait(1000) end
    return user_id
end

