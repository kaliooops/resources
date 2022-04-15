-- BLIPS: see https://wiki.gtanet.work/index.php?title=Blips for blip id/color

-- TUNNEL CLIENT API

-- BLIP

markerNames = {}

-- create new blip, return native id
function tvRP.addBlip(x,y,z,idtype,idcolor,text)
  local blip = AddBlipForCoord(x+0.001,y+0.001,z+0.001) -- solve strange gta5 madness with integer -> double
  SetBlipSprite(blip, idtype)
  SetBlipAsShortRange(blip, true)
  SetBlipScale(blip, 0.8)
  SetBlipColour(blip,idcolor)

  if text ~= nil then
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
  end

  return blip
end

-- remove blip by native id
function tvRP.removeBlip(id)
  RemoveBlip(id)
end

function tvRP.addMarkerNames(theX, theY, theZ, theText, theFont, theScale)
	table.insert(markerNames, {x = theX, y = theY, z = theZ, text = theText, font = theFont, scale = theScale})
end

local named_blips = {}

-- set a named blip (same as addBlip but for a unique name, add or update)
-- return native id
function tvRP.setNamedBlip(name,x,y,z,idtype,idcolor,text)
  tvRP.removeNamedBlip(name) -- remove old one

  named_blips[name] = tvRP.addBlip(x,y,z,idtype,idcolor,text)
  return named_blips[name]
end

-- remove a named blip
function tvRP.removeNamedBlip(name)
  if named_blips[name] ~= nil then
    tvRP.removeBlip(named_blips[name])
    named_blips[name] = nil
  end
end

-- GPS

-- set the GPS destination marker coordinates
function tvRP.setGPS(x,y)
  SetNewWaypoint(x+0.0001,y+0.0001)
end

-- set route to native blip id
function tvRP.setBlipRoute(id)
  SetBlipRoute(id,true)
end

-- MARKER

local markers = {}
local marker_ids = Tools.newIDGenerator()
local named_markers = {}

