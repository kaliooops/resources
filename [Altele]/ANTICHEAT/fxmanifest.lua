game "gta5"
lua54 "yes"
fx_version 'cerulean'
client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "c_*.lua"
}

escrow_ignore {
    "c_CONFIG.lua",
    "s_CONFIG.lua",
}

server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
}


