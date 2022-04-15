Cfvr = {}
Tunnel.bindInterface("fvr_carwash",Cfvr)
Proxy.addInterface("fvr_carwash",Cfvr)
Sfvr = Tunnel.getInterface("fvr_carwash","fvr_carwash")
vRP = Proxy.getInterface("vRP")


local pret = 60
time = 20 --cat sa dureze spalarea
local carwash = {
    {104.03102874756,6622.1728515625,31.828527450562-1},
    {19.568704605102,-1391.9758300782,29.3473777771-1}
}

local test = false
local meniuplm = false
cariswashing = false

-- this cb is used as the main route to transfer data back 
-- and also where we hanld the data sent from js
RegisterNUICallback("main", function(data)
    chat(data.text, {0,255,0})
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        price = pret,
        status = bool,
    })
    if bool == true then
        TransitionToBlurred(5000)
    else
    TransitionFromBlurred(5000)
    end
end




RegisterNUICallback("milbei", function(data)
    if data.action == "leave" then
        meniuplm = false
        SetDisplay(false)
    elseif data.action == "buy" then
        Sfvr.spalamasinutza({pret})
    end
end)

 


---------------

Citizen.CreateThread(function()
    while test do
        Citizen.Wait(0)
        TransitionToBlurred(2000)
        DisableControlAction(0, 1, test) -- LookLeftRight
        DisableControlAction(0, 2, test) -- LookUpDown
        DisableControlAction(0, 142, test) -- MeleeAttackAlternate
        DisableControlAction(0, 18, test) -- Enter
        DisableControlAction(0, 322, test) -- ESC
        DisableControlAction(0, 106, test) -- VehicleMouseControlOverride
    end
    TransitionFromBlurred(2000)
end)

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end

Citizen.CreateThread(function()
    for i = 1, #carwash do
		garageCoords = carwash[i]
		stationBlip = AddBlipForCoord(garageCoords[1], garageCoords[2], garageCoords[3])
		SetBlipSprite(stationBlip, 100)
		SetBlipAsShortRange(stationBlip, true)
	end
    local ticks = 1000
    while true do
        Citizen.Wait(ticks)
        local ped = PlayerPedId()
        local pedcoords = GetEntityCoords(ped)
        for i,v in pairs(carwash) do
            local dist = #(vector3(v[1],v[2],v[3])-pedcoords)
            if dist < 10 and not cariswashing then
                ticks = 1
            DrawMarker(1, v[1], v[2], v[3], 0, 0, 0, 0, 0, 0, 3.0, 3.0, 0.4, 20, 255, 20, 200, 0, 0, 0, 0, 0, 0, 0)
            DrawText3D(v[1],v[2],v[3]+1,"Apasa [~g~E~w~] pentru a spala masina!")    
            if dist < 3 and IsControlJustPressed(0,38) and IsPedInAnyVehicle(ped, -1) then
                SetDisplay(true)
                end
            end 
        end
    end
end)

RegisterNetEvent("fvr:spalamasina")
AddEventHandler("fvr:spalamasina",function()
local pedcoords = GetEntityCoords(PlayerPedId())
local vehicle = GetVehiclePedIsUsing(PlayerPedId())

FreezeEntityPosition(vehicle, true)
if not HasNamedPtfxAssetLoaded("core") then
    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
        Wait(1)
    end
end
UseParticleFxAssetNextCall("core")
water = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", pedcoords.x, pedcoords.y, pedcoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
UseParticleFxAssetNextCall("core")
water2 = StartParticleFxLoopedAtCoord("ent_amb_waterfall_splash_p", pedcoords.x + 2, pedcoords.y, pedcoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

time2 = true
    Citizen.CreateThread(function()
        while time2 do
            Citizen.Wait(1000)
            if(time > 0)then
                cariswashing = true
                time = time - 1
            elseif (time == 0) then
                cariswashing = false
                WashDecalsFromVehicle(vehicle, 1.0)
                SetVehicleDirtLevel(vehicle)
                FreezeEntityPosition(vehicle, false)
                StopParticleFxLooped(water, 0)
                StopParticleFxLooped(water2, 0)
                time2 = false
            end
        end
    end)
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end
