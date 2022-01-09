vRPCbb = {}
Tunnel.bindInterface("vRP_boombox",vRPCbb)
Proxy.addInterface("vRP_boombox",vRPCbb)
vRPSbb = Tunnel.getInterface("vRP_boombox","vRP_boombox")
vRP = Proxy.getInterface("vRP")

local placed = nil
local obj = nil
local prop = "prop_boombox_01"
local coords = {121.36611175537,-1282.2862548828,29.480518341064}

loadoutObj = nil


Citizen.CreateThread(function()
    local blip = AddBlipForCoord(coords[1], coords[2], coords[3])
    SetBlipSprite(blip, 93)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 48)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Vanilla Club")
    EndTextCommandSetBlipName(blip)
  end)

Citizen.CreateThread(function()
  while true do
    if(loadoutObj == nil)then
      model = "prop_boombox_01" -- apa_mp_h_din_table_11
      RequestModel(GetHashKey(model))
      while not HasModelLoaded(GetHashKey(model)) do
        Wait(0)
      end
      loadoutObj = CreateObject(GetHashKey(model), coords[1], coords[2], coords[3]-0.2, false, false)
      FreezeEntityPosition(loadoutObj, true)
      SetEntityHeading(loadoutObj,300.0)
      SetEntityDynamic(loadoutObj, false)
    end
  
    Citizen.Wait(15)
  end
end)

Citizen.CreateThread(function()
    while true do
        if Vdist(GetEntityCoords(GetPlayerPed(-1)),coords[1],coords[2],coords[3]) < 15.0 then
            DrawText3D(coords[1],coords[2],coords[3]+0.8, "[~g~E~w~] - Porneste Melodie", 255,255,255,255, 4, 1.0)
            DrawText3D(coords[1],coords[2],coords[3]+0.7, "[~o~PAGE UP~w~] - Volum", 255,255,255,255, 4, 1.0)
            DrawText3D(coords[1],coords[2],coords[3]+0.6, "[~r~PAGE DOWN~w~] - Opreste Melodia", 255,255,255,255, 4, 1.0)
            if Vdist(GetEntityCoords(GetPlayerPed(-1)),coords[1],coords[2],coords[3]) < 1.5 then
                if(IsDisabledControlJustPressed(0, 38))then -- START SONG
                    vRPSbb.openPrompt({})
                elseif(IsDisabledControlJustPressed(0, 11))then -- STOP SONG 
                    vRPSbb.stopSong({})
                elseif(IsDisabledControlJustPressed(0, 10))then -- VOLUME OF THE SONG
                    vRPSbb.setVolume({})
                end
            end
        end
        Wait(0)
    end
end)

local newSong = false
function vRPCbb.playSound(id)

    SendNUIMessage({
        transactionType = 'playSound',
        transactionData = id
    })
    print("starting ".. id)

    newSong = true
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(50)
            local d = distance(loadoutObj) 
            
            SendNUIMessage({
                transactionType = 'volume',
                transactionData = math.max( 0, 100 - 100/30 * d )
            })
        
            if newSong then break end
        end
    end)
    newSong = false

end

function vRPCbb.stopSong()
    if distance(object) < 20.0 then
        SendNUIMessage({
            transactionType = 'stopSound'
        })
    end
end

function vRPCbb.setVolume(volume)
    if distance(object) < 20.0 then
        SendNUIMessage({
            transactionType = 'volume',
            transactionData = volume
        })
    end
end

function distance(object)
    local playerPed = PlayerPedId()
    local lCoords = GetEntityCoords(playerPed)
    local distance  = GetDistanceBetweenCoords(lCoords, 121.36611175537,-1282.2862548828,29.480518341064, true)
    return distance
end

function DrawText3D(x,y,z, text, r,g,b,a, font, scale)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, true)
  
    if onScreen then
    local CoordFrom = GetEntityCoords(PlayerPedId(), true)
        local RayHandle = StartShapeTestRay(CoordFrom.x, CoordFrom.y, CoordFrom.z, x, y, z, -1, PlayerPedId(), 0)
        local _, _, _, _, object = GetShapeTestResult(RayHandle)
    if(object == 0) or (object == nil)then
      local fov = (1/GetGameplayCamFov())*100
      local scale = (1/dist)*scale
      local scale = scale*fov
      
      SetTextScale(scale, scale)
      SetTextFont(font)
      SetTextProportional(1)
      SetTextColour(r, g, b, a)
      SetTextDropshadow(0, 0, 0, 0, 100)
      SetTextEdge(2, 0, 0, 0, 150)
      SetTextEntry("STRING")
      SetTextCentre(1)
      SetTextOutline()
      AddTextComponentString(text)
      DrawText(_x,_y)
    end
    end
end