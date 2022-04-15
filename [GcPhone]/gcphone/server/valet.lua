--
RegisterServerCallback("gcPhone:getCars", function(a, b)
    local c = vRP.getUserId({a})
    if not c then
        return
    end;
    exports.ghmattimysql:execute("SELECT vehicle_plate, upgrades, storedhouse FROM vrp_user_vehicles WHERE user_id = @cid and veh_type = @type", {["@cid"] = c, ["@type"] = "car"}, function(d)
        local e = {} for f, g in ipairs(d) do
            table.insert(e, {["garage"] = g["storedhouse"], ["plate"] = g["vehicle_plate"], ["props"] = json.decode(g["upgrades"])})
        end;
        b(e)
    end)
end)
RegisterServerEvent("gcPhone:finish")
AddEventHandler("gcPhone:finish", function(a)
    local b = source;
    local c = vRP.getUserId({b})
    TriggerClientEvent("esx:showNotification", b, Config.valetPrice .. _U("valet_succ"))
    vRP.tryBankPayment({c,Config.valetPrice})
end)
RegisterServerEvent("gcPhone:valet-car-set-outside")
AddEventHandler("gcPhone:valet-car-set-outside", function(a)
    local b = source;
    local c = vRP.getUserId({b})
    if c then
       exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET storedhouse = @stored WHERE vehicle_plate = @plate", {["@plate"] = a, ["@stored"] = 0})
    end
end)
