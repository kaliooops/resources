-- Double was here ;x 
-- Muie legend (apropo vinde sorta smartu' ?)

userID = {}
tempID = 0
local distanceToCheck = 5.0


local fontsLoaded = false
local fontId
Citizen.CreateThread(function()
  Citizen.Wait(1000)
  RegisterFontFile('wmk')
  fontId = RegisterFontId('Freedom Font')
  fontsLoaded = true
end)

AddEventHandler("playerSpawned", function(spawn)
	SetCanAttackFriendly(GetPlayerPed(-1), true, false)
	NetworkSetFriendlyFireOption(true)
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
local saititraglamuiemachiamarapunzel = {
    {"Sala de forta",246.01,-264.76,59.92,311,17,0.8},
    --{"Politie",444.64547729492,-991.77990722656,30.689582824707,526,29,0.8},
    {"Armament Politie",460.39306640625,-981.12103271484,30.689577102661,110,3,0.8},
    {"Primarie",-538.74041748047,-215.06581115723,37.649810791016,181,0,0.8}
}
Citizen.CreateThread(function()
    for i,v in pairs(saititraglamuiemachiamarapunzel)do
      local blip = AddBlipForCoord(v[2], v[3], v[4])
      SetBlipSprite(blip, v[5])
      SetBlipScale(blip, v[7])
      SetBlipColour(blip, v[6])
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(v[1])
      EndTextCommandSetBlipName(blip)
    end
end)

ReplaceHudColourWithRgba(255, 0, 0, 255, 255)

local spawn = vector3(-1038.0017089844,-2737.7614746094,20.169298171998)
Citizen.CreateThread(function()
    local waittime = 1000
    while true do
		Citizen.Wait(waittime)
		if(Vdist(GetEntityCoords(GetPlayerPed(-1)),spawn[1],spawn[2],spawn[3]) <= 15.0)then 
            waittime = 0
			DrawMarker(2, spawn[1],spawn[2],spawn[3], 0, 0, 0, 0, 0, 0, 0.401, 0.301, 0.4001, 255, 255, 255, 255, 0, 0, 0, 1)
			DrawText3D563464562341(spawn[1],spawn[2],spawn[3]+0.4, "BUN VENIT PE \n~y~k2 ~w~ROMANIA !", 1.0, 4)
        else
            if waittime == 1000 then
                waittime = 0
            end
        end
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do 
-- 		Citizen.Wait(0)
-- 		HideHudComponentThisFrame( 3 )
-- 		HideHudComponentThisFrame( 4 )
-- 		HideHudComponentThisFrame( 13 ) 
-- 		HideHudComponentThisFrame( 7 )
-- 		HideHudComponentThisFrame( 2 )
-- 		HideHudComponentThisFrame( 8 ) 
-- 		HideHudComponentThisFrame( 6 )
-- 		HideHudComponentThisFrame( 9 )  
-- 	end
-- end)

function DrawText3D563464562341(x,y,z, text, scl, font) 
  
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
--nu inteleg functia asta
-- Citizen.CreateThread(function()
--     while true do
--         Wait(0)
--         for i = 1, 12 do
--             EnableDispatchService(i, false)
--         end
--         SetPlayerWantedLevel(PlayerId(), 0, false)
--         SetPlayerWantedLevelNow(PlayerId(), false)
--         SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
--     end
-- end)



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000)
		SetDiscordAppId(923444722926764032)
		SetDiscordRichPresenceAsset('logo')
        SetDiscordRichPresenceAction(0, "Discord", "https://discord.io/k2roleplay")

		vRPserver.getUserID({}, function(user_id)
			user_id = tonumber(user_id)
			vRPserver.getUserFaction({}, function(faction)
                jucatori = #GetActivePlayers()
				faction = tostring(faction)
                SetRichPresence(GetPlayerName(PlayerId()).." ["..user_id.."]["..faction.."] - "..jucatori.."/256")
			end)
		end)
    end
end)










local crouched = false
CreateThread(function()
    while true do
        Wait(0)
        DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

    end
end)


Citizen.CreateThread( function()
    while true do 
        tick = 10

        local ped = GetPlayerPed( -1 )

            if ( IsDisabledControlJustPressed( 0, 36 ) ) then 

                tick = 0
                RequestAnimSet( "move_ped_crouched" )
                RequestAnimSet( "move_m@casual@d" )

                while ( not HasAnimSetLoaded( "move_ped_crouched" ) and not HasAnimSetLoaded( "move_m@casual@d" ) ) do 
                    Citizen.Wait( 100 )
                end 

                if ( crouched == true ) then 
                    SetPedMovementClipset( ped, "move_m@casual@d", 0.25 )
                    crouched = false 
                elseif ( crouched == false ) then
                    SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                    crouched = true 
                end 
            end

            -- if IsControlJustPressed(0, 20) then
            --     RequestAnimSet( "move_crawl" )
            --     RequestAnimSet( "move_m@casual@d" )
            --     while ( not HasAnimSetLoaded( "move_crawl" ) and not HasAnimSetLoaded( "move_m@casual@d" ) ) do 
            --         Citizen.Wait( 100 )
            --     end 

            --     if ( proned == true ) then 
            --         ClearPedTasksImmediately(ped)
            --         SetPedMovementClipset( ped, "move_m@casual@d", 0.25 )
            --         proned = false 
            --     elseif ( proned == false ) then 
            --         ClearPedTasksImmediately(ped)
            --         TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", GetEntityCoords(ped), 0.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
            --         proned = true 
            --     end 

            -- end

            Wait(tick)
    end
end )


handsup = false

function getSurrenderStatus()
	return handsup
end

RegisterNetEvent('vk_handsup:getSurrenderStatusPlayer')
AddEventHandler('vk_handsup:getSurrenderStatusPlayer',function(event,source)
		if handsup then
			TriggerServerEvent("vk_handsup:reSendSurrenderStatus",event,source,true)
		else
			TriggerServerEvent("vk_handsup:reSendSurrenderStatus",event,source,false)
		end
end)
Citizen.CreateThread(function()
    local dict = "missminuteman_1ig_2"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(5)
		if IsControlJustPressed(1, 323) then --Start holding X
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)


local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        tick = 50

        if once then
            once = false
        end

        if not keyPressed then
            tick = 5
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                tick = 0
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
            tick = 0
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
                tick = 0
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
        Wait(tick)
    end
end)