function GetBlipData(t,zoneCoord)
  if t == "owner" then
    if not Config.HideOwnBlips then
      local color,sprite
      if Config.UseZoneSprites then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        sprite = (Config.ZoneBlipSprites[zone] and Config.ZoneBlipSprites[zone].OwnerSprite or Config.BlipOwnerSprite)
      else
        sprite = Config.BlipOwnerSprite
      end
      if Config.UseZoneColoring then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        color = (Config.ZoneBlipColors[zone] and Config.ZoneBlipColors[zone].OwnerColor or Config.BlipOwnerColor)
      else
        color = Config.BlipOwnerColor
      end
      return color,sprite
    else
      return false
    end
  elseif t == "owned" then
    if not Config.HideSoldBlips then
      local color,sprite
      if Config.UseZoneSprites then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        sprite = (Config.ZoneBlipSprites[zone] and Config.ZoneBlipSprites[zone].OwnedSprite or Config.BlipOwnedSprite)
      else
        sprite = Config.BlipOwnedSprite
      end
      if Config.UseZoneColoring then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        color = (Config.ZoneBlipColors[zone] and Config.ZoneBlipColors[zone].OwnedColor or Config.BlipOwnedColor)
      else
        color = Config.BlipOwnedColor
      end
      return color,sprite
    else
      return false
    end
  elseif t == "empty" then
    if not Config.HideEmptyBlips then
      local color,sprite
      if Config.UseZoneSprites then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        sprite = (Config.ZoneBlipSprites[zone] and Config.ZoneBlipSprites[zone].EmptySprite or Config.BlipEmptySprite)
      else
        sprite = Config.BlipEmptySprite
      end
      if Config.UseZoneColoring then
        local zone = GetZoneAtCoords(zoneCoord.x,zoneCoord.y,zoneCoord.z)
        color = (Config.ZoneBlipColors[zone] and Config.ZoneBlipColors[zone].EmptyColor or Config.BlipEmptyColor)
      else
        color = Config.BlipEmptyColor
      end
      return color,sprite
    else
      return false
    end
  end
end

function RefreshBlips()
  if Config.UseBlips then
    vRPhousingB.getID({}, function(id)
      for _,house in pairs(Houses) do
        if house.Blip then
          RemoveBlip(house.Blip)
        end
        local color,sprite,text
        if house.Owned and house.Owner and (tonumber(house.Owner) == id) then
          text = "Casa Mea"
          color,sprite = GetBlipData("owner",house.Entry)
        elseif house.Owned then
          text = "Casa Jucator"
          color,sprite = GetBlipData("owned",house.Entry)
        else
          text = "Casa Goala"
          color,sprite = GetBlipData("empty",house.Entry)
        end

        if color and sprite then
          house.Blip = CreateBlip(house.Entry,sprite,color,text)
        end
      end
    end)
  end
end

function CreateBlip(pos,sprite,color,text,scale)
  local blip = AddBlipForCoord(pos.x,pos.y,pos.z)
  SetBlipSprite               (blip, (sprite or 1))
  SetBlipColour               (blip, (color or 4))
  SetBlipScale                (blip, (scale or 0.7))
  SetBlipAsShortRange         (blip, true)
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      ((text or "Blip "..tostring(blip)))
  EndTextCommandSetBlipName   (blip)
  return blip
end

function ShowNotification(msg)
  SetNotificationTextEntry('STRING')
  AddTextComponentSubstringPlayerName(msg)
  DrawNotification(false, true)
end

function ShowAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
  if saveToBrief == nil then saveToBrief = true end
  AddTextEntry('ahAdvancedNotification', msg)
  BeginTextCommandThefeedPost('ahAdvancedNotification')
  if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
  EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
  EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

function ShowHelpNotification(msg, thisFrame, beep, duration)
  AddTextEntry('ahHelpNotification', msg)

  if thisFrame then
    DisplayHelpTextThisFrame('ahHelpNotification', false)
  else
    if beep == nil then beep = true end
    BeginTextCommandDisplayHelp('ahHelpNotification')
    EndTextCommandDisplayHelp(0, false, beep, duration or -1)
  end
