kraneUtility = module(Classes_Config.resource_name, "classes/c_kraneUtility")
kranePed = module(Classes_Config.resource_name, "classes/c_kranePED")
kraneVeh = module(Classes_Config.resource_name, "classes/c_kraneVehicle")
kraneObject = module(Classes_Config.resource_name, "classes/c_kraneObject")

already_explaiend = false
has_bothered = false

isHired = false

CreateThread(function()
    Wait(1000)

    Mario_Minerul = kranePed.new()
    Mario_Minerul:Create_Me(2946.9958496094,2771.5334472656,38.126533508301, 357.22, "s_m_y_airworker", false)
    Mario_Minerul:Set_Name_And_Responsability("Mario", "Miner")
    Mario_Minerul:Idle()
    Mario_Minerul:Ignore_World()

    Mario_Minerul:Listen_Interactions(function()
        if not already_explaiend then
            Mario_Minerul:Speak("meet")
            Mario_Minerul:Simulate_Talk({
                "Pe aici prin mina asta",
                "Nu prea e multa lume care lucreaza",
                "Uita-te la mine... *Rade*",
                "Trebuie sa spargi pietrele de aici",
                "Fiecare piatra trebuie lovita",
                "De cam 15 ori cu tarnacopul pana crapa",
                "Ai sa vezi tu ce si cum",
            })
            isHired = true
            kraneUtility.Notify("info","Miner","Te-ai angajat")
            TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Angajeaza-te ca miner")
            already_explaiend = true
            kraneUtility.setRoute(config.topitoria.x, config.topitoria.y, config.topitoria.z, "Topitorie", kraneUtility.rgb_rainbow.r, kraneUtility.rgb_rainbow.g, kraneUtility.rgb_rainbow.b)
        else
            if has_bothered then
                Mario_Minerul:Speak("insult")
                Mario_Minerul:Simulate_Talk({
                    "Ba da deja sari calu",
                    "Ia mai du-te-n pizda ma-tii",
                })

                Mario_Minerul:Unignore_World()
                Mario_Minerul:Add_New_Enemy(PlayerPedId())
                Mario_Minerul:Fight()
                isHired = false
                Wait(5000)
                kraneUtility.Notify("info","Miner","Esti concediat")
            else
                Mario_Minerul:Speak("insult")
                Mario_Minerul:Simulate_Talk({
                    "Ti-am explicat odata",
                    "De ce ma tot inebunesti de cap?",
                    "De cate ori sa-ti mai tot explic?",
                })
                has_bothered = true
            end
        end
    end)


    Asu = kranePed.new()
    Asu:Create_Me(2831.5090332031,2797.4633789062,56.534290313721, 105.01, "s_m_y_airworker", false)
    Asu:Set_Name_And_Responsability("Asu", "Vanzator")
    Asu:Idle()
    Asu:Generic_NPC()
    
end)

function generate_rock()
    has_Rock = true
    rock = kraneObject.new()
    random_spawn = config.locatii_piatra[math.random(1, #config.locatii_piatra)]
    rock:Create_Me(random_spawn.x, random_spawn.y, random_spawn.z, math.random(0,360), "prop_rock_3_f", false)
    rock:Set_Max_Health(5000)
    rock:Set_Health(5000)
    rock:Freeze()
    rock:Internal_Cycle(function()
        rock:Draw_Info("~r~Ramas~w~: " .. rock:Get_Health() .. "/" .. rock:Get_Max_Health(), 7.0) 
        if rock:Get_Health() < 1 then
            rock:Destroy()
            has_Rock = false
            TriggerServerEvent("Miner:Give_Minereuri", true)
        end
    end)

    rock:Listen_Interactions(function()
        if IsControlJustPressed(1, 51) then
            if kraneUtility.Has_Item(config.ce_sa_consume_pt_minerit) then
                myped = kranePed.new()
                myped.ped = PlayerPedId()

                pickaxe = kraneObject.new()
                pickaxe:Create_Me(0,0,0, 0, "prop_tool_pickaxe", true)
                
                AttachEntityToEntity(pickaxe.obj, myped.ped,  GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.08, -0.4, -0.10, 80.0, -20.0, 175.0, true, true, false, true, 1, true)
                for i=1, math.random(3,8) do
                    if has_Rock then
                        myped:Play_Animation("melee@large_wpn@streamed_core", "ground_attack_on_spot")
                        Wait(700)
                        rock:Subtract_Health(math.random(30, 130))
                        Wait(300)
                        TriggerServerEvent("Miner:Give_Minereuri", false)
                    end
                end
                ClearPedTasks(myped.ped)
                DetachEntity(pickaxe.obj, true, true)
                pickaxe:Destroy()
            end
        end        
    end)
end

has_Rock = false
has_Pickaxe = false
minereuri = {"fier", "aur", "argint"}
CreateThread(function()
    while true do
        Wait(1000)
        while isHired do
            Wait(0)
            if not has_Rock then
                generate_rock()
            end

            x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
            if Vdist(config.topitoria.x, config.topitoria.y, config.topitoria.z, x,y,z) < 25.0 then
                kraneUtility.DrawText3D(config.topitoria.x, config.topitoria.y, config.topitoria.z+1.0, "Topitorie ~w~[~r~E~w~]", 4.0, kraneUtility.rgb_rainbow.r, kraneUtility.rgb_rainbow.g, kraneUtility.rgb_rainbow.b)
                kraneUtility.Generic_Marker(config.topitoria.x, config.topitoria.y, config.topitoria.z, kraneUtility.rgb_rainbow.r, kraneUtility.rgb_rainbow.g, kraneUtility.rgb_rainbow.b)
                if IsControlJustPressed(1, 51) then
                    random_item = minereuri[math.random(1, #minereuri)]
                    if kraneUtility.Has_Item("minereu_de_"..random_item) then
                        kraneUtility.Draw_Progress_Bar(3, "Se face "..random_item, false, true)
                        TriggerServerEvent("Miner:Give_Item", "bucata_de_"..random_item)
                    end
                end
            end
        end
    end
end)



-- melting

CreateThread(function()
    Wait(1000)

    Andreea_Amanetista = kranePed.new()
    Andreea_Amanetista:Create_Me(-631.49310302734,-229.32090759277,37.057048797607, 279.22, "a_f_y_bevhills_01", false)
    Andreea_Amanetista:Set_Name_And_Responsability("Andreea", "Amanet")
    Andreea_Amanetista:Idle()
    Andreea_Amanetista:Ignore_World()
    Andreea_Amanetista:Generic_NPC()
    Andreea_Amanetista:Listen_Interactions(function()
        if not already_explaiend then
            Andreea_Amanetista:Speak("meet")
            Andreea_Amanetista:Simulate_Talk({
                "Buna, eu sunt Andreea",
                "Eu iti voi cumpara metale semipretioase",
                "Pentru a face din ele bijuterii",
                "Cand ai metale pretioase adu-le la mine",
                "Iti voi oferii tot timpul un pret bun!",
                
            })
            already_explaiend = true
            else
                TriggerServerEvent("Amanet:openMenu", "Amanet")
        end

    end)
end)