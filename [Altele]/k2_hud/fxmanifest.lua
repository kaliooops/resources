fx_version "cerulean"

game "gta5"
dependency "vrp"

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "c_*.lua",
}

ui_page "html/index.html"



files {
    "html/*",
    "html/img/*",
}

server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
}