tvpos = {x=-3238.5815429688,y=-444.78387451172,z=213.20399475098}

CreateThread(function()
    mhash = GetHashKey("p_cs_leaf_s")
    RequestModel(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Wait(1)
    end

    print("loaded model")

    local o = CreateObject(mhash, tvpos.x, tvpos.y, tvpos.z, false, false, true)
    SetEntityHeading(o, 338.12)
    FreezeEntityPosition(o, true)
end)

RegisterCommand("__kmnez", function(x, args, z)
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
    SetEntityCoords(PlayerPedId(), tvpos.x, tvpos.y, tvpos.z, 0,0,0, false)
    Wait(500)
    ExecuteCommand("tv " .. args[1])
    Wait(300)
    SetEntityCoords(PlayerPedId(), x, y, z, 0,0,0, false)
end, false)
