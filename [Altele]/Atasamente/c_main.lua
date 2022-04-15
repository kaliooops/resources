kraneUtility = module(Classes_Config.resource_name, "classes/c_kraneUtility")
kranePed = module(Classes_Config.resource_name, "classes/c_kranePED")
kraneVeh = module(Classes_Config.resource_name, "classes/c_kraneVehicle")
kraneObject = module(Classes_Config.resource_name, "classes/c_kraneObject")

has_finished_tutorial = false

RegisterNetEvent("Atasamente:Has_Finished")
AddEventHandler("Atasamente:Has_Finished", function(hasit)
    has_finished_tutorial = hasit
end)

TriggerServerEvent("Atasamente:Has_Finished")

greeted = false
function greet(kranepedobj)
    greeted = true
    CreateThread(function()
        kranepedobj:Simulate_Talk({"Salut, vino aici", "Vino la mine daca vrei sa inveti meserie"})
    end)
    kranepedobj:Speak("meet")
end

CreateThread(function()
    Wait(1000)

    silencer = kraneObject.new()
    silencer:Create_Me(silencer_pos.x, silencer_pos.y, silencer_pos.z, 0, "w_at_ar_supp", false)
    -- CreateThread(function()
    --     while true do
    --         Wait(0)
    --         utility.Outline_Entity(silencer.obj)
    --     end
    -- end)
    silencer:Internal_Cycle(function()
        if Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(silencer.obj)) < 3.0 then
            silencer:Draw_Info("Silencer ~r~100 ~w~Fier ~r~30 ~w~Argint", 3.0)    
        end
    end, 0)

end)


CreateThread(function()
    Wait(1000)

    Calin_Fierar = kranePed.new()
    Calin_Fierar:Create_Me(calin_pos.x, calin_pos.y, calin_pos.z, calin_pos.heading, "mp_m_weapexp_01", false)
    Calin_Fierar:Set_Name_And_Responsability("Calin", "Fierar si Maestru al Armelor")
    Calin_Fierar:Ignore_World()
    Calin_Fierar:Aggresive_Response() -- will attack if aimed at
    Calin_Fierar:Idle()
    x,y,z = GetEntityCoords(PlayerPedId())

    Calin_Fierar:Internal_Cycle(function()
        if Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(Calin_Fierar.ped)) < 10.0 then
            if not greeted then
                greet(Calin_Fierar)
            end
        
        else
            if greeted then
                greeted = false
            end
        end
        
    end, 1000)

    Calin_Fierar:Listen_Interactions(function()
        TriggerServerEvent("Atasamente:Has_Finished")
        ExecuteCommand("me il bate pe umar")
        Wait(3000)

        if not has_finished_tutorial then
            show_silencer(Calin_Fierar)
            Wait(7000)
            show_gold_weapon(Calin_Fierar)
            Wait(3000)
            finish_presenting(Calin_Fierar)
            TriggerServerEvent("Atasamente:Tutorial_Completed")
        else
            TriggerServerEvent("Atasamente:openMenu", "Atasamente")
        end
    end)
end)

function show_gold_weapon(kranepedobj)
    kranepedobj:Move_To(presenting_golden_weapon.x, presenting_golden_weapon.y,presenting_golden_weapon.z, true)

    while not utility.Is_In_Range(PlayerPedId(), presenting_golden_weapon.x, presenting_golden_weapon.y,presenting_golden_weapon.z, 5.0) do Wait(0) end

    kranepedobj:Play_Animation("missheistdockssetup1ig_10@base", "talk_pipe_base_worker1", false, true)

    kranepedobj:Give_Weapon("WEAPON_ASSAULTRIFLE")
    kranepedobj:Give_Weapon_Attachment("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE")
    kranepedobj:Equip_Weapon()

    kranepedobj:Simulate_Talk({"Bestia asta", "*Respira greu*", "E acoperita de ~g~AUR"})

    CreateThread(function()
        Wait(1000)
        kranepedobj:Simulate_Talk({"OOOh", "Ascult-o doar..."})
    end)

    kranepedobj:Shoot_At(-1132.8065185547,4922.0004882812,219.80598449707, 2500, true)
    Wait(3000)
    kranepedobj:Shoot_At(-1132.8065185547,4922.0004882812,219.80598449707, 7500, false)
    kranepedobj:Simulate_Talk({"Ahahaha, asta e ce-mi place mie!"})

    


    
end

function finish_presenting(kranepedobj) 
    kranepedobj:Remove_Weapons()

    Wait(1000)
    kranepedobj:Simulate_Talk({
        "Cam asa stam cu armele...", 
        "Daca vrei sa cumperi atasamente",
        "Sau sa-ti fac arma din aur",
        "Stii unde sa vi"
    })

    kranepedobj:Move_To(calin_pos.x, calin_pos.y, calin_pos.z, true)
    SetEntityCoords(kranepedobj.ped, calin_pos.x, calin_pos.y, calin_pos.z, 0,0,0, false)
    SetEntityHeading(kranepedobj.ped, calin_pos.heading)
    kranepedobj:Idle()

end

function show_silencer(kranepedobj)
    kranepedobj:Move_To(presenting_silencer_pos.x, presenting_silencer_pos.y, presenting_silencer_pos.z, true)

    while not utility.Is_In_Range(PlayerPedId(), presenting_silencer_pos.x, presenting_silencer_pos.y, presenting_silencer_pos.z, 5.0) do Wait(0) end
    
    CreateThread(function()
        Wait(1000)
        kranepedobj:Point_At(241.33)
        Wait(3000)
        kranepedobj:Point_At(241.33)
    end)
    
    kranepedobj:Simulate_Talk({"Asta e silencer", "Ai nevoie de 100 fier si 30 argint sa-l faci"})
    
    Wait(1000)
    kranepedobj:Give_Weapon("WEAPON_PISTOL") --WEAPON_PISTOL
    kranepedobj:Give_Weapon_Attachment("COMPONENT_AT_PI_SUPP_02")
    kranepedobj:Equip_Weapon()
    Wait(300)
    CreateThread(function()
        Wait(1000)
        kranepedobj:Simulate_Talk({"Ahahaha", "E o placere sa trag cu el"})
    end)
    kranepedobj:Shoot_At(shoot_at_coords.x, shoot_at_coords.y, shoot_at_coords.z, 7000, false)
end