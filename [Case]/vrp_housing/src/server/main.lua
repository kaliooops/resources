local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_housing")

vRPhousing = {}
Tunnel.bindInterface("vRP_housing",vRPhousing)
Proxy.addInterface("vRP_housing",vRPhousing)
vRPhousingB = Tunnel.getInterface("vRP_housing","vRP_housing")


function vRPhousing.GetPlayerFullCash()
	local thePlayer = source
	if thePlayer ~= nil then
		local user_id = vRP.getUserId({thePlayer})
		if user_id ~= nil then
			local walletMoney = vRP.getMoney({user_id})
			local bankMoney = vRP.getBankMoney({user_id})
			local FullMoney = walletMoney+bankMoney
			return FullMoney
		end
	end
end

function vRPhousing.getID()
	local thePlayer = source
	if thePlayer ~= nil then
		local user_id = vRP.getUserId({thePlayer})
		if user_id ~= nil then
			return user_id
		end
	end
end

function vRPhousing.CreateHousePerm()
	local thePlayer = source
	local user_id = vRP.getUserId({thePlayer})
	if user_id ~= nil then
		  if vRP.isUserFondator({user_id}) then
			return true
		else
			return false
		end
	end
end

HouseKey = 1

SqlCheck = function()
	Houses = (Houses or {})
	local addToDb = {}
	local curInDb = exports.ghmattimysql:executeSync("SELECT * FROM allhousing")
	if curInDb and type(curInDb) == "table" then
		for k, v in pairs(curInDb) do
			if v.id and v.id >= HouseKey then
				HouseKey = v.id + 1
			end
		end
	end
	local newHouses = {}
	if Houses and type(Houses) == "table" then
		for k1, v1 in pairs(Houses) do
			local foundMatch = false
			for k2, v2 in pairs(curInDb) do
				local entry = json.decode(v2.entry)
				if (math.floor(tonumber(v1.Entry.x)) == math.floor(tonumber(entry.x)) and math.floor(tonumber(v1.Entry.y)) == math.floor(tonumber(entry.y)) and math.floor(tonumber(v1.Entry.z)) == math.floor(tonumber(entry.z))) then
					foundMatch = k2
					break
				end
			end
			if not foundMatch then
				newHouses[HouseKey] =  (Houses[HouseKey] or {})
				newHouses[HouseKey].Id = HouseKey
				newHouses[HouseKey].Owner = 0
				newHouses[HouseKey].OwnerName = ""
				newHouses[HouseKey].Owned = false
				newHouses[HouseKey].Price = v1.Price
				newHouses[HouseKey].ResalePercent = 0
				newHouses[HouseKey].Entry = v1.Entry
				newHouses[HouseKey].Garage = (v1.Garage or false)
				newHouses[HouseKey].Furniture = {}
				newHouses[HouseKey].Shell = v1.Shell
				newHouses[HouseKey].Shells = v1.Shells
				newHouses[HouseKey].HouseKeys = {}
				newHouses[HouseKey].Wardrobe = false
				newHouses[HouseKey].InventoryLocation = false
				table.insert(addToDb, Houses[HouseKey])
				HouseKey = HouseKey + 1
			else
				newHouses[curInDb[foundMatch].id] =  (Houses[curInDb[foundMatch].id] or {})
				newHouses[curInDb[foundMatch].id].Id = (curInDb[foundMatch].id)
				newHouses[curInDb[foundMatch].id].Owner = (curInDb[foundMatch].owner)
				newHouses[curInDb[foundMatch].id].OwnerName = (curInDb[foundMatch].ownername)
				newHouses[curInDb[foundMatch].id].Owned = (curInDb[foundMatch].owned >= 1 and true or false)
				newHouses[curInDb[foundMatch].id].Price = curInDb[foundMatch].price
				newHouses[curInDb[foundMatch].id].ResalePercent = curInDb[foundMatch].resalepercent
				newHouses[curInDb[foundMatch].id].Entry = table.tovec(json.decode(curInDb[foundMatch].entry))
				newHouses[curInDb[foundMatch].id].Garage = (curInDb[foundMatch].garage:len() > 5 and table.tovec(json.decode(curInDb[foundMatch].garage)) or false)
				newHouses[curInDb[foundMatch].id].Furniture = json.decode(curInDb[foundMatch].furniture)
				newHouses[curInDb[foundMatch].id].Shell = curInDb[foundMatch].shell
				newHouses[curInDb[foundMatch].id].Shells = json.decode(curInDb[foundMatch].shells)
				newHouses[curInDb[foundMatch].id].HouseKeys = json.decode(curInDb[foundMatch].housekeys)
				newHouses[curInDb[foundMatch].id].Wardrobe = (curInDb[foundMatch].wardrobe:len() > 5 and table.tovec(json.decode(curInDb[foundMatch].wardrobe)) or false)
				newHouses[curInDb[foundMatch].id].InventoryLocation = (curInDb[foundMatch].inventorylocation:len() > 5 and table.tovec(json.decode(curInDb[foundMatch].inventorylocation)) or false)
			end
		end
	end
	if curInDb and type(curInDb) == "table" then
		for k1, v1 in pairs(curInDb) do
			local foundMatch = false
			local entry = json.decode(v1.entry)
			for k2, v2 in pairs(newHouses) do
				if (math.floor(tonumber(v2.Entry.x)) == math.floor(tonumber(entry.x)) and math.floor(tonumber(v2.Entry.y)) == math.floor(tonumber(entry.y)) and math.floor(tonumber(v2.Entry.z)) == math.floor(tonumber(entry.z))) then
					foundMatch = k2
					break
				end
			end
			if not foundMatch then
			newHouses[v1.id] = {
				Id = v1.id,
				Owner = v1.owner,
				OwnerName = v1.ownername,
				Owned = (v1.owned >= 1 and true or false),
				Price = v1.price,
				ResalePercent = v1.resalepercent,
				Entry = table.tovec(json.decode(v1.entry)),
				Garage = (v1.garage:len() > 5 and table.tovec(json.decode(v1.garage)) or false),
				Furniture = json.decode(v1.furniture),
				Shell = v1.shell,
				Shells = json.decode(v1.shells),
				HouseKeys = json.decode(v1.housekeys),
				Wardrobe = (v1.wardrobe:len() > 5 and table.tovec(json.decode(v1.wardrobe)) or false),
				InventoryLocation = (v1.inventorylocation:len() > 5 and table.tovec(json.decode(v1.inventorylocation)) or false)
			}
			end
		end
	end
	if addToDb and type(addToDb) == "table" then
		for k, v in pairs(addToDb) do
			exports.ghmattimysql:execute("INSERT INTO allhousing SET id=@id,owner=@owner,ownername=@ownername,owned=@owned,entry=@entry,garage=@garage,furniture=@furniture,price=@price,resalepercent=@resalepercent,shell=@shell,shells=@shells,housekeys=@housekeys,wardrobe=@wardrobe,inventorylocation=@inventorylocation", {
			id = v.Id,
			owner = 0,
			ownername = "",
			owned = 0,
			entry = json.encode(table.fromvec(v.Entry)),
			garage = json.encode((v.Garage and table.fromvec(v.Garage) or {})),
			furniture = json.encode({}),
			price = v.Price,
			resalepercent = 0,
			shell = v.Shell,
			shells = json.encode(v.Shells),
			housekeys = json.encode({}),
			wardrobe = json.encode((v.Wardrobe and table.fromvec(v.Garage) or {})),
			inventorylocation = json.encode({}),
			}, function()end)
		end
	end
	Houses = newHouses
	SqlReady = true
