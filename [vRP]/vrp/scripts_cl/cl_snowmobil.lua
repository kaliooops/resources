local pos = {x=-1495.0540771484,y=4977.4736328125,z=63.433647155762}
----------------------------------------------------------------------------------
Citizen.CreateThread(function()
  local blip = AddBlipForCoord(-1495.0540771484,4977.4736328125,63.433647155762)
  SetBlipSprite(blip, 512)
  SetBlipScale(blip, 0.8)
  SetBlipColour(blip, 0)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("ATV Rent")
  EndTextCommandSetBlipName(blip)
end)
----------------------------------------------------------------------------------
Citizen.CreateThread(function()
  local waittime = 1000
  while true do
    Citizen.Wait(waittime)
    if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, GetEntityCoords(GetPlayerPed(-1))) < 20.0 then
      waittime = 0
    DrawMarker(6, pos.x,pos.y,pos.z+0.25, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 255,255,255, 200, 0, 0, 0, 1, 0, 0, 0)
    DrawMarker(36, pos.x,pos.y,pos.z+0.25, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 98, 20, 208, 200, 0, 0, 0, 1, 0, 0, 0)
    --DrawMarker(36, pos.x,pos.y,pos.z+0.25, 0, 0, 0, 0, 0, 0, 1.0,1.0,1.0, 255, 153, 51, 200, 1, 1, 0, 1, 0, 0, 0)
    text_overflow(pos.x,pos.y, pos.z + 1, "Pret : 300€")
    text_overflow(pos.x,pos.y, pos.z + 1.25, "Inchiriaza un ATV")
      if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, GetEntityCoords(GetPlayerPed(-1))) < 3.0 then -- here u can set up ur position, this is a test position
        license_text("Apasa ~INPUT_CONTEXT~ pentru a inchiria un ATV!")
        if IsControlJustPressed(1, 51) then
          if IsInVehicle() then
            TriggerEvent('vRP_Ren: pedincar')
          else
            TriggerServerEvent('vRP_ren: payment')
          end
        end
      end
    else
      if waittime == 0 then waittime = 1000 end
    end
  end
end)
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
RegisterNetEvent('vRP_Ren: spawncar')
AddEventHandler('vRP_Ren: spawncar', function()
  local myPed = GetPlayerPed(-1)
  local player = PlayerId()
  local vehicle = GetHashKey('blazer')
  RequestModel(vehicle)
  while not HasModelLoaded(vehicle) do
    Wait(1)
  end
  local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
  local spawned_car = CreateVehicle(vehicle, coords, GetEntityHeading(myPed), true, false)
  SetVehicleOnGroundProperly(spawned_car)
  SetVehicleNumberPlateText(spawned_car, "SNOW")
  SetModelAsNoLongerNeeded(vehicle)
  SetPedIntoVehicle(myPed,spawned_car,-1)
  Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(spawned_car))
end)

RegisterNetEvent('vRP_Ren: message')
AddEventHandler('vRP_Ren: message', function()
    SetNotificationTextEntry("STRING")
    AddTextComponentString("Ai inchiriat un ATV.")
    SetNotificationMessage("CHAR_CARSITE", "CHAR_CARSITE", true, 1, "Inchiriaza acum!")
    DrawNotification(false, true)
end)

  RegisterNetEvent('vRP_Ren: pedincar')
  AddEventHandler('vRP_Ren: pedincar', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("You're in a car! :)")
      SetNotificationMessage("CHAR_CARSITE", "CHAR_CARSITE", true, 1, "Inchiriaza acum!")
      DrawNotification(false, true)
  end)

  RegisterNetEvent('vRP_Ren: notenough')
  AddEventHandler('vRP_Ren: notenough', function()
      SetNotificationTextEntry("STRING")
      AddTextComponentString("Nu ai destui bani!")
      SetNotificationMessage("CHAR_CARSITE", "CHAR_CARSITE", true, 1, "Inchiriaza acum!")
      DrawNotification(false, true)
  end)

RegisterNetEvent( 'vRP_Ren: deleteveh' )
AddEventHandler( 'vRP_Ren: deleteveh', function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )        
            local licenseplate = GetVehicleNumberPlateText(vehicle)

                  if licenseplate == "  SNOW  " then
                    SetEntityAsMissionEntity( vehicle, true, true )
                    deleteCar( vehicle )
                  end

                if ( DoesEntityExist( vehicle ) ) then 
                  ShowNotification( "~r~Nu am gasit masina inchiriata!" )
                else 
                  ShowNotification( "Timpul a expirat!" )
                end 
        else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, 5.0, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )
            local licenseplate = GetVehicleNumberPlateText(vehicle)

            if ( DoesEntityExist( vehicle ) ) then 

                  if licenseplate == "  SNOW  " then
                    SetEntityAsMissionEntity( vehicle, true, true )
                    deleteCar( vehicle )
                  end

                if ( DoesEntityExist( vehicle ) ) then 
                  ShowNotification( "~r~Nu am gasit masina inchiriata!" )
                else 
                  ShowNotification( "Timpul a expirat!" )
                end 
            else 
                ShowNotification( "Trebuie sa fii aproape de masina..." )
            end 
        end 
    end 
end ) 
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
function text_overflow(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*130
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.2*scale, 0.5*scale)
        SetTextFont(6)
        SetTextProportional(1)
    SetTextColour( 255, 255, 255, 255 )
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
      World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

function timp(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
  SetTextColour( 0,0,0, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
  SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

function license_text(str)
  SetTextComponentFormat("STRING")
  AddTextComponentString(str)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


--------------------------------------------------------------------------------------------------------------
-- Double was here ;)
