vRPhousingC = {}
Tunnel.bindInterface("vRP_housing",vRPhousingC)
Proxy.addInterface("vRP_housing",vRPhousingC)
vRP = Proxy.getInterface("vRP")
vRPhousingB = Tunnel.getInterface("vRP_housing", "vRP_housing")

Init = function()
  local startTime = GetGameTimer()
  Wait(1000)
  
  StartData = Callback("Allhousing:GetHouseData")
  Houses = StartData.Houses
  RefreshBlips()
  Update()
end

Update = function()
  local wTime = 2000
  while true do
    local do_render = false
    if not InsideHouse then
      do_render = RenderExterior()
    else
      do_render = RenderInterior()
    end
    if do_render then
      wTime = 1
    else
      wTime = 2000
    end
    Wait(wTime)
    wTime = 2000
  end
end

local spasmTimer = 100
local markerColors = {
  [1] = {r = 0, g = 255, b = 0, a = 155},
  [2] = {r = 255, g = 0, b = 0, a = 155},
  [3] = {r = 0, g = 0, b = 0, a = 155},
  [4] = {r = 0, g = 0, b = 255, a = 155},
  [5] = {r = 255, g = 255, b = 0, a = 155},
  [6] = {r = 0, g = 255, b = 255, a = 155},
  [7] = {r = 255, g = 255, b = 255, a = 155},
}
local textColors = {
  [1] = "~p~",
  [2] = "~r~",
  [3] = "~b~",
  [4] = "~o~",
  [5] = "~p~",
  [6] = "~y~",
  [7] = "~w~",
}

local markerSelection = 1
local selectedMarker = markerColors[markerSelection]
local selectedColors = textColors[markerSelection]

local int_closest,int_dist,int_pos,last_pos
RenderInterior = function()
  local res = false
  local plyPed = PlayerPedId()
  local plyPos = GetEntityCoords(plyPed)
  local now = GetGameTimer()
  if not LastIntCheck or not last_pos or now - LastIntCheck > 1000 or Vdist(last_pos,plyPos) > 2.0 then
    LastIntCheck = now
    int_dist = false
    last_pos = plyPos
    local exitDist = Vdist(plyPos,InsideHouse.Entry.xyz - ShellOffsets[InsideHouse.Shell]["exit"].xyz + Config.SpawnOffset)
    local wardrobeDist = (InsideHouse.Wardrobe and InsideHouse.Owned and not InsideHouse.Visiting and Vdist(plyPos,InsideHouse.Entry.xyz - InsideHouse.Wardrobe + Config.SpawnOffset) or false)
    local inventoryDist = (InsideHouse.InventoryLocation and InsideHouse.Owned and not InsideHouse.Visiting and Vdist(plyPos,InsideHouse.Entry.xyz - InsideHouse.InventoryLocation + Config.SpawnOffset) or false)
    if wardrobeDist and wardrobeDist < exitDist then
      int_closest = "Garderoba"
      int_pos = InsideHouse.Wardrobe
      int_dist = wardrobeDist
    else
      int_closest = "Iesire"
      int_pos = ShellOffsets[InsideHouse.Shell].exit
      int_dist = exitDist
    end

    if inventoryDist and inventoryDist < int_dist then
      int_closest = "Cufar"
      int_pos = InsideHouse.InventoryLocation
      int_dist = inventoryDist
    end
  end

  if Config.UseMarkers and int_dist < Config.InteractDistance then
    res = true
    DrawMarker(1,InsideHouse.Entry.x - int_pos.x + Config.SpawnOffset.x,InsideHouse.Entry.y - int_pos.y + Config.SpawnOffset.y,InsideHouse.Entry.z - int_pos.z-1.5 + Config.SpawnOffset.z, 0.0,0.0,0.0, 0.0,0.0,0.0, 1.0,1.0,1.0, selectedMarker.r,selectedMarker.g,selectedMarker.b,selectedMarker.a, false,true,2)
  end

  if Config.Use3DText and int_dist < Config.TextDistance3D then
    if int_dist < Config.InteractDistance then
      DrawText3D(InsideHouse.Entry.x - int_pos.x + Config.SpawnOffset.x,InsideHouse.Entry.y - int_pos.y + Config.SpawnOffset.y,InsideHouse.Entry.z - int_pos.z+0.1 + Config.SpawnOffset.z, "["..selectedColors.."E~s~] "..int_closest)
    else
      DrawText3D(InsideHouse.Entry.x - int_pos.x + Config.SpawnOffset.x,InsideHouse.Entry.y - int_pos.y + Config.SpawnOffset.y,InsideHouse.Entry.z - int_pos.z+0.1 + Config.SpawnOffset.z, int_closest)
    end
    res = true
  end

  if Config.UseHelpText and int_dist < Config.InteractDistance then
    ShowHelpNotification("~INPUT_PICKUP~ "..int_closest)
    res = true
  end

  if int_dist < Config.InteractDistance and IsControlJustPressed(0,38) then
    vRPhousingB.getID({}, function(id)
      OpenMenu(InsideHouse,int_closest,((InsideHouse.Visiting and "Empty") or (InsideHouse.Owner and tonumber(InsideHouse.Owner) == id and "Owner") or (InsideHouse.Owned and "Owned") or "Empty"))
      res = true
    end)
  end
  return res
