fx_version 'cerulean'
games { 'gta5' }

description "LeFruJohn's Housing System"

author "LeFruJohn"

client_scripts{ 
  "lib/Tunnel.lua",
  "lib/Proxy.lua",
  "client.lua"
}

server_scripts{ 
  "@vrp/lib/utils.lua",
  "server.lua"
}