NativeUIHandler = function(d,t,st)
  if t == "Entry" then
    if st == "Owner" then
      NativeEntryOwnerMenu(d)
    elseif st == "Owned" then
      NativeEntryOwnedMenu(d)
    elseif st == "Empty" then
      NativeEntryEmptyMenu(d)
    end
  elseif t == "Garage" then
    if st == "Owner" then
      NativeGarageOwnerMenu(d)
    elseif st == "Owned" then
      NativeGarageOwnedMenu(d)
    end
  elseif t == "Iesire" then
    if st == "Owner" then
      NativeExitOwnerMenu(d)
    elseif st == "Owned" then
      NativeExitOwnedMenu(d)
    elseif st == "Empty" then
      NativeExitEmptyMenu(d)
    end
  elseif t == "Garderoba" then
    if st == "Owner" or st == "Owned" then
      OpenWardrobe(d)
    end
  elseif t == "Cufar" then
    OpenChest(d)
  end
end

CreateNativeUIMenu = function(title,subtitle)
  if _Pool then _Pool:Remove(); end
  _Pool = NativeUI.CreatePool()

  local ResX,ResY = GetActiveScreenResolution()
  local xPos = ResX - (ResX > 2560 and 1050 or 550)
  local menu = NativeUI.CreateMenu(title,subtitle,xPos,250)

  _Pool:Add(menu)

  return menu
end

NativeConfirmSaleMenu = function(d,floored)
  _Pool:CloseAllMenus()

  local sellMenu = CreateNativeUIMenu("Confirma Vanzarea","Pune Casa La Vanzare Pentru $"..floored)

  local confirm = NativeUI.CreateItem("Da, Pune Casa La Vanzare.","CONFIRMA")
  confirm.Activated = function(...) 
    ShowNotification("~w~Casa Pusa La Vanzare Pentru ~p~$"..floored)
    d.Owner = 0
    d.Owned = false

    if InsideHouse then LeaveHouse(d); end
    TriggerServerEvent("Allhousing:SellHouse",d,floored)

    _Pool:CloseAllMenus()
  end
  sellMenu:AddItem(confirm)

  local cancel = NativeUI.CreateItem("Nu, Nu Mai Casa Pune La Vanzare.","ANULEAZA")
  cancel.Activated = function(...) 
    _Pool:CloseAllMenus()
  end
  sellMenu:AddItem(cancel)

  sellMenu:RefreshIndex()
  sellMenu:Visible(true)
end

NativeOpenInvite = function(d)
  _Pool:CloseAllMenus()

  local inviteMenu = CreateNativeUIMenu("Invita In Casa","")

  local t = 0
  local playerPed = GetPlayerPed(-1)
  for _, i in pairs(GetActivePlayers()) do
    local targetServerID = GetPlayerServerId(i)
    local targetPed = GetPlayerPed(i)
    local name = GetPlayerName(i)
    if playerPed ~= targetPed then
      local x,y,z = table.unpack(GetEntityCoords(targetPed,true))
      local distance = GetDistanceBetweenCoords(x,y,z,d.Entry,true)
      if distance <= 10 then
        local _item = NativeUI.CreateItem(name,"Invita In Casa")
        _item.Activated = function(...) InviteInside(d,targetServerID); vRP.notify({"~w~L-ai invitat pe ~p~"..name.." ~w~in casa ta!"})end
        inviteMenu:AddItem(_item)
        t = t + 1
      end
    end
  end
 
  if t == 0 then
    local _item = NativeUI.CreateItem("Nu Sunt Jucatori Langa Usa Casei Tale.","")
    inviteMenu:AddItem(_item)
  end

  inviteMenu:RefreshIndex()
  inviteMenu:Visible(true)
end

