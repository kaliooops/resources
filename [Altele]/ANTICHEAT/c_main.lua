local current_location = nil

local teleport_spots_allowed = {
    {x = -973.08, y = -2994.97, z = 15.29}, --showroom test masina
    {x = -30.03,  y = -1105.07, z = 26.42}, --showroom de unde ai fost
}

--[[
    if ped z is under ground z then put ped on groundz
]]
function put_ped_on_ground(ped)
    local ped_z = GetEntityCoords(ped).z
    local bool, ground_z = GetGroundZFor_3dCoord(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z+300, 0)

    if ped_z < ground_z and IsPedFalling(ped) then
        SetEntityCoords(ped, GetEntityCoords(ped).x, GetEntityCoords(ped).y, ground_z, 0, 0, 0, false) -- put ped on ground
    end
end

--check if entity ped is shooting is within angle
function is_entity_shooting_in_angle(entity, angle, target)
    local entity_coords = GetEntityCoords(entity)
    local target_coords = GetEntityCoords(target)
    local entity_forward = GetEntityForwardVector(entity)

    local angle_rad = math.rad(angle)
    local target_angle = math.abs(
        math.atan2(
            target_coords.y - entity_coords.y,
            target_coords.x - entity_coords.x
        )
    )

    if entity_forward.x > 0 then
        target_angle = math.abs(math.pi*2 - target_angle)
    end

    if target_angle < angle_rad / 2 or target_angle > math.pi - angle_rad / 2 then
        return true
    end

    return false
end


--calculate move speed based on past and current location
function calculate_move_speed(current_location, past_location)
    local distance = GetDistanceBetweenCoords(current_location.x, current_location.y, current_location.z, past_location.x, past_location.y, past_location.z, true)
    local time = 1
    local speed = distance / time
    return speed
end

local last_health = 200
function check_if_ped_is_revived_with_nobody_around(ped)
    
    -- if GetEntityHealth(ped) > last_health then
    --     --get entities around ped
    --     local entities_around = GetActivePlayers()
    --     --get distance between ped and all entities around, if distance is less than 10 then return
    --     for _, entity in pairs(entities_around) do
    --         local distance = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(entity), true)
    --         if distance < 15 then
    --             return false
    --         end
    --     end

    --     TriggerServerEvent("banMe", " ped revive")
    -- end
end

--[[
    if ped has any ilegal weapon from config.weapons list then remove it and notify player
]]
function remove_ilegal_weapons(ped)
    for k,v in pairs(config.weapons) do -- check if ped has any ilegal weapon
        if HasPedGotWeapon(ped, v, false) then --  if ped has weapon
            RemoveAllPedWeapons(ped, true) -- remove all weapons
            TriggerServerEvent("banMe", "Arme nepermise") -- ban player
            TriggerEvent('chat:addMessage', { -- notify player
                color = {255, 0, 0}, -- red
                multiline = true, -- multiline
                args = {"[^1WARNING]", "^0Ai niste arme de mai bine nu le aveai"} -- args
            })
            
            TriggerServerEvent("screenshot_player", GetPlayerServerId(PlayerId())) -- take screenshot

            return
        end
    end
end


local noclip_duration = 0
function isUsingNoclip()
    local ped = PlayerPedId() -- get player ped
    local p_coords = GetEntityCoords(ped) -- ped coords
    local bool, groundZ = GetGroundZFor_3dCoord(p_coords.x, p_coords.y, p_coords.z, true) -- get ground z for player coords

    local d = math.abs(groundZ - p_coords.z) --     distance between ground and player coords
    local speed = GetEntitySpeed(ped) -- get player speed
    
    if d > 10 and speed == 0.0 then -- if distance between ground and player coords is greater than 10 and player speed is 0.0 then player is using noclip
<<<<<<< HEAD
        return true
    end
    return false
=======
        noclip_duration = noclip_duration + 1 -- increase noclip duration
        if noclip_duration >= 10 then -- if noclip duration is greater than 10 then
            noclip_duration = 0 -- reset noclip duration
            TriggerServerEvent("banMe", "No Clip") -- ban player
        end
    end
>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657
end

function checkSpeedHack()
    local ped = PlayerPedId()
    local veh

    if IsPedInAnyVehicle(ped, true) then
        veh = GetVehiclePedIsIn(ped, false)
    else
        return
    end
    if GetEntitySpeed(veh)*3.6 >= 500 then -- if player speed is greater than 300 then
