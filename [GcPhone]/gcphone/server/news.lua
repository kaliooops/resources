
local canUse = false

local cnn_menu = {
    name = "Anunturi Comerciale",
css = {top = "75px", header_color = "rgba(226, 87, 36, 0.75)"}}

RegisterServerEvent("gcphone:newNews")
AddEventHandler("gcphone:newNews", function()
    local src = source
    local user_id = vRP.getUserId({src})
    vRP.prompt({src, "Titlu", "", function(player, data)
        vRP.prompt({player, "Content:", "", function(player, data2)
            vRP.prompt({player, "Poza:", "", function(player, data3)
                if data3 then
                    vRP.prompt({src, "Video? Daca nu ai, lasa gol", "", function(player, data4)
                        if data4 then
                            sendNews(data, data2, data3, data4)
                        else
                            sendNews(data, data2, data3, "")
                        end
                    end})
                end
            end})
        end})
    end})
end)

cnn_menu["Anunt Comercial"] = {function(player, choice)
    local user_id = vRP.getUserId({player})
    if canUse then
        TriggerClientEvent('okokNotify:Alert', player, "FFA Romania", "Cooldown activ, asteapta 60 de secunde pana sa pui un alt anunt", 5000, 'error')
    else
        vRP.prompt({player, "Titlu :", "", function(player, msg1)
            vRP.prompt({player, "Content :", "", function(player, msg2)
                vRP.prompt({player, "Poza (NECESAR) :", "", function(player, msg3)
                    vRP.prompt({player, "Video: (Lasa gol daca nu ai) :", "", function(player, msg4)
                        if msg4 then
                            if msg1 ~= nil and msg2 ~= nil and msg3 ~= nil and msg4 ~= nil then
                                sendNews(msg1, msg2, msg3, msg4)
                            else
                                TriggerClientEvent('okokNotify:Alert', player, 'Eroare', 'Valori invalide (msg=1,2,3,4)')
                            end
                        else
                            if msg1 ~= nil and msg2 ~= nil and msg3 ~= nil then
                                sendNews(msg1, msg2, msg3, "")
                                canUse = true
                                Wait(60000)
                                canUse = false
                            else
                                TriggerClientEvent('okokNotify:Alert', player, 'Eroare', 'Valori invalide (msg=1,2,3)')
                            end
                        end
                    end})
                end})
            end})
        end})
    end
end}

    RegisterCommand("anunt2", function(source)
        sendNews("Anunt test", "Vand porc, 3 kg", "nu am", "")
    end)

    function sendNews(a, b, c, d)
        local e = {}
        e.name = a;
        e.content = b;
        e.img = c;
        if d ~= nil then
            e.video = d
        end;
        exports.ghmattimysql:execute("INSERT INTO crew_phone_news (`data`) VALUES (@data);", {["@data"] = json.encode(e)})
        TriggerClientEvent("gcPhone:twitter_showSuccess", -1, a, c)
    end

    RegisterServerEvent("crew-phone:delete-news")
    AddEventHandler("crew-phone:delete-news", function(a)
    exports.ghmattimysql:execute("DELETE from crew_phone_news WHERE id = @id", {["@id"] = a}) end)

    RegisterServerCallback("crew-phone:get-news", function(a, b)
        exports.ghmattimysql:execute("SELECT * FROM crew_phone_news ORDER BY id DESC", {}, function(c)
            local d = {}
            for e = 1, #c, 1 do table.insert(d, {alldata = c[e].data, id = c[e].id})
            end;
            b(d)
        end)
    end)

    local function build_static_menu(source)
        local user_id = vRP.getUserId({source})
        if user_id ~= nil then
            local function cnn_enter()
                local user_id = vRP.getUserId({source})
                if user_id ~= nil then
                    vRP.openMenu({source, cnn_menu})
                end
            end

            local function cnn_leave()
                vRP.closeMenu({source})
            end
            x, y, z = -1082.1088867188, -247.57398986816, 37.76329421997
            vRP.setArea({source, "vRP:cnn", x, y, z, 1, 1.5, cnn_enter, cnn_leave})
        end
    end

    AddEventHandler('onResourceStart', function(res)
        if GetCurrentResourceName() == res then
            local users = vRP.getUsers({})
            for user_id, source in pairs(users) do
                build_static_menu(source)
            end
        end
    end)

    AddEventHandler("vRP:playerSpawn", function(user_id, player, first_spawn)
        if first_spawn then
            build_static_menu(player)
        end
    end)

   