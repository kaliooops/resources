fx_version "adamant"
game "gta5"

dependency {
	'vrp'
}

ui_page "nui/index.html"

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	'serverCallbackLib/client.lua',
	"config.lua",
	"client.lua"
} 

server_script {
	"@vrp/lib/utils.lua",
	'serverCallbackLib/server.lua',
	"config.lua",
	"server.lua"
}

files {
	"nui/index.html",
	"nui/script.js",
	"nui/lang.js",
	"nui/css.css"
}