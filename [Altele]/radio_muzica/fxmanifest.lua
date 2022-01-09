fx_version 'adamant'

game 'gta5'

server_scripts {
    "@vrp/lib/utils.lua",
    "server.lua"
}

client_script {
    "@vrp/client/Proxy.lua",
    "@vrp/client/Tunnel.lua",
    "client.lua"
}

ui_page('html/index.html')

files {
    'html/index.html',
    'html/app.js'
}