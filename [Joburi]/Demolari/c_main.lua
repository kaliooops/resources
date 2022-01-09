local current_Dirtpile = nil
local working = false
local myjob = nil

function DrawPedInfo(coords)
    k_draw3DText(coords.x, coords.y, coords.z+1.2, master.npc.npc_name, 1, 1)
    k_draw3DText(coords.x, coords.y, coords.z+1.1, "[~b~Inginer Demolari~w~]", 0.8, 1)
    
end

CreateThread(function ()
    master.npc.ped = k_CreatePed(master.npc.model, master.npc.location.x, master.npc.location.y, master.npc.location.z, master.npc.heading)

    blip = AddBlipForCoord(master.npc.location.x, master.npc.location.y, master.npc.location.z)
    SetBlipSprite(blip, 599)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Demolari")
    EndTextCommandSetBlipName(blip)

end)


CreateThread(function() -- dresser
    local waittime = 1000
    while true do
        Wait(waittime)
        while myjob ~= "Demolari" do Wait(5000) end
        if Vdist2(GetEntityCoords(PlayerPedId()), Dresser.location.x, Dresser.location.y, Dresser.location.z) < 15 then
            waittime = 0
            k_subtitleText("Apasa [~b~E~w~] sa te schimbi")
            k_draw3DText(Dresser.location.x, Dresser.location.y, Dresser.location.z+1.0, "[~b~Vestiar~w~]", 2, 1)
            if IsControlJustPressed(1, 51) then
                if not Dresser.dressed then 
                    get_p_clothes() 
                    dressUP() 
                    RemoveBlip(master.mission_blip)
                else 
                    dressUP()
                end
                showProgress("Te schimbi")
                FreezeEntityPosition(PlayerPedId(), true)   
                ExecuteCommand("e adjust")
                Wait(2500)
                ExecuteCommand("e adjust")
                Wait(2500)
                ExecuteCommand("e adjust")
                Wait(2500)
                ExecuteCommand("e adjust")
                Wait(2500)
                
                FreezeEntityPosition(PlayerPedId(), false)

            end
        else
            if waittime == 0 then waittime = 1000 end
        end

    end

end)


function createDirtPile(coords)
    return objSpawn(coords, "prop_pile_dirt_07")
end

function prepareForJob()
    master.zona_aleasa_pentru_demolare = math.random(1, #master.mission_locations)
    current_Dirtpile = createDirtPile(master.mission_locations[master.zona_aleasa_pentru_demolare])
    setRoute(master.mission_locations[master.zona_aleasa_pentru_demolare])
end

function endjob()
    RemoveBlip(master.mission_blip)
    print("blip removed", master.mission_blip)
    DeleteObject(current_Dirtpile)
    print("Dirt removed", current_Dirtpile)
    DeleteVehicle(master.veh.ref)
    print("veh deleted", master.veh.ref)
    working = false
    
end


function job()
    CreateThread(function() 
        local waittime = 300
        while true do
            while myjob ~= "Demolari" do Wait(10000) end
            while not working do Wait(1000) end
            Wait(waittime) 
            if Vdist2(GetEntityCoords(current_Dirtpile), GetEntityCoords(PlayerPedId())) < 15 then
                waittime = 0
                k_subtitleText("Apasa [~b~E~w~] sa demolezi")
                if IsControlJustPressed(1, 51) then
                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)
                    showProgress("Demolare")
                    DisableControlAction(1, 51, true)
                    Wait(10000)
                    DisableControlAction(1, 51, false)
                    ClearPedTasksImmediately(PlayerPedId())
                    DeleteObject(current_Dirtpile)
                    RemoveBlip(master.mission_blip)

                    kserverTrigger("giveMoney")

                    prepareForJob()
                    waittime = 300
                end
            end
                      
        end
    end)
end

--continuous update
local main_loop_wait = 1000

CreateThread(function () --checkjob
    while true do
        kserverTrigger("sendPlayerJob")
        Wait(120000) 
        
    end    
end) 

local function clearAreaOfVehicles()
    --clear any vehicles in the radius
    local vehicles = GetVehiclesInArea(master.veh.location, 10.0)
    for k,v in pairs(vehicles) do
        if IsEntityAVehicle(v) then
            if GetPedInVehicleSeat(v, -1) ~= PlayerPedId() then
                SetEntityAsMissionEntity(v, true, true)
                DeleteVehicle(v)
            end
        end
    end

end

Citizen.CreateThread(function() 
    while true do
        Wait(main_loop_wait)
        while myjob ~= "Demolari" do Wait(10000) end
        master.distance_player_to_ped = Vdist2(GetEntityCoords(master.npc.ped), GetEntityCoords(PlayerPedId()))
        can_interact = master.distance_player_to_ped < 15
        if can_interact then 
            main_loop_wait = 0
        else
            if main_loop_wait == 0 then
                main_loop_wait = 1000
            end
        end

        if can_interact then
            DrawPedInfo(master.npc.location)
            if not working then
                k_subtitleText("Apasa [~b~E~w~] sa lucrezi")
            else
                k_subtitleText("Apasa [~b~E~w~] sa termini de lucru")
            end
            if IsControlJustPressed(1, 51) then
                if not Dresser.dressed then 
                    setRoute(Dresser.location)
                    TriggerEvent("toasty:Notify", {type = "info", title="[Demolari]", message = "Trebuie sa te schimbi de haine"})

                else
                    if not working then
                        prepareForJob()
                        clearAreaOfVehicles() --TESTING
                        
                        master.veh.ref = TeleportPedInCreatedVeh(PlayerPedId(), master.veh.model, master.veh.location, master.veh.heading)
                        working = true
                        job()

                    else
                        endjob()
                        working = false
                    end

                end
            end



        end
    end

end)





RegisterNetEvent("getPlayerJob")
AddEventHandler("getPlayerJob", function (jname)
    myjob = jname 
end)
