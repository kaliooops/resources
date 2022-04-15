utility = module(Classes_Config.resource_name, "classes/c_kraneUtility")

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

function c_kranePED:Create_Me(x,y,z, heading, model, isNet)
    if not isNet then isNet = false end
    utility.Force_Model_Load(model)
    local modelhash = ""
    if type(model) == "number" then
        modelhash = model
    else
        modelhash = GetHashKey(model)
    end
    local ped = CreatePed(4, modelhash, x,y,z, heading, isNet, isNet)
    SetEntityAsMissionEntity(ped, true, true)
    
    self.ped = ped
    self:Set_Personality("gangster")
    
    return ped
end


function c_kranePED:Set_Name_And_Responsability(name, responsability)
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
    TaskVehicleDriveToCoord(self.ped, GetVehiclePedIsUsing(self.ped), x,y,z, 20.0, 1.0, vehhash, self.driving_style, 1.0, true)

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
    should_talk = false
    for i = 1, #textlines do
        should_talk = true
        CreateThread(function()            
            while should_talk do 
                Wait(0)
                self:Update_Position()
                utility.DrawText3D(self.x, self.y, self.z+1.2,  "~b~" ..self.name .. ": ~w~" ..textlines[i], 3.0)
            end
        end)
        Wait(1500)
        should_talk = false
        Wait(100)
    end
end

function c_kranePED:Move_To(x,y,z)
    TaskGoToCoordAnyMeans(self.ped, x,y,z, 1.0, 0, 0, 786603, 0xbf800000)

end

function c_kranePED:Speak(interactionname)
    if interactionname == "meet" then
        PlayPedAmbientSpeechNative(self.ped, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
    end

    if interactionname == "nice car" then
        PlayPedAmbientSpeechNative(self.ped, "NICE_CAR", "SPEECH_PARAMS_FORCE")
    end
end

AddRelationshipGroup('team1')
AddRelationshipGroup('team2')

function c_kranePED:Set_Friendly(ped)
    SetRelationshipBetweenGroups(1, 'team1', 'team2')
    SetRelationshipBetweenGroups(1, 'team2', 'team1')

    SetPedRelationshipGroupHash(ped, GetHashKey('team2'))
    SetPedRelationshipGroupHash(self.ped, GetHashKey("team1"))
end

function c_kranePED:Set_Enemy(ped)
    SetRelationshipBetweenGroups(5, 'team1', 'team2')
    SetRelationshipBetweenGroups(5, 'team2', 'team1')

    SetPedRelationshipGroupHash(ped, GetHashKey('team2'))
    SetPedRelationshipGroupHash(self.ped, GetHashKey("team1"))
end

function c_kranePED:Set_Neutral(ped)
    SetRelationshipBetweenGroups(3, 'team1', 'team2')
    SetRelationshipBetweenGroups(3, 'team2', 'team1')
    
    SetPedRelationshipGroupHash(ped, GetHashKey('team2'))
    SetPedRelationshipGroupHash(self.ped, GetHashKey("team1"))
end


function c_kranePED:Update_Enemy_List(enemy_list)
    self.enemy_list = enemy_list
end

function c_kranePED:Fight()
    for _, ped in pairs(self.enemy_list) do
        self:Set_Enemy(ped)
    end

    random_enemy = self.enemy_list[math.random(#self.enemy_list)]
    TaskCombatPed(self.ped, random_enemy, 0, 16)
end

function c_kranePED:Give_Weapon(weaponname)
    GiveWeaponToPed(self.ped, GetHashKey(weaponname), 1000, true, false)
end

function c_kranePED:Aggresive_Response()
    if IsPlayerFreeAimingAtEntity(PlayerId(), self.ped) then
        print("aggresive")
        c_kranePED:Set_Enemy(PlayerPedId())
        c_kranePED:Fight()
    end
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
        CreateThread(function()
            while true do 
                if not sync_everybody then
                    Wait(math.random(1, 2500))
                end
                utility.Play_Animation(self.ped, animdic, animname)
                duration = GetAnimDuration(animdic, animname)
                duration = duration-1000
                Wait(duration)
            end
        end)
    else
        utility.Play_Animation(self.ped, animdic, animname)
    end
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




return c_kranePED