-- add a circular marker to the game map
-- return marker id
function tvRP.addMarker(x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  local marker = {x=x,y=y,z=z,sx=sx,sy=sy,sz=sz,r=r,g=g,b=b,a=a,visible_distance=visible_distance}


  -- default values
  if marker.sx == nil then marker.sx = 2.0 end
  if marker.sy == nil then marker.sy = 2.0 end
  if marker.sz == nil then marker.sz = 0.7 end

  if marker.r == nil then marker.r = 0 end
  if marker.g == nil then marker.g = 155 end
  if marker.b == nil then marker.b = 255 end
  if marker.a == nil then marker.a = 200 end

  -- fix gta5 integer -> double issue
  marker.x = marker.x+0.001
  marker.y = marker.y+0.001
  marker.z = marker.z+0.001
  marker.sx = marker.sx+0.001
  marker.sy = marker.sy+0.001
  marker.sz = marker.sz+0.001

  if marker.visible_distance == nil then marker.visible_distance = 150 end

  local id = marker_ids:gen()
  markers[id] = marker

  return id
end

-- remove marker
function tvRP.removeMarker(id)
  if markers[id] ~= nil then
    markers[id] = nil
    marker_ids:free(id)
  end
end

-- set a named marker (same as addMarker but for a unique name, add or update)
-- return id
function tvRP.setNamedMarker(name,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  tvRP.removeNamedMarker(name) -- remove old marker

  named_markers[name] = tvRP.addMarker(x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  return named_markers[name]
end

function tvRP.removeNamedMarker(name)
  if named_markers[name] ~= nil then
    tvRP.removeMarker(named_markers[name])
    named_markers[name] = nil
  end
end

local markerSigns = {}
local markerSign_id = Tools.newIDGenerator()
local named_markerSign = {}
function tvRP.addMarkerSign(Sid,x,y,z,sx,sy,sz,r,g,b,a,visible_distance,spin,bobble,rotate)
  local markerSign = {Sid=Sid,x=x,y=y,z=z,sx=sx,sy=sy,sz=sz,r=r,g=g,b=b,a=a,visible_distance=visible_distance,spin=spin,bobble=bobble,rotate=rotate}


  -- default values
  if markerSign.sx == nil then markerSign.sx = 2.0 end
  if markerSign.sy == nil then markerSign.sy = 2.0 end
  if markerSign.sz == nil then markerSign.sz = 0.7 end

  if markerSign.r == nil then markerSign.r = 0 end
  if markerSign.g == nil then markerSign.g = 155 end
  if markerSign.b == nil then markerSign.b = 255 end
  if markerSign.a == nil then markerSign.a = 200 end

  -- fix gta5 integer -> double issue
  markerSign.x = markerSign.x+0.001
  markerSign.y = markerSign.y+0.001
  markerSign.z = markerSign.z+0.001
  markerSign.sx = markerSign.sx+0.001
  markerSign.sy = markerSign.sy+0.001
  markerSign.sz = markerSign.sz+0.001

  if markerSign.visible_distance == nil then markerSign.visible_distance = 150 end

  local id = markerSign_id:gen()
  markerSigns[id] = markerSign

  return id
end

function tvRP.removeMarkerSign(id)
  if markerSigns[id] ~= nil then
    markerSigns[id] = nil
    markerSign_id:free(id)
  end
end

function tvRP.setNamedSign(name,Sid,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  tvRP.removeNamedSign(name) -- remove old marker

  named_markerSign[name] = tvRP.addMarkerSign(Sid,x,y,z,sx,sy,sz,r,g,b,a,visible_distance)
  return named_markerSign[name]
end

function tvRP.removeNamedSign(name)
  if named_markerSign[name] ~= nil then
    tvRP.removeMarkerSign(named_markerSign[name])
    named_markerSign[name] = nil
  end
end

function DrawText3D(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

-- markers draw loop
Citizen.CreateThread(function()
	local waittime = 1000
	while true do
		Citizen.Wait(0)

		local px,py,pz = tvRP.getPosition()

		for k,v in pairs(markers) do
			-- check visibility
			if GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= 5.0 then
				waittime = 0
				DrawMarker(1,v.x,v.y,v.z,0,0,0,0,0,0,v.sx,v.sy,v.sz,v.r,v.g,v.b,v.a,0,0,0,0)
			else
				if waittime == 0 then waittime = 1000 end
			end
		end
		for k,v in pairs(markerSigns) do
			-- check visibility
			if GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= 5.0 then
				waittime = 0
				DrawMarker(v.Sid,v.x,v.y,v.z+1.4,0,0,0,0,0,0,v.sx,v.sy,v.sz,v.r,v.g,v.b,v.a,v.bobble,true,0,v.spin,v.rotate)
			else
				if waittime == 0 then waittime = 1000 end
			end
		end
		for k,v in pairs(markerNames) do
			-- check visibility
			if GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= 5.0 then
				waittime = 0
				DrawText3D(v.x,v.y,v.z, v.text, v.scale, v.font)
			else
				if waittime == 0 then waittime = 1000 end
			end
		end
	end
end)


-- AREA

local areas = {}
local pickups = {}
local thePickups = {}
local peds = {}
local thePeds = {}

-- create/update a cylinder area
function tvRP.setArea(name,x,y,z,radius,height)
  local area = {x=x+0.001,y=y+0.001,z=z+0.001,radius=radius,height=height}

  -- default values
  if area.height == nil then area.height = 6 end

  areas[name] = area
end

-- remove area
function tvRP.removeArea(name)
  if areas[name] ~= nil then
    areas[name] = nil
  end
end

function tvRP.setPickup(name,object,x,y,z,radius,height)
  local pickup = {object=object,x=x+0.001,y=y+0.001,z=z+0.001,radius=radius,height=height}

  -- default values
  if pickup.height == nil then pickup.height = 6 end

  pickups[name] = pickup
end

-- remove area
function tvRP.removePickup(name)
  if pickups[name] ~= nil then
    pickups[name] = nil
  end
end

function tvRP.createNPC(name,model,x,y,z,rot,radius,height)
	local npc = {model=model,x=x+0.001,y=y+0.001,z=z+0.001,rot=rot,radius=radius,height=height}

	-- default values
	if npc.height == nil then npc.height = 6 end

	peds[name] = npc
	
	model = model
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(0)
	end
	thePeds[name] = CreatePed(26,GetHashKey(model),x,y,z,rot,false,false)
	FreezeEntityPosition(thePeds[name], true)
	SetEntityCollision(thePeds[name], false)
	SetEntityDynamic(thePeds[name], false)
	SetEntityInvincible(thePeds[name], true)
	SetBlockingOfNonTemporaryEvents(thePeds[name], true)
end

-- remove area
function tvRP.removeNPC(name)
  if peds[name] ~= nil then
    peds[name] = nil
  end
end
-- areas triggers detections
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)

		local px,py,pz = tvRP.getPosition()

		for k,v in pairs(areas) do
			-- detect enter/leave

			local player_in = (GetDistanceBetweenCoords(v.x,v.y,v.z,px,py,pz,true) <= v.radius and math.abs(pz-v.z) <= v.height)

			if v.player_in and not player_in then -- was in: leave
				vRPserver.leaveArea({k})
			elseif not v.player_in and player_in then -- wasn't in: enter
				vRPserver.enterArea({k})
			end

			v.player_in = player_in -- update area player_in
		end
		
		for key,value in pairs(pickups) do
			-- detect enter/leave
			if(thePickups[key] == nil)then
				model = value.object
				RequestModel(GetHashKey(model))
				while not HasModelLoaded(GetHashKey(model)) do
					Wait(0)
				end
				thePickups[key] = CreateObject(GetHashKey(model), value.x,value.y,value.z, false, false)
				FreezeEntityPosition(thePickups[key], true)
				SetEntityCollision(thePickups[key], false)
				SetEntityDynamic(thePickups[key], false)
			end
			local player_in = (GetDistanceBetweenCoords(value.x,value.y,value.z,px,py,pz,true) <= value.radius and math.abs(pz-value.z) <= value.height)

			if value.player_in and not player_in then -- was in: leave
				vRPserver.leavePickup({key})
			elseif not value.player_in and player_in then -- wasn't in: enter
				vRPserver.enterPickup({key})
			end

			value.player_in = player_in -- update area player_in
		end
		
		for key,value in pairs(peds) do
			-- detect enter/leave
			local player_in = (GetDistanceBetweenCoords(value.x,value.y,value.z,px,py,pz,true) <= value.radius and math.abs(pz-value.z) <= value.height)

			if value.player_in and not player_in then -- was in: leave
				vRPserver.leaveNPC({key})
			elseif not value.player_in and player_in then -- wasn't in: enter
				vRPserver.enterNPC({key})
			end

			value.player_in = player_in -- update area player_in
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		tick = 500
		for i, v in pairs(thePickups) do
			if DoesEntityExist(v) then
				tick = 0
				SetEntityHeading(v, GetEntityHeading(v)+1 %360)
			end
		end
		Wait(tick)
	end
end)

-- DOOR

-- set the closest door state
-- doordef: .model or .modelhash
-- locked: boolean
-- doorswing: -1 to 1
function tvRP.setStateOfClosestDoor(doordef, locked, doorswing)
  local x,y,z = tvRP.getPosition()
  local hash = doordef.modelhash
  if hash == nil then
    hash = GetHashKey(doordef.model)
  end

  SetStateOfClosestDoorOfType(hash,x,y,z,locked,doorswing+0.0001)
end

function tvRP.openClosestDoor(doordef)
  tvRP.setStateOfClosestDoor(doordef, false, 0)
end

function tvRP.closeClosestDoor(doordef)
  tvRP.setStateOfClosestDoor(doordef, true, 0)
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function tvRP.getObjects()
	local objects = {}

	for object in EnumerateObjects() do
		table.insert(objects, object)
	end

	return objects
end

function tvRP.getClosestObjects(filter, coords)
	local objects         = tvRP.getObjects()
	local closestDistance = -1
	local closestObject   = -1
	local filter          = filter
	local coords          = coords

	if type(filter) == 'string' then
		if filter ~= '' then
			filter = {filter}
		end
	end

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #objects, 1 do

		local foundObject = false

		if filter == nil or (type(filter) == 'table' and #filter == 0) then
			foundObject = true
		else
			local objectModel = GetEntityModel(objects[i])

			for j=1, #filter, 1 do
				if objectModel == GetHashKey(filter[j]) then
					foundObject = true
				end
			end
		end

		if foundObject then
			local objectCoords = GetEntityCoords(objects[i])
			local distance     = GetDistanceBetweenCoords(objectCoords, coords.x, coords.y, coords.z, true)
			if closestDistance == -1 or closestDistance > distance then
				closestObject   = objects[i]
				closestDistance = distance
			end
		end

	end

	return closestObject, closestDistance
end

Citizen.CreateThread(function()
    --AddTextEntry('FE_THDR_GTAO', '~b~k2 ~w~Romania ~s~| discord.io/kaliooops')
    AddTextEntry('PM_PANE_LEAVE', 'Vezi lista de servere')
    AddTextEntry('PM_PANE_QUIT', 'Inchide jocul')
    AddTextEntry('PM_SCR_MAP', 'Harta')
    AddTextEntry('PM_SCR_GAM', 'Joc')
    AddTextEntry('PM_SCR_INF', 'Informatii')
    AddTextEntry('PM_SCR_SET', 'Setari')
    AddTextEntry('PM_SCR_GAL', 'Galerie')
    AddTextEntry('PM_SCR_STA', 'Statistici')
    AddTextEntry('PM_SCR_RPL', 'Editor ∑')
end)