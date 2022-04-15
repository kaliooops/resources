local quests = {
    -- 
    [1] = { title = "Citeste Panoul 📜", description = "In primarie, este la stanga intrarii un panou informativ.", cp_required = 0 },
    [2] = { title = "Creeaza-ti un buletin 💳", description = "La biroul primariei, se poate creea un buletin.", cp_required = 0 },
    [3] = { title = "Inchiriaza Motorul 🏍️", description="Inchiriaza motorul din parcarea de la spawn", cp_required = 0 },
    [4] = { title = "Cumpara un vehicul 🚘", description = "La showroom se poate cumpara un vehicul.", cp_required = 0 },
    [5] = { title = "Angajare 💼", description = "La (k->gps->Job Center) trebuie sa te angajezi ca Pescar.", cp_required = 0 },
    [6] = { title = "Mircea Pescarul ⚓", description = "Vorbeste cu Mircea Pescarul Satului din Paleto.", cp_required = 0 },
    [7] = { title = "Folosirea Sonarului 📡", description = "Descopera adancime de 50m cu ajutorul sonarului.", cp_required = 0 },
    [8] = { title = "Pestele 🐬", description = "Prinde o platica, si du-o lui Mircea.", cp_required = 0 },
    -- [9] = { title = "PUBG 🎮", description = "Participa la un meci de PUBG. (/pubg).", cp_required = 0 },
    [9] = { title = "Rent 🏎️", description = "Foloseste o masina de la Rent.", cp_required = 0 },
    [10] = { title = "Vanator 🏹", description = "Angajeaza-te ca vanator.", cp_required = 0 },
    [11] = { title = "Vanatoarea 🦌", description = "Vaneaza o caprioara.", cp_required = 0 },
    [12] = { title = "Jocurile de Noroc 🎰", description = "Joaca o runda la Pacanele.", cp_required = 0 },
    [13] = { title = "Tuneaza-ti Masina 🧑‍🔧 ", description = "Du-te la tuning, si adauga ceva nou pe masina ta.", cp_required = 0},
    [14] = { title = "Anunta-ti Prezenta 📢", description = "Pune un anuntat la CNN.", cp_required = 0},
    [15] = { title = "Muntele 🗻", description = "Viziteaza muntele Chiliad", cp_required = 0},
    [16] = { title = "La sala 💪", description = "Viziteaza sala LA|Fitness (/gps)", cp_required = 0},
    [17] = { title = "Showroomul Diamant 💎", description = "Viziteaza showroomul cu diamante (/gps)", cp_required = 0},
    [18] = { title = "La Biliard 🎱", description = "Joaca un meci de biliard (/gps).", cp_required = 0},
    [19] = { title = "Distractie ✨", description = "Obtine 10 ore jucate.", cp_required = 0 },
    [20] = { title = "Viata de hot 💰", description = "Angajeaza-te la Car Delivery.", cp_required = 0 },
    [21] = { title = "Giany samsarul 🕵🏻‍♂️", description = "Livreaza o masina lui Giany Versace.", cp_required = 0 },
    [22] = { title = "Minerul", description = "Angajeaza-te ca miner", cp_required = 0},
    [23] = { title = "Aurul", description = "Gaseste minereu de aur", cp_required = 0},
    [24] = { title = "Restaurantele", description = "Angajeaza-te ca livrator de pizza", cp_required = 0},
    [25] = { title = "Vinde Pizza", description = "Ia o pizza de jos, si livreaz-o", cp_required = 0},
    [26] = { title = "Aprovizioneaza Magazine", description = "Livreaza marfa la magazin.", cp_required = 0}

    -- TriggerEvent("Achievements:UP_Current_Progress", user_id, "Gaseste minereu de aur")
    -- TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Ia o pizza de jos, si livreaz-o")
}

