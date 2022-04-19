modules = {}
function module(rsc, path) -- load a LUA resource file as module
  if path == nil then -- shortcut for vrp, can omit the resource parameter
    path = rsc
    rsc = "vrp"
  end

  local key = rsc..path

  if modules[key] then -- cached module
    return table.unpack(modules[key])
  else
    local f,err = load(LoadResourceFile(rsc, path..".lua"))
    if f then
      local ar = {pcall(f)}
      if ar[1] then
        table.remove(ar,1)
        modules[key] = ar
        return table.unpack(ar)
      else
        modules[key] = nil
        print("[vRP] error loading module "..rsc.."/"..path..":"..ar[2])
      end
    else
      print("[vRP] error parsing module "..rsc.."/"..path..":"..err)
    end
  end
end

utility = module("kraneCore", "classes/c_kraneUtility")

local c_kranePED = {}
c_kranePED.__index = c_kranePED

function c_kranePED.new()
    local instance = setmetatable({}, c_kranePED)
    return instance
end

function c_kranePED:Update_Position()
    x,y,z = table.unpack(GetEntityCoords(self.ped))
    
    self.x = x
    self.y = y
    self.z = z
end

function c_kranePED:Create_Me(x, y, z, heading, model, isNet)
    if not isNet then isNet = false end

    local modelhash = utility.Get_Model(model)
    utility.Force_Model_Load(model)
    
    local ped = CreatePed(4, modelhash, x,y,z, heading, isNet, isNet)
    
    self.ped = ped
    self.isNet = isNet
    self:Set_Personality("gangster")
    
    return ped
end


function c_kranePED:Set_Name_And_Responsability(name, responsability, ped)
    CreateThread(function()
        while true do
            Wait(0)
            x,y,z = table.unpack(GetEntityCoords(self.ped))
            if Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(self.ped)) < 15.0 then
                utility.DrawText3D(x,y,z+1.1, "~g~"..name, 3.0)
                utility.DrawText3D(x,y,z+1.0, "~b~[~y~"..responsability .."~b~]~w~", 3.0)
            end
        end
    end)
    self.name = name
    self.responsability = responsability
end

function c_kranePED:Can_Interact()
    if Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(self.ped)) < 2.0 then
        return true
    else
        return false
    end
end

function c_kranePED:Freeze()
    FreezeEntityPosition(self.ped, true)
end

function c_kranePED:Unfreeze()
    FreezeEntityPosition(self.ped, false)
end

function c_kranePED:Ignore_World()
    SetBlockingOfNonTemporaryEvents(self.ped, true)
end

function c_kranePED:Unignore_World()
    SetBlockingOfNonTemporaryEvents(self.ped, false)
end


function c_kranePED:Invincible()
    SetEntityInvincible(self.ped, true)
end

function c_kranePED:Idle(animation)
    if animation == nil then
        animation = "WORLD_HUMAN_SMOKING"
    end
    self.idle_animation = animation
    TaskStartScenarioInPlace(self.ped, animation, 0, true)
end

function c_kranePED:Generic_NPC(animation)
    self:Ignore_World()
    self:Invincible()
    self:Freeze()
    self:Idle(animation)
end


function c_kranePED:Set_Personality(trait)
    if trait == "scared" then
        SetPedCombatAbility(self.ped, 0)
        SetPedCombatAttributes(self.ped, 0, true)
        SetPedCombatAttributes(self.ped, 5, false)
        SetPedCombatAttributes(self.ped, 46, false)
        SetPedCombatMovement(self.ped, 1)
    elseif trait == "gangster" then
        SetPedCombatAbility(self.ped, 100)
        SetPedCombatAttributes(self.ped, 0, true)
        SetPedCombatAttributes(self.ped, 5, true)
        SetPedCombatAttributes(self.ped, 46, true)
        SetPedCombatMovement(self.ped, 2)
    elseif trait == "bombardier" then
        SetPedCombatAbility(self.ped, 100)
        SetPedCombatAttributes(self.ped, 0, true)
        SetPedCombatAttributes(self.ped, 5, true)
        SetPedCombatAttributes(self.ped, 46, true)
        SetPedCombatMovement(self.ped, 3)
    end

    self.personality = trait
end