end

RegisterCommand('house', function(...)  
  local plyPos = GetEntityCoords(PlayerPedId())
  local closestDist,closest
  for _,thisHouse in pairs(Houses) do
    local dist = Vdist(plyPos,thisHouse.Entry.xyz)
    if not closestDist or dist < closestDist then
      closest = thisHouse
      closestDist = dist
    end
  end
  if closest and closestDist and closestDist < 50.0 then
    ShowNotification("~p~[~w~k2~p~]~w~ Casa Numar: ~r~"..closest.Id)
  end
end, false)

local ext_dist,ext_key,ext_house
RenderExterior = function()
  local res = false
  local plyPed = PlayerPedId()
  local plyPos = GetEntityCoords(plyPed)

  local now = GetGameTimer()
  if not LastExtCheck or not last_pos or now - LastExtCheck > 5000 or Vdist(last_pos,plyPos) > 2.0 then
    last_pos = plyPos
    LastExtCheck = now
    ext_dist = false
    for _,thisHouse in pairs(Houses) do
      local closestDist,closestKey
      local entryDist = Vdist(plyPos,thisHouse.Entry.xyz)
      local garageDist = (thisHouse.Garage and Vdist(plyPos,thisHouse.Garage.xyz) or false)

      if not garageDist or entryDist < garageDist then
        closestDist = entryDist
        closestKey = "Entry"
      else
        closestDist = garageDist
        closestKey = "Garage"
      end

      if not ext_dist or closestDist < ext_dist then
        ext_dist = closestDist
        ext_key = closestKey
        ext_house = thisHouse
      end
    end
  end

  if ext_dist and ext_dist < 100.0 then
    if Config.UseMarkers and ext_dist < Config.MarkerDistance then
      if ext_key == "Entry" then
        DrawMarker(1,ext_house.Entry.x,ext_house.Entry.y,ext_house.Entry.z-1.6, 0.0,0.0,0.0, 0.0,0.0,0.0, 1.0,1.0,1.0, selectedMarker.r,selectedMarker.g,selectedMarker.b,selectedMarker.a, false,true,2)
      elseif ext_key == "Garage" then
        DrawMarker(1,ext_house.Garage.x,ext_house.Garage.y,ext_house.Garage.z-1.6, 0.0,0.0,0.0, 0.0,0.0,0.0, 1.0,1.0,1.0, selectedMarker.r,selectedMarker.g,selectedMarker.b,selectedMarker.a, false,true,2)
      end
      res = true
    end

    if Config.Use3DText and ext_dist < Config.TextDistance3D then
      if ext_key == "Entry" then
        if ext_dist < Config.InteractDistance then
          DrawText3D(ext_house.Entry.x,ext_house.Entry.y,ext_house.Entry.z+0.1, "["..selectedColors.."E~s~] Intrare Casa")
        else
          DrawText3D(ext_house.Entry.x,ext_house.Entry.y,ext_house.Entry.z+0.1, "Intrare Casa")
        end
      elseif ext_key == "Garage" then
        if ext_dist < Config.InteractDistance then
          DrawText3D(ext_house.Garage.x,ext_house.Garage.y,ext_house.Garage.z+0.1, "["..selectedColors.."E~s~] Garaj Casa")
        else            
          DrawText3D(ext_house.Garage.x,ext_house.Garage.y,ext_house.Garage.z+0.1, "Garaj Casa")
        end
      end
      res = true
    end

    if Config.UseHelpText and ext_dist < Config.HelpTextDistance then
      if ext_key == "Entry" and not BeingInvited then
        ShowHelpNotification("~INPUT_PICKUP~ Intrare Casa")
      elseif ext_key == "Garage" then
        ShowHelpNotification("~INPUT_PICKUP~ Garaj Casa")
      end
      res = true
    end

    if ext_dist < Config.InteractDistance then
      res = true
      if IsControlJustPressed(0,38) then
        vRPhousingB.getID({}, function(id)
          local ped = PlayerPedId()
          local car = GetVehiclePedIsIn(ped, false)
          if car and GetPedInVehicleSeat(car, -1) == ped then
            if ext_house.Owned and (tonumber(ext_house.Owner) == id) then
              local veh = GetVehiclePedIsUsing(ped)
              local props = GetVehicleProperties(veh)
              local ownerInfo = Callback("Allhousing:GetVehicleOwner",props.plate)
              if ownerInfo.owned and ownerInfo.owner then
                TaskEveryoneLeaveVehicle(veh)
                SetEntityAsMissionEntity(veh,true,true)
                TriggerServerEvent("Allhousing:VehicleStored",ext_house.Id,props.plate)
                ShowNotification("~p~[~w~k2~p~]~w~ ~p~Vehicul Parcat.")
              else
                ShowNotification("~p~[~w~k2~p~]~w~ ~r~Acest vehicul nu este al tau, nu il poti parca la garaj!")
              end
            else
              for k,v in pairs(ext_house.HouseKeys) do
                if v.identifier == id then
                  local ped = PlayerPedId()
                  local veh = GetVehiclePedIsUsing(ped)
                  local props = GetVehicleProperties(veh)
                  local ownerInfo = Callback("Allhousing:GetVehicleOwner",props.plate)
                  if ownerInfo.owned and v.identifier == id then
                    TaskEveryoneLeaveVehicle(veh)
                    SetEntityAsMissionEntity(veh,true,true)
                    TriggerServerEvent("Allhousing:VehicleStored",ext_house.Id,props.plate)
                    ShowNotification("~p~[~w~k2~p~]~w~ ~p~Vehicul Parcat.")
                  else
                    ShowNotification("~p~[~w~k2~p~]~w~ ~r~Acest vehicul nu este al tau, nu il poti parca la garaj!")
                  end
                  return
                end
              end
              ShowNotification("~p~[~w~k2~p~]~w~ ~r~Aceasta casa nu este a ta!")
            end
          else
            if ext_house.Owned and (tonumber(ext_house.Owner) == id) then
              OpenMenu(ext_house,ext_key,"Owner")
            elseif ext_house.Owned then
              OpenMenu(ext_house,ext_key,"Owned")
            else
              OpenMenu(ext_house,ext_key,"Empty")
            end
          end
        end)
      end
    end
  end
  return res
