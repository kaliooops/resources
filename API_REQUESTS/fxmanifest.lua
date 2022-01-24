<<<<<<< HEAD

fx_version "bodacious"

game "gta5"
dependency "vrp"

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "c_*.lua",
    "MASTER.lua",
}


server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
    "MASTER.lua"
}


ui_page "html/index.html"
-- ui_page "http://cfx-nui-api_requests/html/index.html"
-- ui_page "http://cfx-nui-API_REQUESTS/html/index.html"
files {
    "html/index.html",
    "html/style.css",
    "html/main.js",
}
=======

fx_version "bodacious"

game "gta5"
dependency "vrp"

client_scripts {
    "@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
    "c_*.lua",
    "MASTER.lua",
}


server_scripts {
    "@vrp/lib/utils.lua",
    "s_*.lua",
    "MASTER.lua"
}


ui_page "html/index.html"
-- ui_page "http://cfx-nui-api_requests/html/index.html"
-- ui_page "http://cfx-nui-API_REQUESTS/html/index.html"
files {
    "html/index.html",
    "html/style.css",
    "html/main.js",
}
>>>>>>> d05cafde748606797b6297fba9c5b4b7bc8b8657
