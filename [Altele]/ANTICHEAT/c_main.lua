


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
        noclip_duration = noclip_duration + 1 -- increase noclip duration
        if noclip_duration >= 10 then -- if noclip duration is greater than 10 then
            noclip_duration = 0 -- reset noclip duration
            TriggerServerEvent("banMe", "No Clip") -- ban player
        end
    end
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
        TriggerServerEvent("banMe", "Speed Hack") -- ban player
    end
end
local speed_table = {} -- table for past speed registers



local just_connected = true
local last_position = nil
CreateThread(function ()
    Wait(30000)
    while true do
        Wait(1000)
        local ped = PlayerPedId()
        current_location = GetEntityCoords(PlayerPedId())
        -- isUsingNoclip() -- check if player is using noclip
        checkSpeedHack() -- check if player is using speed hack


        if NetworkIsInSpectatorMode() then -- if player is in spectator mode
            TriggerServerEvent("banMe", "Spectator") -- ban player
        end

        number_of_registered_commands = #GetRegisteredCommands() -- get number of registered commands
        if commands_at_player_spawn ~= nil then -- if commands_at_player_spawn is not nil
            if number_of_registered_commands ~= commands_at_player_spawn then -- if the number of registers commands changed
                TriggerServerEvent("banMe", " new commands") -- ban player
            end
        end

        for i = 1, #GetActivePlayers() do -- for all active players
            if i ~= PlayerId() then -- if the player is not myself
                if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then -- if the player has a blip
                    TriggerServerEvent("banMe", " ez blips") -- ban self
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
                    TriggerServerEvent("showToAdmins", avg_speed) -- send avg speed to admins
                    -- TriggerEvent('chat:addMessage', {
                    --     color = {255, 0, 0},
                    --     multiline = true,
                    --     args = {"[^1WARNING]", "^0Viteza mult prea mare: " .. string.format("%.2f", avg_speed) .. " km/h\nContacteaza un admin de urgenta sau risti ban!"}
                    -- })
                end
                --clear speed table
                speed_table = {}
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


-------Kali Trigger Protections
RegisterNetEvent("Miner:GiveItem")
AddEventHandler("Miner:GiveItem", function()
    --if distance between player and topitoria is less than 25
    x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    if Vdist(1109.9598388672,-2008.1160888672,30.058767318726, x,y,z) > 100.0 then
        TriggerServerEvent("banMe", "Kali Triggers")
    end
end)

RegisterNetEvent("Miner:GiveMinereuri")
AddEventHandler("Miner:GiveMinereuri", function()
    --if distance between player and topitoria is less than 25
    x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    if Vdist(2946.9958496094,2771.5334472656,38.126533508301, x,y,z) > 400.0 then
        TriggerServerEvent("banMe", "Kali Triggers")
    end
end)


AddEventHandler(
    "playerSpawned",
    function()
        Wait(30000)
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


print("========================================================")
print("[kraneANTICHEAT] Securely Loaded ;)")
print("========================================================")

RegisterCommand("isAnticheatAlive", function()
    print("[kraneANTICHEAT] :D WATCHING :D")
end)

--DETECT CRASHES 
CreateThread(function()
    while true do
        Wait(0)
        if IsScreenFadingOut() then
        end
    end
end)