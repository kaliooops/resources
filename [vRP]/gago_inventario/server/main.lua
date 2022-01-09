local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "gago_inventario")
BMclient = Tunnel.getInterface("vRP_basic_menu","vRP_basic_menu")
vRPbsC = Tunnel.getInterface("vRP_barbershop","vRP_basic_menu")
Tunnel.bindInterface("vRP_basic_menu",vRPbm)
vRPserver = Tunnel.getInterface("vRP", "vRP_basic_menu")
HKserver = Tunnel.getInterface("vrp_hotkeys", "vRP_basic_menu")
BMserver = Tunnel.getInterface("vRP_basic_menu", "vRP_basic_menu")

Dclient = Tunnel.getInterface("gago_inventario","gago_inventario")

RegisterServerEvent("gago_inventario:openGui")
AddEventHandler("gago_inventario:openGui",function()
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})
        local data = vRP.getUserDataTable({user_id})
        if data and data.inventory then
            local inventory = {}
            for data_k, data_v in pairs(data.inventory) do
                for items_k, items_v in pairs(items) do
                    if data_k == items_k then
                        local item_name = vRP.getItemName({data_k})
                        local itemWeight = vRP.getItemWeight({data_k})*data_v.amount
                            if item_name then
                            table.insert(inventory,
                                {
                                    name = item_name,
                                    amount = data_v.amount,
                                    item_peso = string.format("%.2f", itemWeight), -- mod de a arăta greutatea obiectului
                                    idname = data_k,
                                    icon = items_v[5]
                                }
                            )
                        end
                    end
                end
            end
            local weight = vRP.getInventoryWeight({user_id})
            local maxWeight = vRP.getInventoryMaxWeight({user_id})
            TriggerClientEvent("gago_inventario:updateInventory", source, inventory, weight, maxWeight)
        end
end)

RegisterServerEvent("gago_inventario:useItem")
AddEventHandler("gago_inventario:useItem",function(args)
        local data = args
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})

        if data.idname then
            for k, v in pairs(items) do
                if data.idname == k then
                    useItem(user_id, player, k, v[1], v[2], v[3], v[4], data.amount)
                end
            end
        end
end)

RegisterServerEvent("gago_inventario:dropItem")
AddEventHandler("gago_inventario:dropItem",function(data)
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})
        local amount = parseInt(data.amount)
        local peso = true
        local idname = data.idname
        local px,py,pz = vRPclient.getPosition(source)
        if vRPclient.isInComa(player) then
            vRPclient.notify(player,"Esti in coma.")
        else
            if idname == "mochila" then		
                peso = vRP.setMochila({user_id,0})
            end
            if peso then	
                if vRP.tryGetInventoryItem({user_id, data.idname, amount, false}) then
                    TriggerClientEvent("gago_inventario:closeGui", player)
					vRPclient.playAnim(player,{false,{{"pickup_object","pickup_low"}},false})                  
                else
                    -- TriggerClientEvent("Notify",player,"negado","A fost o problema.")
                end
            else
                TriggerClientEvent("toasty:Notify", player , {type = "info", title="Inventar", message = "Goliti mai intai rucsacul."})


            end	
        end    
    end)


function split(str, sep)
    local array = {}
    local reg = string.format("([^%s]+)", sep)
    for mem in string.gmatch(str, reg) do
        table.insert(array, mem)
    end
    return array
end


local MosNicoale_items = {
    ['Portocala'] = function(src)
        ped = GetPlayerPed(src)
        vRPclient.varyHealth(src,{30})
        vRP.tryGetInventoryItem({vRP.getUserId({src}), "Portocala", 1})
    end,
    
    ['Ciocolata'] = function(src)
        ped = GetPlayerPed(src)
        SetPedArmour(ped, GetPedArmour(ped) + 30) 
        vRP.tryGetInventoryItem({vRP.getUserId({src}), "Ciocolata", 1})
    
    end,
    ['Globulete']  = function(src) 
        vRP.giveKRCoins({vRP.getUserId({src}), math.random(1, 3)})  
        TriggerClientEvent("toasty:Notify", src , {type = "info", title="Mos Craciun", message = "Ai gasit praf de diamante pe Globulete"})

        vRP.tryGetInventoryItem({vRP.getUserId({src}), "Globulete", 1})
    end
}

