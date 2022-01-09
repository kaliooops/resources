local cfg = {}

cfg.safes = {
    ['KMN Gang'] = vector3(-3028.5529785156,73.700874328613,12.902229309082), --k am k asta gang
    -- ['Bloods'] = vector3(-1520.4436035156,849.01989746094,181.59484863282) -- bloods
    
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