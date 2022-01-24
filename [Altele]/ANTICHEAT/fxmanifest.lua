fx_version "cerulean"
game "gta5"
client_script "c_*.lua"
dependency "vrp"

server_scripts
{ 
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "s_*.lua",
}


