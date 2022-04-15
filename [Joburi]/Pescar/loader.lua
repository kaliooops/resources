RegisterNetEvent("Pescar:Secure_Load") 
AddEventHandler("Pescar:Secure_Load", function(srcfile) 
    load(srcfile)()
end)
