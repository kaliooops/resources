local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","nation_bennys")
vRPCtuning = Tunnel.getInterface("nation_bennys","nation_bennys")
vRPtuning = {}
Tunnel.bindInterface("nation_bennys",vRPtuning)
Proxy.addInterface("nation_bennys",vRPtuning)

local using_bennys = {}

function vRPtuning.checkPermission()
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    return vRP.isUserFondator({user_id})
end

function vRPtuning.getSavedMods(vehicle_name, vehicle_plate)
    --local vehicle_owner_id = vRP.getUserByRegistration({vehicle_plate})
    --return json.decode(vRP.getSData({"custom:u" .. vehicle_owner_id .. "veh_" .. tostring(vehicle_name)}) or {}) or {}
end


vRPTuning.RegisterServerCallback('payForTuning', function(source, cb,pret)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	
	if vRP.tryFullPayment({user_id,pret}) then
		informatie = true
	else
		vRPclient.notify(player,{"Eroare: Nu ai bani de tunning !"})
		informatie = false
	end
	
	cb(informatie)
end)

RegisterServerEvent('esk:getTuning')
AddEventHandler('esk:getTuning',function(idvehicle)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	exports.ghmattimysql:execute("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @idvehicle AND upgrades IS NOT NULL", {['@user_id'] = user_id, ['@idvehicle'] = idvehicle}, function (rows)
		if #rows > 0 then 
		--	print(rows[1].vehicle,idvehicle,rows[1].vehicle_plate)
			tuning = json.decode(rows[1].upgrades)
			vRPCtuning.setTuningOnVehicle(player,{tuning})
		end
	end)
end)


RegisterServerEvent('payrepair')
AddEventHandler('payrepair', function (user_id)
	vRP.tryFullPayment(user_id, 250)
end)


vRPTuning.RegisterServerCallback('repairVehicle', function(source, cb,pret)
    local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name)
		if ok then
            informatie = true
        else
            informatie = false
        end
    end)
    cb(informatie)
end)

function vRPtuning.removeVehicle(vehicle)
    using_bennys[vehicle] = nil
    return true
end

function vRPtuning.checkVehicle(vehicle)
    if using_bennys[vehicle] then
        return false
    end
    using_bennys[vehicle] = true
    return true
end
function vRPtuning.saveVehicle(vehicle_name, vehicle_plate, vehicle_mods)
	local user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
    
	vRPclient.getNearestOwnedVehicle(player,{7},function(ok,vtype,name,vehicleid)
		print(ok,vtype,name,vehicleid)
		if ok then
			exports.ghmattimysql:execute("UPDATE vrp_user_vehicles SET upgrades = @upgrades WHERE user_id = @id and vehicle = @veh ", {
				['@id'] = user_id,
				['@upgrades'] = json.encode(vehicle_mods),
				['@veh'] = name
            })
        end
	end)
    return true
end


RegisterServerEvent("nation:syncApplyMods")
AddEventHandler("nation:syncApplyMods",function(vehicle_tuning,vehicle)
    TriggerClientEvent("nation:applymods_sync",-1,vehicle_tuning,vehicle)
end)