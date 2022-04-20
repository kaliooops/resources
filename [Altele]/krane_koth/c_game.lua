local first_spawn = true
RegisterNetEvent("krane_koth:Spawn_Player")
AddEventHandler("krane_koth:Spawn_Player", function()
    SetEntityHealth(PlayerPedId(), pregame.selected_class_health)
    SetPedArmour(PlayerPedId(), pregame.selected_class_armor)
    x,y,z = Config.Spawn_Point.x, Config.Spawn_Point.y, Config.Spawn_Point.z
    SetEntityCoords(PlayerPedId(), x, y, z)
    GiveWeaponToPed(PlayerPedId(), GetHashKey("GADGET_PARACHUTE"), 1, false, true)
    if first_spawn then
        TriggerEvent("toasty:Notify", {type="info", title="KOTH", message = "scrie /kothleave pentru a iesi din joc"})
        TriggerEvent("chatMessage", "^1[^2King of the Hill^1]", {255, 255, 255}, "^0 Scrie /kothleave pentru a iesi din joc.")
        first_spawn = false
    end
end)


RegisterNetEvent("krane_koth:Finish_game")
AddEventHandler("krane_koth:Finish_game", function()
    SetEntityCoords(PlayerPedId(), 207.6552734375,-70.153923034668,70.697982788086, 0, 0, 0, 0)
    SetEntityHealth(PlayerPedId(), 200)
    first_spawn = true
    CreateThread(function()
        for i=1,5 do
            Wait(1000)
            GiveWeaponToPed(PlayerPedId(), GetHashKey("weapon_unarmed"), 1, false, true)
            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), true)
        end
    end)

    pregame.is_inside = false
    pregame.is_in_character_selection_screen = false
    pregame.is_playing_game = false
    Change_Clothes("1")
    SendNUIMessage({
        type="cleanup"
    })
end)

RegisterCommand("x", function()
    TriggerEvent("krane_koth:Killed_Someone", "muie")
end, false)

RegisterNetEvent("krane_koth:Killed_Someone")
AddEventHandler("krane_koth:Killed_Someone", function(victim_name)
    if pregame.is_playing_game then
        CreateThread(function()
            soundlink = "https://www.youtube.com/watch?v=M59BZwMLjuE"
            local xSound = exports.xsound
            xSound:PlayUrl("killed_somone", soundlink, 1.0, false, {})
        end)
        
        Wait(500)
        SendNUIMessage({
            type="kill",
            name=victim_name
        })
    end
end)

--while in game
CreateThread(function()
    while true do
        Wait(1000)
        while pregame.is_playing_game do
            Wait(0)

            kraneUtility.Draw_Hud_Text(0.5,0.01, 0.0, 0.0, 0.5, "Playerii: ~w~" .. pregame.ingame_players_count, utility.rgb_rainbow.r, utility.rgb_rainbow.g, utility.rgb_rainbow.b,200, false, 1, 1) --should not be used, its deprecated

            if GetEntityHealth(PlayerPedId()) <= 121 then
                Wait(5000)
                TriggerEvent("krane_koth:Spawn_Player")
            end

            local _, weaponHash = GetCurrentPedWeapon(PlayerPedId(), 1)
            if weaponHash ~= GetHashKey("GADGET_PARACHUTE") then
                GiveWeaponToPed(PlayerPedId(), GetHashKey(pregame.selected_class_weapon), 250, false, true)
            end

            --hook "R" key
            if IsControlJustPressed(1, 80) then
                GiveWeaponToPed(PlayerPedId(), GetHashKey(pregame.selected_class_weapon), 250, false, true)
                MakePedReload(PlayerPedId())
            end

            

        end
    end
end)
