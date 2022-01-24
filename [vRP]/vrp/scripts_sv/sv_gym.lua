local members = {}

local gymTable = {
	["biceps1"] = {253.03,-257.67,59.92, "BICEPS BARA"},
	["abdo"] = {252.00,263.61,59.92, "ABDOMENE"},
	["biceps2"] = {255.59,-259.68,59.92, "BICEPS BARA"},
	["yoga"] = {234.41, -267.23, 60.04, "YOGA"},
	["tractiuni1"] = {248.49, -268.22,59.92, "TRACTIUNI"},
	["tractiuni2"] = {251.42, -266.96, 59.92, "TRACTIUNI"},
	["flotari"] = {241.04, -261.44, 59.92, "FLOTARI"},
	["bench1"] = {247.50,-263.62,59.97, "PIEPT"},
	["bench2"] = {243.16,-262.14,59.92, "PIEPT"},
	-- ["bench3"] = {-1206.4871, -1561.5948, 4.1115, "PIEPT"},
	-- ["bench4"] = {-1201.4362, -1562.7670, 4.1115, "PIEPT"}
}

local theGym = {260.19,-270.06,53.96}

local workouts = {
	["PROP_HUMAN_MUSCLE_CHIN_UPS"] = {"tractiuni1", "tractiuni2"},
	["WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"] = {"biceps1", "biceps2"},
	["WORLD_HUMAN_SIT_UPS"] = {"abdo"},
	["WORLD_HUMAN_YOGA"] = {"yoga"},
	["WORLD_HUMAN_PUSH_UPS"] = {"flotari"},
	["PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS"] = {"bench1", "bench2", "bench3", "bench4"}
}

local supplements = {
	["Creatina"] = {50, "creatina"},
	["Batoane Proteice"] = {60, "batoaneproteice"},
	["Multivitamine"] = {540, "multivitamine"},
	["Oxid Nitric"] = {140, "oxidnitric"},
	["BCAA"] = {10, "bcaa"},
	["Amino Acizi"] = {253, "aminoacizi"},
	["Pre-Workout"] = {243, "preworkout"},
	["ZMA"] = {125, "zma"},
	["Tablete Ulei Peste"] = {155, "uleipeste"}
}

local supplements_menu = {name="Suplimente",css={top="75px", header_color="rgba(0,125,255,0.75)"}}
local gym_menu = {name="Magazin Sala",css={top="75px", header_color="rgba(0,125,255,0.75)"}}

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		local thePlayer = source
		if thePlayer ~= nil then
			vRPclient.populateGymTable(thePlayer, {gymTable, theGym})
		end
	end
end)

function tvRP.initWorkout(workout)
	local thePlayer = source
	for i, v in pairs(workouts) do
		workTable = v
		for k, vl in pairs(workTable) do
			if(vl == workout)then
				TriggerClientEvent("disabledpemotesbruh", thePlayer, true)
        		vRP.closeMenu(thePlayer)
        		vRPclient.disableMeniu(thePlayer,{true})
				vRPclient.startWorkout(thePlayer, {i})
				break
			end
		end
	end
end

function tvRP.stopWorkout()
	local thePlayer = source
	TriggerClientEvent("disabledpemotesbruh", thePlayer, false)
    vRPclient.disableMeniu(thePlayer,{false})
end

function tvRP.gainStrenght(strenght)
	local user_id = vRP.getUserId(source)
	local parts = splitString("physical.strength",".")
    if #parts == 2 then
        vRP.varyExp(user_id,parts[1],parts[2],tonumber(strenght))
    end
end

function tvRP.hasMembership()
	local thePlayer = source
	local user_id = vRP.getUserId(thePlayer)
	if(user_id ~= nil)then
		if(members[user_id] == true)then
			return true
		else
			return false
		end
	end
end

local function buyMembership(player, choice)
	local user_id = vRP.getUserId(player)
	if(members[user_id] ~= true)then
		if(vRP.tryPayment(user_id, 50))then
			members[user_id] = true
			vRPclient.notify(player, {"~w~[GYM] ~g~Ai platit 50€ pentru abonament! Timp de o zi poti accesa facilitatile salii!"})
		else
			vRPclient.notify(player, {"~w~[GYM] ~r~Nu ai destui bani pentru abonament"})
		end
	else
		vRPclient.notify(player, {"~w~[GYM] ~r~Ai deja abonament"})
	end
	vRP.closeMenu(player)
end

local function cancelMembership(player, choice)
	local user_id = vRP.getUserId(player)
	if(members[user_id] == true)then
		members[user_id] = false
		vRPclient.notify(player, {"~w~[GYM] ~g~Ti-ai anulat abonamentul la sala!"})
	else
		vRPclient.notify(player, {"~w~[GYM] ~r~Nu ai abonament la sala!"})
	end
	vRP.closeMenu(player)
end

local function buySupplements(player, choice)
	for i, v in pairs(supplements) do
		supplements_menu[i] = {function(player, choice) 
			local user_id = vRP.getUserId(player)
			if(vRP.tryPayment(user_id, v[1]))then
				vRPclient.notify(player, {"~w~[GYM] ~g~Ai cumparat ~y~"..i.."!"})
				vRP.giveInventoryItem(user_id,v[2],1,false)
				vRP.closeMenu(player)
			else
				vRPclient.notify(player, {"~w~[GYM] ~r~Nu ai destui bani pentru a cumpara ~y~"..i.."!"})
			end
		end, "Pret: $"..v[1]}
	end
	vRP.openMenu(player, supplements_menu)
end

RegisterServerEvent("showGymMenu")
AddEventHandler("showGymMenu", function()
	local thePlayer = source
	if(members[user_id] ~= true)then
		gym_menu["Fa-ti Abonament"] = {buyMembership, "Cumpara abonament pentru o zi<br>Pret: $1500"}
		gym_menu["Anuleaza Abonament"] = nil
	else
		gym_menu["Anuleaza Abonament"] = {cancelMembership, "Anuleaza-ti abonamentul"}
		gym_menu["Fa-ti Abonament"] = nil
	end
	-- gym_menu["Suplimente"] = {buySupplements, "Cumpara suplimenete"}
	vRP.openMenu(thePlayer,gym_menu)
end)