end

Init = function()
	while not SqlReady do
		Wait(0);
	end
	ModReady = true
end

InviteInside = function(house, id)
	TriggerClientEvent("Allhousing:Invited", id, house)
end

KnockOnDoor = function(entry)
	TriggerClientEvent("Allhousing:KnockAtDoor", -1, entry)
end

GetHouseData = function(source, entry)
	while not ModReady do
		Wait(0);
	end
	local user_id = vRP.getUserId({source})
	if not entry then
		return {
			Houses = Houses,
			Identifier = user_id
		};
	end
	if Houses and type(Houses) == "table" then
		for k, v in pairs(Houses) do
			if v.Entry.x == entry.x and v.Entry.y == entry.y and v.Entry.z == entry.z then
				return v
			end
		end
	end
	return false
end
RegisterCallback("Allhousing:GetHouseData", GetHouseData)

SellHouse = function(house, price)
	local thePlayer = source
	if thePlayer ~= nil then
		local v = Houses[house.Id]
		local entry = house.Entry
		local user_id = vRP.getUserId({thePlayer})
		if v.Entry.x == entry.x and v.Entry.y == entry.y and v.Entry.z == entry.z then
			if v.Owned and v.Owner == user_id then
				if Config.RemoveFurniture then
					if Config.RefundFurniture and Config.RefundPercent then
						TriggerEvent("Allhousing.Furni:GetPrices", function(prices)
							local addVal, count = 0, 0
							if v and v.Furniture and type(v.Furniture) == "table" then
								for k, v in pairs(v.Furniture) do
									local price = prices[v.model]
									addVal = addVal + price
									count = count + 1
								end
								if count and count > 0 then
									vRP.giveBankMoney({user_id, math.ceil(addVal * (Config.RefundPercent / 100))})
								end
							end
						end)
					end
					v.Furniture = {}
				end
				local furniTab = {}
				if v and v.Furniture and type(v.Furniture) == "table" then
					for k, v in pairs(v.Furniture) do
						table.insert(furniTab, {
							pos = {
								x = v.pos.x,
								y = v.pos.y,
								z = v.pos.z
							},
							rot = {
								x = v.rot.x,
								y = v.rot.y,
								z = v.rot.z
							},
							model = v.model
						})
					end
				end
				v.Owned = false
				v.Price = price
				v.ResalePercent = 100
				TriggerClientEvent("Allhousing:SyncHouse", -1, v)
				TriggerClientEvent("Allhousing:Boot", -1, house.Id)
				exports.ghmattimysql:execute("UPDATE allhousing SET owned=0,price=@price,resalepercent=100,furniture=@furniture WHERE id=@id", {
					furniture = json.encode(furniTab),
					price = price,
					id = v.Id
				}, function()end)
				return
			end
		end
	end
