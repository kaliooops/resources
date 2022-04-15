function Handle_Bombs_And_Replace_Box(crateobj, location_name)
    -- after ex_prop_crate_biohazard_bc
    -- before ex_prop_crate_closed_bc   
    local x,y,z = table.unpack(GetEntityCoords(crateobj))
    local heading = GetEntityHeading(crateobj)
    local enemies_spawned = false
    CreateThread(function()
        time_left = 5 * 1000 * 60 -- 5 minutes
        -- time_left = 60000
        seconds_passed = 0
        plant_bomb(crateobj)
        CreateThread(function() --draw
            while not finished and time_left > 0 do
                Wait(0)
                if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < 100.0 then
                    k_draw3DText(x, y, z+1.0, "Timp ramas: ~r~"..transform_ms_to_minutes(time_left).."~w~ minute", 3)
                end
            end
        end)

        while not finished and time_left > 0 do --logics 
            Wait(1000)
            time_left = time_left - 1000
            seconds_passed = seconds_passed + 1
            if seconds_passed > 30 then
                if not enemies_spawned then
                    spawn_enemy_waves(location_name)
                    enemies_spawned = true
                end
            end
        end    
        
        
        local bomb = nil
        DeleteObject(crateobj)
        if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < 100.0 then
            k_draw3DText(x, y, z+1.0, "~r~Crate-ul a fost deschis!", 3)
            bomb = GetClosestObjectOfType(x, y, z, 101.0, GetHashKey("prop_ld_bomb"), false, false, false)
            DeleteObject(bomb)
            TriggerServerEvent("Weapons_Dealer:AddExplosion", x,y,z)
            opened_crate = spawn_net_object(x, y, z, "ex_prop_crate_biohazard_bc", heading)
        end

        while not finished do
            Wait(0)
            if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) < 5.0 then
                if IsControlJustPressed(1, 51) then
                    for i=0,6 do
                        ExecuteCommand("e pickup")
                        Wait(700)
                        TriggerServerEvent("Weapons_Dealer:Give_Weapon", getPlayersInRadius(150).players)
                        ExecuteCommand("me Ia din cutie")
                    end
                    Wait(10000)
                    DeleteObject(opened_crate)
                    finished = true
                    return                    
                end
            end    
        end
        DeleteObject(opened_crate)
        finished = true

        for i, ped in pairs(enemies) do
            if GetEntityHealth(ped) < 1 then
                SetPedAsNoLongerNeeded(ped)
                NetworkUnregisterNetworkedEntity(ped)
                DeletePed(ped)
                DeleteEntity(ped)
                table.remove(enemies, i)    
            end
        end  
        RemovePedFromGroup(PlayerPedId())

    end)
end    

enemies = {}
function spawn_enemies_at_position(spawn_table)
    team = {}
    team = getPlayersInRadius(150).players

    TriggerServerEvent("Weapons_Dealer:Play_Sound", "alert_army", GetEntityCoords(PlayerPedId()))    

    Wait(3000)
    for i=1, 3*#team do
        random_location = spawn_table[math.random(1, #spawn_table)]
        local x,y,z = random_location.x, random_location.y, random_location.z 
        local ped_to_insert = k_CreatePed(0x72C0CAD2, x,y,z)
        RemoveAllPedWeapons(ped_to_insert, true)
        r_weapon = get_random_weapon()
        GiveWeaponToPed(ped_to_insert, get_random_weapon(), 200, false, true)
        ped_to_insert = PedToNet(ped_to_insert)
        NetToPed(ped_to_insert)
        -- NetworkUseHighPrecisionBlending(ped_to_insert, false)
        SetEntityAsMissionEntity(ped, true, true)
        SetNetworkIdExistsOnAllMachines(ped_to_insert, true)
        Wait(100)
        NetworkRegisterEntityAsNetworked(ped_to_insert)
        table.insert(enemies, ped_to_insert)

        CreateThread(function()
            AddRelationshipGroup('team1')
            AddRelationshipGroup('team2')
            for _, ped in pairs(enemies) do
                SetRelationshipBetweenGroups(5, 'team1', 'team2')
                SetRelationshipBetweenGroups(5, 'team2', 'team1')
                SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey('team2')) -- or team1
                SetPedCombatAttributes(ped, 0, true) --[[ BF_CanUseCover ]]
                SetPedCombatAttributes(ped, 5, true) --[[ BF_CanFightArmedPedsWhenNotArmed ]]
                SetPedCombatAttributes(ped, 46, true) --[[ BF_AlwaysFight ]]
                SetPedFleeAttributes(ped, 0, true) --[[ allows/disallows the ped to flee from a threat i think]]
                
                SetPedRelationshipGroupHash(ped, GetHashKey("team1")) --[[ when i did army, the peds fought eachother and it was pretty funny - https://runtime.fivem.net/doc/natives/#_0xC80A74AC829DDD92 ]]
                SetPedAccuracy(ped, 60)
                SetPedSuffersCriticalHits(ped, true)
                GiveWeaponToPed(ped, get_random_weapon(), 200, true, false)
                SetPedMaxHealth(ped, 100)
                SetPedArmour(ped, 100)
                --get random team member
                local team_member = team[math.random(1, #team)]
                TaskCombatPed(ped, team_member, 0, 16)
            end
        end)
    end

    CreateThread(function()
        while true do
            Wait(5000)
            if GetEntityHealth(PlayerPedId()) <= 121 then
                finished = true
            end
            for i, ped in pairs(enemies) do
                if GetEntityHealth(ped) < 1 then
                    SetPedAsNoLongerNeeded(ped)
                    NetworkUnregisterNetworkedEntity(ped)
                    DeletePed(ped)
                    DeleteEntity(ped)
                    table.remove(enemies, i)    
                end
            end                      
        end
        
        RemovePedFromGroup(PlayerPedId())
    end)
end

function spawn_enemy_waves(lname)
    CreateThread(function()
        while not finished do
            spawn_table = enemy_spawns[lname]
            spawn_enemies_at_position(spawn_table)
            Wait(25000)
        end

        -- despawn all enemies
        for i, ped in pairs(enemies) do
            SetPedAsNoLongerNeeded(ped)
            NetworkUnregisterNetworkedEntity(ped)
            DeletePed(ped)
            DeleteEntity(ped)
        end
        enemies = {}

        print("FINISHED")
    end)
end