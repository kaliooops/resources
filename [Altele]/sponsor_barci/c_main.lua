CreateThread(function()
    local waittime = 1000
    while true do
        Wait(waittime)
        
        local p_coords = GetEntityCoords(PlayerPedId())
        local garaj = cfg.garaj
        
        
        if Vdist(p_coords.x, p_coords.y, p_coords.z, garaj.x, garaj.y, garaj.z) < 20.0 then
            waittime = 0
            --draw 3d saying "Garaj Barci"
            Draw3DText(garaj.x, garaj.y, garaj.z + 1.0, "[~g~Yacht Sponsor~w~]")

            --draw marker at garaj coords
            DrawMarker(1, garaj.x, garaj.y, garaj.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 100, 255, 100, 100, false, true, 2, false, false, false, false)

            --if distance between player and garaj is less than 2.0
            if Vdist(p_coords.x, p_coords.y, p_coords.z, garaj.x, garaj.y, garaj.z) < 2.0 then
                if IsControlJustPressed(1, 51) then
                    
                    local yacht = TeleportPedInCreatedVeh(PlayerPedId(), "yaluxe", cfg.veh_spawn, cfg.veh_heading)

                end
            end
        end


    end

    
end)

Citizen.CreateThread(function()
    local garaj = cfg.garaj
    local blip = AddBlipForCoord(garaj.x, garaj.y, garaj.z)
    SetBlipSprite(blip, 427)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 27)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Sponsor Yacht")
    EndTextCommandSetBlipName(blip)
  end)