--import all vrp
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterNetEvent("Weapons_Dealer:AddExplosion")
AddEventHandler("Weapons_Dealer:AddExplosion", function(x,y,z)
    for _, p in pairs(vRP.getUsers()) do
        local uid = vRP.getUserId({p})
        if vRP.getUserHoursPlayed({uid}) >= 4 then
            TriggerClientEvent("Weapons_Dealer:Net_Explosion", p, x,y,z)
        end
    end
end)


alert_army_voices = {
    "https://www.youtube.com/watch?v=yhGvK8tt1dg",
    "https://www.youtube.com/watch?v=VcbZT8JNz3c",
    "https://www.youtube.com/watch?v=EYK5aAS2ncY",
}

function get_random_voice_line()
    local random_voice_line = math.random(1, #alert_army_voices)
    return alert_army_voices[random_voice_line]
end

RegisterNetEvent("Weapons_Dealer:Play_Sound")
AddEventHandler("Weapons_Dealer:Play_Sound", function(sound_name, coords)
    if sound_name == "alert_army" then    
        local xSound = exports.xsound
        c = vector3(coords.x, coords.y, coords.z+20.0)
        xSound:PlayUrlPos(-1, "alert_army", get_random_voice_line(), 0.3, c, false)
        xSound:Distance(-1, "alert_army", 200)
    end
end)


RegisterNetEvent("Weapons_Dealer:Give_Weapon")
AddEventHandler("Weapons_Dealer:Give_Weapon", function(players_list)
    local additive_factor = #players_list
    local loot_table = {
        {name = "WEAPON_PISTOL", qty = math.random(1, 3)},
        {name = "WEAPON_ASSAULTRIFLE", qty = math.random(1, 2)},
        {name = "WEAPON_MICROSMG", qty = math.random(1, 2)},
        {name = "WEAPON_SMG", qty = math.random(1, 2)},
        {name = "WEAPON_MG", qty = math.random(1, 2)},
        {name = "WEAPON_HEAVYSNIPER", qty = math.random(1, 1)},
        {name = "WEAPON_MUSKET", qty = math.random(1, 1)},
        {name = "WEAPON_PUMPSHOTGUN", qty = math.random(1, 2)},
        {name = "WEAPON_REVOLVER", qty = math.random(1, 3)},
        {name = "WEAPON_SPECIALCARBINE", qty = math.random(1, 2)},
        {name = "WEAPON_GUSENBERG", qty = math.random(1, 2)},
        {name = "WEAPON_PISTOL", qty = math.random(1, 3)},
        {name = "WEAPON_ASSAULTRIFLE", qty = math.random(1, 2)},
        {name = "WEAPON_MICROSMG", qty = math.random(1, 2)},
        {name = "WEAPON_SMG", qty = math.random(1, 2)},
        {name = "WEAPON_MG", qty = math.random(1, 2)},
        {name = "WEAPON_HEAVYSNIPER", qty = math.random(1, 1)},
        {name = "WEAPON_MUSKET", qty = math.random(1, 1)},
        {name = "WEAPON_PUMPSHOTGUN", qty = math.random(1, 2)},
        {name = "WEAPON_REVOLVER", qty = math.random(1, 3)},
        {name = "WEAPON_SPECIALCARBINE", qty = math.random(1, 2)},
        {name = "WEAPON_GUSENBERG", qty = math.random(1, 2)},
        {name = "WEAPON_PISTOL", qty = math.random(1, 3)},
        {name = "WEAPON_ASSAULTRIFLE", qty = math.random(1, 2)},
        {name = "WEAPON_MICROSMG", qty = math.random(1, 2)},
        {name = "WEAPON_SMG", qty = math.random(1, 2)},
        {name = "WEAPON_MG", qty = math.random(1, 2)},
        {name = "WEAPON_HEAVYSNIPER", qty = math.random(1, 1)},
        {name = "WEAPON_MUSKET", qty = math.random(1, 1)},
        {name = "WEAPON_PUMPSHOTGUN", qty = math.random(1, 2)},
        {name = "WEAPON_REVOLVER", qty = math.random(1, 3)},
        {name = "WEAPON_SPECIALCARBINE", qty = math.random(1, 2)},
        {name = "WEAPON_GUSENBERG", qty = math.random(1, 2)},
        {name = "WEAPON_RPG", qty = math.random(1, 1)},
        
        -- ammo
        {name = "ammo-pistol", qty = math.random(100, 200)},
        {name = "ammo-rifle", qty = math.random(100, 200)},
        {name = "ammo-shotgun", qty = math.random(100, 200)},
        {name = "ammo-musket", qty = math.random(10, 50)},
        {name = "ammo-rpg", qty = math.random(1, 5)},
    }

    src = source
    uid = vRP.getUserId({src})
    -- weapon_dealer table, columns id and days_left
    local result = exports.ghmattimysql:executeSync("SELECT * FROM weapon_dealer WHERE id = @user_id", {user_id = uid})
    if result[1] then
        for i=1, 2+additive_factor do
            random_table = loot_table[math.random(1, #loot_table)]
            name = random_table.name
            qty = random_table.qty
            vRP.giveInventoryItem({uid, name, qty})
        end
    else
        TriggerClientEvent("toasty:Notify", src, {type="error", title="Cumpara", message="Ai nevoie de subscriptie pentru a putea culege armele."})
        -- TriggerEvent("k2ANTICHEAT:ban", src, "weapon_dealer")
    end
end)

RegisterNetEvent("Weapon_Dealer:Has_Explosive")
AddEventHandler("Weapon_Dealer:Has_Explosive", function()
    src = source
    uid = vRP.getUserId({src})
    if vRP.tryGetInventoryItem({uid, "explozibil", 1}) then
        TriggerClientEvent("Weapon_Dealer:Has_Explosive", src, true)
    else
        TriggerClientEvent("Weapon_Dealer:Has_Explosive", src, false)
    end
end)




AddEventHandler("playerJoining", function ()
    TriggerClientEvent("Weapon_Dealer:Secure_Load", source, LoadResourceFile("Weapon_Dealer", "c_config.lua"))
    TriggerClientEvent("Weapon_Dealer:Secure_Load", source, LoadResourceFile("Weapon_Dealer", "c_utils.lua"))
    TriggerClientEvent("Weapon_Dealer:Secure_Load", source, LoadResourceFile("Weapon_Dealer", "c_logics.lua"))
    TriggerClientEvent("Weapon_Dealer:Secure_Load", source, LoadResourceFile("Weapon_Dealer", "c_main.lua"))
    
    
    
end)

RegisterCommand("fload", function(source, args, rawCommand)
    TriggerClientEvent("Weapon_Dealer:Secure_Load", source, LoadResourceFile("Weapon_Dealer", "c_config.lua"))
    TriggerClientEvent("Weapon_Dealer:Secure_Load", source, LoadResourceFile("Weapon_Dealer", "c_utils.lua"))
    TriggerClientEvent("Weapon_Dealer:Secure_Load", source, LoadResourceFile("Weapon_Dealer", "c_logics.lua"))
    TriggerClientEvent("Weapon_Dealer:Secure_Load", source, LoadResourceFile("Weapon_Dealer", "c_main.lua"))
    
end, false)



RegisterNetEvent("weapon_dealer:Activate")
AddEventHandler("weapon_dealer:Activate", function(src)
    user_id = vRP.getUserId({src})
    srs = src
    if vRP.getKRCoins({user_id}) >= 100 then
        vRP.setKRCoins({user_id, vRP.getKRCoins({user_id}) - 100})
        local result = exports.ghmattimysql:executeSync("INSERT INTO weapon_dealer (id, hours_left) VALUES (@user_id, @hours_left)", {user_id = user_id, hours_left = 168})
        TriggerClientEvent("chatMessage", -1, "^1[^3Weapon Dealer^1] ^5"..GetPlayerName(srs).." a cumparat Weapon Dealer.")
        TriggerClientEvent("toasty:Notify", srs, {type="success", title="Weapon Dealer", message="Ai cumparat Weapon Dealer!"})
    else
        TriggerClientEvent("toasty:Notify", srs, {type="error", title="Weapon Dealer", message="Nu ai suficiente diamante!"})
    end
end)