end

CreateHouse = function(house)
	if not vRPhousing.CreateHousePerm() then vRPclient.notify(source,{"~p~Nu ai permisiuni "}) return end
	local _key = HouseKey
	HouseKey = HouseKey + 1
	Houses[_key] = {
		Id = _key,
		Owner = 0,
		OwnerName = "",
		Owned = false,
		Price = house.Price,
		ResalePercent = 0,
		Entry = house.Entry,
		Garage = house.Garage,
		Furniture = {},
		Shell = house.Shell,
		Shells = house.Shells,
		HouseKeys = {},
		Wardrobe = false,
		InventoryLocation = false,
	}
	TriggerClientEvent("Allhousing:SyncHouse", -1, Houses[_key])
	exports.ghmattimysql:execute("INSERT INTO allhousing SET id=@id,owner=@owner,ownername=@ownername,owned=@owned,price=@price,originalprice=@price,resalepercent=@resalepercent,entry=@entry,garage=@garage,furniture=@furniture,shell=@shell,shells=@shells,housekeys=@housekeys,wardrobe=@wardrobe,inventorylocation=@inventorylocation", {
		id = _key,
		owner = 0,
		ownername = "",
		owned = 0,
		price = house.Price,
		resalepercent = 0,
		entry = json.encode(table.fromvec(house.Entry)),
		garage = json.encode((house.Garage and table.fromvec(house.Garage) or {})),
		furniture = json.encode({}),
		shell = house.Shell,
		shells = json.encode(house.Shells),
		housekeys = json.encode({}),
		wardrobe = json.encode({}),
		inventorylocation = json.encode({})
	}, function()end)
end

UpgradeHouse = function(house, shell)
	local thePlayer = source
	if thePlayer ~= nil then
		local v = Houses[house.Id]
		local entry = house.Entry
		local user_id = vRP.getUserId({thePlayer})
		if v.Owned == true and v.Owner == user_id then
			local truePrice = ShellPrices[shell]
			if vRP.tryFullPayment({user_id,truePrice}) then
				v.Shell = shell
				TriggerClientEvent("Allhousing:SyncHouse", -1, v)
				exports.ghmattimysql:execute("UPDATE allhousing SET shell=@shell WHERE id=@id", {
					shell = shell,
					id = v.Id
				}, function()end)
				TriggerClientEvent("Allhousing:Boot", -1, house.Id, true)
			end
		end
	end
end

GiveKeys = function(house, target)
	local thePlayer = source
	if thePlayer ~= nil then
		local v = Houses[house.Id]
		local entry = house.Entry
		if target then
			local user_id = vRP.getUserId({thePlayer})
			local nuser_id = vRP.getUserId({target})
			if v.Owned == true and v.Owner == user_id then
				table.insert(v.HouseKeys, {
					identifier = nuser_id,
					name = vRP.getPlayerName({target})
				})
				TriggerClientEvent("Allhousing:SyncHouse", -1, v)
				TriggerClientEvent("Allhousing:NotifyPlayer", target, "~p~[~w~k2~p~]~w~ ~r~"..vRP.getPlayerName({thePlayer}).." ~w~ti-a dat cheile casei.")
				exports.ghmattimysql:execute("UPDATE allhousing SET housekeys=@housekeys WHERE id=@id", {
					housekeys = json.encode(v.HouseKeys),
					id = v.Id
				}, function()end)
			end
		else
			vRPclient.notify(thePlayer,{"~p~[~w~k2~p~]~w~ ~r~Esti prea departe de jucator pentru a ii da cheile casei!"})
		end
	end