--AddEventHandler("Achievements:UP_Current_Progress", function(user_id, quest_name)

--import all vRP related
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

function Update_User(source)
    user_id = vRP.getUserId({source})
    src = source
    local result = exports.ghmattimysql:executeSync("SELECT progress FROM achievements WHERE user_id = @user_id", {user_id = user_id})
    if result[1] then
        TriggerClientEvent("Achievements:Update", src, result[1].progress .. "/" .. #quests, quests[result[1].progress].title, quests[result[1].progress].description)
    else
        TriggerClientEvent("Achievements:Update", src, 1 .. "/" .. #quests, quests[1].title, quests[1].description)
        exports.ghmattimysql:executeSync("INSERT INTO achievements (user_id, progress, current_progress) VALUES (@user_id, @progress, @current_progress)", {user_id = user_id, progress = 1, current_progress = 0})
    end
end

function Progress_Up(source, reward)
    local user_id = vRP.getUserId({source})
    --update progress + 1
    local result = exports.ghmattimysql:executeSync("SELECT progress FROM achievements WHERE user_id = @user_id", {user_id = user_id})
    if result[1] then
        local progress = result[1].progress + 1
        if progress > #quests then
            progress = #quests
        end
        exports.ghmattimysql:executeSync("UPDATE achievements SET progress = @progress WHERE user_id = @user_id", {user_id = user_id, progress = progress})
        exports.ghmattimysql:executeSync("UPDATE achievements SET current_progress = 0 WHERE user_id = @user_id", {user_id = user_id})
        TriggerClientEvent("Achievements:Update", source, progress .. "/" .. #quests, quests[progress].title, quests[progress].description)
    end
    local result = exports.ghmattimysql:executeSync("SELECT progress FROM achievements WHERE user_id = @user_id", {user_id = user_id})
    if result[1] then   
        local prog = result[1].progress 
        if prog == 26 then
            print(prog)
            vRP.giveKRCoins({user_id, 3})
            TriggerClientEvent("toasty:Notify", source, {type="success", title="Achievement", message="Ai primit 3 Cristale!"})
            else
            vRP.giveMoney({user_id, 2000})
            vRP.giveKRCoins({user_id, 3})
            TriggerClientEvent("toasty:Notify", source, {type="success", title="Achievement", message="Ai primit 2000 si 3 Cristale!"})
        end
    end
end

function get_Data(uid)
    return exports.ghmattimysql:executeSync("SELECT * FROM achievements WHERE user_id = @user_id", {user_id = uid})[1]
end

RegisterNetEvent("Achievements:Progress_Up")
AddEventHandler("Achievements:Progress_Up", function()
    Progress_Up(source)
end)


RegisterCommand("acup", function(source, args, rawCommand)
    Progress_Up(source)
end, false)


RegisterNetEvent("Achievements:Update")
AddEventHandler("Achievements:Update", function()
    Update_User(source)
end)

function UP_Current_Progress(source, user_id, quest_name)
    local data = get_Data(user_id)
    print(json.encode(data))

    if quest_name == quests[data.progress].description then
        if data.current_progress >= quests[data.progress].cp_required then
            Progress_Up(source, quests[data.progress].reward)
        else
            data.current_progress = data.current_progress + 1
            exports.ghmattimysql:executeSync("UPDATE achievements SET current_progress = @current_progress WHERE user_id = @user_id", {user_id = user_id, current_progress = data.current_progress})
            Update_User(source)
        end 
    end
end

RegisterNetEvent("Achievements:UP_Current_Progress")
AddEventHandler("Achievements:UP_Current_Progress", function(user_id, quest_name)
   
    -- if "source=" is found on user_id then get the number after it, if no source= is found then 
    if string.find(user_id, "source=") then
        user_id = vRP.getUserId({source})
        UP_Current_Progress(source, user_id, quest_name)
        print("upped from source " .. user_id)
    else
        UP_Current_Progress(vRP.getUserSource({user_id}), user_id, quest_name)
        print("normal up" .. user_id )
    end

end)