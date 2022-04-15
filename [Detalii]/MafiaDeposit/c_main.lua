local cfg = {}

cfg.safes = {
    ['KMN Gang'] = vector3(-3028.5529785156,73.700874328613,12.902229309082), --k am k asta gang
    ['Bloods'] = vector3(-1802.699584961,411.37338256836,128.30728149414), -- bloods
    ['Clanu` Tiganilor'] = vector3(-1588.8607177734,-81.632049560546,54.3344039917), -- bloods
    ['Los Vagos'] = vector3(-1064.10,-1663.45,4.56), -- Vagos
    ['Ballas'] = vector3(131.6160736084,-1961.6796875,18.859014511108),
    
}

CreateThread(function()

    while true do
        Wait(1000)
        for k,v in pairs(cfg.safes) do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local dist = #(coords - v)

            while dist < 2.0 do
                Wait(0)
                coords = GetEntityCoords(ped)
                dist = #(coords - v)
                k_draw3DText(v.x, v.y, v.z, '~w~[~g~E~w~] ~y~Depozit ~w~' .. k)
                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent("maf_deposit:openMenu",k)
                end
            end
        end
    end
end)