end

RefreshInterior = function()
  if InsideHouse then
    for k,v in pairs(Houses) do
      if v.Entry == InsideHouse.Entry then
        InsideHouse.HouseKeys = v.HouseKeys
      end
    end
  end
end

Sync = function(data)
  local _key
  for k,house in pairs(Houses) do
    if house.Blip then
      RemoveBlip(house.Blip)
      house.Blip = false
      if InsideHouse and InsideHouse.Id == house.Id then
        _key = k
      end
    end
  end
  
  Houses = data
  RefreshBlips()
  if _key then
    InsideHouse = Houses[_key]
  end
end

SyncHouse = function(sync_house)
  local house = Houses[sync_house.Id]
  if not house then
    Houses[sync_house.Id] = sync_house
    house = Houses[sync_house.Id]
  end
  if house.Blip then
    RemoveBlip(house.Blip)
    house.Blip = false
  end
  if house.Id == sync_house.Id then
    if house.Blip then
      RemoveBlip(house.Blip)
    end

    Houses[sync_house.Id] = sync_house

    if InsideHouse and InsideHouse.Id == sync_house.Id then
      sync_house.Extras = InsideHouse.Extras
      sync_house.Object = InsideHouse.Object
      sync_house.Visiting = InsideHouse.Visiting  
      InsideHouse = Houses[sync_house.Id]
    end

    if Config.UseBlips then
      vRPhousingB.getID({}, function(id)
        local color,sprite,text
        if Houses[sync_house.Id].Owned and Houses[sync_house.Id].Owner and (tonumber(Houses[sync_house.Id].Owner) == id) then
          text = "Casa Mea"
          color,sprite = GetBlipData("owner",Houses[sync_house.Id].Entry)
        elseif Houses[sync_house.Id].Owned then
          text = "Casa Jucator"
          color,sprite = GetBlipData("owned",Houses[sync_house.Id].Entry)
        else
          text = "Casa Goala"
          color,sprite = GetBlipData("empty",Houses[sync_house.Id].Entry)
        end
        if color and sprite then
          Houses[sync_house.Id].Blip = CreateBlip(Houses[sync_house.Id].Entry,sprite,color,text)
        end
      end)
    end
  end
  LastExtCheck = 0
