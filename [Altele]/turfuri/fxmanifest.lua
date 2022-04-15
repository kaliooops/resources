fx_version "cerulean"
game "gta5"

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "c_*.lua",
}

ui_page "html/index.html"
files {
    "html/index.html",
    "html/style.css",
    "html/script.js",
}

server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
}