NativeCreateKeysMenu = function(d,menu) 
  local keys = _Pool:AddSubMenu(menu,"Cheile Casei","Interior: "..d.Shell,true,true) 
  local giveKeys = _Pool:AddSubMenu(keys.SubMenu,"Da Cuiva Cheile Casei","Interior: "..d.Shell,true,true)
  local takeKeys = _Pool:AddSubMenu(keys.SubMenu,"Ia Cuiva Cheile Casei","Interior: "..d.Shell,true,true)
  keys.SubMenu:RefreshIndex()

  local t = 0
  local playerPed = GetPlayerPed(-1)
  local px,py,pz = vRP.getPosition()
  for _, i in pairs(GetActivePlayers()) do
    local targetServerID = GetPlayerServerId(i)
    local targetPed = GetPlayerPed(i)
    local name = GetPlayerName(i)
    if playerPed ~= targetPed then
      local x,y,z = table.unpack(GetEntityCoords(targetPed,true))
      local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
      if distance <= 3 then
        local _item = NativeUI.CreateItem(name,"Da Cuiva Cheile Casei")
        _item.Activated = function(...) GiveKeys(d,targetServerID); end
        giveKeys.SubMenu:AddItem(_item)
        t = t + 1
      end
    end
  end

  if t == 0 then
    local _item = NativeUI.CreateItem("Nu Sunt Jucatori Langa Tine","")
    giveKeys.SubMenu:AddItem(_item)
  end

  t = 0
  for k,v in pairs(Houses) do
    if v.Entry == d.Entry then
      for _,data in pairs(v.HouseKeys) do
        local _item = NativeUI.CreateItem(data.name,"Ia Cuiva Cheile Casei")
        _item.Activated = function(...) TakeKeys(v,data); end
        takeKeys.SubMenu:AddItem(_item)
        t = t + 1
      end
    end
  end

  if t == 0 then
    local _item = NativeUI.CreateItem("Nu Sunt Jucatori Cu Cheile Casei Tale","")
    takeKeys.SubMenu:AddItem(_item)
  end

  giveKeys.SubMenu:RefreshIndex()
  takeKeys.SubMenu:RefreshIndex()
end

NativeCreateUpgradeMenu = function(d,menu,empty)  
  local upgrade = _Pool:AddSubMenu(menu,(not empty and "Upgradeaza Casa" or "Upgrade-uri Valabile"),"Interior: "..d.Shell,true,true)
  local c = 0
  local dataTable = {}
  local sortedTable = {}
  for k,v in pairs(d.Shells) do
    local price = ShellPrices[k]
    if price then
      dataTable[price.."_"..k] = {
        available = v,
        price = price,
        shell = k,
      }
      table.insert(sortedTable,price.."_"..k)
    end
  end
  table.sort(sortedTable)

  for key,price in pairs(sortedTable) do
    local data = dataTable[price]
    if data.available and d.Shell ~= data.shell then
      local _item = NativeUI.CreateItem(data.shell,"Interior: "..d.Shell)
      _item:RightLabel("$"..data.price)
      if not empty then 
        _item.Activated = function(...) UpgradeHouse(d,data); end
      end
      upgrade.SubMenu:AddItem(_item)
      c = c + 1
    end    
  end

  if c == 0 then
    local _item = NativeUI.CreateItem("Nu Este Nici Un Upgrade Valabil","")
    upgrade.SubMenu:AddItem(_item)
  end
  upgrade.SubMenu:RefreshIndex()
end

NativeCreateSellMenu = function(d,menu)
  local sell = _Pool:AddSubMenu(menu,"Vinde Casa","Interior: "..d.Shell,true,true)  
  local verifyItem = NativeUI.CreateItem("Confirma","Pune Casa La Vanzare.")
  local cancelItem = NativeUI.CreateItem("Nu Mai Vreau","Nu Mai Pune Casa La Vanzare.")

  verifyItem.Activated = function() _Pool:CloseAllMenus(); SellHouse(d); end
  cancelItem.Activated = function() _Pool:CloseAllMenus(); end

  sell.SubMenu:AddItem(verifyItem)
  sell.SubMenu:AddItem(cancelItem)
  sell.SubMenu:RefreshIndex()
end