<<<<<<< HEAD
        return true
    end
    return false
=======
        TriggerServerEvent("banMe", "Speed Hack") -- ban player
    end
>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657
end
local speed_table = {} -- table for past speed registers



local just_connected = true
local last_position = nil

local Suspicious_Keys = {
    "INSERT", "END", "F1", "F2", "F4", "F5", "F6", "F7",
    "F8", "F10", "F11",
}

local trust_Factor = 5

function Suspicious_Behavior(avg_speed, last_keys)
    if avg_speed < 5 then
        if last_keys ~= nil then
            for _, key in pairs(last_keys) do
                for _, skey in pairs(Suspicious_Keys) do
                    if key == skey then
                        trust_Factor = trust_Factor - 25
                    end
                end
            end
        end
    end
end

drawsus = false
function drawSusLevel()
    while true do
        
        while drawsus do
            blips = {}
            for k, p in pairs(GetActivePlayers()) do
                blips[k]= AddBlipForEntity(GetPlayerPed(p))
            end
            print("drawing sus " .. #blips)
            for k, v in pairs(blips) do
                SetBlipSprite(v, 1)
                SetBlipColour(v, 1)
                SetBlipScale(v, 1.5)
                BeginTextCommandSetBlipName("Suspect"..k)
                AddTextComponentString("Suspect"..k)
                AddTextComponentSubstringPlayerName('Suspect'..k)
                AddTextEntry('Suspect'..k, 'Trust Factor ~a~ ')
                EndTextCommandSetBlipName(v)
            end
            Wait(1)
        end
        Wait(5000)
    end
end

CreateThread(function ()
    Wait(5000)
    
    while true do
        Wait(1000)
        trust_Factor = trust_Factor + 0.5
		local year --[[ integer ]], month --[[ integer ]], day --[[ integer ]], hour --[[ integer ]], minute --[[ integer ]], second --[[ integer ]] = GetUtcTime()
        print("Trust Factor: " .. trust_Factor .. " la " .. hour .. " : " .. minute .. " : " .. second)
        local ped = PlayerPedId()
        current_location = GetEntityCoords(PlayerPedId())
        -- isUsingNoclip() -- check if player is using noclip
        if isUsingNoclip() then
            trust_Factor = trust_Factor - 3.5
            TriggerServerEvent("kraneANTICHEAT:chatADMINS", "no clip")
        end
        
        if checkSpeedHack() then -- check if player is using speed hack
            trust_Factor = trust_Factor - 50
        end

        if NetworkIsInSpectatorMode() then -- if player is in spectator mode
            -- trust_Factor = trust_Factor - 1 -- decrease trust factor
            TriggerServerEvent("banMe", "Spectator") -- ban player
        end

        number_of_registered_commands = #GetRegisteredCommands() -- get number of registered commands
        if commands_at_player_spawn ~= nil then -- if commands_at_player_spawn is not nil
            if number_of_registered_commands ~= commands_at_player_spawn then -- if the number of registers commands changed
<<<<<<< HEAD
                trust_Factor = trust_Factor - 50 -- decrease trust factor
                TriggerServerEvent("kraneANTICHEAT:chatADMINS", "comenzi noi in consola (trebuie verificat de urgenta)")

                -- TriggerServerEvent("banMe", " new commands") -- ban player
=======
                TriggerServerEvent("banMe", " new commands") -- ban player
>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657
            end
        end

        for i = 1, #GetActivePlayers() do -- for all active players
            if i ~= PlayerId() then -- if the player is not myself
                if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then -- if the player has a blip
<<<<<<< HEAD
                    -- TriggerServerEvent("banMe", " ez blips") -- ban self
                    trust_Factor = trust_Factor - 10
                    TriggerServerEvent("kraneANTICHEAT:chatADMINS", "blipuri activate")

=======
                    TriggerServerEvent("banMe", " ez blips") -- ban self
>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657
                end
            end
        end

        if IsEntityOnFire(PlayerPedId()) then
            local isfirestarted --[[ boolean ]], outPosition --[[ vector3 ]] = GetClosestFirePos(
                current_location
            )
            if isfirestarted then
                StopFireInRange(outPosition, 100)
            end
            SetEntityHealth(PlayerPedId(), 200)
        end

        if last_position ~= nil then
            local d = GetDistanceBetweenCoords(last_position, current_location, true)


            table.insert(speed_table, calculate_move_speed(current_location, last_position)) -- insert current speed to speed table 
            if #speed_table > 10 then -- if speed table has more than 10 elements
                --get avg of all the speeds and calculate an avg speed of player
                local avg_speed = 0
                for i = 1, #speed_table do
                    avg_speed = avg_speed + speed_table[i]
                end
                avg_speed = avg_speed / #speed_table
                avg_speed = avg_speed * 3.6 -- convert to km/h
                if avg_speed >= 500 then
                    --show in chat as warning
<<<<<<< HEAD
                    trust_Factor = trust_Factor - 1
                    TriggerServerEvent("kraneANTICHEAT:chatADMINS", "viteza mare")
                    -- TriggerServerEvent("showToAdmins", avg_speed) -- send avg speed to admins
=======
                    TriggerServerEvent("showToAdmins", avg_speed) -- send avg speed to admins
>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657
                    -- TriggerEvent('chat:addMessage', {
                    --     color = {255, 0, 0},
                    --     multiline = true,
                    --     args = {"[^1WARNING]", "^0Viteza mult prea mare: " .. string.format("%.2f", avg_speed) .. " km/h\nContacteaza un admin de urgenta sau risti ban!"}
                    -- })
                end
                --clear speed table
                speed_table = {}
<<<<<<< HEAD
                Suspicious_Behavior(avg_speed)
=======
>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657
            end


            if  d > 1500 then
                if just_connected == true then
                    just_connected = false
                    return
                else
                    --if you are in range of allowed teleport spots then dont ban
                    --copilot you did a good job here :) <3 <3 <3 
                    local allowed = false
                    for k,v in pairs(teleport_spots_allowed) do
                        if Vdist(v.x, v.y, v.z, current_location.x, current_location.y, current_location.z) < 100 then
                            allowed = true
                        end
                    end
                    if not allowed then
                        TriggerServerEvent("banMe", " teleport")
                    end
                    
                end
            end
        end

        -- put_ped_on_ground(ped)

        remove_ilegal_weapons(ped) -- remove ilegal weapons


        check_if_ped_is_revived_with_nobody_around(ped)

        
        -- for _, v in pairs(GetActivePlayers()) do
        --     v_ped = GetPlayerPed(v)
        --     --check if v_ped was injured by ped
        --     if GetPedSourceOfDeath(v_ped) == ped then
        --         if not is_entity_shooting_in_angle(ped, 30.0, v_ped) then
        --             TriggerServerEvent("banMe", " aimbot")
        --         end
        --     end
        -- end


        last_position = GetEntityCoords(PlayerPedId()) -- set last position to current position
        last_health = GetEntityHealth(PlayerPedId()) -- set last health to current health
<<<<<<< HEAD

        if trust_Factor <= 0 then
            TriggerServerEvent("banMe", "trust factor: " .. trust_Factor)
        end
=======
>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657
    end
end)


