cfg = {
    {
        nume = "rmodx6",
        descriere = "BMW X6",
        pret = 20,
        finished_renting = false,
        coords = vector3(-554.72, 336.99, 83.37),
        heading = 147.30
    },
    {
        nume = "rmodm4gts",
        descriere = "M4 GTS",
        pret = 25,
        finished_renting = false,
        coords = vector3(-560.34, 336.99, 83.37),
        heading = 150.57
    },

    {
        nume = "rmodmi8lb",
        descriere = "BMW i8",
        pret = 25,
        finished_renting = false,
        coords = vector3(-564.73, 338.02, 83.37),
        heading = 148.66
    },

    {
        nume = "ocnetrongt",
        descriere = "E-TRON GT",
        pret = 30,
        finished_renting = false,
        coords = vector3( -570.03, 337.66, 83.37),
        heading = 149.84
    },
    {
        nume = "audquattros",
        descriere = "Audi Quattro",
        pret = 10,
        finished_renting = false,
        coords = vector3(-576.84, 338.59, 83.37),
        heading = 211.96
    },
    
    {
        nume = "bati",
        descriere = "Yamaha O-BEY",
        pret = 25,
        finished_renting = false,
        coords = vector3(-583.59, 316.84, 83.37),
        heading = 342.15,
    },

    {
        nume = "africat",
        descriere = "Honda Africa Twin",
        pret = 25,
        finished_renting = false,
        coords = vector3(-578.90, 314.99, 83.37),
        heading = 358.51
    },

    {
        nume = "zx10r",
        descriere = "Zonda X10R",
        pret = 25,
        finished_renting = false,
        coords = vector3(-575.70, 315.96, 83.37),
        heading = 1.89,
    },

    {
        nume = "bmws",
        descriere = "BMW S1000",
        pret = 25,
        finished_renting = false,
        coords = vector3(-571.85, 314.74, 83.51),
        heading = 357.67,
    },

    {
        nume = "bugatti",
        descriere = "Bugatti Veyron",
        pret = 100,
        finished_renting = false,
        coords = vector3(-618.92, 335.73, 84.12),
        heading = 265.69,
    },

    {  
        nume = "lp700",
        descriere = "Lamborghini LP 700",
        pret = 100,
        finished_renting = false,
        coords = vector3(-618.78, 341.65, 84.14),
        heading = 260.31,
    },

}


local data = {}
local renting = false
data.garaje = {
    vector3(58.84827041626,6469.0556640625,31.425289154053),
    vector3(1209.0063476562,2643.6474609375,37.828971862793),
    vector3(310.55587768555,-1376.4459228516,31.844318389893),
    vector3(135.94720458984,-1082.021484375,29.193765640259),
    vector3(-1195.8973388672,-1496.4847412109,4.3730320930481),
    vector3(-1169.1387939453,-883.07800292969,14.115057945251),
    vector3(-1142.8312988281,-748.63165283203,19.508142471313),
    vector3(371.54653930664,-950.51336669922,29.338975906372),
    vector3(-331.64074707031,-750.87963867188,33.968532562256),
    vector3(-1432.0504150391,-582.8837890625,30.630140304565),
    vector3(-1389.6484375,57.306610107422,53.614276885986),
    vector3(-3088.8291015625,344.66540527344,7.4301538467407),
    vector3(-1895.27734375,2034.8106689453,140.74147033691),
    vector3(-2210.4890136719,4245.5415039062,47.552459716797),
    vector3(-489.29852294922,-282.87945556641,35.47709274292),
}

data.blips = vector3(-573.86535644531,329.07525634766,84.589469909668)
data.blips_icon = 523

CreateThread(function()
    blip = AddBlipForCoord(data.blips.x, data.blips.y, data.blips.z)
    SetBlipSprite(blip, data.blips_icon)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 1)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Garaje Rent")
    EndTextCommandSetBlipName(blip)    
end)

