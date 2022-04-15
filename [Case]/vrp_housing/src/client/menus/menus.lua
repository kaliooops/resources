OpenMenu = function(...)
  if Config.UsingNativeUI then
    menuType = "NativeUI"
  end

  if menuType == "NativeUI" then
    NativeUIHandler(...)
  end
end

UnlockHouse = function(house)
  if InsideHouse then
    InsideHouse.Unlocked = true
  else
    house.Unlocked = true
  end
  TriggerServerEvent("Allhousing:UnlockDoor",house)
  ShowNotification("~p~Casa ~w~Descuiata.")
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end
end

LockHouse = function(house)
  if InsideHouse then
    InsideHouse.Unlocked = false
  else
    house.Unlocked = false
  end
  TriggerServerEvent("Allhousing:LockDoor",house)
  ShowNotification("~p~Casa ~w~Incuiata.")
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end
end

GetVehiclesAtHouse = function(house)
  local data = Callback("Allhousing:GetVehicles",house)
  return data
end

OpenWardrobe = function()
  vRPhousingB.openWardrobe({InsideHouse.Id})
end

OpenChest = function()
  vRPhousingB.openChest({InsideHouse.Id})
end

SetWardrobe = function(d)
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end

  ShowNotification("Apasa ~p~[G] ~w~cand esti in pozitie sa setezi ~p~garderoba.")
  while true do
    if IsControlJustPressed(0,58) then
      local pos = d.Entry.xyz - GetEntityCoords(GetPlayerPed(-1))
      InsideHouse.Wardrobe = pos + Config.SpawnOffset
      TriggerServerEvent("Allhousing:SetWardrobe",d,InsideHouse.Wardrobe)
      ShowNotification("~w~Locatia ~p~Garderoberi ~w~a fost setata!")
      return
    end
    Wait(0)
  end
end

SetInventory = function(d)
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end

  ShowNotification("~w~Apasa ~p~[G] ~w~cand esti in pozitie sa setezi ~p~cufarul.")
  while true do
    if IsControlJustPressed(0,58) then
      local pos = d.Entry.xyz - GetEntityCoords(GetPlayerPed(-1))
      InsideHouse.InventoryLocation = pos + Config.SpawnOffset
      TriggerServerEvent("Allhousing:SetInventory",d,InsideHouse.InventoryLocation)
      ShowNotification("~w~Locatia ~p~Cufarului ~w~a fost setata!")
      return
    end
    Wait(0)
  end
end

SetOutfit = function(index,label)
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end
  vRPhousingB.setOutfit()
end

OpenFurniture = function(d)
  ShowNotification("~w~Apasa ~p~[F] ~w~sa ~p~deschizi/inchizi ~w~meniul de ~p~mobilare.")
  TriggerEvent("Allhousing:OpenFurni")    

  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end
end

GiveKeys = function(d,serverId)
  TriggerServerEvent("Allhousing:GiveKeys",d,serverId)
  ShowNotification("~w~Ai dat cheile ~p~jucatorului.")
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end
end

TakeKeys = function(d,data)
  TriggerServerEvent("Allhousing:TakeKeys",d,data)
  ShowNotification("~w~Ai luat cheile ~p~jucatorului.")

  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end
end

MoveGarage = function(d)
  local last_dist = Vdist(d.Garage.xyz,d.Entry.xyz)
  local ped = GetPlayerPed(-1)
  FreezeEntityPosition(ped,false)

  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end

  ShowNotification("~w~Apasa ~p~[E] ~w~sa setezi locatia ~p~garajului ~w~SAU ~p~[G] ~w~sa nu setezi.")
  while true do
    if IsControlJustPressed(0,38) then
      local ped = GetPlayerPed(-1)
      local pos = GetEntityCoords(ped)
      if Vdist(pos,d.Entry.xyz) <= last_dist+15.0 then
        local head = GetEntityHeading(ped)
        d.Garage = vector4(pos.x,pos.y,pos.z,head)
        TriggerServerEvent("Allhousing:SetGarageLocation",d.Id,d.Garage)
        ShowNotification("~w~Locatia ~p~garajului ~w~a fost setata cu succes!")
        return
      else
        ShowNotification("~w~Locatia ~p~garajului ~w~este prea departe de casa!")
      end
    elseif IsControlJustPressed(0,47) then
      ShowNotification("~w~Schimbarea ~p~locatiei ~w~a ~p~garajului ~w~a fost anulata!")
      return
    end
    Wait(0)
  end
