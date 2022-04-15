
fx_version "cerulean"

game "gta5"
dependency "vrp"

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "classes/c_*.lua",
    "loader.lua"
}

ui_page "html/index.html"

files {
    "html/*",
}

server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
    "classes/s_*.lua"
}