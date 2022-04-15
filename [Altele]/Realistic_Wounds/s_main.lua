
AddEventHandler("playerJoining", function ()
    TriggerClientEvent("Realistic_wounds:Secure_Load", source, LoadResourceFile("Realistic_Wounds", "c_main.lua"))
    TriggerClientEvent("Realistic_wounds:Secure_Load", source, LoadResourceFile("Realistic_Wounds", "c_config.lua"))
    
end)

RegisterCommand("fload", function(source, args, rawCommand)
    TriggerClientEvent("Realistic_wounds:Secure_Load", source, LoadResourceFile("Realistic_Wounds", "c_main.lua"))
    TriggerClientEvent("Realistic_wounds:Secure_Load", source, LoadResourceFile("Realistic_Wounds", "c_config.lua"))
    
end, false)
