--import all vrp
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

function element_in_table(element, table) 
    for i = 1, #table, 1 do
        if table[i] == element then
            return true
        end
    end
    return false
end

local Active_Codes = {
    ["majock2"] = {diamante = 30, bani = 10000},
    ["1234K2"] = {diamante = 10, bani = 4000},
    ["brigada"] = {diamante = 20, bani = 5000},
    ['pitick2'] = {diamante = 10, bani = 3000},
    ['mbmk2'] = {diamante = 10, bani = 3000},
    ['vreaupek2'] = {diamante = 10, bani = 3000},

    
    ['haipek2'] = {diamante = 10, bani = 3000},


}

function Activate_Referral(user_id, code)
    local src = vRP.getUserSource({user_id})
    local result = exports.ghmattimysql:executeSync("SELECT code FROM referral WHERE id = @user_id", {user_id = user_id})
    if result[1] then
        TriggerClientEvent("toasty:Notify", src, {type="error", title="Referral", message="Ai deja un cod activ: " .. result[1].code})
    else
        if Active_Codes[code] then
            exports.ghmattimysql:execute("INSERT INTO referral (id, code) VALUES (@user_id, @code)", {user_id = user_id, code = code})
            TriggerClientEvent("toasty:Notify", src, {type="success", title="Referral", message="Ai activat cu succes codul: " .. code})
            TriggerClientEvent("toasty:Notify", src, {type="success", title="Referral", message="Ai primit " .. Active_Codes[code].diamante .. " diamante si " .. Active_Codes[code].bani .. " bani"})
            vRP.giveMoney({user_id, Active_Codes[code].bani})
            vRP.giveKRCoins({user_id, Active_Codes[code].diamante})
            return true
        else
            TriggerClientEvent("toasty:Notify", src, {type="error", title="Referral", message="Acest cod este gresit: " .. code})
            return false
        end
    end
end

RegisterNetEvent("Referral:Activate_Code")
AddEventHandler("Referral:Activate_Code", function(code)
    local uid = vRP.getUserId({source})
    Activate_Referral(uid, code)
end)