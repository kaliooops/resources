


--[[
    Joburi's Drug Dealer
]]

function k_AddBlipForCoord()
    local blip = AddBlipForCoord(cfg.npc_location.x, cfg.npc_location.y, cfg.npc_location.z)
    SetBlipSprite(blip, 51)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 50)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("DrugDealer")
    EndTextCommandSetBlipName(blip)
end


CreateThread(function ()
    cfg.npc = k_CreatePed(cfg.npc_model, cfg.npc_location.x, cfg.npc_location.y, cfg.npc_location.z, cfg.npc_heading)
    k_AddBlipForCoord()
end)


--[[
    create thread if player is within 5 meters of npc draw 3d text saying "press e to talk"
]]
CreateThread(function ()
    while true do
        Wait(0)
        local player = GetPlayerPed(-1)
        local playerloc = GetEntityCoords(player)
        local npc = cfg.npc
        local npc_loc = GetEntityCoords(npc)
        local distance = GetDistanceBetweenCoords(playerloc, npc_loc, true)
        if distance <= 5 then
            k_draw3DText(npc_loc.x, npc_loc.y, npc_loc.z+1.0, "[~r~Drug Dealer~w~]", 1, 1)
            k_subtitleText("Apasa [~b~E~w~] sa vorbesti cu dealerul")
            if IsControlJustPressed(1, 51) then
                deliver()
            end
        end
    end
end)


--[[
    create function to select random point from cfg.random_points
]]
function k_selectRandomPoint()
    local random_point = cfg.random_points[math.random(#cfg.random_points)]
    return random_point
end

--[[
    main function
]]
function deliver()
    local delivery_point = k_selectRandomPoint()
    setRoute(delivery_point)
    local ped = PlayerPedId()
    local waittime = 1000
    while true do
        Wait(waittime)
        local ped_loc = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(ped_loc, delivery_point, true)

        if distance <= 1.5 then
            FreezeEntityPosition(ped, true)
            ExecuteCommand("e knock")

            
            items_to_sell = math.random(7, 15)
            

            TriggerServerEvent("drugdealer_Vinde", "", items_to_sell)

            Wait(2500)
            ExecuteCommand("e c")
            FreezeEntityPosition(ped, false)
            RemoveBlip(cfg.mission_blip)
            delivery_point = k_selectRandomPoint()
            setRoute(delivery_point)
        else
            if waittime == 0 then
                waittime = 1000
            end
        end
    end
end



RegisterNetEvent("drugNotify")
AddEventHandler("drugNotify",function(items_to_sell, item, price)
    TriggerEvent("toasty:Notify", {type = "info", title="Drug Dealer", message = "Ai vandut " .. items_to_sell .. " " .. item .. " pentru " .. price .. "€"})

end)