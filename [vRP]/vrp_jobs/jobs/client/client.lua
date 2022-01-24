vRPjobsC = {}
Tunnel.bindInterface("vRP_jobs",vRPjobsC)
Proxy.addInterface("vRP_jobs",vRPjobsC)
vRP = Proxy.getInterface("vRP")
vRPSjobs = Tunnel.getInterface("vRP_jobs","vRP_jobs")

function drawInfoText(x,y,z, text, scl,font,r,g,b) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        if(font ~= nil)then
            SetTextFont(font)
        else
            SetTextFont(4)
        end
        SetTextProportional(1)

            SetTextColour(r, g, b, 255)
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
function job_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function vRPjobsC.addBlip(x,y,z,idtype,idcolor,text,range)
    local blip = AddBlipForCoord(x+0.001,y+0.001,z+0.001)
    SetBlipSprite(blip, idtype)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip,idcolor)
  
    if text ~= nil then
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(text)
      EndTextCommandSetBlipName(blip)
    end
  
    return blip
  end

  function vRPjobsC.CreateNPC(hash,x,y,z,h)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait( 1 ) end
  
    local npc = CreatePed(4,hash,x,y,z-1,h, false, true)
    SetModelAsNoLongerNeeded()
    SetEntityHeading(npc, h)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
  
    return npc
  end

  function vRPjobsC.IsPlayerInRadius(x,y,z,radius)
    if Vdist(GetEntityCoords(GetPlayerPed(-1)),x,y,z) < radius then
        return true
    else
        return false
    end
end

jobs = {}
jobvehs = {}
text = nil
local missions = {}

function vRPjobsC.setBlipMission(x,y,z)
    local blip = AddBlipForCoord(x,y,z)
    SetBlipRoute(blip,true)
    missions[blip] = true
    TriggerEvent("mission:drawmarker",x,y,z+1.0)
    return blip
end

function vRPjobsC.removeJobBlips()
    for i,v in pairs(missions) do
        SetBlipRoute(i,false)
        RemoveBlip(i)
    end
end


RegisterNetEvent("mission:drawmarker")
AddEventHandler("mission:drawmarker",function(x,y,z)
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            if Vdist(GetEntityCoords(GetPlayerPed(-1)),x,y,z) < 30.0 then
                DrawMarker(1, x,y,z, 0, 0, 0, 0, 0, 0, 0.7001,0.7001,0.7001,245, 222, 0, 150, 0, 1, 0, 1, 0, 0, 0)
                if Vdist(GetEntityCoords(GetPlayerPed(-1)),x,y,z) < 5.0 then
                    Wait(2500)
                    break
                end
            end
        end
    end)
end)

RegisterNetEvent("remove_blip")
AddEventHandler("remove_blip",function(blip)
    RemoveBlip(blip)
end)

  
function shuffle(t)
    local rand = math.random
  
    assert(t, "table.shuffle() expected a table, got nil")
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
  end

  function vRPjobsC.DrawJobText(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*130
    local scale = scale*fov
    
    if onScreen then
      SetTextScale(0.2*scale, 0.5*scale)
      SetTextFont(1)
      SetTextProportional(1)
      SetTextColour( 255,255,255, 250 )
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
  
  function vRPjobsC.draw2DText(width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
      SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    SetTextWrap(0.0,1.0)
    SetTextCentre(true)
    DrawText(1.0 - width/2, 1.0-0.075)
  end
function drawInfoText(x,y,z, text, scl,font,r,g,b) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        if(font ~= nil)then
            SetTextFont(font)
        else
            SetTextFont(4)
        end
        SetTextProportional(1)

            SetTextColour(r, g, b, 255)
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
function job_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function vRPjobsC.addBlip(x,y,z,idtype,idcolor,text,range)
    local blip = AddBlipForCoord(x+0.001,y+0.001,z+0.001)
    SetBlipSprite(blip, idtype)
    SetBlipScale(blip,1.0)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip,idcolor)
  
    if text ~= nil then
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(text)
      EndTextCommandSetBlipName(blip)
    end
  
    return blip
  end

  function vRPjobsC.CreateNPC(hash,x,y,z,h)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Citizen.Wait( 1 ) end
  
    local npc = CreatePed(4,hash,x,y,z-1,h, false, true)
    SetModelAsNoLongerNeeded()
    SetEntityHeading(npc, h)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
  
    return npc
  end

  function vRPjobsC.IsPlayerInRadius(x,y,z,radius)
    if Vdist(GetEntityCoords(GetPlayerPed(-1)),x,y,z) < radius then
        return true
    else
        return false
    end
end

jobs = {}
jobvehs = {}
text = nil
local missions = {}

function vRPjobsC.setBlipMission(x,y,z)
    local blip = AddBlipForCoord(x,y,z)
    SetBlipRoute(blip,true)
    missions[blip] = true
    TriggerEvent("mission:drawmarker",x,y,z+1.0)
    return blip
end

function vRPjobsC.removeJobBlips()
    for i,v in pairs(missions) do
        SetBlipRoute(i,false)
        RemoveBlip(i)
    end
end


RegisterNetEvent("mission:drawmarker")
AddEventHandler("mission:drawmarker",function(x,y,z)
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            if Vdist(GetEntityCoords(GetPlayerPed(-1)),x,y,z) < 30.0 then
                DrawMarker(1, x,y,z, 0, 0, 0, 0, 0, 0, 0.7001,0.7001,0.7001,245, 222, 0, 150, 0, 1, 0, 1, 0, 0, 0)
                if Vdist(GetEntityCoords(GetPlayerPed(-1)),x,y,z) < 5.0 then
                    Wait(2500)
                    break
                end
            end
        end
    end)
end)

RegisterNetEvent("remove_blip")
AddEventHandler("remove_blip",function(blip)
    RemoveBlip(blip)
end)

  
function shuffle(t)
    local rand = math.random
  
    assert(t, "table.shuffle() expected a table, got nil")
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
  end

  function vRPjobsC.DrawJobText(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*130
    local scale = scale*fov
    
    if onScreen then
      SetTextScale(0.2*scale, 0.5*scale)
      SetTextFont(1)
      SetTextProportional(1)
      SetTextColour( 255,255,255, 250 )
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
  
  function vRPjobsC.draw2DText(width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
      SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    SetTextWrap(0.0,1.0)
    SetTextCentre(true)
    DrawText(1.0 - width/2, 1.0-0.075)
  end
local function RGBRainbow( frequency )
    local result = {}
    local curtime = GetGameTimer() / 1000

    result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
    result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
    result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
    
    return result
end

local fontId
Citizen.CreateThread(function()
    RegisterFontFile('wmk')
    fontId = RegisterFontId('Freedom Font')
end)