end

TakeKeys = function(house, target)
	local thePlayer = source
	if thePlayer ~= nil then
		local v = Houses[house.Id]
		local entry = house.Entry
		if target then
			local user_id = vRP.getUserId({thePlayer})
			if v.Owned == true and v.Owner == user_id then
				local foundTarget = false
				if v and v.HouseKeys and type(v.HouseKeys) == "table" then
					for _k, _v in pairs(v.HouseKeys) do
						if _v.identifier == target.identifier and _v.name == target.name then
							foundTarget = _v.identifier
							table.remove(v.HouseKeys, _k)
							v.HouseKeys[_k] = nil
						end
					end
				end
				if foundTarget then
					TriggerClientEvent("Allhousing:SyncHouse", -1, v)
					exports.ghmattimysql:execute("UPDATE allhousing SET housekeys=@housekeys WHERE id=@id", {
						housekeys = json.encode(v.HouseKeys),
						id = v.Id
					}, function()end)
					local targetPlayer = vRP.getUserSource({foundTarget})
					if targetPlayer then
						TriggerClientEvent("Allhousing:NotifyPlayer", targetPlayer, "~p~[~w~k2~p~]~w~ ~r~"..vRP.getPlayerName({thePlayer}).." ~w~ti-a luat cheile casei.")
					end
				end
			end
		else
			vRPclient.notify(thePlayer,{"~p~[~w~k2~p~]~w~ ~r~Esti prea departe de jucator pentru a ii lua inapoi cheile casei!"})
		end
	end
end



SetFurni = function(house, furni)
	local v = Houses[house.Id]
	local entry = house.Entry
	v.Furniture = furni
	TriggerClientEvent("Allhousing:SyncHouse", -1, v)
	return
end

SetWardrobe = function(house, wardrobe)
	local thePlayer = source
	if thePlayer ~= nil then
		local v = Houses[house.Id]
		local user_id = vRP.getUserId({thePlayer})
		if v.Owned == true and v.Owner == user_id then
			v.Wardrobe = wardrobe
			TriggerClientEvent("Allhousing:SyncHouse", -1, v)
			exports.ghmattimysql:execute("UPDATE allhousing SET wardrobe=@wardrobe WHERE id=@id", {
				wardrobe = json.encode({
					x = wardrobe.x,
					y = wardrobe.y,
					z = wardrobe.z
				}),
				id = v.Id
			}, function()end)
		end
	end
end

SetInventory = function(house, inventoryLocation)
	local thePlayer = source
	if thePlayer ~= nil then
		local v = Houses[house.Id]
		local user_id = vRP.getUserId({thePlayer})
		if v.Owned == true and v.Owner == user_id then
			v.InventoryLocation = inventoryLocation
			TriggerClientEvent("Allhousing:SyncHouse", -1, v)
			exports.ghmattimysql:execute("UPDATE allhousing SET inventorylocation=@inventorylocation WHERE id=@id", {
				inventorylocation = json.encode({
					x = inventoryLocation.x,
					y = inventoryLocation.y,
					z = inventoryLocation.z
				}),
				id = v.Id
			}, function()end)
		end
	end
end

LockDoor = function(house)
	Houses[house.Id].Unlocked = false
	TriggerClientEvent("Allhousing:SyncHouse", -1, Houses[house.Id])
end

UnlockDoor = function(house)
	Houses[house.Id].Unlocked = true
	TriggerClientEvent("Allhousing:SyncHouse", -1, Houses[house.Id])
end

RegisterNetEvent("Allhousing:CreateHouse")
AddEventHandler("Allhousing:CreateHouse", CreateHouse)

RegisterNetEvent("Allhousing:GiveKeys")
AddEventHandler("Allhousing:GiveKeys", GiveKeys)

RegisterNetEvent("Allhousing:TakeKeys")
AddEventHandler("Allhousing:TakeKeys", TakeKeys)

RegisterNetEvent("Allhousing:SellHouse")
AddEventHandler("Allhousing:SellHouse", SellHouse)

