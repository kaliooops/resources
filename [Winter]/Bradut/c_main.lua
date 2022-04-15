active_missions = 0
pets = {}


copaci = {
    vector3(197.15449523926,-997.01391601563,30.091779708862),
}



CreateThread(function() --main interaction
    while true do
        Wait(1000)

        for _, brad in pairs(copaci) do
            
            while Vdist(GetEntityCoords(PlayerPedId()), table.unpack(brad)) < 10 do
                Wait(0)
                draw_brad_info(brad)

                while Vdist(GetEntityCoords(PlayerPedId()), table.unpack(brad)) < 4 do --functionalitate
                    Wait(0)
                        drawSubtitleText("Apasa [~b~E~w~] pentru a pune cadoul in brad", 1)

                    if IsControlJustPressed(1, 51) then

                            TriggerServerEvent("winter_misiuni:k2uri_sub_brad")
                        end
                    end
                    end
                end
            end

end)