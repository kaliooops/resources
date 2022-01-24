resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
fx_version 'cerulean'
game 'gta5'

author 'Kali'
version '1.0.0'
ui_page 'client/html/ui.html'

client_script {
	'lib/Tunnel.lua',
	'lib/Proxy.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'config.lua',
	'server/main.lua'
}

files {
	'client/html/ui.html',
	'client/html/styles.css',
	'client/html/scripts.js',
	'configNui.js',
	'client/html/debounce.min.js',
	'client/html/sweetalert2.all.min.js',
	-- Icons
	'client/html/logo.png',
	'client/html/icons/**/*'
}