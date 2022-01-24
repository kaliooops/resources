active_missions = 0
pets = {}


copaci = {
    vector3(151.73243713378,-970.62841796875,30.09178352356),
}


RegisterCommand("vreaumisiune", function ()
    local c = copaci[math.random(1, #copaci)]
    SetNewWaypoint(c.x, c.y)
end, false)

CreateThread(function()  --handle pets
    while true do
        Wait(1000)
        for _, pet in pairs(pets) do
            if GetEntityHealth(pet) <= 0 then
                SetTimeout(15000, function()
                    SetEntityAsMissionEntity(pet, true, true)
                    DeleteEntity(pet)
                end)
                table.remove(pets, _)
            end
        end
    end
end)

CreateThread(function() --main interaction
    while true do
        Wait(1000)

        for _, brad in pairs(copaci) do
            
            while Vdist(GetEntityCoords(PlayerPedId()), table.unpack(brad)) < 10 do
                Wait(0)
                draw_brad_info(brad)

                while Vdist(GetEntityCoords(PlayerPedId()), table.unpack(brad)) < 4 do --functionalitate
                    Wait(0)
                    if active_missions == 0 then
                        drawSubtitleText("Apasa [~b~E~w~] pentru a lua o misiune", 1)
                    end

                    if IsControlJustPressed(1, 51) then
                        if #pets == 0 then
                            spawn_pet_husky()
                        end

                        if active_missions == 0 then
                            TriggerServerEvent("winter_misiuni:get_new_mision")
                        end
                    end
                end
            end
        end
    end

end)