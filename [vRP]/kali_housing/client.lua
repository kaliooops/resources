vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP", "lfj_housing")
vRPhouse = Tunnel.getInterface("lfj_housing", "lfj_housing")
vRPC = {}
Tunnel.bindInterface("lfj_housing", vRPC)
vRPS = Tunnel.getInterface("lfj_housing", "lfj_housing")

housestypeslist = {

    ["Ave"] = {
        exit = {-467.51974487305,-708.71990966797,77.088912963867},
        inventory = {-466.94387817383,-700.59442138672,77.095520019531},
        wardrobe = {-466.77813720703,-687.98785400391,70.890403747559}
    },
    ["Integrity"] = {
        exit = {-25.509645462036,-607.33001708984,100.23720550537},
        inventory = {-21.650575637817,-599.77124023438,100.24155426025},
        wardrobe = {-17.703319549561,-588.00286865234,94.036338806152}
    },
    ["Low"] = {
        exit = {265.99789428711,-1002.9628295898,-99.008674621582},
        inventory = {265.89581298828,-999.25262451172,-99.008674621582},
        wardrobe = {259.73986816406,-1003.9325561523,-99.008674621582}
    },
    ["Weazel"] = {
        exit = {-907.68957519531,-453.55035400391,126.53206634521},
        inventory = {-899.98187255859,-450.69653320313,126.54312133789},
        wardrobe = {-889.05023193359,-444.46182250977,120.33790588379}
    },
    ["Richards"] = {
        exit = {-907.12536621094,-372.48165893555,109.44027709961},
        inventory = {-914.83441162109,-375.36795043945,109.44898223877},
        wardrobe = {-925.89654541016,-381.40393066406,103.24378204346}
    },
    ["Del"] = {
        exit = {-1450.0091552734,-525.86877441406,69.556587219238},
        inventory = {-1457.3240966797,-529.74517822266,69.565299987793},
        wardrobe = {-1467.5614013672,-537.50366210938,63.360126495361}
    },
    ["Tinsel"] = {
        exit = {-596.40277099609,56.105251312256,108.03133392334},
        inventory = {-604.69458007813,57.107929229736,108.03573608398},
        wardrobe = {-617.44274902344,56.765182495117,101.83054351807}
    },
    ["Eclipse"] = {
        exit = {-774.19219970703,342.2014465332,196.68617248535},
        inventory = {-766.0087890625,331.42572021484,196.08598327637},
        wardrobe = {-763.59106445313,329.23403930664,199.48638916016}
    },
    ["Low2"] = {
        exit = {346.46792602539,-1012.4415893555,-99.196281433105},
        inventory = {351.74472045898,-999.21624755859,-99.196159362793},
        wardrobe = {350.55114746094,-993.58935546875,-99.195816040039}
    },
    ["House1"] = {
        exit = {-174.32986450195,497.52966308594,137.66902160645},
        inventory = {-174.58013916016,493.87899780273,130.04351806641},
        wardrobe = {-167.19668579102,487.99975585938,133.84378051758}
    },
    ["House2"] = {
        exit = {341.43780517578,437.3385925293,149.39422607422},
        inventory = {338.23623657227,437.12780761719,141.77075195313},
        wardrobe = {334.5251159668,428.71600341797,145.57089233398}
    },
    ["House3"] = {
        exit = {373.5500793457,423.35952758789,145.90919494629},
        inventory = {376.80319213867,428.98178100586,138.2999420166},
        wardrobe = {374.48107910156,411.89239501953,142.10011291504}
    },
    ["House4"] = {
        exit = {-682.07635498047,592.24945068359,145.39300537109},
        inventory = {-680.82458496094,589.13586425781,137.76965332031},
        wardrobe = {-671.80682373047,587.52380371094,141.56988525391}
    },
    ["House5"] = {
        exit = {-759.02825927734,619.04925537109,144.15390014648},
        inventory = {-762.18469238281,618.81945800781,136.53051757813},
        wardrobe = {-767.08612060547,610.87506103516,140.33073425293}
    },
    ["House6"] = {
        exit = {-859.84997558594,690.89971923828,152.86027526855},
        inventory = {-858.23937988281,697.28771972656,145.25299072266},
        wardrobe = {-855.28070068359,680.03491210938,149.05294799805}
    },
    ["House7"] = {
        exit = {117.14981842041,559.662109375,184.30487060547},
        inventory = {118.58249664307,565.98443603516,176.69715881348},
        wardrobe = {121.91715240479,548.36322021484,180.49716186523}
    },
    ["House8"] = {
        exit = {-1289.7893066406,449.74935913086,97.902503967285},
        inventory = {-1287.8046875,455.54931640625,90.294692993164},
        wardrobe = {-1286.1428222656,438.15322875977,94.094779968262}
    },
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
        -- SetBlipColour(blip, 25)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        if v.sellingprice == 0 then
            SetBlipColour(blip, 27)
            SetBlipSprite(blip, 40)
            AddTextComponentString("Casa #" .. v.id .. " ~r~(Owned)")
        else
            SetBlipColour(blip, 25)
            SetBlipSprite(blip, 375)
            AddTextComponentString("Casa #" .. v.id .. " ~g~(De Vanzare)")
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
                        Draw2DText(0.45, 0.9, "[~g~E~w~] Meniul Casei")
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
                    Draw2DText(0.45, 0.9, "[~g~E~w~] Meniul Casei")
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