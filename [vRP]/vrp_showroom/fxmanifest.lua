fx_version "adamant"

game "gta5"

ui_page "nui/index.html"

files {
	'nui/index.html',
	'nui/style.css',
  'nui/scripts.js',
  'nui/img/logo2.png',
  'nui/img/backgr.png'
}

client_scripts{ 
  "@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
  "client.lua",
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}
