
fx_version "cerulean"
game "gta5"
dependency "vrp"

client_scripts {
    "classes/c_*.lua",
    "c_*.lua",
}


server_scripts {
    "@vrp/lib/utils.lua",
    "classes/s_*.lua",
    "s_*.lua",
}