end

DrawText3D = function(x,y,z, text, col)
  local onScreen,_x,_y = World3dToScreen2d(x,y,z)
  local px,py,pz = table.unpack(GetGameplayCamCoord())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

  if not lastMessage or text ~= lastMessage or not lastDist or dist > lastDist+0.1 or dist < lastDist-0.1 then
    lastMessage = text
    lastDist = dist
    AddTextEntry("3dtext_markers",text)
    updateWidth = true
  end

  if onScreen then
    SetTextColour(255,255,255,200)
    SetTextScale(0.0*scale, 0.40*scale)
    SetTextFont(7)
    SetTextProportional(1)
    SetTextCentre(true)
    SetTextDropshadow(10, 100, 100, 100, 255)
    if updateWidth then
      BeginTextCommandWidth("3dtext_markers")
      height = GetTextScaleHeight(0.45*scale, font)
      width = EndTextCommandGetWidth(font)
      updateWidth = false
    end
    SetTextEntry("3dtext_markers")
    EndTextCommandDisplayText(_x, _y)
    DrawRect(_x, _y+scale/74, width+0.005, height+0.005, (col or 0),(col or 0),(col or 0),100)
  end
end

_Callbacks = {}
_CallbackID = 0
function Callback(event,...)
  local myId = _CallbackID  
  _Callbacks[myId] = false
  _CallbackID = _CallbackID + 1
  TriggerServerEvent("Allhousing:Callback",myId,event,...)

  local start = GetGameTimer()
  while not (_Callbacks[myId]) and (GetGameTimer() - start < 30000) do Wait(0); end

  if not _Callbacks[myId] then 
    return false
  else 
    return table.unpack(_Callbacks[myId])
  end
end

function _Calledback(id,...)
  _Callbacks[id] = {...}
end

GoToDoor = function(p)
  local plyPed = PlayerPedId()
  TaskGoStraightToCoord(plyPed, p.x, p.y, p.z, 10.0, 10, p.w, 0.5)
  local dist = 999
  local tick = 0
  while dist > 0.5 and tick < 10000 do
    local pPos = GetEntityCoords(plyPed)
    dist = Vdist(pPos.x,pPos.y,pPos.z, p.x,p.y,p.z)
    tick = tick + 1
    Citizen.Wait(100)  
  end
  ClearPedTasksImmediately(plyPed)
end

FaceCoordinate = function(pos)
  local plyPed = PlayerPedId()
  TaskTurnPedToFaceCoord(plyPed, pos.x,pos.y,pos.z, -1)
  Wait(1500)
  ClearPedTasks(plyPed)
end