function c_kranePED:Set_Driving_Style(trait) 
    if trait == "normal" then
        SetDriverAggressiveness(self.ped, 0.5)
        SetDriveTaskDrivingStyle(self.ped, 786603)
    elseif trait == "aggressive" then
        SetDriverAggressiveness(self.ped, 1.0)
        SetDriveTaskDrivingStyle(self.ped, 1074528293)
    end
    self.driving_style = trait
end

function c_kranePED:Enter_Car(veh, should_drive)
    if should_drive == nil then
        should_drive = true
    end

    x,y,z = table.unpack(GetEntityCoords(self.ped))
    if not veh then veh = utility.Get_Closest_Veh(x,y,z, 100.0, 0) end

    if should_drive then
        TaskEnterVehicle(self.ped, veh, -1, -1, 1.0, 1, 0)
    else
        empty_seat = 0
        for i = -1, -5, -1 do
            if GetVehiclePedIsUsing(self.ped) == veh and GetPedInVehicleSeat(GetVehiclePedIsUsing(self.ped), i) == 0 then
                empty_seat = i
                break
            end
        end
        TaskEnterVehicle(self.ped, veh, empty_seat, -1, 1.0, 1, 0)
    end
end

function c_kranePED:Drive_To_Coords(x,y,z)
    veh = GetVehiclePedIsUsing(self.ped)
    vehhash = GetEntityModel(veh)
    vehhash = GetHashKey(vehhash)

    if not self.driving_style then self.driving_style = 786603 end
    -- TaskVehicleDriveToCoord(self.ped, GetVehiclePedIsUsing(self.ped), x,y,z, 20.0, 1.0, vehhash, self.driving_style, 1.0, true)
    TaskVehicleDriveToCoordLongrange(self.ped, GetVehiclePedIsUsing(self.ped), x,y,z, 60.0, 447, 20.0);


    CreateThread(function()
        while true do
            Wait(0) 
            if utility.Is_In_Range(self.ped, x,y,z, 10.0) then
                TaskLeaveVehicle(self.ped, veh, 1)
                break
            end
        end
    end)
end


function c_kranePED:Listen_Interactions(cb)
    CreateThread(function()
        while true do
            Wait(1000)
            while self:Can_Interact() do
                if IsControlJustPressed(1, 51) then
                    ClearPedTasksImmediately(self.ped)
                    cb()
                end
                Wait(0)
            end
        end
    end)
end

function c_kranePED:Simulate_Talk(textlines)
    while self.is_talking do
        Wait(0)
    end
    if not self.is_talking then self.is_talking = true end
    should_talk = false
    for i = 1, #textlines do
        should_talk = true
        CreateThread(function()  
            while should_talk do 
                Wait(0)
                self:Update_Position()

                if self.ped ~= GetPlayerPed(PlayerId()) then
                    utility.DrawText3D(self.x, self.y, self.z+1.2,  "~b~" ..self.name .. ": ~w~" ..textlines[i], 3.0)
                else
                    ExecuteCommand("me "..textlines[i])
                    Wait(3000)
                end

            end
        end)
        Wait(3000)
        should_talk = false
        Wait(100)
    end
    self.is_talking = false 
end

function c_kranePED:Move_To(x,y,z, block_thread)
    if block_thread == nil then block_thread = false end

    TaskGoToCoordAnyMeans(self.ped, x,y,z, 1.0, 0, 0, 786603, 0xbf800000)
    CreateThread(function()
        while Vdist(GetEntityCoords(self.ped), x,y,z) > 2.0 do
            Wait(0)
            if not IsPedWalking(self.ped) and not IsPedRunning(self.ped) then
                TaskGoToCoordAnyMeans(self.ped, x,y,z, 1.0, 0, 0, 786603, 0xbf800000)
                Wait(2000)
            end
        end
        block_thread = false
    end)
    while block_thread do Wait(0) end
end

