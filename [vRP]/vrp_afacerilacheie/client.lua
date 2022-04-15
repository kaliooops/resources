vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP", "vrp_afacerilacheie")
vRPhouse = Tunnel.getInterface("vrp_afacerilacheie", "vrp_afacerilacheie")
vRPC = {}
Tunnel.bindInterface("vrp_afacerilacheie", vRPC)
vRPS = Tunnel.getInterface("vrp_afacerilacheie", "vrp_afacerilacheie")

housestypeslist = {
    ["Birou"] = {
        exit = {-1902.2843017578,-572.54046630859,19.097227096558},
        inventory = {-1904.7668457031,-570.85974121094,19.097227096558},
        wardrobe = {0,0,0}
    },
    ["NightClub"] = {
        exit = {246.57621765137,-1589.3984375,-187.00007629395},
        inventory = {227.84788513184,-1601.2540283203,-181.08476257324},
        wardrobe = {0,0,0}
    },
    ["GalaxyClub"] = {
        exit = {354.81579589844,300.33343505859,104.03701782227},
        inventory = {391.79251098633,266.99017333984,94.991004943848},
        wardrobe = {0,0,0}
    },
    ["SediuCEO"] = {
        exit = {-1396.0882568359,-480.53219604492,72.042053222656},
        inventory = {-1374.701171875,-462.59121704102,72.046356201172},
        wardrobe = {0,0,0}
    },
    ["SediuCEO2"] = {
        exit = {-1581.1705322266,-562.05218505859,108.52291870117},
        inventory = {-1555.4114990234,-572.30517578125,108.52725219727},
        wardrobe = {0,0,0}
    },
    ["SediuCEO3"] = {
        exit = {-141.4983215332,-617.64764404297,168.82034301758},
        inventory = {-124.21942138672,-639.43286132813,168.8246307373},
        wardrobe = {0,0,0}
    },
    ["SediuCEO4"] = {
        exit = {-77.203598022461,-830.1689453125,243.38577270508},
        inventory = {-83.076171875,-802.77838134766,243.39007568359},
        wardrobe = {0,0,0}
    },
    ["Depozit"] = {
        exit = {1048.6702880859,-3097.3342285156,-38.999954223633},
        inventory = {1051.6091308594,-3102.5830078125,-38.999954223633},
        wardrobe = {0,0,0}
    },
    ["DepozitMare"] = {
        exit = {992.9619140625,-3097.9560546875,-38.99585723877},
        inventory = {999.98382568359,-3102.7395019531,-38.999862670898},
        wardrobe = {0,0,0}
    },
    ["BirouSay"] = {
        exit = {550.41192626953,-2785.5715332031,6.0988082885742},
        inventory = {542.22955322266,-2783.3083496094,6.0984215736389},
        wardrobe = {0,0,0},
    }
}

houses = {}
idh = nil
typeh = nil

function vRPC.CreateHouses(house)
    houses = nil
    Wait(1000)
    houses = house
    blips()
end

function vRPC.setUpJoinedPlayer(id, type)
    idh = id
    typeh = type
end

function vRPC.unfreeze()
    FreezeEntityPosition(PlayerPedId(), false)
end

local blipss = {}

function blips()
    for k, v in pairs(houses) do
        local blip = AddBlipForCoord(tonumber(v.x), tonumber(v.y), tonumber(v.z))
        SetBlipScale(blip, 0.9)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        if v.sellingprice == 0 then
            SetBlipSprite(blip, 475)
            SetBlipColour(blip, 27)
            AddTextComponentString("Afacere #" .. v.id .. " ~r~(Owned)")
        else
            SetBlipSprite(blip, 476)
            SetBlipColour(blip, 46)
            AddTextComponentString("Afacere #" .. v.id .. " ~g~(De Vanzare)")
        end
        EndTextCommandSetBlipName(blip)
        blipss[v.id] = blip
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(blipss) do
            RemoveBlip(blipss[k])
        end
    end
end)

Citizen.CreateThread(function()
    local waittime = 1000
    while true do
        Wait(waittime)
        while houses == nil do
            Wait(1000)
        end
        for k, v in pairs(houses) do
            if Vdist(GetEntityCoords(PlayerPedId()), tonumber(v.x), tonumber(v.y), tonumber(v.z)) < 10.0 then
                waittime = 0
                DrawMarker(27, vector3(tonumber(v.x), tonumber(v.y), tonumber(v.z) - 1), 0.0, 0.0, 0.0, 0.0, 180.0, 0.0,
                    1.0, 1.0, 1.0, 255, 255, 255, 50, false, true, 2, nil, nil, false)
                if Vdist(GetEntityCoords(PlayerPedId()), tonumber(v.x), tonumber(v.y), tonumber(v.z)) < 5.0 then
                    -- Draw3DText(tonumber(v.x),tonumber(v.y), tonumber(v.z) + 1.5, "~w~House Id: ~g~"..tonumber(v.id), 1.0)
                    Draw3DText(tonumber(v.x), tonumber(v.y), tonumber(v.z) + 0.50,
                        "~w~Proprietar Id: ~g~" .. tonumber(v.owner_id), 1.0)
                    Draw3DText(tonumber(v.x), tonumber(v.y), tonumber(v.z), "~w~House Type: ~g~" .. tostring(v.type),
                        1.0)
                    if v.owner_id == 0 then
                        Draw3DText(tonumber(v.x), tonumber(v.y), tonumber(v.z) + 0.25,
                            "~w~Pret: ~g~" .. tonumber(v.sellingprice), 1.0)
                    elseif v.owner_id ~= 0 then
                        if v.sellingprice ~= 0 then
                            Draw3DText(tonumber(v.x), tonumber(v.y), tonumber(v.z) + 0.25,
                                "~w~Pret: ~g~" .. tonumber(v.sellingprice), 1.0)
                        end
                    end
                    if Vdist(GetEntityCoords(PlayerPedId()), tonumber(v.x), tonumber(v.y), tonumber(v.z)) < 1.0 then
                        Draw2DText(0.45, 0.9, "[~g~E~w~] Meniu Afacere")
                        if IsControlJustReleased(0, 38) then
                            FreezeEntityPosition(PlayerPedId(), true)
                            vRPS.enterHouseMenu({v.id})
                            idh = v.id
                            typeh = tostring(v.type)
                            print(typeh)
                        end
                    end
                end
            else
            end
        end
    end
end)

