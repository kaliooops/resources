Citizen.CreateThread(function()
    local waittime = 1000
    while true do 
        Citizen.Wait(waittime)
        if(Vdist(GetEntityCoords(GetPlayerPed(-1)),460.19183349609,-981.16168212891,30.689580917358) <= 5.0)then  
            waittime = 0
            DrawText3D111(460.19183349609,-981.16168212891,30.689580917358+0.4, "[~b~E~w~] Pentru a te echipa", 0.9, 4)
            if IsControlPressed(0, 38)then 
                TriggerServerEvent("double:politai")
            end
        elseif(Vdist(GetEntityCoords(GetPlayerPed(-1)),298.50366210938,-598.35833740234,43.284027099609) <= 5.0)then  
            waittime = 0
            DrawText3D111(298.50366210938,-598.35833740234,43.284027099609+0.4, "[~r~E~w~] Pentru a te echipa", 0.9, 4)
            if IsControlPressed(0, 38)then 
                TriggerServerEvent("double:smurdan")
            end
        else
            if waittime == 0 then
                waittime = 1000
            end
        end
    end
end)

RegisterNetEvent('double:smurd')
AddEventHandler('double:smurd', function()
    giveWeapon("weapon_stungun")
    giveWeapon("weapon_nightstick")
    AddArmourToPed(ped, 100)
    notify('Te-ai echipat cu ~g~Succes')
end)

RegisterNetEvent('double:politie')
AddEventHandler('double:politie', function()
    giveWeapon("weapon_pistol")
    giveWeapon("weapon_stungun")
    giveWeapon("weapon_nightstick")
    giveWeapon("weapon_carbinerifle")
    giveWeapon("weapon_assaultsmg")
    giveWeapon("weapon_assaultshotgun")
    AddArmourToPed(ped, 100)
    notify('Te-ai echipat cu ~g~Succes')
end)

function giveWeapon(weaponHash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weaponHash), 999, false, false)
end

function notify(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end

function DrawText3D111(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(font)
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