RegisterNetEvent("Allhousing:LockDoor")
AddEventHandler("Allhousing:LockDoor", LockDoor)

RegisterNetEvent("Allhousing:UnlockDoor")
AddEventHandler("Allhousing:UnlockDoor", UnlockDoor)

RegisterNetEvent("Allhousing:SetWardrobe")
AddEventHandler("Allhousing:SetWardrobe", SetWardrobe)

RegisterNetEvent("Allhousing:SetInventory")
AddEventHandler("Allhousing:SetInventory", SetInventory)

RegisterNetEvent("Allhousing:KnockOnDoor")
AddEventHandler("Allhousing:KnockOnDoor", KnockOnDoor)

RegisterNetEvent("Allhousing:InviteInside")
AddEventHandler("Allhousing:InviteInside", InviteInside)

RegisterNetEvent("Allhousing:UpgradeHouse")
AddEventHandler("Allhousing:UpgradeHouse", UpgradeHouse)

AddEventHandler("Allhousing:SetFurni", SetFurni)

AddEventHandler("onResourceStart", function(res)
	if(res == "vrp_housing")then
		Wait(2000)
		SqlCheck()
	end
end)

AddEventHandler("Allhousing:GetGlobalOffset", function(cb)
	cb(Config.SpawnOffset);
end)

Citizen.CreateThread(Init)

function vRPhousing.openWardrobe(houseID)
	local _source = source
	local user_id = vRP.getUserId({_source})
	if user_id ~= nil then
		if houseID then
			local menu = {name="Meniu Garderoba",css={top = "75px", header_color="rgba(0,255,125,0.75)"}}
			vRP.getUData({user_id, "vRP:home:wardrobeHouse"..houseID,function(data)
				local sets = json.decode(data)
				if sets == nil then
					sets = {}
				end
				menu["#Salveaza Imbracamintea"] = {function(player, choice)
					vRP.prompt({player,"Pune un nume imbracamintei","",function(player,setname)
						if setname ~= nil and setname ~= "" and string.len(setname) > 0 then
							vRPclient.getCustomization(player,{},function(custom)
								sets[setname] = custom  
								vRP.setUData({user_id,"vRP:home:wardrobeHouse"..houseID,json.encode(sets)})
								vRPhousing.openWardrobe()
							end)
						else
							vRPclient.notify(player,{"~p~[~w~k2~p~]~w~ ~r~Valoare Invalida"})
						end
					end})
				end}
				local choose_set = function(player,choice)
					local custom = sets[choice]
					if custom ~= nil then
						vRPclient.setCustomization(player,{custom})
					end
				end
				for k,v in pairs(sets) do 
					menu[k] = {choose_set}
				end
				vRP.openMenu({_source,menu})
			end})
		end
	end
end

function vRPhousing.openChest(houseID)
	local thePlayer = source
	if thePlayer ~= nil then
		local user_id = vRP.getUserId({thePlayer})
		if user_id ~= nil then
			vRP.openChest({source, "u"..user_id..":"..houseID.."home", 200, nil, nil, nil})
		end
	end
end

GetVehicles = function(source,house)
	local vehs = {}
	local retData = exports.ghmattimysql:executeSync("SELECT * FROM vrp_user_vehicles WHERE storedhouse=@storedhouse",{storedhouse = house.Id})
	if retData and type(retData) == "table" then
		for k,v in pairs(retData) do
			table.insert(vehs,{
				type = v.veh_type,
				plate = v.vehicle_plate,
				vehicle = v.vehicle,
			})
		end
	end
	return vehs
end

VehicleStored = function(id,plate)
	exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET storedhouse=@storedhouse WHERE vehicle_plate=@plate",{storedhouse = id, plate = plate}, function()end)
end


VehicleRequestMods = function(house,vehicle,plate)
	local thePlayer = source
	if thePlayer ~= nil then
		local user_id = vRP.getUserId({thePlayer})
		local src = vRP.getUserSource({user_id})
		if src ~= nil then
			local rows = exports.ghmattimysql:executeSync("SELECT upgrades FROM vrp_user_vehicles WHERE storedhouse=@storedhouse AND vehicle_plate = @plate AND vehicle = @vehicle AND upgrades IS NOT NULL", {storedhouse = house.Id, plate = plate, vehicle = vehicle})
			if #rows > 0 then
				vRPclient.garage_setmods(src, {rows[1].upgrades})
				exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET storedhouse=0 WHERE vehicle_plate=@plate AND vehicle=@vehicle",{plate = plate, vehicle = vehicle}, function()end)
			end
		end
	end
