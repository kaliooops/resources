

local pThread = Citizen.CreateThread
local TequilaClub = {
    Location = {954.58361816406,28.191989898682,76.991333007813},
    Radius = 1000
}

local Dresser = {
    DressLocation = {939.21350097656,49.592361450195,80.291709899902},
    Dressed = false,    
    WorkClothes = {
        mask = {1, 107, 11}, 
        jacket = {11, 138, 0},
        undershirts = {8, -1, 0},
        armsgloves = {3, 30},
        pants = {4, 28},
        shoes = {6, 28}
    },
    cleanClothes = {}
}

local angajat = false

local function payCheck()
    TriggerServerEvent("bodyguard_sendPlayerCurrentJob")
    if angajat then
        vRPSjobs.finishBodyGuardJob({}) 
    end
end


function get_p_clothes()
    local ped = PlayerPedId()
    Dresser.cleanClothes.hat = GetPedPropIndex(ped, 0)
    Dresser.cleanClothes.hat_tx = GetPedPropTextureIndex(ped, 0)

    Dresser.cleanClothes.jacket = GetPedDrawableVariation(ped, 11)
    Dresser.cleanClothes.jacket_tx = GetPedTextureVariation(ped, 11)
    
    Dresser.cleanClothes.undershirt = GetPedDrawableVariation(ped, 8)
    Dresser.cleanClothes.undershirt_tx = GetPedTextureVariation(ped, 8)

    Dresser.cleanClothes.armsgloves = GetPedDrawableVariation(ped, 3)
    Dresser.cleanClothes.armsgloves_tx = GetPedTextureVariation(ped, 3)

    Dresser.cleanClothes.pants = GetPedDrawableVariation(ped, 4)
    Dresser.cleanClothes.pants_tx = GetPedTextureVariation(ped, 4)

    Dresser.cleanClothes.shoes = GetPedDrawableVariation(ped, 6)
    Dresser.cleanClothes.shoes_tx = GetPedTextureVariation(ped, 6)

    Dresser.cleanClothes.mask = GetPedDrawableVariation(ped, 1)
    Dresser.cleanClothes.mask_tx = GetPedTextureVariation(ped, 1)
end
get_p_clothes()

local function DressForTheJob()
    get_p_clothes()
    Dresser.Dressed = true
    local ped = PlayerPedId()


    -- SetPedComponentVariation(ped, Dresser.WorkClothes.mask[1], Dresser.WorkClothes.mask[2], Dresser.WorkClothes.mask[3], 0)
    -- SetPedComponentVariation(ped, Dresser.WorkClothes.jacket[1] ,Dresser.WorkClothes.jacket[2] ,Dresser.WorkClothes.jacket[3], 0)
    -- SetPedComponentVariation(ped, Dresser.WorkClothes.undershirts[1] ,Dresser.WorkClothes.undershirts[2], Dresser.WorkClothes.undershirts[3], 0)
    -- SetPedComponentVariation(ped, Dresser.WorkClothes.armsgloves[1], Dresser.WorkClothes.armsgloves[2], 0, 0)
    -- SetPedComponentVariation(ped, Dresser.WorkClothes.pants[1], Dresser.WorkClothes.pants[2], 0, 0)
    -- SetPedComponentVariation(ped, Dresser.WorkClothes.shoes[1],Dresser.WorkClothes.shoes[2], 0, 0)
    TriggerServerEvent("bodyguard_SetOnDuty")
    -- GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL50"), 21, false, false)
    GiveWeaponToPed(ped, GetHashKey("WEAPON_STUNGUN"), 1, false, false)
    GiveWeaponToPed(ped, GetHashKey("weapon_nightstick"), 1, false, true)
    
end