end

InviteInside = function(d,serverId)
  TriggerServerEvent("Allhousing:InviteInside",d,serverId)
end

BuyHouse = function(d)
  vRPhousingB.GetPlayerFullCash({}, function(AllCash)
    if tonumber(AllCash) then
      if tonumber(AllCash) >= tonumber(d.Price) then
        ShowNotification("~w~Ai cumparat casa pentru ~p~$"..tonumber(d.Price))
        vRPhousingB.getID({}, function(id)
          d.Owner = id
          d.Owned = true

          if Config.UsingNativeUI and _Pool then
            _Pool:CloseAllMenus()
          end

          TriggerServerEvent("Allhousing:PurchaseHouse",d)
        end)
      else
        ShowNotification("~r~Nu ai destui bani pentru a cumpara aceasta casa")
      end
    end
  end)
  FreezeEntityPosition(GetPlayerPed(-1),false)
end

KnockOnDoor = function(d)  
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end

  GoToDoor(d.Entry)
  FaceCoordinate(d.Entry)
  TriggerServerEvent("Allhousing:KnockOnDoor",d.Entry)
  local plyPed = GetPlayerPed(-1)
  while not HasAnimDictLoaded("timetable@jimmy@doorknock@") do RequestAnimDict("timetable@jimmy@doorknock@"); Wait(0); end
  TaskPlayAnim(plyPed, "timetable@jimmy@doorknock@", "knockdoor_idle", 8.0, 8.0, -1, 4, 0, 0, 0, 0 )     
  Wait(0)

  while IsEntityPlayingAnim(plyPed, "timetable@jimmy@doorknock@", "knockdoor_idle", 3) do Citizen.Wait(0); end 

  RemoveAnimDict("timetable@jimmy@door@knock@")
end

LeaveHouse = function(d)
  LeavingHouse = true
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end

  DoScreenFadeOut(500)
  TriggerEvent("Allhousing:Leave")
  Wait(1000)

  local plyPed = GetPlayerPed(-1)

  SetEntityCoordsNoOffset(plyPed, InsideHouse.Entry.x,InsideHouse.Entry.y,InsideHouse.Entry.z)
  SetEntityHeading(plyPed, InsideHouse.Entry.w - 180.0)

  Wait(500)
  DoScreenFadeIn(500)

  SetEntityAsMissionEntity(InsideHouse.Object,true,true)
  DeleteObject(InsideHouse.Object)
  DeleteEntity(InsideHouse.Object)

  if InsideHouse and InsideHouse.Extras then
    for k,v in pairs(InsideHouse.Extras) do
      SetEntityAsMissionEntity(v,true,true)
      DeleteObject(v)
    end
  end

  InsideHouse = false
  SetWeatherAndTime(true)
  LeavingHouse = false
end

SpawnHouse = function(d)
  local model = ShellModels[d.Shell]
  local hash  = GetHashKey(model)

  local start = GetGameTimer()
  while not HasModelLoaded(hash) and GetGameTimer() - start < 10000 do RequestModel(hash); Wait(0); end
  if not HasModelLoaded(hash) then
    ShowNotification(string.format("Interior Invalid: %s, te rog sa raportezi problema asta la Fondator.",model))
    return false,false
  end

  local shell = CreateObject(hash, d.Entry.x + Config.SpawnOffset.x,d.Entry.y + Config.SpawnOffset.y,d.Entry.z - 30.0 + Config.SpawnOffset.z,false,false)
  FreezeEntityPosition(shell,true)
  while not DoesEntityExist(shell) do Wait(0); end

  SetEntityAsMissionEntity(shell,true,true)
  SetModelAsNoLongerNeeded(hash)

  local extras = {}
  if ShellExtras[d.Shell] then
    for objHash,data in pairs(ShellExtras[d.Shell]) do
      RequestModel(objHash)
      while not HasModelLoaded(objHash) do Wait(0); end

      local pos = d.Entry.xyz + data.offset + Config.SpawnOffset
      local rot = data.rotation
      local obj = CreateObject(objHash, pos.x,pos.y,pos.z - 30.0, false,false)
      FreezeEntityPosition(obj,true)
      while not DoesEntityExist(obj) do Wait(0); end
      if rot then
        SetEntityRotation(obj,rot.x,rot.y,rot.z,2)
      end
      SetEntityAsMissionEntity(obj,true,true)
      SetModelAsNoLongerNeeded(objHash)
      table.insert(extras,obj)
    end
  end

  local pos = vector3(d.Entry.x,d.Entry.y,d.Entry.z)
  for k,v in pairs(d.Furniture) do
    local objHash = GetHashKey(v.model)
    RequestModel(objHash)
    while not HasModelLoaded(objHash) do Wait(0); end

    local obj = CreateObject(objHash, pos.x + v.pos.x, pos.y + v.pos.y, pos.z + v.pos.z, false,false,false)
    FreezeEntityPosition(obj, true)
    SetEntityCoordsNoOffset(obj, pos.x + v.pos.x, pos.y + v.pos.y, pos.z + v.pos.z)
    SetEntityRotation(obj, v.rot.x, v.rot.y, v.rot.z, 2)

    SetModelAsNoLongerNeeded(objHash)

    table.insert(extras,obj)
  end

  return shell,extras
