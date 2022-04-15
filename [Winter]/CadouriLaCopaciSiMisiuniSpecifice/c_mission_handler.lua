local mission = nil


RegisterNetEvent("winter_mision_handler:set_mission")
AddEventHandler("winter_mision_handler:set_mission", function (_mission)
    if mission == nil then
        mission = _mission
        build_mission(mission)
        TriggerEvent("toasty:Notify", {type = "info", title = "Misiune noua", message = mission})
        active_missions = 1
    end
end)




function build_mission(mission)
    --/**\ ^_^ \**/--
    if mission == "Condu cu snow mobilul 30 de km" then
        CreateThread(snow_mobil_50km)
    end

    if mission == "Gaseste Cadourile Ascunse in cele 3 zone albastre" then
        CreateThread(gaseste_cadouri)
    end

    if mission == "Aprinde 100 de artificii" then
        CreateThread(aprinde_artificiile)
    end

    if mission == "Viziteaza extraterestrul din iglu" then
        CreateThread(viziteaza_extraterestrul)
    end

    -- if mission == "Plimbare cu masina de la rent" then
    --     CreateThread(plimbare_cu_masina_de_la_rent)
    -- end

    if mission == "Nu parasi si orasul timp de o ora" then
        CreateThread(nu_parasi_orasul)
    end

    if mission == "Viziteaza insula cayo perico" then
        CreateThread(viziteaza_cayo_perico)
    end

    if mission == "Mergi cu masina cu spatele 10 km" then
        CreateThread(mergi_cu_masina_cu_spatele)
    end

    if mission == "Poarta caciula de craciun" then
        CreateThread(poarta_caciula_de_craciun)
    end

    if mission == "Obtine 5.000 euro" then
        CreateThread(obtine_5k_euro)
    end
end




function snow_mobil_50km()
    local drive_time = 0
    CreateThread(function()
        while drive_time < 30 do
            drawHudText(0.5,0.01, 0.0,0.0,0.65,"Snowmobil: ", 255,255,255, 255,1,6,1)
            drawHudText(0.57,0.01, 0.0,0.0,0.65, string.format("%.2f", drive_time) .. "/30 km", 20, 184, 11, 255,1,6,1)
            Wait(0)
        end
    end)
    while true do
        Wait(1000)
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        local veh_model = GetEntityModel(veh)
        
        if veh_model == -2128233223 then
            --store drive time
            drive_time = drive_time + GetEntitySpeed(veh) * 3.6 / 3600

            if drive_time >= 30 then
                active_missions = 0
                TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai finalizat misiunea: " .. mission})
                TriggerServerEvent("winter_misiuni:finish_mission", mission)
                mission = nil
                break
            end
        end
    end
end


function gaseste_cadouri()
    local found_cadouri = 0
    local cadouri = {
        {x = -41.60, y = 109.66, z = 81.44, name = "Cadou 1",  obj = nil,    blip = nil},
        {x = 721.45, y = -783.65, z = 24.80, name = "Cadou 2", obj = nil,    blip = nil},
        {x = -1347.71, y = -1233.33, z = 5.93, name = "Cadou 3", obj = nil,  blip = nil},
    
    }
    --put a green overlay on the cadou
    Citizen.CreateThread(function()
        while found_cadouri < 3 do
            Wait(200)
            for _, kadoi in pairs(cadouri) do
                kadoi.blip = AddBlipForRadius(kadoi.x, kadoi.y, kadoi.z, 150.0)
                SetBlipRotation(kadoi.blip, 0)
                SetBlipColour(kadoi.blip, 67)
                SetBlipAlpha(kadoi.blip, 3)
            end
        end
    end)


    

    for _, ka2 in pairs(cadouri) do
        ka2.obj = CreateObject(-1938376606, ka2.x, ka2.y, ka2.z, false, false, true)
    end
    CreateThread(function()
        while found_cadouri < 3 do
            drawHudText(0.5,0.01, 0.0,0.0,0.65,"Gaseste Cadourile Ascunse in cele 3 zone albastre", 255,255,255, 255,1,6,1)
            drawHudText(0.5,0.038, 0.0,0.0,0.65, string.format("%d/3", found_cadouri), 20, 184, 11, 255,1,6,1)
            Wait(0)
        end
    end)

    while true do
        Wait(1000)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        for i = 1, #cadouri do
            local dist = Vdist(GetEntityCoords(PlayerPedId()), cadouri[i].x, cadouri[i].y, cadouri[i].z)
            if dist < 3.5 then
                found_cadouri = found_cadouri + 1
                TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai gasit cadouul: " .. cadouri[i].name})
                DeleteEntity(cadouri[i].obj)
                table.remove(cadouri, i)
                break
            end
        end
        if found_cadouri == 3 then
            active_missions = 0
            TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai finalizat misiunea: " .. mission})
            TriggerServerEvent("winter_misiuni:finish_mission", mission)
            mission = nil
            break
        end
    end
end

Artificii_Aprinse = 0
function aprinde_artificiile()
    --draw aritficii aprinse
    CreateThread(function()
        while Artificii_Aprinse < 80 do
            drawHudText(0.5,0.01, 0.0,0.0,0.65,"Aprinde Artificii: ", 255,255,255, 255,1,6,1)
            drawHudText(0.57,0.01, 0.0,0.0,0.65, string.format("%d/80", Artificii_Aprinse), 20, 184, 11, 255,1,6,1)
            Wait(0)
        end
    end)

    while true do
        Wait(1000)
        if Artificii_Aprinse == 80 then
            active_missions = 0
            TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai finalizat misiunea: " .. mission})
            TriggerServerEvent("winter_misiuni:finish_mission", mission)
            mission = nil
            break
        end
    end