end

Invited = function(house)
  local plyPed = PlayerPedId()
  local plyPos = GetEntityCoords(plyPed)
  if Vdist(plyPos,house.Entry.xyz) < 50.0 then
    ShowNotification("~p~[~w~k2~p~]~w~ Ai fost invitat in casa de langa tine. Apasa ~p~[~p~G~p~] ~w~pentru a intra!")
    BeingInvited = true
    while Vdist(GetEntityCoords(plyPed),house.Entry.xyz) < 50.0 do
      if IsControlJustPressed(0,47) then
        ViewHouse(house)
        BeingInvited = false
        return
      end
      Wait(0)
    end
    BeingInvited = false
    ShowNotification("~p~[~w~k2~p~]~w~ ~r~Te-ai mutat prea departe de usa casei!")
  else    
    ShowNotification("~p~[~w~k2~p~]~w~ ~r~Te-ai mutat prea departe de usa casei!")
  end
end

KnockAtDoor = function(entry)
  vRPhousingB.getID({}, function(id)
    if InsideHouse and InsideHouse.Entry == entry and InsideHouse.Owner and tonumber(InsideHouse.Owner) == id then
      ShowNotification("~p~[~w~k2~p~]~w~ Cineva iti bate la usa!")
    end
  end)
end

Boot = function(id,enter)
  if InsideHouse and InsideHouse.Id == id and not LeavingHouse then
    local _id = InsideHouse.Id
    LeaveHouse()
    if enter then
      for k,v in pairs(Houses) do
        if v.Id == _id then
          EnterHouse(v)
          return
        end
      end
    end
  end
end

RegisterNetEvent("Allhousing:Sync")
AddEventHandler("Allhousing:Sync", Sync)

RegisterNetEvent("Allhousing:SyncHouse")
AddEventHandler("Allhousing:SyncHouse", SyncHouse)

RegisterNetEvent("Allhousing:Boot")
AddEventHandler("Allhousing:Boot", Boot)

RegisterNetEvent("Allhousing:Invited")
AddEventHandler("Allhousing:Invited", Invited)

RegisterNetEvent("Allhousing:KnockAtDoor")
AddEventHandler("Allhousing:KnockAtDoor", KnockAtDoor)

Citizen.CreateThread(Init)