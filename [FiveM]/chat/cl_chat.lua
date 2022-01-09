local chatInputActive = false
local chatInputActivating = false

RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')

RegisterNetEvent('_chat:muitzaqmessageEntered')

--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = color,
      multiline = true,
      args = args
    }
  })
end)

xSound = exports.xsound

local musicId
local playing = false
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    musicId = "music_id_" .. PlayerPedId()
    local pos
    while true do
        Citizen.Wait(100)
        if xSound:soundExists(musicId) and playing then
            if xSound:isPlaying(musicId) then
                pos = GetEntityCoords(GetVehiclePedIsIn(PlayerPedId(), false))
                if not IsPedInAnyVehicle(PlayerPedId(), false) then
                  pos = GetEntityCoords(GetVehiclePedIsIn(PlayerPedId(), true))
                end

                TriggerServerEvent("kmusic:soundStatus", "position", musicId, { position = pos })
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(1000)
        end
    end
end)



RegisterCommand("cm", function(source, args, rawCommand)
    local pos = GetEntityCoords(PlayerPedId())
    playing = true
    TriggerServerEvent("kmusic:soundStatus", "play", musicId, { position = pos, link = args[1] })
end, false)

RegisterCommand("cmstop", function ()
  TriggerServerEvent("kmusic:soundStatus", "stop", musicId)
  
end)


RegisterNetEvent("kmusic:soundStatus")
AddEventHandler("kmusic:soundStatus", function(type, musicId, data)
    if type == "position" then
        if xSound:soundExists(musicId) then
            xSound:Position(musicId, data.position)
        end
    end

    if type == "play" then
        xSound:PlayUrlPos(musicId, data.link, 0.5, data.position)
        xSound:Distance(musicId, 25)
    end

    if type == "stop" then
      xSound:Pause(musicId)
    end
end)



AddEventHandler('__cfx_internal:serverPrint', function(msg)
  print(msg)

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = { 0, 0, 0 },
      multiline = true,
      args = { msg }
    }
  })
end)

AddEventHandler('chat:addMessage', function(message)
  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = message
  })
end)

RegisterCommand("cleanskin", function()
  local ped = PlayerPedId()
  ClearPedBloodDamage(ped)
  ResetPedVisibleDamage(ped)
  ClearPedWetness(ped)
  ClearPedEnvDirt(ped)
end)

RegisterCommand("jobs", function ()
  SetNewWaypoint(-268.06692504883,-958.42895507812)
  TriggerEvent("toasty:Notify", {type = "success", title="Job Center", message = "Ai notat locatia pe GPS!"})

end)

RegisterNetEvent("ssPlayerClient")
AddEventHandler("ssPlayerClient", function (s_id)

  -- Citizen.CreateThread(function ()
  --   for i=1, 2 do
  --     Citizen.Wait(2500)
      
  --     exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/910244415438741524/NeGo-BsTNG-Yg0CHOaZeCjZ3xBpCP9BXH_yvrR9SqaG8uH4jQ-GIw7F6oajMgXqXZ5Gb', 'file', function(data) end)
  --   end
  -- end)
  
  

end)


local duty = false

RegisterNetEvent("onDuty")
AddEventHandler("onDuty", function()
  --set ped in godmode and make him walk thru walls
  local ped = PlayerPedId()
  duty = true
  CreateThread(function()
    while true do
      Wait(500)
      if duty == false then break end

      if GetEntityHealth(ped) < 200 then
        SetEntityHealth(ped, 200)
      end

      if IsPedRagdoll(ped) then
        SetPedCanRagdoll(ped, false)
      end

      --autorepair vehicle ped is in if he is at the wheel
      local vehicle = GetVehiclePedIsIn(ped, false)
      if DoesEntityExist(vehicle) then
        --set engine power boost
        SetVehicleCheatPowerIncrease(vehicle, 1.8)


        if GetVehicleEngineHealth(vehicle) < 1000 then
          SetVehicleEngineHealth(vehicle, 1000.0)
        end
        if GetVehicleBodyHealth(vehicle) < 1000 then
          SetVehicleBodyHealth(vehicle, 1000.0)
        end
        if GetVehiclePetrolTankHealth(vehicle) < 1000 then
          SetVehiclePetrolTankHealth(vehicle, 1000.0)
        end
      end
    end
  end)
end)

RegisterNetEvent("offDuty")
AddEventHandler("offDuty", function()
  local ped = PlayerPedId()
  duty = false
end)


AddEventHandler('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

RegisterCommand("disable", function(source, args)
  TriggerServerEvent("disableChat", source)
end, false)

spamDetection = 0
spamDetected = 0

RegisterNUICallback('chatResult', function(data, cb)
	chatInputActive = false
	SetNuiFocus(false)

	if not data.canceled then
		local id = PlayerId()

		--deprecated
		local r, g, b = 0, 0x99, 255

		if data.message:sub(1, 1) == '/' then
			ExecuteCommand(data.message:sub(2))
		else
			if(spamDetection < 3)then
				spamDetection = spamDetection + 1
				TriggerServerEvent('_chat:muitzaqmessageEntered', GetPlayerName(id), { r, g, b }, data.message)
			else
				if(spamDetected < 5)then
					spamDetected = spamDetected + 1
					TriggerEvent("chatMessage", "[SPAM]", {255, 0, 0}, "Spam detectat! Continuarea spamului va duce la kick!")
				else
					TriggerServerEvent('chat:kickSpammer')
				end
			end
		end
	end
  cb('ok')
end)

Citizen.CreateThread(function()
	while true do
		Wait(3000)
		if(spamDetection > 0)then
			spamDetection = 0
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(9000)
		if(spamDetected == 5)then
			spamDetection = 0
		end
	end
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  cb('ok')
end)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)

  while true do
    Wait(0)

    if not chatInputActive then
      if IsControlPressed(0, 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
        chatInputActive = true
        chatInputActivating = true

        SendNUIMessage({
          type = 'ON_OPEN'
        })
      end
    end

    if chatInputActivating then
      if not IsControlPressed(0, 245) then
	  	  ExecuteCommand("talk3dchat")
        SetNuiFocus(true)

        chatInputActivating = false
      end
    end
  end
end)