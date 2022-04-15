--import all vrp and basic menu
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

function update_diamonds_in_database(diamonds, mafia)
    exports.ghmattimysql:execute("UPDATE mafia_safe SET diamonds = diamonds + @diamonds WHERE mafie = @mafia_name", {
        diamonds= diamonds,
        mafia_name = mafia
    }, function() end)
end

function get_diamonds_in_database(mafia)
    local safe_diamonds = -1
    exports.ghmattimysql:execute("SELECT diamonds FROM mafia_safe WHERE mafie = @mafie", {
        mafie = mafia
    }, function(diamonds)
            safe_diamonds = diamonds
    end)
    while safe_diamonds == -1 do
        Citizen.Wait(0)
    end
    return safe_diamonds[1].diamonds
end


--build a safe menu with deposit and withdraw function
local function buildSafeMenu(safe, player)
	local menu = {name = "Safe",css={top="75px",header_color="rgba(0,125,255,0.75)"}}
	menu.name = "Safe"

	local function ch_deposit(player,choice)
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
			vRP.prompt({player,"Cantitatea pe care vrei sa o depozitezi:","0",function(player,amount)
				amount = parseInt(amount)
                if amount < 0 then
                    TriggerEvent("k2ANTICHEAT:ban", player, " Tentativa de bug la seif")
                    return
                end
                if vRP.getKRCoins({user_id}) >= amount then
                    vRP.setKRCoins({user_id, vRP.getKRCoins({user_id}) - amount})
                    update_diamonds_in_database(amount, vRP.getUserFaction({user_id}))
                    TriggerClientEvent("toasty:Notify", player , {type = "success", title="Seif", message = "Ai adaugat " .. amount .. "💎 in seif"})

                else
                    TriggerClientEvent("toasty:Notify", player , {type = "error", title="Seif", message = "Nu ai destule 💎"})
                end
                vRP.closeMenu({player})
			end})
		end
	end

	local function ch_withdraw(player,choice)
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
            if vRP.isFactionLeader({user_id, vRP.getUserFaction({user_id})}) then
                vRP.prompt({player,"Cantitatea pe care vrei sa o extrage:","0",function(player,amount)
                    amount = parseInt(amount)
                    local d = get_diamonds_in_database(vRP.getUserFaction({user_id}))
                    d = parseInt(d)

                    if amount < 0 then
                        TriggerEvent("k2ANTICHEAT:ban", player, " Tentativa de bug la seif")
                        return
                    end

                    if amount < d then                    
                        vRP.setKRCoins({user_id, vRP.getKRCoins({user_id}) + amount})
                        update_diamonds_in_database(-amount, vRP.getUserFaction({user_id}))
                        TriggerClientEvent("toasty:Notify", player , {type = "success", title="Seif", message = "Ai extras " .. amount .. "💎"})
                    else
                        TriggerClientEvent("toasty:Notify", player , {type = "error", title="Seif", message = "Nu sunt suficiente 💎"})
                    end
                    vRP.closeMenu({player})
                end})
            else
                TriggerClientEvent("toasty:Notify", player , {type = "error", title="Seif", message = "Doar liderul are acces"})
                vRP.closeMenu({player})
            end
		end
	end


	local function safeinfo(player,choice)
		local user_id = vRP.getUserId({player})
		if user_id ~= nil then
            local d = get_diamonds_in_database(vRP.getUserFaction({user_id}))
            TriggerClientEvent("toasty:Notify", player , {type = "info", title="Seif", message = "Diamante: " .. d})
            TriggerClientEvent('chatMessage', player,"^4 💎Diamante💎 ^3\n " .. d)
            TriggerClientEvent('chatMessage', player,"^4 💎Diamante💎 ^3\n " .. d)
            TriggerClientEvent('chatMessage', player,"^4 💎Diamante💎 ^3\n " .. d)
            vRP.closeMenu({player})
            
        end
	end

	menu['1.Depoziteaza'] = {ch_deposit,"Depozitează"}
	menu['2.Extrage'] = {ch_withdraw,"Extrage"}
    menu['3.Info']        = {safeinfo, "Info"}

	vRP.openMenu({player,menu})
end

RegisterServerEvent("maf_deposit:openMenu")
AddEventHandler("maf_deposit:openMenu", function(name,safe)
	local user_id = vRP.getUserId({source})
    if vRP.getUserFaction({user_id}) == name then
        if user_id ~= nil then
            local player = vRP.getUserSource({user_id})
            if player ~= nil then
                buildSafeMenu(safe, player)
            end
        end
    end
end)


-- --Bloods
-- RegisterCommand("mafiaCreateSafe", function(x,args,z)
--     if vRP.getUserId({x}) == 1 or vRP.getUserId({x}) ==2 then
--         local mafia = table.concat(args, " ")
--         if mafia ~= nil then
--             exports.ghmattimysql:execute("INSERT INTO mafia_safe (mafie, diamonds) VALUES (@mafie, @diamonds)", {
--                 mafie = mafia,
--                 diamonds = 0
--             }, function() end)
--         end
--     else
--         --add message
--         TriggerClientEvent("chatMessage", x, "", {0,0,0}, "Spike e bolnav psihiiiiiiiiiiiiiiiiiiic!")
--     end
-- end, false)