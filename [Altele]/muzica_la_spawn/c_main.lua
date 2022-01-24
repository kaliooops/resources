

local xSound = exports.xsound

--destroy old ones for safety
for k, v in pairs(spawn_locations) do
    xSound:Destroy(k)
end

CreateThread(function()
    while true do
        song_link = play_list[math.random(#play_list)]

        for k,v in pairs(spawn_locations) do
            if not xSound:soundExists(k) then
                xSound:PlayUrlPos(k, tostring(song_link), 0.03, v, false)            
                xSound:Distance(k, 100)
            end
            
            if xSound:getMaxDuration(k) - xSound:getTimeStamp(k) < 5 then
                xSound:PlayUrlPos(k, tostring(song_link), 0.03, v, false)
                xSound:Distance(k, 100)
            
            end
        end

        

        Wait(3000)

    end

end)
