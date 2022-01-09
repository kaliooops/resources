local vRP = Proxy.getInterface("vRP")
local coords = {2490.3090820313,-265.54098510742,-58.918571472168}
local open = false
local inMenu = true

local CreateThread = Citizen.CreateThread
local GetEntityCoords = GetEntityCoords
local IsDisabledControlJustPressed = IsDisabledControlJustPressed
local StartScreenEffect = StartScreenEffect
local DisableAllControlActions = DisableAllControlActions
local StopScreenEffect = StopScreenEffect
local SendNUIMessage = SendNUIMessage
local RegisterNUICallback = RegisterNUICallback
local SetNuiFocus = SetNuiFocus
local blip = vRP.addBlip({934.40716552734,45.555229187012,81.09578704834,617,50,"Diamond Casino",1.5})
local function togglePrizes()
	open = not open
	SendNUIMessage({type = "toggle"})
    SetNuiFocus(open, open)
end

local fontsLoaded = false
local fontId
Citizen.CreateThread(function()
  Citizen.Wait(1000)
  RegisterFontFile('wmk')
  fontId = RegisterFontId('Freedom Font')
  fontsLoaded = true
end)

RegisterNetEvent("prizes:setPrice")
AddEventHandler("prizes:setPrice", function(rollPrice, dmdPrice)
	SendNUIMessage({type = "setPrice", price = rollPrice, dmdPrice = dmdPrice})
end)

RegisterNetEvent("prizes:winSomething")
AddEventHandler("prizes:winSomething", function(winName)
	Wait(600)
	SendNUIMessage({type = "spinTo", itemId = winName})
end)

RegisterNUICallback('tryGetPrize', function(data, cb)
	if open then
		TriggerServerEvent("prizes:doPayment", data.withDmd)
	else
		vRP.notify({'Te pupa fratele mai incearca'})
	end
end)
RegisterNetEvent('prizes:exit')
AddEventHandler('prizes:exit',function()
	SendNUIMessage({type = "noteng"})
end)
RegisterNUICallback('NUIFocusOff', function()
	open = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)

RegisterNUICallback('exit', function()
	open = not open
	SetNuiFocus(open, open)
    StopScreenEffect("MenuMGHeistIn")
	StartScreenEffect("MenuMGHeistOut", 800, false)
end)

CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local distance = #(GetEntityCoords(ped) - vector3(coords[1],coords[2],coords[3]))
		if distance <= 2.5 and not open then
			ticks = 0
			dumpaiureabai(0.5, 0.90, 0,0, 0.40, "~w~Apasa ~r~E ~w~pentru a juca la ~r~Lucky Roulette", 255, 255, 255, 230, 1, 4, 1)
			if IsDisabledControlJustPressed(0,38) then
				StartScreenEffect("MenuMGHeistIn", 0, true)
				togglePrizes()
			end
		else
			ticks = 2000
		end
	Wait(ticks)
	end
end)

function dumpaiureabai(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(fontId)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextCentre(center)
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end