GetVehicleProperties = function(vehicle)
  if DoesEntityExist(vehicle) then
    local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
    local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
    local extras = {}

    for id=0, 12 do
      if DoesExtraExist(vehicle, id) then
        local state = IsVehicleExtraTurnedOn(vehicle, id) == 1
        extras[tostring(id)] = state
      end
    end

    local Trim = function(value)
      if value then
        return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
      else
        return nil
      end
    end

    return {
      model             = GetEntityModel(vehicle),

      plate             = Trim(GetVehicleNumberPlateText(vehicle)),
      plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

      bodyHealth        = GetVehicleBodyHealth(vehicle, 1),
      engineHealth      = math.round(GetVehicleEngineHealth(vehicle), 1),

      fuelLevel         = math.round(GetVehicleFuelLevel(vehicle), 1),
      dirtLevel         = math.round(GetVehicleDirtLevel(vehicle), 1),
      color1            = colorPrimary,
      color2            = colorSecondary,

      pearlescentColor  = pearlescentColor,
      wheelColor        = wheelColor,

      wheels            = GetVehicleWheelType(vehicle),
      windowTint        = GetVehicleWindowTint(vehicle),
      xenonColor        = GetVehicleXenonLightsColour(vehicle),

      neonEnabled       = {
        IsVehicleNeonLightEnabled(vehicle, 0),
        IsVehicleNeonLightEnabled(vehicle, 1),
        IsVehicleNeonLightEnabled(vehicle, 2),
        IsVehicleNeonLightEnabled(vehicle, 3)
      },

      neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
      extras            = extras,
      tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

      modSpoilers       = GetVehicleMod(vehicle, 0),
      modFrontBumper    = GetVehicleMod(vehicle, 1),
      modRearBumper     = GetVehicleMod(vehicle, 2),
      modSideSkirt      = GetVehicleMod(vehicle, 3),
      modExhaust        = GetVehicleMod(vehicle, 4),
      modFrame          = GetVehicleMod(vehicle, 5),
      modGrille         = GetVehicleMod(vehicle, 6),
      modHood           = GetVehicleMod(vehicle, 7),
      modFender         = GetVehicleMod(vehicle, 8),
      modRightFender    = GetVehicleMod(vehicle, 9),
      modRoof           = GetVehicleMod(vehicle, 10),

      modEngine         = GetVehicleMod(vehicle, 11),
      modBrakes         = GetVehicleMod(vehicle, 12),
      modTransmission   = GetVehicleMod(vehicle, 13),
      modHorns          = GetVehicleMod(vehicle, 14),
      modSuspension     = GetVehicleMod(vehicle, 15),
      modArmor          = GetVehicleMod(vehicle, 16),

      modTurbo          = IsToggleModOn(vehicle, 18),
      modSmokeEnabled   = IsToggleModOn(vehicle, 20),
      modXenon          = IsToggleModOn(vehicle, 22),

      modFrontWheels    = GetVehicleMod(vehicle, 23),
      modBackWheels     = GetVehicleMod(vehicle, 24),

      modPlateHolder    = GetVehicleMod(vehicle, 25),
      modVanityPlate    = GetVehicleMod(vehicle, 26),
      modTrimA          = GetVehicleMod(vehicle, 27),
      modOrnaments      = GetVehicleMod(vehicle, 28),
      modDashboard      = GetVehicleMod(vehicle, 29),
      modDial           = GetVehicleMod(vehicle, 30),
      modDoorSpeaker    = GetVehicleMod(vehicle, 31),
      modSeats          = GetVehicleMod(vehicle, 32),
      modSteeringWheel  = GetVehicleMod(vehicle, 33),
      modShifterLeavers = GetVehicleMod(vehicle, 34),
      modAPlate         = GetVehicleMod(vehicle, 35),
      modSpeakers       = GetVehicleMod(vehicle, 36),
      modTrunk          = GetVehicleMod(vehicle, 37),
      modHydrolic       = GetVehicleMod(vehicle, 38),
      modEngineBlock    = GetVehicleMod(vehicle, 39),
      modAirFilter      = GetVehicleMod(vehicle, 40),
      modStruts         = GetVehicleMod(vehicle, 41),
      modArchCover      = GetVehicleMod(vehicle, 42),
      modAerials        = GetVehicleMod(vehicle, 43),
      modTrimB          = GetVehicleMod(vehicle, 44),
      modTank           = GetVehicleMod(vehicle, 45),
      modWindows        = GetVehicleMod(vehicle, 46),
      modLivery         = GetVehicleLivery(vehicle)
    }
  else
    return {}
  end
end

SetWeatherAndTime = function(syncTime)
  if not syncTime then
    if Config.UsingVSync then
      TriggerEvent('vSync:toggle',false)
    end
    
    SetRainFxIntensity(0.0)
    SetBlackout(false)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist('CLEAR')
    SetWeatherTypeNow('CLEAR')
    SetWeatherTypeNowPersist('CLEAR')
    NetworkOverrideClockTime(23,0,0)
  else
    if Config.UsingVSync then
      TriggerEvent('vSync:toggle',true)
      TriggerServerEvent('vSync:requestSync')
    else
      h,m,s = NetworkGetGlobalMultiplayerClock()
      NetworkOverrideClockTime(h,m,s)
    end
  end
end

RegisterNetEvent("Allhousing:Calledback")
AddEventHandler("Allhousing:Calledback",_Calledback)

RegisterNetEvent("Allhousing:NotifyPlayer")
AddEventHandler("Allhousing:NotifyPlayer",ShowNotification)