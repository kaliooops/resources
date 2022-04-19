kraneUtility = module(Classes_Config.resource_name, "classes/c_kraneUtility")
kranePed = module(Classes_Config.resource_name, "classes/c_kranePED")
kraneVeh = module(Classes_Config.resource_name, "classes/c_kraneVehicle")
kraneObject = module(Classes_Config.resource_name, "classes/c_kraneObject")
CreateThread(function()
    Wait(30000)

    ped = kranePed.new()
    x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    ped.ped = PlayerPedId()
    last_damaged_bone = -1
    ped:Normal_Foot()
    ped:Internal_Cycle(function()
        
        if ped:Got_Damaged() then
            if ped.last_damage_value >= 50 then
                CreateThread(function()
                    ped:Simulate_Talk({"Este inconstient"})    
                end)
                CreateThread(function()
                    ped:Anim_Passed_Out()
                end)
                simulate_heavy_injury()
            end
            bname = Get_Bone_Name(ped.last_damaged_bone)

            print(tostring(bname) .. " code: " .. ped.last_damaged_bone)

            if GetEntityHealth(ped.ped) < 180 then
                bname = Get_Bone_Name(ped.last_damaged_bone)
                if kraneUtility.String_Has_Substring(bname, "Calf") or kraneUtility.String_Has_Substring(bname, "Thigh") then
                    CreateThread(function()
                        ped:Simulate_Talk({"Si-a rupt piciorul", "Il doare piciorul rupt", "Il doare piciorul rupt", "Il doare piciorul rupt", "Il doare piciorul rupt"})    
                    end)
                    
                    ped:Broken_Foot()    
                end

                if GetEntityHealth(ped.ped) < 140 then
                    if kraneUtility.String_Has_Substring(bname, "Spine") or kraneUtility.String_Has_Substring(bname, "ROOT") then
                        CreateThread(function()
                            ped:Simulate_Talk({"A fost lovit in abdomen", "Il doare abdomenul unde a fost lovit", "Il doare abdomenul unde a fost lovit", "Il doare abdomenul unde a fost lovit", "Il doare abdomenul unde a fost lovit"})    
                        end)
                        
                        CreateThread(function()
                            ped:Anim_Got_Heavily_Shot()     
                        end)
                        simulate_heavy_injury()
                    end
                end

                if ped.last_damaged_bone == 40269 or kraneUtility.String_Has_Substring(bname, "Hand") or kraneUtility.String_Has_Substring(bname, "arm") or kraneUtility.String_Has_Substring(bname, "Arm") or  kraneUtility.String_Has_Substring(bname, "Clavicle") then
                    CreateThread(function()
                        ped:Simulate_Talk({"Si-a rupt mana", "Il doare mana rupta", "Il doare mana rupta", "Il doare mana rupta", "Il doare mana rupta", "Il doare mana rupta"})    
                    end)
                    ped:Broken_Arm()
                end
            end
            last_damaged_bone = ped.last_damaged_bone
        end

    end, 0)
end)

heavy_injury = false
function simulate_heavy_injury()
    heavy_injury = true
    StartScreenEffect('Rampage', 0, true)
    CreateThread(function()
        for i=1, 3 do
            ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
            Wait(3500)
        end
    end)

    CreateThread(function()
        while true do
            Wait(1000)
            while heavy_injury do 
                Wait(0)
                HideHudComponentThisFrame( 14 )
            end
        end
    end)
    
    CreateThread(function()
        for i=1, 2 do
            Wait(1500)
            DoScreenFadeOut(3000)
            Wait(4500)
            DoScreenFadeIn(2000)
            Wait(2000)
        end
    end)

    playnewsong()
    Wait(15000)
    StopScreenEffect('Rampage')
    heavy_injury = false
end

local xSound = exports.xsound
xSound:Destroy("heartbeat_krane_wounds")

function playnewsong()
    rsong = "https://www.youtube.com/watch?v=TgZjYIPPe50"
    xSound:PlayUrlPos("heartbeat_krane_wounds", tostring(rsong), 1.0, GetEntityCoords(PlayerPedId()), false)            
    xSound:Distance("heartbeat_krane_wounds", 100)
end
