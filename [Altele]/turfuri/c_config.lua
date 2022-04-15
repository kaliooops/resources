turfuri = {
}


RegisterNetEvent("turfuri:Get_Turfs")
AddEventHandler("turfuri:Get_Turfs", function(ts)
    for _, t in pairs(ts) do
        if #turfuri == 0 then
            table.insert(turfuri, t)
        end
        for _, tr in pairs(turfuri) do
            if t.x == tr.x and t.y == tr.y and t.z == tr.z then
                tr.score = t.score
                tr.owner = t.owner
            end
        end

    end

end)

TriggerServerEvent("turfuri:Get_Turfs")   

