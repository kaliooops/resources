
fx_version "cerulean"

game "gta5"
dependency "vrp"

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "loader.lua"

}

ui_page "html/index.html"

files {
    "html/img/sonar.png",
    "html/img/wallpaper.jpg",
    "html/index.html",
    "html/style.css",
    "html/descopera.css",
    "html/main.js",
    "html/mouse_hover_info.js",
    "html/informatii.css"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
}