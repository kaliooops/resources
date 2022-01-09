resource_manifest_version "77731fab-63ca-442c-a67b-abc70f28dfa5"

ui_page "client/html/ui.html"
files {
	"client/html/ui.html",
	"client/html/styles.css",
	"client/html/scripts.js",
	"configNui.js",
	"client/html/debounce.min.js",
	"client/html/sweetalert2.all.min.js",


	-- "client/html/assets/icons/drogas/tigara.png",
	-- "client/html/assets/icons/none/aphone.png",
	-- "client/html/assets/icons/none/lighter.png",
	-- "client/html/assets/incons/arme/armura.png",
	-- "client/html/assets/icons/emergency/tilidin.png",
	-- "client/html/assets/icons/alcool/vodka.png",
	-- "client/html/assets/icons/none/picamar.png",
	-- "client/html/assets/icons/none/ciocan.png",
	-- "client/html/assets/icons/none/weld.png",
	-- "client/html/assets/icons/droguri/lemonhaze.png",
	-- "client/html/assets/icons/droguri/kush.png",
	-- "client/html/assets/icons/droguri/purplehaze.png",
	-- "client/html/assets/icons/droguri/tramadol.png",
	-- "client/html/assets/icons/none/dirty_money.png",
	-- "client/html/assets/icons/munitie/munitiepistol.png",
	-- "client/html/assets/icons/munitie/munitiesmg.png",
	-- "client/html/assets/icons/munitie/munitietazer.png",
	-- "client/html/assets/icons/arme/GADGET_PARACHUTE.png",
	-- "client/html/assets/icons/arme/WEAPON_ASSAULTRIFLE.png",
	-- "client/html/assets/icons/arme/WEAPON_ASSAULTSMG.png",
	-- "client/html/assets/icons/arme/WEAPON_BAT.png",
	-- "client/html/assets/icons/arme/WEAPON_CARBINERIFLE.png",
	-- "client/html/assets/icons/arme/WEAPON_COMBATPISTOL.png",
	-- "client/html/assets/icons/arme/WEAPON_DAGGER.png",
	-- "client/html/assets/icons/arme/WEAPON_FIREEXTINGUISHER.png",
	-- "client/html/assets/icons/arme/WEAPON_FLASHLIGHT.png",
	-- "client/html/assets/icons/arme/WEAPON_GUSENBERG.png",
	-- "client/html/assets/icons/arme/WEAPON_HAMMER.png",
	-- "client/html/assets/icons/arme/WEAPON_HATCHET.png",
	-- "client/html/assets/icons/arme/WEAPON_KNIFE.png",
	-- "client/html/assets/icons/arme/WEAPON_KNUCKLE.png",
	-- "client/html/assets/icons/arme/WEAPON_MACHETE.png",
	-- "client/html/assets/icons/arme/WEAPON_MICROSMG.png",
	-- "client/html/assets/icons/arme/WEAPON_NIGHTSTICK.png",
	-- "client/html/assets/icons/arme/WEAPON_PISTOL.png",
	-- "client/html/assets/icons/arme/WEAPON_REVOLER.png",
	-- "client/html/assets/icons/arme/WEAPON_SMG.png",
	-- "client/html/assets/icons/arme/WEAPON_SNSPISTOL.png",
	-- "client/html/assets/icons/arme/WEAPON_STUNGUN.png",
	-- "client/html/assets/icons/arme/WEAPON_SWITCHBLADE.png",
	-- "client/html/assets/icons/arme/WEAPON_VINTAGEPISTOL.png",
	-- "client/html/assets/icons/none/artificii.png",
	'client/html/assets/icons/**/*',
}

client_scripts {
	"@vrp/client/Tunnel.lua",
	"@vrp/client/Proxy.lua",
	"@vrp/lib/utils.lua",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"config.lua",
	"client/main.lua",
	"client/dorgas.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server/main.lua"
}
