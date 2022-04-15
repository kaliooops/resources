
local client_areas = {}
local client_peds = {}
local client_pickups = {}

-- free client areas when leaving
AddEventHandler("vRP:playerLeave",function(user_id,source)
  client_areas[source] = nil
  client_pickups[source] = nil
  client_peds[source] = nil
end)

-- create/update a player area
function vRP.setArea(source,name,x,y,z,radius,height,cb_enter,cb_leave)
  local areas = client_areas[source] or {}
  client_areas[source] = areas

  areas[name] = {enter=cb_enter,leave=cb_leave}
  vRPclient.setArea(source,{name,x,y,z,radius,height})
end

-- delete a player area
function vRP.removeArea(source,name)
  -- delete remote area
  vRPclient.removeArea(source,{name})

  -- delete local area
  local areas = client_areas[source]
  if areas then
    areas[name] = nil
  end
end

-- TUNNER SERVER API

function tvRP.enterArea(name)
  local areas = client_areas[source]
  if areas then
    local area = areas[name] 
    if area and area.enter then -- trigger enter callback
      area.enter(source,name)
    end
  end
end

function tvRP.leaveArea(name)
  local areas = client_areas[source]

  if areas then
    local area = areas[name] 
    if area and area.leave then -- trigger leave callback
      area.leave(source,name)
    end
  end
end



function vRP.setPickup(source,name,object,x,y,z,radius,height,cb_enter,cb_leave)
  local pickups = client_pickups[source] or {}
  client_pickups[source] = pickups

  pickups[name] = {enter=cb_enter,leave=cb_leave}
  vRPclient.setPickup(source,{name,object,x,y,z,radius,height})
end

-- delete a player pickup
function vRP.removePickup(source,name)
  -- delete remote pickup
  vRPclient.removePickup(source,{name})

  -- delete local pickup
  local pickups = client_pickups[source]
  if pickups then
    pickups[name] = nil
  end
end

-- TUNNER SERVER API

function tvRP.enterPickup(name)
  local pickups = client_pickups[source]
  if pickups then
    local pickup = pickups[name] 
    if pickup and pickup.enter then -- trigger enter callback
      pickup.enter(source,name)
    end
  end
end

function tvRP.leavePickup(name)
  local pickups = client_pickups[source]

  if pickups then
    local pickup = pickups[name] 
    if pickup and pickup.leave then -- trigger leave callback
      pickup.leave(source,name)
    end
  end
end

function vRP.createNPC(source,name,model,x,y,z,rot,radius,height,cb_enter,cb_leave)
	local peds = client_peds[source] or {}
	client_peds[source] = peds
	
	peds[name] = {enter=cb_enter,leave=cb_leave}
	vRPclient.createNPC(source,{name,model,x,y,z,rot,radius,height})
end

-- delete a player pickup
function vRP.removeNPC(source,name)
  -- delete remote pickup
  vRPclient.removeNPC(source,{name})

  -- delete local pickup
  local peds = client_peds[source]
  if peds then
    peds[name] = nil
  end
end

-- TUNNER SERVER API

function tvRP.enterNPC(name)
  local peds = client_peds[source]
  if peds then
    local ped = peds[name] 
    if ped and ped.enter then -- trigger enter callback
      ped.enter(source,name)
    end
  end
end

function tvRP.leaveNPC(name)
  local peds = client_peds[source]

  if peds then
    local ped = peds[name] 
    if ped and ped.leave then -- trigger leave callback
      ped.leave(source,name)
    end
  end
end

local cfg = module("cfg/blips_markers")

-- add additional static blips/markers
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    for k,v in pairs(cfg.blips) do
      vRPclient.addBlip(source,{v[1],v[2],v[3],v[4],v[5],v[6]})
    end

    for k,v in pairs(cfg.markers) do
      vRPclient.addMarker(source,{v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11]})
    end
  end
end)
