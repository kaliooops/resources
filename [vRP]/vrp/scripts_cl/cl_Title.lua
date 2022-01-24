local fontLogo

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    RegisterFontFile('wmk')
    fontLogo = RegisterFontId('Freedom Font')
end)

local function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(fontLogo)
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

local playerHealth = 100
local playerArmor = 100

local tempPed

Citizen.CreateThread(function()
    Citizen.Wait(20000)
	while true do
        tempPed = GetPlayerPed(-1)
		local playerPed = tempPed
		playerHealth = GetEntityHealth(playerPed)
		playerArmor = GetPedArmour(playerPed)
		Citizen.Wait(2000) 
	end
end)

local showviata = true
RegisterNetEvent("showviata", function()
    showviata = not showviata
end, false)

Citizen.CreateThread(function()

    Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~y~k2 ~w~Romania - ~y~discord.io/k2roleplay')

    local punch = GetHashKey('WEAPON_UNARMED')
    local rozeta = GetHashKey('WEAPON_KNUCKLE')
    local bat = GetHashKey('WEAPON_BAT')
    local fallingDmg = GetHashKey('WEAPON_FALL')
    local knife = GetHashKey('WEAPON_KNIFE')
    local animal = GetHashKey('WEAPON_ANIMAL')
    local cougar = GetHashKey('WEAPON_COUGAR')
    local pulan = GetHashKey('WEAPON_NIGHTSTICK')
    local lnt = GetHashKey('WEAPON_FLASHLIGHT')
    local smokeGrenade = GetHashKey("WEAPON_SMOKEGRENADE")
	while true do
        if showviata then
            drawTxt(0.535, 1.4615, 1.0, 1.0, 0.2, "VIATA ~g~"..math.floor(playerHealth - 100), 255, 255, 255, 255)
            drawTxt(0.6, 1.4615, 1.0, 1.0, 0.2, "ARMURA ~b~"..math.floor(playerArmor), 255, 255, 255, 255)
        end
        HideHudComponentThisFrame(21)
        
        N_0x4757f00bc6323cfe(-1553120962, 0.0) -- Masina
        N_0x4757f00bc6323cfe(fallingDmg, 0.1)
        N_0x4757f00bc6323cfe(punch, 0.2)
        N_0x4757f00bc6323cfe(rozeta, 0.8)
        N_0x4757f00bc6323cfe(bat, 0.5)
        N_0x4757f00bc6323cfe(knife, 0.6)
        N_0x4757f00bc6323cfe(animal, 0.0)
        N_0x4757f00bc6323cfe(cougar, 0.0)
        N_0x4757f00bc6323cfe(pulan, 0.1)
        N_0x4757f00bc6323cfe(lnt, 0.05)
        N_0x4757f00bc6323cfe(smokeGrenade, 0.0)

        DisablePlayerVehicleRewards(PlayerId())
        DisablePlayerVehicleRewards(-1)

        RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
        RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
        RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
        RemoveAllPickupsOfType(0x3A4C2AD2) -- smg

		HideHudComponentThisFrame(1) -- wanted level
        HideHudComponentThisFrame(3) -- cash
        HideHudComponentThisFrame(4) -- bank

        HideHudComponentThisFrame(6) -- Nume masina
        HideHudComponentThisFrame(7) -- Cartier
        HideHudComponentThisFrame(9) -- Strada

		Citizen.Wait(1)
	end
end)

