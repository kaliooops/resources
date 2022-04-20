fx_version "cerulean"
lua54 "yes"
game "gta5"
dependency "vrp"

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "classes/c_*.lua",
    "c_*.lua"
}

ui_page "html/index.html"

files {
    "html/*",
    "html/**/*",
    "html/*/**"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
    "classes/s_*.lua"
}