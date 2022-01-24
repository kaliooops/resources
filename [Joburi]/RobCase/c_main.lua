
local finished_rob = false
local assigned_house = nil
local has_to_deliver = false
local has_entered_house = false
local stolen = {}

RegisterNetEvent("RobCase:notify")
AddEventHandler("RobCase:notify", function(text)
    TriggerEvent("toasty:Notify", {type = "info", title="Dacian", message = text})

end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(cfg.npc.npc_location.x, cfg.npc.npc_location.y, cfg.npc.npc_location.z)
    SetBlipSprite(blip, 618)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 60)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Rolex")
    EndTextCommandSetBlipName(blip)
  end)

CreateThread(function() -- first generate

    cfg.npc.ref = k_CreatePed(cfg.npc.npc_model, cfg.npc.npc_location.x, cfg.npc.npc_location.y, cfg.npc.npc_location.z+1.0, cfg.npc.npc_heading)

    CreateThread(function()
    
        while true do 
            Wait(1000)

            while Vdist(GetEntityCoords(PlayerPedId()), cfg.npc.npc_location.x, cfg.npc.npc_location.y, cfg.npc.npc_location.z) < 5 do
                --draw ped info
                k_draw3DText(cfg.npc.npc_location.x, cfg.npc.npc_location.y, cfg.npc.npc_location.z+2.0, "Dacian", 1.0, 1)
                k_draw3DText(cfg.npc.npc_location.x, cfg.npc.npc_location.y, cfg.npc.npc_location.z+1.9, "[~b~Amanet~w~]", 0.7, 1)
                
                if IsControlJustPressed(1, 51) then
                    if finished_rob then
                        TriggerServerEvent("RobCase:Payment", stolen)
                        has_entered_house = false
                        stolen = {}
                        finished_rob = false 
                        assigned_house = nil
                    else
                        TriggerServerEvent("RobCase:GiveMission")
                        while assigned_house == nil do
                            Wait(0)
                        end
                        SetNewWaypoint(assigned_house.location)
                        TriggerEvent("toasty:Notify", {type = "info", title="Rob Case", message = "Ti-am trimis locatia unei case, vezi ce gasesti in ea!"})
                    end
                end
                Wait(0)
            end
        end
    end)
end)

function rob()
    while assigned_house == nil do print(assigned_house) Wait(2500) end

    while not finished_rob do
        Wait(1000)

        print(".")
        if Vdist(GetEntityCoords(PlayerPedId()), assigned_house.location) < 5 then
            has_entered_house = true
            TriggerServerEvent("RobCase:Rob", assigned_house.name)
        end

        if Vdist(GetEntityCoords(PlayerPedId()), assigned_house.location) > 50 and has_entered_house then
            finished_rob = true
            TriggerEvent("RobCase:notify", "Ai parasit zona de actiune, vino la mine cu ce ai furat!")
        end

        for i, de_spart in pairs(assigned_house.de_spart) do
            while Vdist(GetEntityCoords(PlayerPedId()), de_spart.location) < 5 do
                if not has_to_deliver and not de_spart.finished then
                    k_draw3DText(de_spart.location.x, de_spart.location.y, de_spart.location.z+2.0, "Fura din " .. de_spart.name, 1.0, 1)
                    if IsControlJustPressed(1, 51) then
                        animation_rob()
                        de_spart.finished = true
                        table.insert(stolen, de_spart)
                    end
                else
                    while has_to_deliver do
                        Wait(0)
                        k_draw3DText(de_spart.location.x, de_spart.location.y, de_spart.location.z+2.0, "Du cutia la intrare!", 1.0, 1)
                        if Vdist(GetEntityCoords(PlayerPedId()), assigned_house.location) < 3 then
                            has_to_deliver = false
                            lasa_la_usa()
                        end
                    end
                end
                
                Wait(0)
            end
        end
    end
end

function lasa_la_usa()
    ExecuteCommand("e c")
    ExecuteCommand("me lasa cutia jos")
    Wait(1000)
end

function animation_rob()
    ExecuteCommand("e mechanic")
    Wait(5000)
    ExecuteCommand("e box")
    has_to_deliver = true
end

RegisterNetEvent("RobCase:GiveMission")
AddEventHandler("RobCase:GiveMission", function (h)
    for _, house in pairs(cfg.houses) do
        if house.name == h.name then
            assigned_house = house
            CreateThread(function()
                rob()
            end)
            break
        end
    end
end)

