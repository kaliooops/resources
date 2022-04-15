local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_furniture")

vRPfurniture = {}
Tunnel.bindInterface("vRP_furniture",vRPfurniture)
Proxy.addInterface("vRP_furniture",vRPfurniture)
vRPfurnitureB = Tunnel.getInterface("vRP_furniture","vRP_furniture")

function vRPfurniture.GetPlayerFullCash()
  local thePlayer = source
  if thePlayer ~= nil then
    local user_id = vRP.getUserId({thePlayer})
    if user_id ~= nil then
      local walletMoney = vRP.getMoney({user_id})
      local bankMoney = vRP.getBankMoney({user_id})
      local FullMoney = walletMoney + bankMoney
      return FullMoney
    end
  end
end

furni.priceLookup = {}

SqlReady = function()
  for _, cat in pairs(furni.objects) do
    for k, v in pairs(cat) do furni.priceLookup[v.object] = v.price end
  end
end

furni.placeFurniture = function(source, houseData, itemData, pos, rot, object)
  if source ~= nil then
    local user_id = vRP.getUserId({source})
    local truePrice = (furni.priceLookup[itemData.object] and furni.priceLookup[itemData.object] or false)
    if truePrice and vRP.tryFullPayment({user_id,truePrice}) then
      local retData = exports.ghmattimysql:executeSync("SELECT * FROM allhousing")
      for _, data in pairs(retData) do
        entry = json.decode(data.entry)
        if (math.floor(tonumber(houseData.Entry.x)) ==
          math.floor(tonumber(entry.x)) and
          math.floor(tonumber(houseData.Entry.y)) ==
          math.floor(tonumber(entry.y)) and
          math.floor(tonumber(houseData.Entry.z)) ==
          math.floor(tonumber(entry.z))) then
          local furniture = json.decode(data.furniture)
          local newPos = {x = pos.x, y = pos.y, z = pos.z}
          local newRot = {x = rot.x, y = rot.y, z = rot.z}
          table.insert(furniture, {
            pos = newPos,
            rot = newRot,
            model = itemData.object
          })
          local jTab = {}
          for k, v in pairs(furniture) do
            jTab[k] = {
              pos = {x = v.pos.x, y = v.pos.y, z = v.pos.z},
              rot = {x = v.rot.x, y = v.rot.y, z = v.rot.z},
              model = v.model
            }
          end
          exports.ghmattimysql:execute(
            "UPDATE allhousing SET furniture=@furniture WHERE id=@id",
            {furniture = json.encode(jTab), id = data.id}, function()end)
          TriggerEvent("Allhousing:SetFurni", houseData, furniture)
          return
        end
      end
    end
  end
end

furni.replaceFurniture = function(source, houseData, itemData, pos, rot, object, lastObject)
  if source ~= nil then
    local retData = exports.ghmattimysql:executeSync("SELECT * FROM allhousing")
    for _, data in pairs(retData) do
      entry = json.decode(data.entry)
      if (math.floor(tonumber(houseData.Entry.x)) ==
        math.floor(tonumber(entry.x)) and
        math.floor(tonumber(houseData.Entry.y)) ==
        math.floor(tonumber(entry.y)) and
        math.floor(tonumber(houseData.Entry.z)) ==
        math.floor(tonumber(entry.z))) then
        local furniture = json.decode(data.furniture)
        local newPos = {x = pos.x, y = pos.y, z = pos.z}
        local newRot = {x = rot.x, y = rot.y, z = rot.z}
        local jTab = {}
        for k, v in pairs(furniture) do
          if math.floor(v.pos.x + houseData.Entry.x) ==
            math.floor(lastObject.pos.x) and
            math.floor(v.pos.y + houseData.Entry.y) ==
            math.floor(lastObject.pos.y) and
            math.floor(v.pos.z + houseData.Entry.z) ==
            math.floor(lastObject.pos.z) and v.model ==
            itemData.object then
            furniture[k].pos = newPos
            furniture[k].rot = newRot
          end
          table.insert(jTab, {
            pos = {x = v.pos.x, y = v.pos.y, z = v.pos.z},
            rot = {x = v.rot.x, y = v.rot.y, z = v.rot.z},
            model = v.model
          })
        end
        exports.ghmattimysql:execute(
          "UPDATE allhousing SET furniture=@furniture WHERE id=@id",
          {furniture = json.encode(jTab), id = data.id}, function()end)
        TriggerEvent("Allhousing:SetFurni", houseData, furniture)
        return
      end
    end
  end
end

furni.deleteFurniture = function(source, houseData, itemData, pos, rot)
  if source ~= nil then
    local retData = exports.ghmattimysql:executeSync("SELECT * FROM allhousing")
    for _, data in pairs(retData) do
      entry = json.decode(data.entry)
      if (math.floor(tonumber(houseData.Entry.x)) ==
        math.floor(tonumber(entry.x)) and
        math.floor(tonumber(houseData.Entry.y)) ==
        math.floor(tonumber(entry.y)) and
        math.floor(tonumber(houseData.Entry.z)) ==
        math.floor(tonumber(entry.z))) then
        local furniture = json.decode(data.furniture)
        local jTab = {}
        local delKey = false
        for k, v in pairs(furniture) do
          global_offset = (global_offset or vector3(0.0, 0.0, 0.0))
          if math.floor(v.pos.x +
            (houseData.Entry.x + global_offset.x)) ==
            math.floor(pos.x) and
            math.floor(v.pos.y +
            (houseData.Entry.y + global_offset.y)) ==
            math.floor(pos.y) and
            math.floor(v.pos.z +
            (houseData.Entry.z + global_offset.z)) ==
            math.floor(pos.z) and v.model == itemData.object then
            delKey = k
          else
            table.insert(jTab, {
              pos = {x = v.pos.x, y = v.pos.y, z = v.pos.z},
              rot = {x = v.rot.x, y = v.rot.y, z = v.rot.z},
              model = v.model
            })
          end
        end
        if delKey then
          local truePrice = (furni.priceLookup[itemData.object] and
          furni.priceLookup[itemData.object] or
          false)
          if truePrice then
            local user_id = vRP.getUserId({source})
            vRP.giveMoney({user_id, math.floor(truePrice * (0.5))})
            table.remove(furniture, delKey)
            exports.ghmattimysql:execute(
              "UPDATE allhousing SET furniture=@furniture WHERE id=@id",
              {furniture = json.encode(jTab), id = data.id}, function()end)
            TriggerEvent("Allhousing:SetFurni", houseData, furniture)
          end
        end
        return
      end
    end
  end
end

AddEventHandler("onResourceStart", function(res)
	if(res == "vrp_furniture")then
		Wait(2000)
		SqlReady()
	end
end)

RegisterNetEvent('furni:PlaceFurniture')
AddEventHandler('furni:PlaceFurniture',function(...)
  if source ~= nil then
    furni.placeFurniture(source, ...); 
  end
end)

RegisterNetEvent('furni:ReplaceFurniture')
AddEventHandler('furni:ReplaceFurniture',function(...)
  if source ~= nil then
    furni.replaceFurniture(source, ...); 
  end
end)

RegisterNetEvent('furni:DeleteFurniture')
AddEventHandler('furni:DeleteFurniture',function(...)
  if source ~= nil then
   furni.deleteFurniture(source, ...); 
  end
end)

AddEventHandler("Allhousing.Furni:GetPrices", function(cb)
  cb(furni.priceLookup);
end)