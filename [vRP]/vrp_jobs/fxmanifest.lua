fx_version "adamant"
games {'gta5'}

client_scripts{ 
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
	"jobs/client/client.lua",
	"jobs/client/c_*.lua",
	"jobs/client/shared.lua",

	
}
dependency "vrp"
server_scripts{ 
	"@vrp/lib/utils.lua",
	"server.lua",
	"piata.lua",
	"jobs/s_*.lua",

}

files{
	"stream/*.gfx",
	"assets/*.png"
}














