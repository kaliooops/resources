fx_version 'cerulean'
game "gta5"

ui_page 'index.html'

client_script {
	'lib/Tunnel.lua',
	'lib/Proxy.lua',
    "main.lua"
}

server_scripts {
	'@vrp/lib/utils.lua',
}


files {
    "beginner.css",
    "entry_card.css",
    "index.html",
    "informatii.css",
    "script.js",
    "style.css",
    "img/cratepubg.png",
}