local closest_dist = 999999999
local closest_garaje = nil
CreateThread(function()
    waittime = 1000
    while true do
        while not renting do Wait(5000) end
        local ped = PlayerPedId()
        Wait(waittime)

        --get closest garaj
        for i,v in ipairs(data.garaje) do
            local dist = #(GetEntityCoords(PlayerPedId()) - v)
            if dist < closest_dist then
                closest_dist = dist
                closest_garaj = v
            end
        end

        local dist =Vdist(GetEntityCoords(PlayerPedId()), closest_garaj)  
        
        if dist < 10 then
            waittime = 0
           if IsPedInAnyVehicle(PlayerPedId(), false) then
                DrawMarker(1, closest_garaj.x, closest_garaj.y, closest_garaj.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 155, 78, 78, 100, false, true, 2, false, false, false, false)
                k_draw3DText(closest_garaj.x, closest_garaj.y, closest_garaj.z+1.0,"Apasa [~g~E~w~] sa returnezi vehiculul", 2, 1)         
                
                local c_vehicle = GetVehiclePedIsIn(ped, false)
                if c_vehicle == data.rented_vehicle then
                    if IsControlJustPressed(1, 51) then
                        SetEntityAsMissionEntity(data.rented_vehicle, true, true)
                        DeleteVehicle(data.rented_vehicle)
                        DeleteEntity(data.rented_vehicle)
                        TriggerServerEvent("rent_real:EndOfRent", data.model)
                        renting = false
                    end
                end
            end
        else
            if waittime == 0 then waittime = 1000 end
        end
        
    end
end)


local cars = {}

CreateThread(function()
    for _, v_table in pairs(cfg) do
        local c =spawnCar(v_table.nume, v_table.coords, v_table.heading)
        FreezeEntityPosition(c, true)
        SetEntityInvincible(c, true)
        table.insert(cars, {c, v_table.nume, v_table.pret})
    end

    CreateThread(function()
        local waittime = 0
        while true do
            Wait(waittime)

            for _, car in pairs(cars) do
                local car_veh = car[1]
                local dist =#(GetEntityCoords(PlayerPedId()) - GetEntityCoords(car_veh))  
                if dist < 10 then
                    if IsControlJustPressed(1, 51) then
                        if not renting then
                            if car_veh == get_closest_vehicle() then
                                data.rented_vehicle = TeleportPedInCreatedVeh(PlayerPedId(), car[2], vector3(-523.42, 342.70, 82.04), 171.06)
                                data.rented_vehicle = VehToNet(data.rented_vehicle)
                                NetworkRegisterEntityAsNetworked(data.rented_vehicle)
                                renting = true
                                TriggerServerEvent("rent_real:Rented", car[3])
                                break
                            end
                        end
                    end
                end
            end
        end
    end)
end)


CreateThread(function()  --threadu de masina rentata
    local locked = true
    local waittime = 1000
    while true do
        Wait(waittime)
        if not DoesEntityExist(data.rented_vehicle) and renting then -- if the vehicle is not spawned
            renting = false
            TriggerServerEvent("rent_real:EndOfRent", data.model) -- end the rent
        else
            if Vdist2(GetEntityCoords(PlayerPedId()), GetEntityCoords(data.rented_vehicle)) < 50 then -- if the player is too far away from the vehicle
                waittime = 0 

                local ped = PlayerPedId()
                local veh = data.rented_vehicle
                if IsControlJustPressed(1, 289) then
                    TriggerEvent("toasty:Notify", {type = "info", title="Rent", message = "Incuietoarea a fost actionata"})

                    SetVehicleDoorsLocked(veh, locked)
                    SetVehicleDoorsLockedForAllPlayers(veh, locked)
    
                    CreateThread(function()
                        while true do
                            SetVehicleEngineOn(veh, true, true, false)
                            SetVehicleLightsMode(veh, 2)
                            SetVehicleIndicatorLights(veh, 0, true)
                            SetVehicleIndicatorLights(veh, 1, true)
                            SetVehicleBrakeLights(veh, true)
                            Wait(200)
                            SetVehicleLightsMode(veh, 1)
                            SetVehicleEngineOn(veh, false, false, false)
                            SetVehicleIndicatorLights(veh, 0, false)
                            SetVehicleIndicatorLights(veh, 1, false)
                            SetVehicleBrakeLights(veh, false)
    
                            break
                        end
                    end)
    
                    locked = not locked
                    Wait(200)
                end
            else
                if waittime == 0 then waittime = 1000 end
            end

        end
    end

end)



CreateThread(function()
    local waittime = 1000
    while true do
        Wait(waittime)
        for _, v_table in pairs(cfg) do
            while Vdist2(GetEntityCoords(PlayerPedId()), v_table.coords) < 15 do
                Wait(0)
                k_draw3DText(v_table.coords.x, v_table.coords.y, v_table.coords.z+2.2, "[Model: ~b~" .. v_table.descriere .. "~w~]", 2, 1)
                k_draw3DText(v_table.coords.x, v_table.coords.y, v_table.coords.z+2.0, "[Pret: ~r~"..v_table.pret.."$~w~]", 2, 1)
            end
        end


    end
end)