end

TeleportInside = function(d,v)  
  local exitOffset = vector4(ShellOffsets[d.Shell]["exit"].x - Config.SpawnOffset.x,ShellOffsets[d.Shell]["exit"].y - Config.SpawnOffset.y,ShellOffsets[d.Shell]["exit"].z - Config.SpawnOffset.z,ShellOffsets[d.Shell]["exit"].w)
  if type(exitOffset) ~= "vector4" or exitOffset.w == nil then
    ShowNotification("~w~Offset-ul este stricat pentru aceasta casa: ~p~"..d.Id..", ~w~te rog sa raportezi problema asta la ~p~Fondator.")
    return
  end

  local plyPed = GetPlayerPed(-1)
  FreezeEntityPosition(plyPed,true)

  DoScreenFadeOut(1000)
  while not IsScreenFadedOut() do Wait(0); end  

  ClearPedTasksImmediately(plyPed)

  local shell,extras = SpawnHouse(d)
  if shell and extras then
    SetEntityCoordsNoOffset(plyPed, d.Entry.x - exitOffset.x,d.Entry.y - exitOffset.y,d.Entry.z - exitOffset.z)
    SetEntityHeading(plyPed, exitOffset.w)

    local start_time = GetGameTimer()
    while (not HasCollisionLoadedAroundEntity(plyPed) and GetGameTimer() - start_time < 2000) do Wait(0); end
    FreezeEntityPosition(plyPed,false)

    DoScreenFadeIn(500)

    InsideHouse = d
    InsideHouse.Extras = extras
    InsideHouse.Object = shell
    InsideHouse.Visiting = v  
  else
    FreezeEntityPosition(plyPed,false)
    DoScreenFadeIn(500)
  end
end

ViewHouse = function(d)
  EnterHouse(d,true)
  
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end
end

EnterHouse = function(d,visiting)
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end

  TriggerEvent("Allhousing:Enter",d)
  TeleportInside(d,visiting)
  SetWeatherAndTime(true)
end

UpgradeHouse = function(d,data)
  vRPhousingB.GetPlayerFullCash({}, function(AllCash)
    if AllCash >= ShellPrices[data.shell] then
      TriggerServerEvent("Allhousing:UpgradeHouse",d,data.shell)
      ShowNotification("~w~Interior Upgradat La: ~p~"..tostring(data.shell))
      d.Shell = data.shell
      if InsideHouse then
        local _visiting = InsideHouse.Visiting
        LeaveHouse(d)
        EnterHouse(d,_visiting)
      end
    else
      ShowNotification("~r~Nu ai destui bani pentru acest upgrade la interior")
    end
  end)

  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end
end

SellHouse = function(d)
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  end

  exports["input"]:Open("Seteaza Pretul Vanzarii",("Native"), function(data)
    local price = (tonumber(data) and tonumber(data) > 0 and tonumber(data) or 0)
    local floored = tonumber(price)

    Wait(100)

    if Config.UsingNativeUI then
      NativeConfirmSaleMenu(d,floored)
    end
  end)
end

MenuThread = function()
  while true do
    if _Pool and _Pool:IsAnyMenuOpen() then
      _Pool:ControlDisablingEnabled(false)
      _Pool:MouseControlsEnabled(false)
      _Pool:ProcessMenus()
    end
    Wait(0)
  end
end

Citizen.CreateThread(MenuThread)