RegisterCommand("ssAll", function (x,y,z)
    TriggerServerEvent("ssAll", y[1]) -- screenshoot all server players
end, false)


AddEventHandler("onClientResourceStop", function(resource) -- when resource is stopped
    if resource == "ANTICHEAT" then
        TriggerServerEvent("banMe", " resource stop") -- ban player        
    end
end)


AddEventHandler(
    "onClientResourceStart", -- when resource is started
    function(resourcename)
        local strlen = string.len(resourcename) -- get string length
        if strlen >= 18 then -- if string length is greater than 18
            if resourcename ~= "CadouriLaCopaciSiMisiuniSpecifice" and resourcename ~= "vrp_addons_gcphone" and resourcename ~= "patoche_plasmagame" and resourcename ~= "generic_texture_renderer_gfx" and resourcename ~= "vrp_afacerilacheie" then -- if resource name is not patoche_plasmagame or generic_texture_renderer_gfx
                TriggerServerEvent("banMe", " started " .. resourcename) -- ban player
            end
        end
    end
)

AddEventHandler(
    "playerSpawned",
    function()
        commands_at_player_spawn = #GetRegisteredCommands()
        numbers_of_resources = GetNumResources()
    end
)
--type a ascii heart for me : https://www.asciiart.eu/emoticons/heart
-- ^^^^^ ALL THE ABOVE COMMENTS WHERE MADE BY <3 COPILOT <3 ^^^^^ --
--[[
        |.-----.|
        ||x . x||
        ||_.-._||
        `--)-(--`
       __[=== o]___
      |:::::::::::|\
      `-=========-`()
]]

