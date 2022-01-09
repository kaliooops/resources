onlinePlayers = 0
local maxPlayers = GetConvar("sv_maxclients", 128)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
    local txd = CreateRuntimeTxd("watermark")
	CreateRuntimeTextureFromImage(txd, "watermark", "stream/watermark.png")

	while true do
		onlinePlayers = #GetActivePlayers()
		Citizen.Wait(20000)
	end
end)

local fontId
Citizen.CreateThread(function()
	RegisterFontFile('wmk')
    fontId = RegisterFontId('Freedom Font')
end)

function drawHudText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(6)
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

Citizen.CreateThread(function()
    while true do 
        x = 0.92
        y = 0.87 
        
        x_l = 0.85
        y_l = 0.95
		 DrawSprite("watermark","watermark",x_l,y_l,0.065*4, 0.1*5,0.1,255,255,255,255)
		-- drawHudText(x, y + 0.022,0.13,0.03,0.45,"K2 Romania",255, 255, 255,255,1,fontId,1)
		drawHudText(x, y + 0.005,0.24,0.0,0.39,"ONLINE: "..#GetActivePlayers().."/"..maxPlayers,255,255,255,255,1,fontId,1)
		drawHudText(x, y + 0.007,0.004,0.0,0.32,"DISCORD.io/k2roleplay",255, 255, 255,255,1,fontId,1)
		Wait(1)
	end
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