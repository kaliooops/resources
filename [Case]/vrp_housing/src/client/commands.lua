RegisterCommand("createhouse", function(...)
  vRPhousingB.CreateHousePerm({}, function(access)
    if access then
      local plyPed = PlayerPedId()
      ShowNotification("~p~[~w~k2~p~]~w~ Stai in pozitie si apasa ~y~[~p~G~y~] ~w~sa setezi intrarea casei.")
      while not IsControlJustPressed(0,47) do Wait(0); end
      while IsControlPressed(0,47) do Wait(0); end
      
      local entryPos = GetEntityCoords(plyPed)
      local entryHead = GetEntityHeading(plyPed)
      local entryLocation = vector4(entryPos.x,entryPos.y,entryPos.z,entryHead)
      ShowNotification("~p~[~w~k2~p~]~w~ Apasa ~y~[~p~G~y~] ~w~sa setezi locatia garajului SAU ~y~[~p~F~y~] ~w~sa nu setezi.")
      while not IsControlJustPressed(0,47) and not IsControlJustPressed(0,49) do Wait(0); end
      while IsControlPressed(0,47) or IsControlPressed(0,49) do Wait(0); end

      local garageLocation = false
      if IsControlJustReleased(0,47) then
        local garagePos = GetEntityCoords(plyPed)
        local garageHead = GetEntityHeading(plyPed)
        garageLocation = vector4(garagePos.x,garagePos.y,garagePos.z,garageHead)
      end

      local salePrice = false
      ShowNotification("~p~[~w~k2~p~]~w~ Seteaza pretul de vanzare.")
      exports["input"]:Open("Seteaza Pretul Vanzarii",("Native"),function(data)
        local price = (tonumber(data) and tonumber(data) > 0 and tonumber(data) or 0)
        salePrice = math.max(1,price)
      end)
      while not salePrice do Wait(0); end

      ShowNotification("~p~[~w~k2~p~]~w~ Selecteaza interiorul default.")
      local homeShell = false
      local shell = CreateNativeUIMenu("Interior Default","")
      for key,price in pairs(ShellModels) do
        local _item = NativeUI.CreateItem(key,"")
        _item.Activated = function(...) 
          homeShell = key
          _Pool:CloseAllMenus()
        end
        shell:AddItem(_item)
      end
      shell:RefreshIndex()
      shell:Visible(true)
      while not homeShell do Wait(0); end
      ShowNotification("~p~[~w~k2~p~]~w~ Selecteaza interioarele valabile pentru aceasta casa.")
      local shells = {}
      local shell = CreateNativeUIMenu("Interioare Valabile","")
      for k,v in pairs(ShellModels) do
        shells[k] = false
        local _item = NativeUI.CreateCheckboxItem(k,false,"")
        _item.CheckboxEvent = function(a,b,checked)
          shells[k] = checked
        end
        shell:AddItem(_item)  
      end 
      local _item = NativeUI.CreateItem("Terminat","")
      _item.Activated = function(...) 
        ShowNotification("~p~[~w~k2~p~]~w~ ~p~Creearea casei a fost finalizata.")
        _Pool:CloseAllMenus()
        TriggerServerEvent("Allhousing:CreateHouse",{Price = salePrice,Entry = entryLocation,Garage = garageLocation,Shell = homeShell,Shells = shells})
      end
      shell:AddItem(_item)
      shell:RefreshIndex()
      shell:Visible(true)
    end
  end)
end, false)