fx_version 'adamant'

game 'gta5'

ui_page "html/index.html"

files {
	'html/index.html',
	'html/style.css',
  'html/fontcustom.woff',
  'html/script.js',
}

client_scripts{ 
  "@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
  "config.lua",
  "client.lua",
  "c_screenshot.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "config.lua",
  "server.lua",
  "s_screenshot.lua"
}