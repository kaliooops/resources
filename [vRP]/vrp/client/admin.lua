vRPserver = Tunnel.getInterface("vRP","vRP")

function ShowMPMessage(message, subtitle, ms)
	Citizen.CreateThread(function()
		Citizen.Wait(0)
		function Initialize(scaleform)
				local scaleform = RequestScaleformMovie(scaleform)
				while not HasScaleformMovieLoaded(scaleform) do
						Citizen.Wait(0)
				end
				PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
				PushScaleformMovieFunctionParameterString(message)
				PushScaleformMovieFunctionParameterString(subtitle)
				PopScaleformMovieFunctionVoid()
				Citizen.SetTimeout(6500, function()
						PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
						PushScaleformMovieFunctionParameterInt(1)
						PushScaleformMovieFunctionParameterFloat(0.33)
						PopScaleformMovieFunctionVoid()
						Citizen.SetTimeout(3000, function() EndScaleformMovieMethod() end)
				end)
				return scaleform
		end

		scaleform = Initialize("mp_big_message_freemode")

		while true do
			Citizen.Wait(0)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 150, 0)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		fontId = RegisterFontId('Freedom Font')
		Citizen.Wait(1)
	end
end)

function drwTicket(text,centre,x,y,scale,r,g,b,a)
  SetTextFont(fontId)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x, y)
end


local tickets = 0
function tvRP.setTickets(amm)
  tickets = amm
end


local aduty = false

RegisterCommand("aduty", function() 
  aduty = not aduty
end, false)

function tvRP.setAdmin()
  Citizen.CreateThread(function()
    Citizen.Wait(1)
    while true do
      if aduty then
        drwTicket("TICKETS: ~y~".. tickets.."",1,0.185,0.918,0.55*0.49,255,255,255,255) 
      end
      Citizen.Wait(3)
    end
  end)
end

RegisterNetEvent("Black:curataStrada")
AddEventHandler("Black:curataStrada", function(radius)
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    local fRadius = radius + 0.0
    ClearAreaOfObjects(x, y, z, fRadius, 1)
    ClearAreaOfCops(x, y, z, fRadius, 1)
    ClearAreaOfPeds(x, y, z, fRadius, 1)
    ClearAreaOfProjectiles(x, y, z, fRadius, 1)
    ClearAreaOfVehicles(x, y, z, fRadius, false, false, false, false, false)
end)

function tvRP.adminAnnouncement(msg)
    local scalingForm = true
    local function Initialize(scaleform)
        local scaleform = RequestScaleformMovie(scaleform)
        while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(0)
        end
        PushScaleformMovieFunction(scaleform, "SHOW_WEAPON_PURCHASED")
        PushScaleformMovieFunctionParameterString("~b~Anunt Admin")
        PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
        PushScaleformMovieFunctionParameterString(msg)
        PopScaleformMovieFunctionVoid()
        Citizen.SetTimeout(6500, function()
                PushScaleformMovieFunction(scaleform, "SHARD_ANIM_OUT")
                PushScaleformMovieFunctionParameterInt(1)
                PushScaleformMovieFunctionParameterFloat(0.33)
                PopScaleformMovieFunctionVoid()
                Citizen.SetTimeout(3000, function() EndScaleformMovieMethod(); scalingForm = false end)
        end)
        return scaleform
    end

    local scaleform = Initialize("mp_big_message_freemode")

    while scalingForm do
        Citizen.Wait(0)
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 150, 0)
    end
end

