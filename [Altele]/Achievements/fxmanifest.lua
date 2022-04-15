game "gta5"

ui_page "html/index.html"

files {
    "html/index.html",
    "html/main.js",
    "html/style.css",
    "html/ac_updater.js",
}

fx_version 'cerulean'
client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "c_*.lua"
}


server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
}