client_script "@ThnAC/natives.lua"
fx_version 'cerulean'
games { 'gta5' }

author 'rValy' -- http://discord.gg/t24h5ku3su
description 'MusicEverywhere tradus din vRPEX in vRP de rValy' -- https://danny255-scripts.tebex.io/package/4289906
version '1.2.0'

ui_page 'html/index.html'

client_scripts {
	--'@vrp/lib/utils.lua',
  'config.lua',
  'client/main.lua',
}

files {
	'html/index.html',
	'html/script.js',
	'html/*.svg',
	'html/radio.png',
	'html/main.css',
}

server_scripts {
	--'@vrp/lib/utils.lua',
  'config.lua',
  'server/main.lua',
}