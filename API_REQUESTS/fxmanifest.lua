
fx_version "cerulean"

game "gta5"
dependency "vrp"

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "c_*.lua",
    "MASTER.lua",
}


server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
    "MASTER.lua"
}


ui_page "html/index.html"
-- ui_page "http://cfx-nui-api_requests/html/index.html"

files {
    "html/index.html",
    "html/style.css",
    "html/main.js",
}