local function RevertClothing()
    Dresser.Dressed = false
    local ped = PlayerPedId()

    --revert clothing
    -- SetPedPropIndex(ped, 0, Dresser.cleanClothes.hat, Dresser.cleanClothes.hat_tx, true)
    -- SetPedComponentVariation(ped, 11, Dresser.cleanClothes.jacket, Dresser.cleanClothes.jacket_tx, 0)
    -- SetPedComponentVariation(ped, 8, Dresser.cleanClothes.undershirt, Dresser.cleanClothes.undershirt_tx, 0)
    -- SetPedComponentVariation(ped, 3, Dresser.cleanClothes.armsgloves, Dresser.cleanClothes.armsgloves_tx, 0)
    -- SetPedComponentVariation(ped, 4, Dresser.cleanClothes.pants, Dresser.cleanClothes.pants_tx, 0)
    -- SetPedComponentVariation(ped, 6, Dresser.cleanClothes.shoes, Dresser.cleanClothes.shoes_tx, 0)
    -- SetPedComponentVariation(ped, 1, Dresser.cleanClothes.mask, Dresser.cleanClothes.mask_tx, 0)

    -- RemoveWeaponFromPed(ped --[[ Ped ]], GetHashKey("WEAPON_PISTOL50") --[[ Hash ]])
    RemoveWeaponFromPed(ped --[[ Ped ]], GetHashKey("WEAPON_STUNGUN") --[[ Hash ]])
    RemoveWeaponFromPed(ped --[[ Ped ]], GetHashKey("weapon_nightstick") --[[ Hash ]])
    TriggerServerEvent("bodyguard_SetOffDuty")

end



local function job()
    TriggerServerEvent("bodyguard_sendPlayerCurrentJob")

    pThread(function () -- clothings
        while true and angajat do

            local distance_from_dresser = Vdist2(GetEntityCoords(GetPlayerPed(-1)), Dresser.DressLocation[1], Dresser.DressLocation[2], Dresser.DressLocation[3])
            if distance_from_dresser <= 200.0 then
                Wait(0)
                Draw3DTextC(Dresser.DressLocation[1], Dresser.DressLocation[2], Dresser.DressLocation[3], "Echipament [~b~E~w~] ~r~BodyGuard", 3, 1)
                if IsControlJustPressed(1, 51) then
                    if Dresser.Dressed then RevertClothing() else  DressForTheJob() end
                end
            else
                Wait(2000)
            end

        end
    end)


    pThread(function () -- out of bounds
        while true and angajat do
            Wait(3000)
            while not Dresser.Dressed do Wait(5000) end
            local distance_from_job = Vdist2(GetEntityCoords(GetPlayerPed(-1)), TequilaClub.Location[1], TequilaClub.Location[2], TequilaClub.Location[3])
            if distance_from_job > 4000.0 then
                TriggerEvent("toasty:Notify", {type = "info", title="Body Guard", message = "Ai parasit perimetrul"})

            end

            if distance_from_job > 6600.0 then
                TriggerEvent("toasty:Notify", {type = "info", title="BodyGuard", message = "Ai dezamagit angajatorul, ai penalizare $2.000"})
                TriggerServerEvent("bodyguard:penalty")
                RevertClothing()
            end

        end
    end)







    pThread(function () --payday conditions
        s_min = GetClockMinutes()
        s_sec = GetClockSeconds()
        while true and angajat do
            local distance_from_job = Vdist2(GetEntityCoords(GetPlayerPed(-1)), TequilaClub.Location[1], TequilaClub.Location[2], TequilaClub.Location[3])
            Wait(100)
            if ( GetClockMinutes() == s_min+1 and GetClockSeconds() >= s_sec) and distance_from_job < 600.0 and Dresser.Dressed then
                payCheck()
                s_min = GetClockMinutes()
                s_sec = GetClockSeconds()
            end
        end 
    end)
    
end

Citizen.CreateThread(function ()
    while true do
        TriggerServerEvent("bodyguard_sendPlayerCurrentJob")
        Wait(60000)
    end
end)
RegisterNetEvent("bodyguard_getPlayerCurrentJob")
AddEventHandler("bodyguard_getPlayerCurrentJob", function(currentjob)
    if currentjob == "BodyGuard" then angajat = true else angajat = false end
end)


Citizen.CreateThread(function ()
    while not angajat do
        Citizen.Wait(1000)
    end
    job()
end)