end


function viziteaza_extraterestrul()
    while Vdist(GetEntityCoords(PlayerPedId()), 180.98994445801,-969.29528808594,30.275205612183) > 2.5 do
        drawHudText(0.5,0.01, 0.0,0.0,0.65,"Viziteaza extraterestrul din iglu din centrul orasului", 255,255,255, 255,1,6,1)
        Wait(0)
    end
    active_missions = 0
    TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai finalizat misiunea: " .. mission})
    TriggerServerEvent("winter_misiuni:finish_mission", mission)
    mission = nil

end



plimbare_masina_rent = 0
function plimbare_cu_masina_de_la_rent()
    CreateThread(function()
        while plimbare_masina_rent < 30 do
            drawHudText(0.5,0.01, 0.0,0.0,0.65,"Condu masina de la rent", 255,255,255, 255,1,6,1)
            drawHudText(0.62,0.01, 0.0,0.0,0.65,plimbare_masina_rent .. "/30 minute",  20, 184, 11, 255,1,6,1)
            Wait(0)
        end
    end)

    while true do
        Wait(1000)
        if plimbare_masina_rent == 30 then
            active_missions = 0
            TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai finalizat misiunea: " .. mission})
            TriggerServerEvent("winter_misiuni:finish_mission", mission)
            mission = nil
            break
        end
    end

end


function nu_parasi_orasul()
    local minute = 0
    CreateThread(function()
        while minute < 60 do
            drawHudText(0.5,0.01, 0.0,0.0,0.65,"Timp petrecut in oras: ", 255,255,255, 255,1,6,1)
            drawHudText(0.60,0.01, 0.0,0.0,0.65,minute .. "/60 minute",  20, 184, 11, 255,1,6,1)
            Wait(0)
        end
    end)

    while minute < 60 do
        Wait(60000)
        minute = minute + 1
    end

    active_missions = 0
    TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai finalizat misiunea: " .. mission})
    TriggerServerEvent("winter_misiuni:finish_mission", mission)
    mission = nil

end


function viziteaza_cayo_perico()
    local cayo_location = vector3(3938.5983886719,-4641.6088867188,4.3066606521606)

    local waypoint = setRoute(cayo_location)

    while Vdist(cayo_location, GetEntityCoords(PlayerPedId())) > 300 do
        drawHudText(0.5,0.01, 0.0,0.0,0.65,"Atinge nisipul de pe insula Cayo Perico", 255,255,255, 255,1,6,1)
        Wait(0)
    end

    active_missions = 0
    TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai finalizat misiunea: " .. mission})
    TriggerServerEvent("winter_misiuni:finish_mission", mission)
    mission = nil
    RemoveBlip(waypoint)

end


function mergi_cu_masina_cu_spatele()
    local drive_time = 0
    CreateThread(function()
        while drive_time < 10 do
            drawHudText(0.5,0.01, 0.0,0.0,0.65,"Mergi cu spatele: ", 255,255,255, 255,1,6,1)
            drawHudText(0.58,0.01, 0.0,0.0,0.65, string.format("%.2f", drive_time) .. "/10 km", 20, 184, 11, 255,1,6,1)
            Wait(0)
        end
    end)
    while true do
        Wait(1000)
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        local veh_model = GetEntityModel(veh)
        if (GetEntitySpeedVector(veh, true).y * 3.6) < 0 then
            
            --store drive time
            drive_time = drive_time + GetEntitySpeed(veh) * 3.6 / 3600
            if drive_time >= 10 then
                active_missions = 0
                TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai finalizat misiunea: " .. mission})
                TriggerServerEvent("winter_misiuni:finish_mission", mission)
                mission = nil
                break
            end
        end
    end
end


function poarta_caciula_de_craciun()
    local minute = 0
    CreateThread(function()
        while minute < 60 do
            drawHudText(0.5,0.01, 0.0,0.0,0.65,"Poarta caciula de craciun: ", 255,255,255, 255,1,6,1)
            drawHudText(0.61,0.01, 0.0,0.0,0.65,minute .. "/60 minute",  20, 184, 11, 255,1,6,1)
            Wait(0)
        end
    end)

    while minute < 60 do
        Wait(60000)

        local hat = GetPedPropIndex(PlayerPedId(), 0)
        if hat == 22 then
            minute = minute + 1
        end
    end

    active_missions = 0
    TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai finalizat misiunea: " .. mission})
    TriggerServerEvent("winter_misiuni:finish_mission", mission)
    mission = nil

end

bani_obtinuti = 0
function obtine_5k_euro()
    while bani_obtinuti < 5000 do
        drawHudText(0.5,0.01, 0.0,0.0,0.65,"Bani obtinuti: ", 255,255,255, 255,1,6,1)
        drawHudText(0.58,0.01, 0.0,0.0,0.65,bani_obtinuti .. "/5.000 euro",  20, 184, 11, 255,1,6,1)
        Wait(0)
    end    

    active_missions = 0
    TriggerEvent("toasty:Notify", {type = "info", title = "Misiune Craciun", message = "Ai finalizat misiunea: " .. mission})
    TriggerServerEvent("winter_misiuni:finish_mission", mission)
    mission = nil

end