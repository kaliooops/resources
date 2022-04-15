currentWeapon = nil

last_weapon_data = {}

function add_silencer()
    local ped = PlayerPedId()
    local retval, weaponHash = GetCurrentPedWeapon(ped, 1)

    GiveWeaponComponentToPed(ped, weaponHash, GetHashKey("COMPONENT_AT_AR_SUPP_02"))
    GiveWeaponComponentToPed(ped, weaponHash, GetHashKey("COMPONENT_AT_PI_SUPP_02"))
    GiveWeaponComponentToPed(ped, weaponHash, GetHashKey("COMPONENT_AT_PI_SUPP"))
end

function add_grip()
    local ped = PlayerPedId()
    local retval, weaponHash = GetCurrentPedWeapon(ped, 1)
    GiveWeaponComponentToPed(ped, weaponHash, GetHashKey("COMPONENT_AT_AR_AFGRIP"))

end

function add_yusuf()
    local ped = PlayerPedId()
    local retval, weaponHash = GetCurrentPedWeapon(ped, 1)
    -- GiveWeaponComponentToPed(ped, weaponHash, GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))
    -- GiveWeaponComponentToPed(ped, weaponHash, GetHashKey("COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"))
    -- GiveWeaponComponentToPed(ped, weaponHash, GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))
    SetPedWeaponTintIndex(ped, weaponHash, 2)
end

function vRPin.equipWeapon(weapon)

    local ped = PlayerPedId()
    local selectedWeapon = GetSelectedPedWeapon(ped)
    local retval, weaponHash = GetCurrentPedWeapon(ped, 1)

    if not last_weapon_data[weaponHash] then
        last_weapon_data[weaponHash] = {
            silencer = false,
            grip = false,
        }
    end


    print(json.encode(last_weapon_data))


    if weapon == "supressor" then
        last_weapon_data[weaponHash].silencer = true
        add_silencer()
        return
    end

    if weapon == "grip" then
        last_weapon_data[weaponHash].grip = true
        add_grip()
        return
    end


    if weapon == "yusuf" then
        last_weapon_data[weaponHash].yusuf = true
        add_yusuf()
        return
    end

    if currentWeapon == weapon and not (selectedWeapon == GetHashKey('WEAPON_UNARMED')) then
        
        vRP.playAnim({true,{{"reaction@intimidation@1h","outro",1}},false})
        Citizen.Wait(1600)
        ClearPedTasks(ped)
        local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
        RemoveWeaponFromPed(ped, GetHashKey(weapon))
        if currentAmmo > 0 then
            INserver.holstered({currentWeapon, currentAmmo})
        end
        currentWeapon = nil
        vRPin.notify({name = weapon, count = 1, label = Config.Items[weapon][1]}, "Dezechipata")
    else
        RemoveAllPedWeapons(ped, true)
        currentWeapon = weapon
        vRP.playAnim({true,{{"reaction@intimidation@1h","intro",1}},false})
        Citizen.Wait(1600)
        ClearPedTasks(ped)
        GiveWeaponToPed(ped, GetHashKey(weapon), 0, false, true)
        Wait(300)
        retval, weaponHash = GetCurrentPedWeapon(ped, 1)

        print(json.encode(last_weapon_data) .. " silencer " .. tostring(last_weapon_data[weaponHash].silencer) .. " hash " .. tostring(weaponHash))

        if last_weapon_data[weaponHash] then
            if last_weapon_data[weaponHash].silencer then
                add_silencer()
            end
            if last_weapon_data[weaponHash].grip then
                local retval, weaponHash = GetCurrentPedWeapon(PlayerPedId(), 1)
                GiveWeaponComponentToPed(PlayerPedId(), weaponHash, GetHashKey("COMPONENT_AT_AR_AFGRIP"))
            end

            if last_weapon_data[weaponHash].yusuf then
                add_yusuf()   
            end
        end

        vRPin.notify({name = weapon, count = 1, label = Config.Items[weapon][1]}, "Echipata")
    end
end

RegisterCommand('reload',function()
    if currentWeapon ~= nil then
        local ped = PlayerPedId()
        local magazineSize = GetMaxAmmoInClip(ped, GetHashKey(currentWeapon))
        local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
        local toReload = magazineSize

        if currentAmmo > 0 then
            toReload = magazineSize - currentAmmo
        end

        INserver.requestReload({currentWeapon, toReload}, function(ok)
            if ok then
                SetPedAmmo(ped, currentWeapon, magazineSize)
                MakePedReload(ped)
            end
        end)
    end
end)
RegisterKeyMapping('reload', 'Reload your weapon', 'keyboard', 'R')

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if currentWeapon ~= nil then
            local ped = PlayerPedId()
            local currentAmmo = GetAmmoInPedWeapon(ped, GetHashKey(currentWeapon))
            if currentAmmo < 1 then
                GiveWeaponToPed(ped, GetHashKey(currentWeapon), 0, false, true)
            end

            if vRP.isInComa({}) or vRP.isHandcuffed{} or vRP.isJailed({}) then
                currentWeapon = nil
                RemoveAllPedWeapons(PlayerPedId(), true)
            end
        else
            Citizen.Wait(1600)
        end
    end
end)