function useItem(user_id, player, idname, type, varyhealth, varyThirst, varyHunger, amount)

    for cheie, mnItems in pairs(MosNicoale_items) do
        if type == cheie then
            if GetEntityHealth(GetPlayerPed(player)) > 120 then
                mnItems(player)
            end
        end
    end

    if type == "k2uri" then
        vRP.tryGetInventoryItem({user_id, "k2uri", 1})
        TriggerEvent("mosnicoale:giveGift", player, user_id)
    end
    
    
    if vRPclient.isInComa(player) then
        TriggerClientEvent("toasty:Notify", player , {type = "info", title="Inventar", message = "Esti in coma"})

        
    else
        if type == "fireworks" then 
            vRPclient.isInComa(player,{}, function(in_coma)
                if(in_coma)then
                    vRPclient.notify(player, {"~r~Eu cred ca esti lesinat"})
                else
            TriggerClientEvent("frobski-fireworks:start", player)
            TriggerClientEvent('3dme:triggerDisplay', -1, 'Aprinzi artificiile', player)
            TriggerClientEvent("winter_misiuni_handler:ArtificiiAprinse", player)
            vRP.giveMoney({user_id, math.random(50, 150)})
            vRP.tryGetInventoryItem({user_id, "fireworks", 1})

        end

    end)
    

end
        
        if type == "weapon" then
            if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                local fullidname = split(idname, "|")
                vRPclient.giveWeapons(player,{{[fullidname[2]] = {ammo=0}}})
            end
        end
        if type == "armura" then
            if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                local fullidname = split(idname, "|")
                BMclient.setArmour(player,{100,true})
            end
        end
        if type == "ammo" then
            local fullidname = split(idname, "|")
            local exists = false
                vRPclient.getWeapons(player,{},function(weapons)
                    for k, v in pairs(weapons) do
                        if k == fullidname[2] then
                            exists = true
                        end
                    end
                    if exists == true then
                        if vRP.tryGetInventoryItem({user_id, idname, tonumber(amount), false}) then
                            vRPclient.giveWeapons(player,{{[fullidname[2]] = {ammo=tonumber(amount)}}})
                        end
                    else
                        TriggerClientEvent("toasty:Notify", player , {type = "info", title="Inventar", message = "Nu ai arma pentru aceasta munitie."})
                  
                    end
                end)  
            end
            if type == "comida" then
                if vRP.tryGetInventoryItem({user_id,idname,1,false}) then
                    if varyHunger ~= 0 then vRP.varyHunger({user_id,varyHunger}) end
                    vRPclient.notify(player,{"~o~ Mananca "..idname.."."})
                    Dclient.eat(player)
                end
            end	
            if type == "bebida" then
                if vRP.tryGetInventoryItem({user_id,idname,1,false}) then
                    if varyThirst ~= 0 then vRP.varyThirst({user_id,varyThirst}) end
                    vRPclient.notify(player,{"~b~ Hai sa bem "..idname.."."})
                    Dclient.drink(player)
                end
            end			
            if type == "emergencia" then
                if vRP.tryGetInventoryItem({user_id,idname,1,false}) then
                    if varyThirst ~= 0 then vRP.varyThirst({user_id,varyThirst}) end
                    vRPclient.isInComa(player,{}, function(in_coma)
                        if(in_coma)then
                            vRPclient.notify(player, {"~r~Eu cred ca esti lesinat"})
                        else
                    vRPclient.notify(player,{"~b~ Iti administrezi "..idname.."."})
                    Dclient.emergencia(player)
                    vRPclient.varyHealth(player,{65})
                end
            end)
        end
    end	
    if type == "paracetamol" then
        if vRP.tryGetInventoryItem({user_id,idname,1,false}) then
            if varyThirst ~= 0 then vRP.varyThirst({user_id,varyThirst}) end
            vRPclient.isInComa(player,{}, function(in_coma)
                if(in_coma)then
                    vRPclient.notify(player, {"~r~Eu cred ca esti lesinat"})
                else
            vRPclient.notify(player,{"~b~ Iti administrezi "..idname.."."})
            Dclient.paracetamol(player)
            vRPclient.varyHealth(player,{25})
        end
    end)
