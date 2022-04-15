fx_version 'adamant'

game 'gta5'

client_scripts {
  '@NativeUILua_Reloaded/src/NativeUIReloaded.lua',
  '@vrp/client/Proxy.lua',
	'@vrp/client/Tunnel.lua',
  'src/config.lua',
  'src/houses.lua',
  'src/utils.lua',
  'src/client/menus/menus.lua',
  'src/client/menus/menus_native.lua',
  'src/client/functions.lua',
  'src/client/main.lua',
  'src/client/commands.lua'
}

server_scripts {
  '@vrp/lib/utils.lua',
  'src/config.lua',
  'src/houses.lua',
  'src/utils.lua',
  'src/server/functions.lua',
  'src/server/main.lua'
}

dependencies {
  'NativeUILua_Reloaded',
  'ghmattimysql',
  'input',
  'vrp_furniture',
  'shellsv2',
  'shells',
  'mythic_interiors',
}












