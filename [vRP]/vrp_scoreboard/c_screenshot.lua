vRPCScreenshot = {}
Tunnel.bindInterface("RVALYScreenshot",vRPCScreenshot)
Proxy.addInterface("RVALYScreenshot",vRPCScreenshot)
vRP = Proxy.getInterface("vRP")
vRPSScreenshot = Tunnel.getInterface("RVALYScreenshot","RVALYScreenshot")

Citizen.CreateThread(function()
	Citizen.Wait(1000)
    if IsControlJustPressed(1,121) then
        vRPSScreenshot.fascreenshot()
    end
end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
    if IsControlJustPressed(1,192) then
        vRPSScreenshot.fascreenshot()
    end
end)