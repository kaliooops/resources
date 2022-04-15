local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPin = {}
Tunnel.bindInterface("vrp_inventoryhud",vRPin)
Proxy.addInterface("vrp_inventoryhud",vRPin)
INclient = Tunnel.getInterface("vrp_inventoryhud","vrp_inventoryhud")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_inventoryhud")

openInventories = {}
Hotbars = {}
vTypes = {}

PerformHttpRequest("https://raw.githubusercontent.com/marinogabri/vrp_inventoryhud/master/version",function(err,newVersion,headers)
	if err == 200 then
		local curVersion = LoadResourceFile(GetCurrentResourceName(), "version")
		if curVersion ~= newVersion then
			print("^3[vRP Inventory Hud]^7 An update is avaible: https://github.com/marinogabri/vrp_inventoryhud")
		end
	end
end, "GET")

function vRPin.requestItemGive(idname, amount)
	local _source = source
	local user_id = vRP.getUserId({_source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
	  	-- get nearest player
	  	vRPclient.getNearestPlayer(player,{10},function(nplayer)
			local nuser_id = vRP.getUserId({nplayer})
			if nuser_id ~= nil then
				local new_weight = vRP.getInventoryWeight({nuser_id})+vRP.getItemWeight({idname})*amount
				if new_weight <= vRP.getInventoryMaxWeight({nuser_id}) then
					if vRP.tryGetInventoryItem({user_id,idname,amount,true}) then
						vRP.giveInventoryItem({nuser_id,idname,amount,true})
		
						vRPclient.playAnim(player,{true,{{"mp_common","givetake2_a",1}},false})
						vRPclient.playAnim(nplayer,{true,{{"mp_common","givetake2_a",1}},false})
					end
				else
					vRPclient.notify(player,{"~r~Inventarul e plin."})
				end
			else
				vRPclient.notify(player,{"~r~Niciun player langa tine."})
			end
	  	end)
	end
  
	INclient.loadPlayerInventory(player)
end

ierburi_aromate = {
	'kush',
	"purplehaze",
	"lemonhaze",
}

juice1 = {
	"ananas",
	"limonada",
	"orange",
	"tigara",
}

juice2 = {
	"kiwi",
	"strawberry",
}

droguri_medicinale = {
	"tramadol",
	"tilidin",
}

medicamente = {
	"paracetamol",
}

pizze = {
	"pizza",
	"taraneasca",
	"romaneasca",
	"diavola",
	"bigmac",
	"hamburger",
	"cheeseburger",
}

food = {
	"gogoasa",
}

bauturi = {
	"cola",
}

function vRPin.requestItemUse(idname)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local choice = vRP.getItemChoices({idname})

	if string.find(idname, "WEAPON_") then
		INclient.equipWeapon(player, {idname})
	else
		-- for key, value in pairs(choice) do 
			-- if key ~= "Give" and key ~= "Trash" then
				-- local cb = value[1]

				if idname == "supressor" then
					INclient.equipWeapon(player, {"supressor"})
				end

				if idname == "grip" then
					INclient.equipWeapon(player, {"grip"})
				end
				
				if idname == "yusuf" then
					INclient.equipWeapon(player, {"yusuf"})
				end

				-- AICI DE FAPT VIN ELE FOLOSITE CU PLAYER FIIND SOURCE 
				if idname == "sonar" then
					TriggerClientEvent("Pescar:Deschide_Sonar", player)
				end
				
				if idname == "undita1m" then
					TriggerClientEvent("Pescar:Echipeaza_Undita", player)
				end

				if idname == "Armura" then
					if vRP.tryGetInventoryItem({user_id, idname, 1}) then
						TriggerClientEvent("Inventory:ArmourMe", player)
					end
				end

				for _, iarbaname in pairs(ierburi_aromate) do
					if iarbaname == idname and vRP.tryGetInventoryItem({user_id, idname, 1}) then
						TriggerClientEvent("Inventory:Iarba", player)
					end
				end
				
				for _, j in pairs(juice1) do
					if j == idname and vRP.tryGetInventoryItem({user_id, idname, 1}) then
						local thirst = vRP.getThirst({user_id}) 
						if thirst > 1 then
							vRP.setThirst({user_id, thirst - 20})
							TriggerClientEvent("Inventory:Juice1", player)
							TriggerClientEvent("hungergames:drink", player)
						else
							TriggerClientEvent("toasty:Notify", source, {type="error", title="Food", message="Nu iti este sete!"})	
						end
					end
				end

				for _, j in pairs(juice2) do
					if j == idname and vRP.tryGetInventoryItem({user_id, idname, 1}) then
						local thirst = vRP.getThirst({user_id}) 
						if thirst > 1 then
							vRP.setThirst({user_id, thirst - 20})
							TriggerClientEvent("Inventory:Juice2", player)
							TriggerClientEvent("hungergames:drink", player)
						else
							TriggerClientEvent("toasty:Notify", source, {type="error", title="Food", message="Nu iti este sete!"})	
						end
					end
				end

				for _, medical in pairs(droguri_medicinale) do
					if medical == idname and vRP.tryGetInventoryItem({user_id, idname, 1}) then
						TriggerClientEvent("Inventory:Medical", player)
						TriggerClientEvent("hungergames:eat", player)
					end
				end

				for _, droguri_farmacie in pairs(medicamente) do
					if droguri_farmacie == idname and vRP.tryGetInventoryItem({user_id, idname, 1}) then
						TriggerClientEvent("Inventory:Medicamente", player)
						TriggerClientEvent("hungergames:eat", player)
					end
				end
			
				for _, pizza in pairs(pizze) do
					if pizza == idname and vRP.tryGetInventoryItem({user_id, idname, 1}) then
						local hunger = vRP.getHunger({user_id}) 
						print(hunger)
						if hunger > 1 then
							vRP.setHunger({user_id, hunger - 50})
							TriggerClientEvent("Inventory:Pizza", player)
							TriggerClientEvent("hungergames:eat", player)
						else
							TriggerClientEvent("toasty:Notify", source, {type="error", title="Food", message="Nu iti este foame!"})
						end
					end
				end

				for _, mancari in pairs(food) do
					if mancari == idname and vRP.tryGetInventoryItem({user_id, idname, 1}) then
						local hunger = vRP.getHunger({user_id}) 
						if hunger > 1 then
						vRP.setHunger({user_id, hunger - 10})
						TriggerClientEvent("Inventory:Gogoasa", player)
						TriggerClientEvent("hungergames:eat", player)
						else
							TriggerClientEvent("toasty:Notify", source, {type="error", title="Food", message="Nu iti este foame!"})
						end
					end
				end

				for _, bautura in pairs(bauturi) do
					if bautura == idname and vRP.tryGetInventoryItem({user_id, idname, 1}) then
						local thirst = vRP.getThirst({user_id}) 
						if thirst > 1 then
							vRP.setThirst({user_id, thirst - 50})
							TriggerClientEvent("Inventory:Cola", player)
							TriggerClientEvent("hungergames:drink", player)
						else
							TriggerClientEvent("toasty:Notify", source, {type="error", title="Food", message="Nu iti este sete!"})	
						end
					end
				end

				if idname == "fireworks" then
					vRPclient.isInComa(player, {}, function(in_coma)
						if (in_coma) then
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




				-- cb(player,key)
				INclient.loadPlayerInventory(player)
				INclient.notify(player, {{name = idname, label = vRP.getItemName({idname}), count = 1}, "Used"})
			-- end
		-- end
	end
end

function vRPin.requestReload(weapon, ammo)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local ammoItem = Config.Items[weapon][5]

		if ammoItem ~= nil then
			local maxAmmo = vRP.getInventoryItemAmount({user_id, ammoItem})
			if ammo > maxAmmo then 
				ammo = maxAmmo
			end

			if vRP.tryGetInventoryItem({user_id, ammoItem, ammo, true}) then
				return true
			else
				INclient.notify(source, {{name = ammoItem, label = vRP.getItemName({ammoItem}), count = ammo}, "Lipseste"})
			end
		end
	end
end

function vRPin.holstered(weapon, ammo)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local ammoItem = Config.Items[weapon][5]
		vRP.giveInventoryItem({user_id, ammoItem, ammo, true})
	end
end

function vRPin.requestPutHotbar(idname, amount, slot, from)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		if from ~= nil then
			Hotbars[user_id][from] = nil
		end

		Hotbars[user_id][slot] = idname

		INclient.loadPlayerInventory(player)
	end
end

function vRPin.requestRemoveHotbar(slot)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil then
		Hotbars[user_id][slot] = nil
		INclient.loadPlayerInventory(player)
	end
end

function vRPin.useHotbarItem(slot)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	if user_id ~= nil and Hotbars[user_id] ~= nil then
		local idname = Hotbars[user_id][slot]
		if idname ~= nil then
			vRPin.requestItemUse(idname)
			local amount = vRP.getInventoryItemAmount({user_id,idname})
			if amount < 1 then
				Hotbars[user_id][slot] = nil
			end
		end
	end
end

function vRPin.getHotbarItems(player)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		local hotbarItems = {}
		if Hotbars[user_id] ~= nil then
			for slot, idname in pairs(Hotbars[user_id]) do
				local item_name, description = vRP.getItemDefinition({idname})
				local amount = vRP.getInventoryItemAmount({user_id,idname})
				if amount > 0 then
					table.insert(hotbarItems, {
						label = item_name,
						count = amount,
						description = description,
						name = idname,
						slot = slot
					})
				end
			end
		end

		return hotbarItems
	end
end

function vRPin.closeInventory(type)
	local user_id = vRP.getUserId({source})

	if type == "trunk" or type == "glovebox" then
		vRPclient.stopAnim(source, {false})
		if vTypes[user_id] ~= nil then
			vRPclient.vc_closeDoor(vTypes[user_id][1], {vTypes[user_id][2],5})
			vTypes[user_id] = nil
		end
	end
	
	openInventories[user_id] = nil
end

function vRPin.inventoryOpened(player)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRPclient.getNearestOwnedVehicle(player,{5},function(ok,vtype,name)
			if ok then
				INclient.isIsideACar(player, {}, function(inside)
					if inside then
						openGlovebox(player, user_id, user_id, name)
						return
					else
						openTrunk(player, user_id, user_id, name, vtype)
						return
					end
				end)
			end
		end)

		vRPclient.getNearestPlayer(player,{2},function(nplayer)
			local nuser_id = vRP.getUserId({nplayer})
			if nuser_id ~= nil then
				vRPclient.isInComa(nplayer,{}, function(inComa)
					vRPclient.isHandcuffed(nplayer,{}, function(isHandcuffed)
						if inComa or isHandcuffed then
							loadTargetInventory(player, user_id, nplayer, nuser_id)
							return
						end
					end)
				end)
			end
		end)

		vRPin.openDrop(player, user_id)
		-- INclient.openInventory(player, {'normal'})
	end
end

function vRPin.getInventoryItems(player)
	local user_id = vRP.getUserId({player})
	local data = vRP.getUserDataTable({user_id})
	local weight = vRP.getInventoryWeight({user_id})
	local max_weight = vRP.getInventoryMaxWeight({user_id})
	local items = {}
	local hotbarItems = {}

	if Hotbars[user_id] == nil then
		Hotbars[user_id] = {}
	end

	for k,v in pairs(data.inventory) do 
		local item_name, description, weight = vRP.getItemDefinition({k})
		local found = false

		if item_name ~= nil then
			for slot, idname in pairs(Hotbars[user_id]) do
				if idname == k then
					found = true
					table.insert(hotbarItems, {
						label = item_name,
						count = v.amount,
						description = description,
						name = idname,
						weight = weight,
						slot = slot
					})
				end
			end

			if not found then
				table.insert(items, {
					label = item_name,
					count = v.amount,
					description = description,
					weight = weight,
					name = k
				})
			end
        end
    end

	return items, hotbarItems, weight, max_weight
end

-- Define items
for k,v in pairs(Config.Items) do
	vRP.defInventoryItem({k,v[1],v[2],v[3],v[4]})
end
