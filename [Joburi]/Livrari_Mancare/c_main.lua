isHired = false
CreateThread(function()
    create_local_npc(Angajator.location.x, Angajator.location.y, Angajator.location.z, "a_f_y_business_01", Angajator.location.heading)
    while true do
        Wait(1000)
        while Vdist(GetEntityCoords(PlayerPedId()), Angajator.location.x, Angajator.location.y,  Angajator.location.z) < 5 do
            Wait(0)
            k_Draw3D(Angajator.location.x, Angajator.location.y, Angajator.location.z+2.2, "~b~Mariana~w~")
            k_Draw3D(Angajator.location.x, Angajator.location.y, Angajator.location.z+2.1, "[~r~Manager~w~]", 1.3)
            k_Subtitle("Apasa [~b~E~w~] sa te angajezi")
            if IsControlJustPressed(1, 51) then
                isHired = not isHired
                if isHired then
                    TriggerEvent("toasty:Notify", {type="success", title="Angajat", message="Ai fost angajat, coboara sa iei pizza"})
                    TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Angajeaza-te ca livrator de pizza")
                else
                    destroyRoute()
                    TriggerEvent("toasty:Notify", {type="error", title="Angajat", message="Ti-ai dat demisia"})    
                end
                Wait(2000)
            end
        end
    end
end)

pizze = {}

CreateThread(function()
    pizza_reading_in = 60000
    CreateThread(function()
        while true do
            Wait(1000)
            pizza_reading_in = pizza_reading_in - 1000
        end
    end)

    while true do
        Wait(1000)
        while isHired and Vdist(GetEntityCoords(PlayerPedId()), Cuptor.x, Cuptor.y, Cuptor.z) < 5 do
            Wait(0)
            if pizza_reading_in <= 0 then
                k_Draw3D(Cuptor.x, Cuptor.y, Cuptor.z+1.0, "~b~Pizza este pregatita~w~")
                if IsControlJustPressed(1, 51) and #pizze < 5 then
                    pizza_reading_in = 60000
                    TriggerServerEvent("Livrari:Give_Pizza")
                    table.insert(pizze, GetGameTimer())
                end
            else
                k_Draw3D(Cuptor.x, Cuptor.y, Cuptor.z+1.0, "Pizza este in pregatire [~b~ ".. ms_to_minutes(pizza_reading_in) .." ~w~]")
            end
        end
    end
end)

locatia_noua = nil
CreateThread(function()
    while true do
        Wait(1000)
        while isHired do
            Wait(1000)
            for i, v in pairs(Delivery_Houses) do
                while Vdist(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z) < 5 do
                    Wait(0)
                    generic_marker(v.x, v.y, v.z-1.0)
                    if locatia_noua then
                        if Vdist(GetEntityCoords(PlayerPedId()), locatia_noua.x,  locatia_noua.y, locatia_noua.z) < 5 then
                            if IsControlJustPressed(1, 51) then
                                FreezeEntityPosition(PlayerPedId(), true)
                                ExecuteCommand(Animation)
                                TriggerServerEvent("Livrari:Deliver_Pizza")
                                TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Ia o pizza de jos, si livreaz-o")
                                Wait(3500)
                                FreezeEntityPosition(PlayerPedId(), false)
                                ExecuteCommand("e c")
                                -- random pizza
                                rpizza = math.random(1, #pizze)
                                table.remove(pizze, rpizza)
                                set_destination()
                            end
                        end
                    end
                end
            end
        end
    end
end)


function set_destination()
    random_destination = Delivery_Houses[math.random(1, #Delivery_Houses)]
    setRoute(random_destination.x, random_destination.y, random_destination.z)
    locatia_noua = random_destination
end

CreateThread(function() -- garage
    while true do
        Wait(1000)
        while Vdist(GetEntityCoords(PlayerPedId()), Garaj['Rent'].x, Garaj['Rent'].y, Garaj['Rent'].z) < 5 and isHired do
            Wait(0)
            k_Draw3D(Garaj['Rent'].x, Garaj['Rent'].y, Garaj['Rent'].z+2.0, "~b~Garaj~w~ [~r~E~w~]")
            generic_marker(Garaj['Rent'].x, Garaj['Rent'].y, Garaj['Rent'].z)
            if IsControlJustPressed(1, 51) then
                spawn_ped_in_net_created_vehicle(Garaj['Spawn'].x, Garaj['Spawn'].y, Garaj['Spawn'].z, "faggio2", Garaj['Spawn'].heading)
                set_destination()
                Wait(15000)
            end
        end
    end
end)



CreateThread(function()
    while true do
        Wait(1000)
        while isHired do
            Wait(0)
            gt = GetGameTimer()
            for i, pizza_timera in pairs(pizze) do
                d = gt - pizza_timera 
                d_seconds = ms_to_seconds(d)
                if d then
                    drawHudText(0.05,0.5+i/30, 0.0,0.0,0.65,"Pizza".. i ..": " .. d_seconds .. "/300s",107, 107, 219,255,1,6,1)
                    if d > 300000 then
                        table.remove(pizze, i)
                        TriggerServerEvent("Livrari_Pizza:Remove_Pizza")
                        break
                    end
                end
            end
        end
    end
end)