DoOpenNativeGarage = function(d)
  local garageMenu = CreateNativeUIMenu("Garaj","Casa Jucator")
  local vehicles = GetVehiclesAtHouse(d)
  
  if (#vehicles > 0) then
    for _,vehData in pairs(vehicles) do
      local vehicleMenu = NativeUI.CreateItem("["..vehData.plate.."] ","Scoate Vehiculul Din Garaj")
      vehicleMenu.Activated = function(...)
        ShowNotification("~w~Scoti vehiculul din garaj...")
        local timp = math.random(0,2000)
        SetTimeout(timp, function()
          vRPhousingB.isVehicleAlreadyOutOfGarage({vehData.vehicle,vehData.plate}, function(isVehicleAlreadyOutOfGarage)
            if isVehicleAlreadyOutOfGarage then
              ShowNotification("~w~Vehiculul cu placuta ~p~["..vehData.plate.."] ~w~este deja scos din garaj!")
            else
              ShowNotification("~w~Ai scos vehiculul din garaj!")
              vRP.spawnGarageVehicle({vehData.type,vehData.vehicle,vehData.plate,d})
            end
          end)
        end)
        garageMenu:Visible(false)
      end
      garageMenu:AddItem(vehicleMenu)
    end
  else
    local invalid = NativeUI.CreateItem("Nu Sunt Vehicule Disponibile In Acest Garaj","")
    garageMenu:AddItem(invalid)
  end

  garageMenu:RefreshIndex()
  garageMenu:Visible(true)
end

NativeGarageOwnerMenu = function(d)
  local garageMenu = CreateNativeUIMenu("Garaj","Casa Mea")
  local vehicles = GetVehiclesAtHouse(d)

  if(#vehicles > 0)then
    for _,vehData in pairs(vehicles) do
      local vehicleMenu = NativeUI.CreateItem("["..vehData.plate.."] Placuta","Scoate Vehiculul Din Garaj")
      vehicleMenu.Activated = function(...)
        ShowNotification("~w~Scoti vehiculul din garaj...")
        local timp = math.random(0,2000)
        SetTimeout(timp, function()
          vRPhousingB.isVehicleAlreadyOutOfGarage({vehData.vehicle,vehData.plate}, function(isVehicleAlreadyOutOfGarage)
            if isVehicleAlreadyOutOfGarage then
              ShowNotification("~w~Vehiculul cu placuta ~p~["..vehData.plate.."] ~w~este deja scos din garaj!")
            else
              ShowNotification("~w~Ai scos vehiculul din garaj!")
              vRP.spawnGarageVehicle({vehData.type,vehData.vehicle,vehData.plate,d})
            end
          end)
        end)
        garageMenu:Visible(false)
      end
      garageMenu:AddItem(vehicleMenu)
    end
  else
    local invalid = NativeUI.CreateItem("Nu Sunt Vehicule Disponibile In Acest Garaj","")
    garageMenu:AddItem(invalid)
  end

  garageMenu:RefreshIndex()
  garageMenu:Visible(true)
end

NativeGarageOwnedMenu = function(d)
  vRPhousingB.getID({}, function(id)
    for k,v in pairs(d.HouseKeys) do
      if v.identifier == id then
        DoOpenNativeGarage(d)
        return
      end
    end
  end)
end

NativeExitOwnerMenu = function(d)
  local exitMenu = CreateNativeUIMenu("Iesire Casa","Casa Mea")

  local invite = NativeUI.CreateItem("Invita In Casa","Interior: "..d.Shell)
  invite.Activated = function(...) NativeOpenInvite(d); end
  exitMenu:AddItem(invite)

  NativeCreateKeysMenu(d,exitMenu)

  NativeCreateUpgradeMenu(d,exitMenu)

  if Config.AllowHouseSales then
    NativeCreateSellMenu(d,exitMenu)
  end

  local furni = NativeUI.CreateItem("Mobileaza Casa","Interior: "..d.Shell)
  furni.Activated = function(...) OpenFurniture(d); end
  exitMenu:AddItem(furni)

  local wardrobe = NativeUI.CreateItem("Seteaza Garderoba","Interior: "..d.Shell)
  wardrobe.Activated = function(...) SetWardrobe(d); end
  exitMenu:AddItem(wardrobe)

  local inventory = NativeUI.CreateItem("Seteaza Cufarul","Interior: "..d.Shell)
  inventory.Activated = function(...) SetInventory(d); end
  exitMenu:AddItem(inventory)

  if d.Unlocked then
    local lock = NativeUI.CreateItem("Incuie Casa","Interior: "..d.Shell)
    lock.Activated = function(...) LockHouse(d); end
    exitMenu:AddItem(lock)
  else
    local unlock = NativeUI.CreateItem("Descuie Casa","Interior: "..d.Shell)
    unlock.Activated = function(...) UnlockHouse(d); end
    exitMenu:AddItem(unlock)
  end

  local leave = NativeUI.CreateItem("Iesi Din Casa","Interior: "..d.Shell)
  leave.Activated = function(...) LeaveHouse(d); end
  exitMenu:AddItem(leave)

  exitMenu:RefreshIndex()
  exitMenu:Visible(true)
end

NativeExitOwnedMenu = function(d)
  local exitMenu = CreateNativeUIMenu("Iesire Casa","Casa Jucator")

  local leave = NativeUI.CreateItem("Iesi Din Casa","Interior: "..d.Shell)
  leave.Activated = function(...) LeaveHouse(d); end
  exitMenu:AddItem(leave)

  vRPhousingB.getID({}, function(id)
    for k,v in pairs(d.HouseKeys) do
      if v.identifier == id then
        local invite = NativeUI.CreateItem("Invita In Casa","Interior: "..d.Shell)
        invite.Activated = function(...) NativeOpenInvite(d); end
        exitMenu:AddItem(invite)

        local furni = NativeUI.CreateItem("Mobileaza Casa","Interior: "..d.Shell)
        furni.Activated = function(...) OpenFurniture(d); end
        exitMenu:AddItem(furni)
        break
      end
    end
  end)

  exitMenu:RefreshIndex()
  exitMenu:Visible(true)
end

NativeExitEmptyMenu = function(d)
  local exitMenu = CreateNativeUIMenu("Iesire Casa","Casa Goala")

  local leave = NativeUI.CreateItem("Iesi Din Casa","Interior: "..d.Shell)
  leave.Activated = function(...) LeaveHouse(d); end
  exitMenu:AddItem(leave)

  exitMenu:RefreshIndex()
  exitMenu:Visible(true)
end

NativeEntryOwnerMenu = function(d)
  local entryMenu = CreateNativeUIMenu("Intrare Casa","Casa Mea")

  local enter = NativeUI.CreateItem("Intra In Casa","Interior: "..d.Shell)
  enter.Activated = function(...) EnterHouse(d); end
  entryMenu:AddItem(enter)

  NativeCreateUpgradeMenu(d,entryMenu)

  if d.Unlocked then
    local lock = NativeUI.CreateItem("Incuie Casa","Interior: "..d.Shell)
    lock.Activated = function(...) LockHouse(d); end
    entryMenu:AddItem(lock)
  else
    local unlock = NativeUI.CreateItem("Descuie Casa","Interior: "..d.Shell)
    unlock.Activated = function(...) EnterHouse(d); end
    entryMenu:AddItem(unlock)
  end

  if d.Garage then
    local move = NativeUI.CreateItem("Muta Garajul","Interior: "..d.Shell)
    move.Activated = function(...) MoveGarage(d); end
    entryMenu:AddItem(move)
  end
  
  if Config.AllowHouseSales then
    NativeCreateSellMenu(d,entryMenu)
  end

  entryMenu:RefreshIndex()
  entryMenu:Visible(true)
end

NativeEntryOwnedMenu = function(d)
  local entryMenu = CreateNativeUIMenu("Intrare Casa","Casa Jucator")

  local hasKeys = false
  vRPhousingB.getID({}, function(id)
    for k,v in pairs(d.HouseKeys) do
      if v.identifier == id then
        local enter = NativeUI.CreateItem("Intra In Casa","Interior: "..d.Shell)
        enter.Activated = function(...) EnterHouse(d); end
        entryMenu:AddItem(enter)
        hasKeys = true
        break
      end
    end
  end)

  if not hasKeys then
    local knock = NativeUI.CreateItem("Bate La Usa","Interior: "..d.Shell)
    knock.Activated = function(...) KnockOnDoor(d); end
    entryMenu:AddItem(knock)

    if d.Unlocked then
      local enterHouse = NativeUI.CreateItem("Intra In Casa","Interior: "..d.Shell)
      enterHouse.Activated = function(...) EnterHouse(d,true); end
      entryMenu:AddItem(enterHouse)
    end
  end

  entryMenu:RefreshIndex()
  entryMenu:Visible(true)
end

NativeEntryEmptyMenu = function(d)
  local entryMenu = CreateNativeUIMenu("Intrare Casa","Casa Goala")

  local buy = NativeUI.CreateItem("Cumpara Casa","Interior: "..d.Shell)
  local visit = NativeUI.CreateItem("Viziteaza Casa","Interior: "..d.Shell)
  buy.Activated = function(...) BuyHouse(d); end
  visit.Activated = function(...) ViewHouse(d); end

  buy:RightLabel("$"..d.Price)

  entryMenu:AddItem(buy)
  entryMenu:AddItem(visit)

  NativeCreateUpgradeMenu(d,entryMenu,true)

  entryMenu:RefreshIndex()
  entryMenu:Visible(true)
end