function c_kranePED:Speak(interactionname)
    if interactionname == "meet" then
        PlayPedAmbientSpeechNative(self.ped, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
    end

    if interactionname == "nice car" then
        PlayPedAmbientSpeechNative(self.ped, "NICE_CAR", "SPEECH_PARAMS_FORCE")
    end

    if interactionname == "insult" then
        PlayPedAmbientSpeechNative(self.ped, "GENERIC_INSULT_HIGH", "SPEECH_PARAMS_FORCE")
    end
end

AddRelationshipGroup('team3')
AddRelationshipGroup('team4')

function c_kranePED:Set_Friendly(ped)
    SetRelationshipBetweenGroups(1, 'team3', 'team4')
    SetRelationshipBetweenGroups(1, 'team4', 'team3')

    SetPedRelationshipGroupHash(ped, GetHashKey('team4'))
    SetPedRelationshipGroupHash(self.ped, GetHashKey("team3"))
end


function c_kranePED:Set_Enemy(ped)
    SetRelationshipBetweenGroups(5, 'team3', 'team4')
    SetRelationshipBetweenGroups(5, 'team4', 'team3')

    SetPedRelationshipGroupHash(ped, GetHashKey('team4'))
    SetPedRelationshipGroupHash(self.ped, GetHashKey("team3"))
end

function c_kranePED:Set_Neutral(ped)
    SetRelationshipBetweenGroups(3, 'team3', 'team4')
    SetRelationshipBetweenGroups(3, 'team4', 'team3')
    
    SetPedRelationshipGroupHash(ped, GetHashKey('team4'))
    SetPedRelationshipGroupHash(self.ped, GetHashKey("team3"))
end


function c_kranePED:Update_Enemy_List(enemy_list)
    self.enemy_list = enemy_list
end

function c_kranePED:Add_New_Enemy(ped)
    if not self.enemy_list then self.enemy_list = {} end
    table.insert(self.enemy_list, ped)
end


function c_kranePED:Fight()
    for _, ped in pairs(self.enemy_list) do
        self:Set_Enemy(ped)
    end

    random_enemy = self.enemy_list[math.random(#self.enemy_list)]
    TaskCombatPed(self.ped, random_enemy, 0, 16)
end

function c_kranePED:Give_Weapon(weaponname)
    self.my_weapon_hash = GetHashKey(weaponname)
    GiveWeaponToPed(self.ped, GetHashKey(weaponname), 64, true, false)
end

function c_kranePED:Give_Weapon_Attachment(attachment)
    GiveWeaponComponentToPed(self.ped, self.my_weapon_hash, GetHashKey(attachment))
end

function c_kranePED:Equip_Weapon()
    SetCurrentPedWeapon(self.ped, self.my_weapon_hash, true)
end

function c_kranePED:Remove_Weapons()
    RemoveAllPedWeapons(self.ped, true)
end

function c_kranePED:Shoot_At(x,y,z, duration, burst)
    if not duration then duration = 3000 end

    SetPedShootRate(self.ped, 1000)
    if not burst then
        TaskShootAtCoord(self.ped, x, y, z, duration, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
    else
        TaskShootAtCoord(self.ped, x, y, z, duration, GetHashKey("FIRING_PATTERN_SINGLE_SHOT"))
    end
end

function c_kranePED:Shoot_At_Entity(entity, duration, burst)
    if not duration then duration = 3000 end

    SetPedShootRate(self.ped, 1000)
    if not burst then
        TaskShootAtCoord(self.ped, x, y, z, duration, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
    else
        TaskShootAtCoord(self.ped, x, y, z, duration, GetHashKey("FIRING_PATTERN_SINGLE_SHOT"))
    end
end

function c_kranePED:Aggresive_Response()
    CreateThread(function()
        while true do
            Wait(0)
            if IsPlayerFreeAimingAtEntity(PlayerId(), self.ped) then
                self:Unignore_World()
                self:Shoot_At_Entity(PlayerPedId())
            end        
        end
    end)
end

function c_kranePED:Bro_Hug()
    ClearPedTasksImmediately(self.ped)

    x,y,z = table.unpack(utility.Get_Pos_In_Front(PlayerPedId(), 1.0))
    SetEntityCoords(self.ped, x,y,z-1.0, 0,0,0, false)
    SetEntityHeading(self.ped, utility.Get_Reverse_Heading(PlayerPedId()))
    self:Speak("meet")
    utility.Play_Animation(self.ped,"mp_ped_interaction", "hugs_guy_a")
    utility.Play_Animation(PlayerPedId(),"mp_ped_interaction", "hugs_guy_a")
end

function c_kranePED:Play_Animation(animdic, animname, looped, sync_everybody)
    if not sync_everybody then sync_everybody = false end
    if not looped then looped = false end

    if looped then
        self.loop_animation = true
        CreateThread(function()
            while self.loop_animation do 
                if not sync_everybody then
                    Wait(math.random(1, 2500))
                end
                utility.Play_Animation(self.ped, animdic, animname)
                duration = GetAnimDuration(animdic, animname)-1000
                -- duration = duration-1000
                Wait(0)
                if not IsEntityPlayingAnim(self.ped, animdic, animname, 3) then
                    utility.Play_Animation(self.ped, animdic, animname, true)    
                end
            end
        end)
    else
        utility.Play_Animation(self.ped, animdic, animname)
    end
end

function c_kranePED:Stop_Animation()
    self.loop_animation = false
    ClearPedTasks(self.ped)
end

function c_kranePED:Trade(cb)
    -- ["give"] = {"mp_common", "givetake1_a", "Give", "give2", AnimationOptions =
    -- {
    --     EmoteMoving = true,
    --     EmoteDuration = 2000
    -- }},
    utility.Play_Animation(self.ped, "mp_common", "givetake1_a")
    utility.Play_Animation(PlayerPedId(), "mp_common", "givetake1_a")
    if cb then
        cb()
    end
end

function c_kranePED:Internal_Cycle(cb, timeout)
    if not timeout then timeout = 0 end
    CreateThread(function()
        while true do
            Wait(timeout)
            cb()
        end
    end)
end


function c_kranePED:Got_Damaged()
    if not self.health then self.health = GetEntityHealth(self.ped) end
    if GetEntityHealth(self.ped) > self.health then
        self.health = GetEntityHealth(self.ped)
        return false
    end
    if GetEntityHealth(self.ped) < self.health then
        self.last_damage_value = self.health - GetEntityHealth(self.ped)
        self.health = GetEntityHealth(self.ped)
        _, self.last_damaged_bone = GetPedLastDamageBone(self.ped)
        return true
    end
    return false
end

function c_kranePED:Broken_Foot()
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(self.ped, "move_m@injured", true)
    CreateThread(function()
        for i=1, 10 do
            Wait(5000)
        end
        self:Normal_Foot()
    end)
end

function c_kranePED:Normal_Foot()
    ResetPedMovementClipset(self.ped)
    ResetPedWeaponMovementClipset(self.ped)
    ResetPedStrafeClipset(self.ped)
end

function c_kranePED:Broken_Arm(should_drop)
    if should_drop == nil then should_drop = true end

    self.broken_arm = true
    CreateThread(function()
        iterations = 0
        while self.broken_arm do
            Wait(5000)
            iterations = iterations + 1
            isit, weaponhash = GetCurrentPedWeapon(self.ped, 1)
            if isit and should_drop then
                if IsPlayerFreeAiming(self.ped) then
                    ClearPedTasksImmediately(self.ped)
                end
                self:Simulate_Talk({"~r~Scapa arma din mana din cauza ranilor"})
                RemoveWeaponFromPed(self.ped, weaponhash)
                SetCurrentPedWeapon(self.ped, GetHashKey("WEAPON_UNARMED"), true)
            end

            if iterations > 20 then
                self.broken_arm = false
            end
        end
    end)
end

function c_kranePED:Normal_Arm()
    self.broken_arm = false
end

function c_kranePED:Anim_Got_Heavily_Shot()
    self:Play_Animation("random@dealgonewrong", "idle_a", true)
    CreateThread(function()
        while self.loop_animation do
            Wait(math.random(3000, 7500)) 
            self:Play_Animation("move_injured_ground", "front_loop")
        end
    end)
    Wait(15000)  
    self:Stop_Animation()
end

function c_kranePED:Anim_Passed_Out()
    self:Play_Animation("missarmenian2", "corpse_search_exit_ped", true)
    CreateThread(function()
        Wait(7500)
        self:Stop_Animation()
    end)
end


function c_kranePED:Point_At(heading)
    SetEntityHeading(self.ped, heading)
    self:Play_Animation("gestures@f@standing@casual", "gesture_point")
end

return c_kranePED