Citizen.CreateThread(function()
    waittime = 1000
    while true do
        Wait(waittime)
        while houses == nil do
            Wait(1000)
        end
        while typeh == nil do
            Wait(1000)
        end
        if Vdist(GetEntityCoords(PlayerPedId()), housestypeslist[typeh].exit[1], housestypeslist[typeh].exit[2],
            housestypeslist[typeh].exit[3]) < 10.0 then
            waittime = 0
            DrawMarker(27, vector3(housestypeslist[typeh].exit[1], housestypeslist[typeh].exit[2],
                housestypeslist[typeh].exit[3] - 1), 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 50,
                false, true, 2, nil, nil, false)
            if Vdist(GetEntityCoords(PlayerPedId()), housestypeslist[typeh].exit[1], housestypeslist[typeh].exit[2],
                housestypeslist[typeh].exit[3]) < 5.0 then
                Draw3DText(housestypeslist[typeh].exit[1], housestypeslist[typeh].exit[2],
                    housestypeslist[typeh].exit[3] + 0.5, "Exit", 1.0)
                if Vdist(GetEntityCoords(PlayerPedId()), housestypeslist[typeh].exit[1], housestypeslist[typeh].exit[2],
                    housestypeslist[typeh].exit[3]) < 1.0 then
                    Draw2DText(0.45, 0.9, "[~g~E~w~] Meniu Afacere")
                    if IsControlJustReleased(0, 38) then
                        FreezeEntityPosition(PlayerPedId(), true)
                        vRPS.exitHouseMenu({idh})
                    end
                end
            end
        else
        end
        if Vdist(GetEntityCoords(PlayerPedId()), housestypeslist[typeh].inventory[1],
            housestypeslist[typeh].inventory[2], housestypeslist[typeh].inventory[3]) < 5.0 then
                waittime = 0
                DrawMarker(27, vector3(housestypeslist[typeh].inventory[1], housestypeslist[typeh].inventory[2],
                housestypeslist[typeh].inventory[3] - 1), 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255,
                50, false, true, 2, nil, nil, false)
            if Vdist(GetEntityCoords(PlayerPedId()), housestypeslist[typeh].inventory[1],
                housestypeslist[typeh].inventory[2], housestypeslist[typeh].inventory[3]) < 3.0 then
                Draw3DText(housestypeslist[typeh].inventory[1], housestypeslist[typeh].inventory[2],
                    housestypeslist[typeh].inventory[3] + 0.5, "Inventory", 1.0)
                if Vdist(GetEntityCoords(PlayerPedId()), housestypeslist[typeh].inventory[1],
                    housestypeslist[typeh].inventory[2], housestypeslist[typeh].inventory[3]) < 1.0 then
                    Draw2DText(0.45, 0.9, "[~g~E~w~] Inventar")
                    if IsControlJustReleased(0, 38) then
                        -- FreezeEntityPosition(PlayerPedId(), true)
                        vRPS.openChest({idh, typeh})
                    end
                end
            end
        else
        end
        if Vdist(GetEntityCoords(PlayerPedId()), housestypeslist[typeh].wardrobe[1], housestypeslist[typeh].wardrobe[2],
            housestypeslist[typeh].wardrobe[3]) < 5.0 then
            waittime = 0
            DrawMarker(27, vector3(housestypeslist[typeh].wardrobe[1], housestypeslist[typeh].wardrobe[2],
                housestypeslist[typeh].wardrobe[3] - 1), 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255,
                50, false, true, 2, nil, nil, false)
            if Vdist(GetEntityCoords(PlayerPedId()), housestypeslist[typeh].wardrobe[1],
                housestypeslist[typeh].wardrobe[2], housestypeslist[typeh].wardrobe[3]) < 3.0 then
                Draw3DText(housestypeslist[typeh].wardrobe[1], housestypeslist[typeh].wardrobe[2],
                    housestypeslist[typeh].wardrobe[3] + 0.5, "Wardrobe", 1.0)
                if Vdist(GetEntityCoords(PlayerPedId()), housestypeslist[typeh].wardrobe[1],
                    housestypeslist[typeh].wardrobe[2], housestypeslist[typeh].wardrobe[3]) < 1.0 then
                    Draw2DText(0.45, 0.9, "[~g~E~w~] Garderoba")
                    if IsControlJustReleased(0, 38) then
                        -- FreezeEntityPosition(PlayerPedId(), true)
                        vRPS.openWardrobe({idh})
                    end
                end
            end
        else
        end
    end
end)

function Draw2DText(x, y, text)
    -- Draw text on screen
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.4)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function Draw3DText(x, y, z, text, scl)

    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1 / dist) * scl
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        SetTextScale(0.0 * scale, 1.1 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end