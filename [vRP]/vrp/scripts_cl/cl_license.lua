local locatie = vector3(437.24661254883,-979.7412109375,30.68962097168)
Citizen.CreateThread(function()
  local waittime = 1000
  while true do
    Citizen.Wait(waittime)
    fontId = RegisterFontId('Freedom Font')
    if GetDistanceBetweenCoords(locatie[1],locatie[2],locatie[3], GetEntityCoords(GetPlayerPed(-1))) < 3.0 then
      waittime = 0
      DrawMarker(21, locatie[1],locatie[2],locatie[3], 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 18, 233, 143, 255, 0, 0, 0, 1)
      DrawText3D1(locatie[1],locatie[2],locatie[3]+0.4, "~w~DOSAR DMV", 1.0, 4)
    else
      if waittime == 0 then waittime = 1000 end
    end
    if GetDistanceBetweenCoords(locatie[1],locatie[2],locatie[3], GetEntityCoords(GetPlayerPed(-1))) < 1.0 then
     -- drawScreenText1(0.50, 0.90, 0,0, 0.4, "Apasa ~g~E ~w~pentru a cumpara un Dosar DMV! \n~g~$~w~1.000", 255, 255, 255, 230, 1, fontId, 1)
      waittime = 0
      msg ("APASA  ~g~E~w~  PENTRU A CUMPARA UN ~r~DOSAR DMV \n~g~200€",4,0.45,0.93,0.50,255,255,255,255)
      if IsControlJustPressed(0,38)then 
        TriggerServerEvent('cumparapermis')
      end
    else
      if waittime == 0 then waittime = 1000 end
    end
  end
end)

Citizen.CreateThread(function()
  local blip = AddBlipForCoord(locatie[1], locatie[2], locatie[3])
  SetBlipSprite(blip, 498)
  SetBlipScale(blip, 0.8)
  SetBlipColour(blip, 3)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Dosar DMV")
  EndTextCommandSetBlipName(blip)
end)

function msg (text,font,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextScale(scale,scale)
  SetTextColour(r,g,b,a)
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x,y)
end

function DrawText3D1(x,y,z, text, scl, font) 

  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

  local scale = (1/dist)*scl
  local fov = (1/GetGameplayCamFov())*100
  local scale = scale*fov
 
  if onScreen then
      SetTextScale(0.0*scale, 1.1*scale)
      SetTextFont(4)
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