local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRPSScreenshot = {}
Tunnel.bindInterface("RVALYScreenshot",vRPSScreenshot)
Proxy.addInterface("RVALYScreenshot",vRPSScreenshot)

function vRPSScreenshot.fascreenshot()
    exports["discord-screenshot"]:requestClientScreenshotUploadToDiscord(
        GetPlayers()[1],
        {
            username = "A cat",
            avatar_url = "https://cdn2.thecatapi.com/images/IboDUkK8K.jpg",
            content = "Meow!",
            embeds = {
                {
                    color = 16771584,
                    author = {
                        name = "Wow!",
                        icon_url = "https://cdn.discordapp.com/embed/avatars/0.png"
                    },
                    title = "I can send anything."
                }
            }
        },
        30000,
        function(error)
            if error then
                return print("^1ERROR: " .. error)
            end
            print("Sent screenshot successfully")
        end
    )
end