end
end	
            if type == "alcool" then
                if vRP.tryGetInventoryItem({user_id,idname,1,false}) then
                    if varyThirst ~= 0 then vRP.varyThirst({user_id,varyThirst}) end
                    vRPclient.isInComa(player,{}, function(in_coma)
                        if(in_coma)then
                            vRPclient.notify(player, {"~r~Eu cred ca esti lesinat"})
                        else
                    vRPclient.notify(player,{"~b~ Hai sa bem "..idname.."."})
                    Dclient.drinkalcool(player)
                end
            end)
        end
    end
            if type == "iarba" then
                if vRP.tryGetInventoryItem({user_id,idname,1,false}) then
                    if varyHealth ~= 21 then vRP.varyHealth({user_id,varyHealth}) end
                    vRPclient.isInComa(player,{}, function(in_coma)
                        if(in_coma)then
                            vRPclient.notify(player, {"~r~Eu cred ca esti lesinat"})
                        else
                    vRPclient.notify(player,{"~b~ Fumezi un Joint "..idname.."."})
                    Dclient.iarba(player)
                    vRPclient.varyHealth(player,{15})
                end
            end)
            end
        end
            if type == "drogmedicinal" then
                if vRP.tryGetInventoryItem({user_id,idname,1,false}) then
                    if varyThirst ~= 0 then vRP.varyThirst({user_id,varyThirst}) end
                    vRPclient.isInComa(player,{}, function(in_coma)
                        if(in_coma)then
                            vRPclient.notify(player, {"~r~Eu cred ca esti lesinat"})
                        else
                    vRPclient.notify(player,{"~b~ Iti administrezi "..idname.."."})
                    Dclient.drogmedicinal(player)
                    vRPclient.varyHealth(player,{80})
                end
            end	)
            if type == "tigara" then
                if vRP.tryGetInventoryItem({user_id,idname,1,false}) then
                if varyThirst ~= 0 then vRP.varyThirst({user_id,varyThirst}) end
                vRPclient.isInComa(player,{}, function(in_coma)
                    if(in_coma)then
                        vRPclient.notify(player, {"~r~Eu cred ca esti lesinat"})
                    else
                vRPclient.notify(player,{"~b~ Fumezi "..idname.."."})
                    Dclient.cigarettee(player)
                    vRPclient.varyHealth(player,{10})
                end
            end)
            end


        if type == "none" then
            TriggerClientEvent("toasty:Notify", player , {type = "info", title="Inventar", message = "Acest articol nu poate fi utilizat."})
   
        end
    end    
end



end
end
end

function play_f1(player)
    vRPclient._playAnim(player, true, {task="WORLD_HUMAN_SMOKING_POT"}, false)
end
function play_f2(player)
vRPclient._playAnim(player,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},false)
end 

RegisterServerEvent("gago_inventario:giveItem")
AddEventHandler("gago_inventario:giveItem",function(data)
    local source = source
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    if user_id then  -- check user
		vRPclient.getNearestPlayer(source,{5},function(nplayer) -- get nearest player
			if nplayer then -- if nearest player
            local nuser_id = vRP.getUserId({nplayer}) -- get player id
            if nuser_id then -- 
                    local amount = parseInt(data.amount) -- amount
                    if amount > 0 then -- if amount
                        if vRP.getInventoryWeight({nuser_id})+vRP.getItemWeight({data.idname})*amount <= vRP.getInventoryMaxWeight({nuser_id}) then -- if don't overflow
                            if vRP.tryGetInventoryItem({user_id,data.idname,amount,true}) then -- get item
                                vRP.giveInventoryItem({nuser_id,data.idname,amount,true}) -- give item
                                vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false) -- anim
                                TriggerClientEvent("gago_inventario:closeGui", source) -- close gui
                                -- TriggerClientEvent("toasty:Notify", source , {type = "success", title="Inventar", message = "A trimis <b>"..data.idname.." x"..amount.."</b>."})
                                -- TriggerClientEvent("toasty:Notify", nplayer , {type = "success", title="Inventar", message = "A primit <b>"..data.idname.." x"..amount.."</b>."})

                            end
                        else
                            TriggerClientEvent("toasty:Notify", source , {type = "info", title="Inventar", message = "Inventar plin."})
                            TriggerClientEvent("toasty:Notify", nplayer , {type = "info", title="Inventar", message = "Inventar plin."})
                        end
                    end
                end
            end
		end)
    end   
end)
