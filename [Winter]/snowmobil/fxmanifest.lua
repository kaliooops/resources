--[[
    DATE: 12.09.2021
    AUTHOR: k2 IC (k2#2890)
    <!> <!> <!>
    ! ROMANIA !
    <!> <!> <!> 
]]
fx_version "cerulean"

game "gta5"
dependency "vrp"

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "client.lua"
}


server_scripts {
    "@vrp/lib/utils.lua",
    "server.lua"
}