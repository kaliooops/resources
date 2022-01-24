local racing = false
local game_mode = nil
local tracker = 2
local last_cp = false
local ready = false
local race_started = false
local all_players_ready_for_anim = false
local passed = 0
local i_am_ready = false

RegisterNetEvent("race:stop_race")
AddEventHandler("race:stop_race", function ()
    i_am_ready = false
    passed = 0
    all_players_ready_for_anim = false
    race_started = false
    ready = false
    last_cp = false
    tracker = 2
    game_mode = nil
    racing = false
end)


RegisterNetEvent("race:build_game")
AddEventHandler("race:build_game", function (data)
    game_mode = data[1].game_mode
    racing = true
end)

RegisterNetEvent("race:startRace")
AddEventHandler("race:startRace", function ()
    racing = true
end)

RegisterNetEvent("race:startRaceGUI")
AddEventHandler("race:startRaceGUI", function ()
    race_started = true
end)

CreateThread(function()
    while true do 
        Wait(1000)

        while not racing do 
            Wait(1000) 
        end 

        check_if_in_position(game_mode)


        while racing and game_mode do 
            if not race_started then
                start_animation(cfg.default_race_tracks[game_mode][1])
            end
            Wait(0)
            if game_mode == nil then break end
            local point = cfg.default_race_tracks[game_mode][tracker] -- change the next cp based on tracker
            local ped_coords = GetEntityCoords(PlayerPedId()) 
            local d = Vdist(point, ped_coords) -- distance in meters between player and next checkpoint
            if tracker == #cfg.default_race_tracks[game_mode] then last_cp = true end -- if last cp then special behavoir
            generate_race_visual_checkpoint(point, RecolorSmooth(d), last_cp) -- visual only

            setRoute(point)
            if d < 10 then
                tracker = tracker + 1
            end

            if tracker > #cfg.default_race_tracks[game_mode] then -- if last cp
                RemoveBlip(cfg.mission_blip)
                TriggerServerEvent("race:Winner")
                if cfg.stop_veh_at_finish then  --mai puteti frana ca va fac sa spuneti piua
                    SetVehicleForwardSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 80)
                end
                --reset vars
                racing = false
                tracker = 1
                last_cp = false
                break
            end
        end
    end
end)


function check_if_in_position(gamemode)
    if not gamemode then print("no gm") return end
    location = cfg.default_race_tracks[gamemode][1]
    ped_coords = GetEntityCoords(PlayerPedId())
    setRoute(location)
    while Vdist(location, ped_coords) > 10 and not ready do
        Wait(0)
        drawHudText(0.5,0.01, 0.0,0.0,0.65,"Race",107, 107, 219,255,1,6,1)
        drawHudText(0.5,0.04, 0.0,0.0,0.65,"Du-te la start!",255, 255, 255,255,1,6,1)
        drawHudText(0.5,0.07, 0.0,0.0,0.65,"#1/3",43, 181, 112,255,1,6,1)
        ped_coords = GetEntityCoords(PlayerPedId())
        DrawMarker(1, location.x, location.y, location.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 155, 78, 78, 100, false, true, 2, false, false, false, false)
        generate_race_visual_checkpoint(location, RecolorSmooth(Vdist(location, ped_coords)), false) -- visual only
        ready = false
    end
    ready = true
    RemoveBlip(cfg.mission_blip)
    TriggerServerEvent("race:PlayerState", {ready = true})
end




RegisterNetEvent("race:seconds_passed")
AddEventHandler("race:seconds_passed", function ()
    passed = passed + 1
end)


RegisterNetEvent("race:all_players_ready")
AddEventHandler("race:all_players_ready", function ()
    all_players_ready_for_anim = true
end)

function start_animation(location)

    while not all_players_ready_for_anim and racing do
        Wait(0)
        drawHudText(0.5,0.01, 0.0,0.0,0.65,"Waiting for players...",173, 17, 17, 255,1,6,1)
        if not i_am_ready then
            if Vdist(location, GetEntityCoords(PlayerPedId())) < 5 then
                TriggerServerEvent("race:Set_Ready_For_Animation")
                i_am_ready = true
            end
        end
    end

    CreateThread(function() 
        passed = 1
        Wait(1000)
        passed = 2
        Wait(1000)
        passed = 3 
        Wait(1000)
        passed = 4        
    end)


    while true and racing do
        Wait(0)
        DisableControlAction(1, 71, true)
        DisableControlAction(1, 72, true)
        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0)

        if passed >= 1 then -- something weird
            drawHudText(0.5,0.01, 0.0,0.0,0.65,"Ready",173, 17, 17, 255,1,6,1)
        end
        if passed >= 2 then -- happens here
            drawHudText(0.5,0.04, 0.0,0.0,0.65,"Set", 184, 166, 11, 255,1,6,1)     
        end
        if passed >= 3 then

            drawHudText(0.5,0.07, 0.0,0.0,0.65,"GO GO GO!", 20, 184, 11, 255,1,6,1)
        end
        DisableControlAction(1, 71, false)
        DisableControlAction(1, 72, false)
        if passed >= 4 then
            race_started = true
            return
        end
    end

end

