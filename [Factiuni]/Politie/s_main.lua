

RegisterNetEvent("Politie:Radar")
AddEventHandler("Politie:Radar", function (player)
    TriggerClientEvent("Politie:Radar", player, player)
end)

function sendToDiscord(name, message)
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest('https://discord.com/api/webhooks/923717211120619531/zkGU7W1PU7rGJ_Fd3PfkPBZJnxeUNMV7xS8sdDTmDnAxLW0i8kJ_6bOTigSGO8z6aTYF', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
  end

RegisterNetEvent("Politie:SendToDiscord")
AddEventHandler("Politie:SendToDiscord", function (string)
    sendToDiscord("[POLITIE]", string)
    send_player_screen(string)
end)

function send_player_screen(string)
    exports["discord-screenshot"]:requestCustomClientScreenshotUploadToDiscord(
        GetPlayers()[1],
        "https://discord.com/api/webhooks/923717211120619531/zkGU7W1PU7rGJ_Fd3PfkPBZJnxeUNMV7xS8sdDTmDnAxLW0i8kJ_6bOTigSGO8z6aTYF",
        {
            encoding = "png",
            quality = 1
        },
        {
            username = "Politie",
            avatar_url = "https://images-ext-1.discordapp.net/external/2vwlAkKAR5S-ZXUVOhaoEvUkOw_JJ2xldQlhUxySZUE/https/media.discordapp.net/attachments/826161097857171497/914774950244663296/discordprofile.png",
            content = string,
        },
        30000,
        function(error)
            if error then
                return print("^1ERROR: " .. error)
            end
        end
    )
end