local noClipConfig = {
    controls = {
        -- [[Controls, list can be found here : https://docs.fivem.net/game-references/controls/]]
        closeKey = 73, -- [[X]]
        goUp = 85, -- [[Q]]
        goDown = 48, -- [[Z]]
        turnLeft = 34, -- [[A]]
        turnRight = 35, -- [[D]]
        goForward = 32,  -- [[W]]
        goBackward = 33, -- [[S]]
        changeSpeed = 21, -- [[L-Shift]]
        togInvisibiliy = 23 -- [[F]]
    },

    speeds = {
        -- [[If you wish to change the speeds or labels there are associated with then here is the place.]]
        { speed = 0},
        { speed = 0.5},
        { speed = 2},
        { speed = 4},
        { speed = 6},
        { speed = 10},
        { speed = 20},
        { speed = 45}
    },

    offsets = {
        y = 0.5, -- [[How much distance you move forward and backward while the respective Button is pressed]]
        z = 0.2, -- [[How much distance you move upward and downward while the respective button is pressed]]
        h = 3, -- [[How much you rotate. ]]
    },

    -- [[Background colour of the buttons. (It may be the standard black on first opening, just re-opening.)]]
    bgR = 0, -- [[Red]]
    bgG = 0, -- [[Green]]
    bgB = 0, -- [[Blue]]
    bgA = 140, -- [[Alpha]]
}

local noclipActive, index, noclipEntity, noclipInvisibility = false, 1, nil, false

function tvRP.toggleNoclip()

	local pedId = PlayerPedId()
	noclipActive = not noclipActive

  if IsPedInAnyVehicle(pedId, false) then
      noclipEntity = GetVehiclePedIsIn(pedId, false)
  else
      noclipEntity = pedId
  end

  SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
  FreezeEntityPosition(noclipEntity, noclipActive)
  SetEntityInvincible(noclipEntity, noclipActive)
  SetVehicleRadioEnabled(noclipEntity, not noclipActive)

  if noclipInvisibility then
  	noclipInvisibility = not noclipInvisibility
  	SetEntityVisible(noclipEntity, not noclipInvisibility, 0)
		if noclipEntity ~= PlayerPedId() then
			SetEntityVisible(PlayerPedId(), not noclipInvisibility, 0)
		end
  end
end

function tvRP.isNoclip()
  return noclipActive
end

local function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function setupScaleform(scaleform)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(6)
    N_0xe83a3e3557a56640(GetControlInstructionalButton(2, noClipConfig.controls.closeKey, true))
    ButtonMessage("Inchide No-Clip")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(5)
    N_0xe83a3e3557a56640(GetControlInstructionalButton(2, noClipConfig.controls.goUp, true))
    ButtonMessage("Sus")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    N_0xe83a3e3557a56640(GetControlInstructionalButton(2, noClipConfig.controls.goDown, true))
    ButtonMessage("Jos")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    N_0xe83a3e3557a56640(GetControlInstructionalButton(1, noClipConfig.controls.turnRight, true))
    N_0xe83a3e3557a56640(GetControlInstructionalButton(1, noClipConfig.controls.turnLeft, true))
    ButtonMessage("Stanga / Dreapta")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    N_0xe83a3e3557a56640(GetControlInstructionalButton(1, noClipConfig.controls.goBackward, true))
    N_0xe83a3e3557a56640(GetControlInstructionalButton(1, noClipConfig.controls.goForward, true))
    ButtonMessage("Fata / Spate")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    N_0xe83a3e3557a56640(GetControlInstructionalButton(2, noClipConfig.controls.togInvisibiliy, true))
    ButtonMessage("Invizibilitate")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    N_0xe83a3e3557a56640(GetControlInstructionalButton(2, noClipConfig.controls.changeSpeed, true))
    ButtonMessage("Viteza ("..index..")")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(noClipConfig.bgR)
    PushScaleformMovieFunctionParameterInt(noClipConfig.bgG)
    PushScaleformMovieFunctionParameterInt(noClipConfig.bgB)
    PushScaleformMovieFunctionParameterInt(noClipConfig.bgA)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

Citizen.CreateThread(function()

  local buttons = setupScaleform("instructional_buttons")

  local currentSpeed = noClipConfig.speeds[index].speed

  while true do
    Citizen.Wait(1000)
    
    while noclipActive do
      Citizen.Wait(1)

      if IsControlJustPressed(1, noClipConfig.controls.closeKey) then
      	tvRP.toggleNoclip()
      end
      
      DrawScaleformMovieFullscreen(buttons)

			local yoff = 0.0
			local zoff = 0.0

			if IsControlJustPressed(1, noClipConfig.controls.changeSpeed) then
				if index ~= #noClipConfig.speeds then
					index = index+1
					currentSpeed = noClipConfig.speeds[index].speed
				else
					currentSpeed = noClipConfig.speeds[1].speed
					index = 1
				end
				setupScaleform("instructional_buttons")
			end

			DisableControlAction(0, 23, true)
			DisableControlAction(0, 30, true)
			DisableControlAction(0, 31, true)
			DisableControlAction(0, 32, true)
			DisableControlAction(0, 33, true)
			DisableControlAction(0, 34, true)
			DisableControlAction(0, 35, true)
			DisableControlAction(0, 266, true)
			DisableControlAction(0, 267, true)
			DisableControlAction(0, 268, true)
			DisableControlAction(0, 269, true)
			DisableControlAction(0, 44, true)
			DisableControlAction(0, 20, true)
			DisableControlAction(0, 74, true)
			DisableControlAction(0, 75, true)

			if IsDisabledControlPressed(0, noClipConfig.controls.goForward) then
				yoff = noClipConfig.offsets.y
			end

			if IsDisabledControlPressed(0, noClipConfig.controls.goBackward) then
				yoff = -noClipConfig.offsets.y
			end

			if IsDisabledControlPressed(0, noClipConfig.controls.turnLeft) then
				SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)+noClipConfig.offsets.h)
			end

			if IsDisabledControlPressed(0, noClipConfig.controls.turnRight) then
				SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)-noClipConfig.offsets.h)
			end

			if IsDisabledControlPressed(0, noClipConfig.controls.goUp) then
				zoff = noClipConfig.offsets.z
			end

			if IsDisabledControlPressed(0, noClipConfig.controls.goDown) then
				zoff = -noClipConfig.offsets.z
			end

			if IsDisabledControlJustPressed(0, noClipConfig.controls.togInvisibiliy) then

				noclipInvisibility = not noclipInvisibility

				SetEntityVisible(noclipEntity, not noclipInvisibility, 0)
				if noclipEntity ~= PlayerPedId() then
					SetEntityVisible(PlayerPedId(), not noclipInvisibility, 0)
				end

			end

			local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
			local heading = GetEntityHeading(noclipEntity)
			SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
			SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
			SetEntityHeading(noclipEntity, heading)
			SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
		end

  end
