function convert_miliseconds_to_minutes(ms)
    --return minutes:seconds
    local minutes = math.floor(ms / 60000)
    local seconds = math.floor((ms % 60000) / 1000)
    return minutes .. ":" .. seconds
end


function find_element_index(table, element)
    for i, v in ipairs(table) do
        if v == element then
            return i
        end
    end
    return nil
end