end

function vRPhousing.isVehicleAlreadyOutOfGarage(vehicle,plate)
	local rows = exports.ghmattimysql:executeSync("SELECT storedhouse FROM vrp_user_vehicles WHERE vehicle = @vehicle AND vehicle_plate = @plate", {plate = plate, vehicle = vehicle})
	if rows[1].storedhouse == 0 then
		return true
	else
		return false
	end
end

PurchaseHouse = function(house)
	local thePlayer = source
	if thePlayer ~= nil then
		local v = Houses[house.Id]
		local entry = house.Entry
		local user_id = vRP.getUserId({thePlayer})
		if not v.Owned then
			if vRP.tryFullPayment({user_id,v.Price}) then
				if v.Owner then
					local targetPlayer = vRP.getUserSource({v.Owner})
					local salePrice = math.floor(v.Price * (v.ResalePercent / 100))
					if salePrice > 0 then
						if targetPlayer then
							vRP.giveBankMoney({v.Owner,salePrice})
							TriggerClientEvent("Allhousing:NotifyPlayer", targetPlayer, "~p~[~w~k2~p~]~w~ Casa ta a fost cumparata de catre ~r~"..vRP.getPlayerName({thePlayer}).." ~w~cu suma de ~p~$"..salePrice)
						else
							exports.ghmattimysql:execute("UPDATE vrp_users SET bankMoney=bankMoney+@money WHERE id=@nuser_id",{money = salePrice, nuser_id = v.Owner}, function()end)
						end
						local rows = exports.ghmattimysql:executeSync("SELECT * FROM allhousing WHERE owner = @user_id", {user_id = v.Owner})
						local originalprice = tonumber(rows[1].originalprice)
						exports.ghmattimysql:execute("UPDATE allhousing SET price = @price WHERE owner = @user_id AND id = @id", {price = originalprice, user_id = v.Owner, id = v.Id}, function()end)
					end
				end
				v.Owner = user_id
				v.OwnerName = vRP.getPlayerName({thePlayer})
				v.Owned = true
				TriggerClientEvent("Allhousing:SyncHouse",-1,v)
				exports.ghmattimysql:execute("UPDATE allhousing SET owner=@owner,ownername=@ownername,owned=1,resalepercent=0,housekeys=@housekeys WHERE id=@id",{owner = v.Owner, ownername = v.OwnerName, housekeys = json.encode({}), id = v.Id}, function()end)
			end
		end
	end
end

SetGarageLocation = function(id,pos)
	local house = Houses[id]
	if house.Owned and house.Garage then
		house.Garage = pos
		TriggerClientEvent("Allhousing:SyncHouse",-1,house)
		exports.ghmattimysql:execute("UPDATE allhousing SET garage=@garage WHERE id=@id",{
		garage = json.encode({x = pos.x, y = pos.y, z = pos.z, w = pos.w}),
		id = id
		}, function()end)
	end
end

GetVehicleOwner = function(source,placuta)
	local thePlayer = source
	if thePlayer ~= nil then
		ret = {}
		local user_id = vRP.getUserId({thePlayer})
		local result = exports.ghmattimysql:executeSync("SELECT * FROM vrp_user_vehicles WHERE vehicle_plate = @placuta AND user_id = @user_id",{placuta = placuta, user_id = user_id})
		if #result > 0 then
			if result[1].user_id == user_id and result[1].vehicle_plate == placuta then
				ret.owner = true
				ret.owned = true
			else
				ret.owner = false
				ret.owned = true
			end
		else
			ret.owner = false
			ret.owned = false
		end
		return ret
	end
end

RegisterCallback("Allhousing:GetVehicles", GetVehicles)

RegisterNetEvent("Allhousing:VehicleStored")
AddEventHandler("Allhousing:VehicleStored", VehicleStored)

RegisterCallback("Allhousing:GetVehicleOwner",GetVehicleOwner)
RegisterCallback("Allhousing:GetHouseData", GetHouseData)

RegisterNetEvent("Allhousing:PurchaseHouse")
AddEventHandler("Allhousing:PurchaseHouse", PurchaseHouse)

RegisterNetEvent("Allhousing:SetGarageLocation")
AddEventHandler("Allhousing:SetGarageLocation", SetGarageLocation)

RegisterNetEvent("Allhousing:VehicleRequestMods")
AddEventHandler("Allhousing:VehicleRequestMods", VehicleRequestMods)

