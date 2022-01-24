local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_boombox")

vRPCbb = Tunnel.getInterface("vRP_boombox","vRP_boombox")

vRPSbb = {}
Tunnel.bindInterface("vRP_boombox",vRPSbb)
Proxy.addInterface("vRP_boombox",vRPSbb)

function vRPSbb.openPrompt()
    local user_id = vRP.getUserId({source})
    vRP.prompt({source, "Pune link-ul de la melodie", "", function(song, raspuns)
        if(song ~= nil)then
            local users = vRP.getUsers({})
            for user_id,source in pairs(users)do
                vRPCbb.playSound(source,{raspuns})
            end
        else
            vRPclient.notify(source,{"Eroare: ~r~Link invalid!"})
        end
    end})
end

function vRPSbb.setVolume()
    local user_id = vRP.getUserId({source})
    vRP.prompt({source, "Volum: ", "De la 1 la 100", function(song, volume)
        volume = parseInt(volume)
        if(volume ~= nil)then
            vRPclient.notify(song,{"Succes: ~g~Ai setat volumul melodiei la ~o~"..volume.."%"})
            local users = vRP.getUsers({})
            for user_id,source in pairs(users)do
                vRPCbb.setVolume(source,{volume})
            end
        else
            vRPclient.notify(source,{"Eroare: ~r~Link invalid!"})
        end
    end})
end


function vRPSbb.stopSong()
    vRPclient.notify(source,{"Eroare: ~r~Ai oprit melodia din ~y~BoomBox"})
    vRPCbb.stopSong(-1,{})
end

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
	local target = vRP.getUserSource({user_id})
	local user_id = vRP.getUserId({target})
	SetTimeout(1000,function()
      exports.ghmattimysql:execute('SELECT * FROM vrp_users WHERE id = @id', {["@id"] = user_id}, function(date)
			local background = tostring(date[1].phoneBg)
			local usrs = vRP.getUserSource({user_id})
			vRPclient.setBGImage(usrs,{background})
  		end)
  end)
end)