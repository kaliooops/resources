--impport all vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterNetEvent("Atasamente:Has_Finished")
AddEventHandler("Atasamente:Has_Finished", function()
    src = source
    uid = vRP.getUserId({src})
    local result = exports.ghmattimysql:executeSync("SELECT completed_tutorial FROM atasamente WHERE uid = @uid", {uid = uid})
    if result then
        if result[1] then
            TriggerClientEvent("Atasamente:Has_Finished", src, true)
        else
            TriggerClientEvent("Atasamente:Has_Finished", src, false)
        end
    else
        TriggerClientEvent("Atasamente:Has_Finished", src, false)
    end
end)

RegisterNetEvent("Atasamente:Tutorial_Completed")
AddEventHandler("Atasamente:Tutorial_Completed", function()
    src = source
    uid = vRP.getUserId({src})
    local result = exports.ghmattimysql:executeSync("SELECT completed_tutorial FROM atasamente WHERE uid = @uid", {uid = uid})
    if result then
        if not result[1] then
            exports.ghmattimysql:execute("INSERT INTO atasamente (uid, completed_tutorial) VALUES (@uid, 1)", {uid = uid})
        end
    end
end)



AddEventHandler("playerJoining", function ()
    TriggerClientEvent("Atasamente:Secure_Load", source, LoadResourceFile("Atasamente", "c_main.lua"))
    TriggerClientEvent("Atasamente:Secure_Load", source, LoadResourceFile("Atasamente", "c_config.lua"))    
end)

RegisterCommand("fload", function(source, args, rawCommand)
    TriggerClientEvent("Atasamente:Secure_Load", source, LoadResourceFile("Atasamente", "c_main.lua"))
    TriggerClientEvent("Atasamente:Secure_Load", source, LoadResourceFile("Atasamente", "c_config.lua"))
end, false)


local function buildSafeMenu(player)
	local menu = {name = "Atasamente",css={top="75px",header_color="rgba(0,125,255,0.75)"}}
	menu.name = "Atasamente"

	local function ch_silencer(player,choice) 
    	local user_id = vRP.getUserId({player})
		if user_id ~= nil then
            a = vRP.tryGetInventoryItem({user_id,"bucata_de_fier",100})
            b = vRP.tryGetInventoryItem({user_id,"bucata_de_argint",30})
            if a and b then
                vRP.giveInventoryItem({user_id, "supressor", 1})
            end
            vRP.closeMenu({player})
        end
    end

    local function ch_gold(player,choice) 
    	local user_id = vRP.getUserId({player})
		if user_id ~= nil then
            a = vRP.tryGetInventoryItem({user_id,"bucata_de_aur",350})
            if a then
                vRP.giveInventoryItem({user_id, "yusuf", 1})
            end
            vRP.closeMenu({player})
        end
    end

	menu['1.Silencer'] = {ch_silencer,"100 Fier, 30 Argint"}
	menu['2.Acoperitor de Aur'] = {ch_gold,"350 Aur"}

	vRP.openMenu({player,menu})
end

RegisterServerEvent("Atasamente:openMenu")
AddEventHandler("Atasamente:openMenu", function(name)
	local user_id = vRP.getUserId({source})
    buildSafeMenu(source)
end)
