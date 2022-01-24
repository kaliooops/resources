RegisterNetEvent("shakemycam")
AddEventHandler("shakemycam", function (factor)
    print(factor)
    if factor == 5.0 then
        local f = factor
        CreateThread(function ()
            local x = 0
            while x < 5 do 
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', f)
                Wait(500)
                x = x + 1
            end
        end)
    else
        ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', factor)
    end
end)

CreateThread(function()
    local ped = PlayerPedId()
    local tv
    local p
    local waittime = 1000
    while true do
        Wait(waittime)

        
        local _, wep_hash = GetCurrentPedWeapon(PlayerPedId(), 1 )
        if wep_hash ~= -1569615261 then -- if not fists
            if IsPedShooting(PlayerPedId()) then
                tv = 0
                repeat 
                Wait(0)
                p = GetGameplayCamRelativePitch()
                if GetFollowPedCamViewMode() ~= 4 then
                    SetGameplayCamRelativePitch(p+0.1, 0.2)
                end
                tv = tv+0.1
                until tv >= 0.05
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.07)
            end

            waittime = 0
        else
            if waittime == 1000 then
                waittime = 0
            end
        end
    end
end)
