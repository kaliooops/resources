function rob(bank)
    TriggerServerEvent("bank_robbed", bank)

    local ped = PlayerPedId()
        
    while bank.secunde_ramase == 0 do Wait(2500) end

    ---------triggere

    RegisterNetEvent("actions:panou")
    AddEventHandler("actions:panou", function (ped)
        SetEntityCoords(ped, bank.panou.location.x, bank.panou.location.y, bank.panou.location.z, 1, 0, 0, 0)
        SetEntityHeading(ped, bank.panou.heading)
        ExecuteCommand(bank.panou.anim)
        showProgress("Tai panoul")
        Wait(150000)
        bank.panou.finished = true
        ClearPedTasks(ped)
    end)

    RegisterNetEvent("actions:balamale")
    AddEventHandler("actions:balamale", function (ped)
        SetEntityCoords(ped, bank.balamale.location.x, bank.balamale.location.y, bank.balamale.location.z, 1, 0, 0, 0)
        SetEntityHeading(ped, bank.balamale.heading)
        ExecuteCommand(bank.balamale.anim)
        showProgress("Tai balamalele")
        Wait(150000)
        bank.balamale.finished = true
        ClearPedTasks(ped)
    end)

    ExecuteCommand("e texting")
    ExecuteCommand("me Opreste camerele")
    Wait(5000)
    ClearPedTasks(ped)
    bank.is_being_robbed = true
    CreateThread(function ()
        Wait(1800000)
        bank.is_being_robbed = false
        bank.balamale.finished = true
        bank.panou.finished = true
        TriggerServerEvent("rob_failed", bank)
    end)
    while true do        
        Wait(0)
        local ped_coords = GetEntityCoords(ped)
        if not bank.panou.finished then
            k_draw3DText(bank.panou.location.x, bank.panou.location.y, bank.panou.location.z+1.5, "Panou", 1.0, 4)
            if Vdist(ped_coords, bank.panou.location) < 2.0 then
                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent('get:panou')
                end
            end
        end

        if not bank.balamale.finished then
            k_draw3DText(bank.balamale.location.x, bank.balamale.location.y, bank.balamale.location.z+1.5, "Balamale", 1.0, 4)
            if Vdist(ped_coords, bank.balamale.location) < 2.0 then
                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent('get:balamale')
                end
            end
        end

        if bank.panou.finished and bank.balamale.finished and bank.is_being_robbed then
            SetNewWaypoint(3352.3271484375,5559.6840820313,18.539682388306)
            k_draw3DText(3352.3271484375,5559.6840820313,18.539682388306+1.5, "Ascunde aici Banii",1.0, 4)
            if Vdist(ped_coords, 3352.3271484375,5559.6840820313,18.539682388306) < 2.0 then
                if IsControlJustPressed(1, 51) then
            TriggerServerEvent("rob_finished", bank)
            break
        end
    end
end
    end
end


local cop_number = 0
--prepare banks
CreateThread(function ()
    local waittime = 1000
    while true do
        Wait(waittime)
        local ped = PlayerPedId()
        local ped_coords = GetEntityCoords(ped)
                
        for _,bank in pairs(cfg) do
            local bank_coords = bank.location
            local panou = bank.panou
            local balamale = bank.balamale
            local dist = #(ped_coords - bank_coords)

            if dist < 3.0 then
                waittime = 0
                if bank.secunde_ramase <= 0 then
                    --draw can rob
                    k_draw3DText(bank_coords.x, bank_coords.y, bank_coords.z+1.0, "Apasa [~b~E~w~] sa jefuiesti", 1, 1)
                    if IsControlJustPressed(1, 51) then
                        if cop_number >= 3 then
                            rob(bank)
                        else
                            TriggerEvent("toasty:Notify", {type = "info", title="Jaf", message = "Trebuie sa fie 3 politisti on"})

                        end
                    end
                else
                    --draw cant rob
                    k_draw3DText(bank_coords.x, bank_coords.y, bank_coords.z+1.0, "Asteapta " .. bank.secunde_ramase , 1, 1)
                end
            end
        end
    end
end)

RegisterNetEvent("get_wait_time_for_bank")
AddEventHandler("get_wait_time_for_bank", function (bank_name, ramase)
    for _, bank in pairs(cfg) do
        if bank.name == bank_name then
            bank.secunde_ramase = ramase
            break
        end
    end
end)

RegisterNetEvent("get_cop_number")
AddEventHandler("get_cop_number", function (cop_n)
    cop_number = cop_n
end)