end)

local featureSpectate = false
local spectatingPlayer = 0

function tvRP.spectatePlayer(target)
	local playerPed = GetPlayerPed(-1)
	local targetPlayer = 0

	for _, i in ipairs(GetActivePlayers()) do
		if NetworkIsPlayerConnected(i) then
			local serverID = GetPlayerServerId(i)
			if(serverID == target)then
				targetPlayer = i
			end
		end
	end
	spectatingPlayer = targetPlayer
	TriggerEvent("setSpectatingPlayer", targetPlayer)


	targetPed = GetPlayerPed(targetPlayer)
	if not featureSpectate then
		if(not IsScreenFadedOut() and not IsScreenFadingOut())then
			DoScreenFadeOut(1000)
			while (not IsScreenFadedOut()) do
				Wait(0)
			end

			local targetpos = GetEntityCoords(targetPed, false)

			RequestCollisionAtCoord(targetpos['x'],targetpos['y'],targetpos['z'])
			NetworkSetInSpectatorMode(true, targetPed)

			if(IsScreenFadedOut()) then
				DoScreenFadeIn(1000)
			end
		end
		featureSpectate = true
	else
		if(not IsScreenFadedOut() and not IsScreenFadingOut())then
			DoScreenFadeOut(1000)
			while (not IsScreenFadedOut()) do
				Wait(0)
			end
				
			featureSpectate = false
			TriggerEvent("setSpectatingPlayer", -1)

			local targetpos = GetEntityCoords(playerPed, false)

			RequestCollisionAtCoord(targetpos['x'],targetpos['y'],targetpos['z'])
			NetworkSetInSpectatorMode(false, targetPed)

			if(IsScreenFadedOut()) then
				DoScreenFadeIn(1000)
			end
		end
	end
end

-- Citizen.CreateThread(function()
-- 	while true do
-- 		if IsDisabledControlJustPressed(0,288) then
-- 			vRPserver.isNoClipStaff({},function(hasStaff)
-- 				if (hasStaff) then
-- 					tvRP.toggleNoclip()
-- 				end
-- 			end)
-- 		end
-- 		Wait(1)
-- 	end
-- end)
