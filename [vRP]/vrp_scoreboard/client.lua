vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP","krimes_scoreboard")
vRPscr = Tunnel.getInterface("krimes_scoreboard","krimes_scoreboard")
vRPscrC = {}
Tunnel.bindInterface("krimes_scoreboard",vRPscrC)
vRPserver = Tunnel.getInterface("krimes_scoreboard","krimes_scoreboard")

Citizen.CreateThread(function()
	Citizen.Wait(1000)


	while true do
		onlinePlayers = #GetActivePlayers()

		Citizen.Wait(20000)
	end
end)

scoreboardon = false

CreateThread(function()
    while true do
        Wait(1)
        if IsControlJustPressed(0, 212) then
            openscoreboard()
        end
    end
end)

function openscoreboard()
    scoreboard = vRPserver.getScoreboardInformations()
end

function GetOnlinePlayers()
	local players = 0

	for i = 0, 256 do
		if NetworkIsPlayerActive(i) then
			players = players + 1
		end
	end

	return tonumber(players)
end

function vRPscrC.openscoreboard(info)
    playerlist = {}
    thePlayers = {}
    for k,v in pairs (info) do
        theID = tonumber(k)
        thePlayers = v[4]
        table.insert(playerlist ,{id=theID,html='<tr> <td>'..v[1]..'</td> <th>'..v[2]..'</th> <th> ID: '..k..'</th><th> ORE: '..v[3]..'</th></tr>'})
    end
    local playersText = {}
        function compare(a,b)
            return a["id"] < b["id"]
        end
        table.sort(playerlist, compare)
        for item, value in pairs(playerlist) do
            table.insert(playersText, value["html"])
        end
        playersOn = thePlayers
        onlinePlayers = onlinePlayers
    SendNUIMessage({
        action = "deschideUsaCrestine",
        idsiuseritext = onlinePlayers,
        info = table.concat(playersText)
    })
    SetNuiFocus(true, true)
end

RegisterNUICallback('inchideusacrestine', function(data,cb)
    SetNuiFocus(false, false)
end)
