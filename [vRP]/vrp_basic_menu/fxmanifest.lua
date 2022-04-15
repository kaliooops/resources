fx_version "adamant"

game "gta5"

dependencies {
  "ghmattimysql"
}

client_scripts{
  "@vrp/client/Tunnel.lua",
  "@vrp/client/Proxy.lua",
  "client.lua",
  "playerblips/client.lua",
  "tptowaypoint/client.lua",
  "drag/client.lua"
}

server_scripts{
  "@vrp/lib/utils.lua",
  "server.lua"
}