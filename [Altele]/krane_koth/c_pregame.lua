kraneUtility = module("kraneCore", "classes/c_kraneUtility")
kranePed = module("kraneCore", "classes/c_kranePED")
kraneVeh = module("kraneCore", "classes/c_kraneVehicle")
kraneObject = module("kraneCore", "classes/c_kraneObject")

RegisterNUICallback("Selected_Class", function(data)
    if data.class_chosen == "scout" then
        pregame.selected_class_health = 200
        pregame.selected_class_armor = 0
        pregame.selected_class_weapon = "WEAPON_SMG"
    end

    if data.class_chosen == "gunner" then
        pregame.selected_class_health = 200
        pregame.selected_class_armor = 50
        pregame.selected_class_weapon = "WEAPON_DOUBLEACTION"        
    end

    if data.class_chosen == "assault" then
        pregame.selected_class_health = 200
        pregame.selected_class_armor = 30
        pregame.selected_class_weapon = "WEAPON_ASSAULTRIFLE"
    end

    if data.class_chosen == "heavy" then
        pregame.selected_class_health = 200
        pregame.selected_class_armor = 200
        pregame.selected_class_weapon = "WEAPON_MG"
    end

    if data.class_chosen == "sniper" then
        pregame.selected_class_health = 200
        pregame.selected_class_armor = 0
        pregame.selected_class_weapon = "WEAPON_HEAVYSNIPER"
    end

    Change_Clothes(data.class_chosen)

end)

pregame = {}

pregame.is_inside = false

pregame.is_in_character_selection_screen = false

pregame.is_playing_game = false

pregame.selected_class_health = 200
pregame.selected_class_armor = 0
pregame.selected_class_weapon = "WEAPON_PISTOL"

pregame.ingame_players_count = 0

--pre-game
CreateThread(function()
    lobby_x, lobby_y, lobby_z = Config.Pregame_Lobby_Position.x, Config.Pregame_Lobby_Position.y, Config.Pregame_Lobby_Position.z
    CreateThread(function()
        while true do
            Wait(1000)
            if pregame.is_inside then
                pregame.is_inside = false
                TriggerServerEvent("krane_koth:Player_Left_Lobby")
            end
            
            while Vdist(GetEntityCoords(PlayerPedId()), lobby_x, lobby_y, lobby_z) < 20 do
                Wait(0)
                if pregame.is_inside == false then
                    pregame.is_inside = true
                    TriggerServerEvent("krane_koth:Player_Joined_Lobby")
                end
                if not pregame.is_in_character_selection_screen then
                    kraneUtility.Draw_Hud_Text(0.5,0.01, 0.0, 0.0, 1.0, "Urmatorul meci in: ~w~" .. convert_miliseconds_to_minutes(pregame.timer), utility.rgb_rainbow.r, utility.rgb_rainbow.g, utility.rgb_rainbow.b,200, false, 1, 1) --should not be used, its deprecated
                end
                kraneUtility.DrawText3D(lobby_x, lobby_y, lobby_z+2.0, "Playeri: ~w~" .. tostring(pregame.players_count), 5.0, utility.rgb_rainbow.r, utility.rgb_rainbow.g, utility.rgb_rainbow.b) --rgb optional
                kraneUtility.Generic_Marker(lobby_x, lobby_y, lobby_z, utility.rgb_rainbow.r, utility.rgb_rainbow.g, utility.rgb_rainbow.b, 10.0, 10.0, 0.3) --rgb optional
            end
        end
    end)
end)


RegisterNetEvent("krane_koth:Update_Pregame_Timer")
AddEventHandler("krane_koth:Update_Pregame_Timer", function(data)
    if data.key == "timer" then
        pregame.timer = data.value
    end
    
    if data.key == "players_count" then
        pregame.players_count = data.value
    end

    if data.key == "is_in_character_selection_screen" then
        pregame.is_in_haracter_selection_screen = data.value
    end

    if data.key == "is_playing_game" then
        pregame.is_playing_game = data.value
        TriggerEvent("krane_koth:Spawn_Player")
        TriggerEvent("krane_koth:Close_Character_Selection_Screen")
    end

    if data.key == "ingame_players_count" then
        pregame.ingame_players_count = data.value
    end
end)