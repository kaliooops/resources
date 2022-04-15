RegisterServerCallback("crew:getBills", function(a, b)
    local c = vRP.getUserId({a})
   exports.ghmattimysql:execute("SELECT amount, id, target, label FROM billing WHERE id = @identifier", {["@identifier"] = c}, function(d)
        b(d)
    end)
end)

RegisterServerEvent("gcPhone:faturapayBill")
AddEventHandler("gcPhone:faturapayBill", function(a)
    local b = vRP.getUserId({source})
   exports.ghmattimysql:execute("SELECT * FROM billing WHERE id = @id", {["@id"] = a}, function(c)
        local d = c[1].sender;
        local e = c[1].target_type;
        local f = c[1].target;
        local g = c[1].amount;
        local h = tonumber(d)
        local hsource = vRP.getUsers({})[h]
        if e == "player" then if hsource ~= nil then
            if vRP.getBankMoney({b}) >= g then
                exports.ghmattimysql:execute("DELETE from billing WHERE id = @id", {["@id"] = a}, function(i)
                    vRP.tryBankPayment({b,g})
                    vRP.giveBankMoney({h,g})
                    TriggerClientEvent('okokNotify:Alert', vRP.getUserSource({b}), "", "Ai platit o factura", 5000, 'success')
                    TriggerClientEvent('okokNotify:Alert', hsource, "", "Cineva a platit aceasta factura", 5000, 'success')
                    TriggerClientEvent("gcPhone:updateFaturalar", vRP.getUserSource({b})) end)
            end
        end
        else
            TriggerEvent("esx_addonaccount:getSharedAccount", f, function(j)
                if vRP.getBankMoney({b}) >= g then
                    exports.ghmattimysql:execute("DELETE from billing WHERE id = @id", {["@id"] = a}, function(i)
                        local k = Round(g / 100 * 10)
                        local l = Round(g / 100 * 90)
                        if hsource ~= nil then vRP.giveBankMoney({h,k})
                        end;
                        vRP.tryBankPayment({b,g})
                        vRP.giveMoney({j,l})
                        TriggerClientEvent('okokNotify:Alert', vRP.getUserSource({b}), "", "Ai platit factura pentru "..g, 5000, 'success')
                        TriggerClientEvent("gcPhone:updateFaturalar", vRP.getUserSource({b}))
                        if h ~= nil then
                            TriggerClientEvent('okokNotify:Alert', h, "", "Cineva a platit o factura, si tu ai primit "..K, 5000, 'success')
                        end
                    end)
                else
                    TriggerClientEvent('okokNotify:Alert', vRP.getUserSource({b}), "", "Nu ai destui bani", 5000, 'error')
                end
            end)
        end
    end)
end)
