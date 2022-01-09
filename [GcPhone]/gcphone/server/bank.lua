RegisterServerEvent("gcPhone:transfer")
AddEventHandler("gcPhone:transfer", function(a, b)
    local c = source
    local d = vRP.getUserId({c})
    local targetSRC = vRP.getUserSource({parseInt(a)})
    local f = 0
    if a ~= nil then
        if targetSRC ~= nil then
            f = vRP.getBankMoney({d})
            zbalance = vRP.getBankMoney({a})
            baniBank_a = vRP.getBankMoney({parseInt(a)})
            -- vRP.giveBankMoney({parseInt(a),tonumber(b)})
            baniBank_c = vRP.getBankMoney({d})

            if parseInt(a) == d then
                TriggerClientEvent('okokNotify:Alert', c, 'FFA Romania', 'Nu iti poti transfera singur bani!', 5000, 'error')
            else
                if baniBank_c >= tonumber(b) then
                    if tonumber(b) < 0 then
                        TriggerClientEvent('okokNotify:Alert', c, 'Bug Abuse [WARNING]', 'Nu mai incerca puiule ca nu merge :)', 5000, 'error')
                        TriggerClientEvent('chatMessage', -1, '^1[WARNING]: ^7Jucatorul ^1'..GetPlayerName(c)..' ['..d..'] ^7a incercat sa faca ^1BUG ABUSE (money, destinatar='..a..')')
                    else
                        vRP.setBankMoney({d, baniBank_c - tonumber(b)})
                        vRP.setBankMoney({parseInt(a), baniBank_a + tonumber(b)})
                        TriggerClientEvent('okokNotify:Alert', c, "FFA Romania", "Ai transferat cu succes suma de "..b, 5000, 'success')
                        TriggerClientEvent('okokNotify:Alert', targetSRC, "FFA Romania", "Ai primit suma "..b, 5000, 'success')
                        exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @identifier", {["@identifier"] = a}, function(g)
                            if g[1] then
                                local h = g[1].firstName .. " " .. g[1].secondName;
                                exports.ghmattimysql:execute("INSERT INTO crew_phone_bank (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {["@type"] = 1, ["@identifier"] = d, ["@price"] = b, ["@name"] = h}, function(i)
                                    TriggerClientEvent("crewPhone:updateHistory", c)
                                end)
                            end
                        end)
                        exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @identifier", {["@identifier"] = d}, function(g)
                            if g[1] then
                                local h = g[1].firstName .. " " .. g[1].secondName;
                                exports.ghmattimysql:execute("INSERT INTO crew_phone_bank (type, identifier, price, name) VALUES (@type, @identifier, @price, @name)", {["@type"] = 2, ["@identifier"] = a, ["@price"] = b, ["@name"] = h}, function(j)
                                    TriggerClientEvent("crewPhone:updateHistory", targetSRC)
                                end)
                            end
                        end)
                    end
                else
                    TriggerClientEvent('okokNotify:Alert', c, 'FFA Romania', 'Nu ai destui bani in banca pentru a face transferul!', 5000, 'error')
                end
            end
        else
            TriggerClientEvent('okokNotify:Alert', c, 'FFA Romania', 'Jucatorul nu este conectat!', 5000, 'error')
        end
        else
            TriggerClientEvent('okokNotify:Alert', c, "FFA Romania", "Jucatorul nu este online", 5000, 'error')
        end
    end)

    RegisterServerCallback("crew-phone:check-bank", function(a, b)
        local c = a;
        local d = vRP.getUserId({c})
        exports.ghmattimysql:execute("SELECT * FROM crew_phone_bank WHERE identifier = @identifier ORDER BY time DESC LIMIT 5", {["@identifier"] = d}, function(e)b(e)
        end)
    end)

    RegisterServerCallback("crew-phone:check-bank-money", function(a, b)
        local c = a;
        local d = vRP.getUserId({c})
        exports.ghmattimysql:execute("SELECT * FROM crew_phone_bank WHERE identifier = @identifier ORDER BY time DESC LIMIT 5", {["@identifier"] = d}, function(e)
            b(e)
        end)
    end)

    function myfirstname(a, b, c)
        exports.ghmattimysql:execute("SELECT firstName, phone FROM vrp_users WHERE firstName = @firstname AND phone = @phone_number", {["@phone_number"] = a, ["@firstname"] = b}, function(d)
            c(d[1])
        end)
    end

   