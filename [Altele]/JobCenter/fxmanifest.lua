fx_version "adamant"
game "gta5"
author "k2"
description "Job Center"
version "1.0.0"

dependency "ghmattimysql"


client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "c_*.lua",
    "MASTER.lua",
    "client.lua"
}


server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
    "MASTER.lua",
    "server.lua"
}