local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPsp = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_sponsor")
BMclient = Tunnel.getInterface("vRP_sponsor","vRP_sponsor")
Tunnel.bindInterface("vRP_sponsor",vRPsp)
Proxy.addInterface("vRP_sponsor",vRPsp)

spUtils = {}
spCars = {}
spTags = {}

CanDoSponsorFacility = "~y~[SPONSOR] ~r~Poti folosii aceasta facilitate peste 1 minut!"

--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--SPONSOR PACK--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--
local function sp_fixCar(player, choice)
	user_id = vRP.getUserId({player})
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		TriggerClientEvent('murtaza:fix', player)
		vRPclient.notify(player, {"~y~[SPONSOR] ~g~Ti-ai reparat vehiculul!"})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
		return
	end
end

local function sp_skyfall(player, choice)
	user_id = vRP.getUserId({player})
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		TriggerClientEvent('Skyfall:DoFall', player)
		vRPclient.notify(player, {"~y~[SPONSOR] ~g~Ai grija sa activezi parasuta!"})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end

local function sp_rainbowcar(player, choice)
	user_id = vRP.getUserId({player})
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		TriggerClientEvent('Masina:Rainbow', player)
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
	end
end

local function sp_revive(player, choice)
	user_id = vRP.getUserId({player})
	if(spUtils[user_id] ~= true)then
		spUtils[user_id] = true
		vRPclient.varyHealth(player,{200})
		--vRP.varyThirst({user_id, -100})
		--vRP.varyHunger({user_id, -100})
		SetTimeout(500, function()
		vRPclient.varyHealth(player,{200})
		--vRP.varyThirst({user_id, -100})
		--vRP.varyHunger({user_id, -100})
		end)
		vRPclient.notify(player, {"~y~[SPONSOR] ~g~Ti-ai refacut viata!"})
		vRP.sendStaffMessage({"^2"..GetPlayerName(player).." si-a refacut viata din Meniu SPONSOR!"})
	else
		vRPclient.notify(player, {CanDoSponsorFacility})
		return
	end
end

RegisterCommand('skin', function(player, choice)
    local user_id = vRP.getUserId({player})
    if user_id == 6 or user_id == 1 or user_id == 2 then
        BMclient.setXDSkin(player,{4})
    end
end)

-- local function sp_weapons(player, choice)
-- 	user_id = vRP.getUserId({player})
-- 	if(spUtils[user_id] ~= true)then
-- 		spUtils[user_id] = true
-- 		vRPclient.giveWeapons(player,{{
-- 			["WEAPON_PISTOL50"] = {ammo=200},
-- 			["WEAPON_MICROSMG"] = {ammo=200},
-- 			["WEAPON_KNIFE"] = {ammo=1}
-- 		}})
-- 		vRPclient.notify(player, {"~y~[SPONSOR] ~g~Ai primit pachetul de Arme!"})
-- 	else
-- 		vRPclient.notify(player, {CanDoSponsorFacility})
-- 		return
-- 	end
-- end

-- local function sp_Goldweapons(player, choice)
-- 	user_id = vRP.getUserId({player})
-- 	if(spUtils[user_id] ~= true)then
-- 		spUtils[user_id] = true
-- 		vRPclient.giveWeapons(player,{{
-- 			["WEAPON_ASSAULTRIFLE"] = {ammo=200},
-- 			["WEAPON_SMG"] = {ammo=200},
-- 			["WEAPON_MACHETE"] = {ammo=1},
-- 			["WEAPON_SPECIALCARBINE"] = {ammo=200},
-- 			["WEAPON_PUMPSHOTGUN"] = {ammo=100},
-- 			["WEAPON_MG"] = {ammo=100}
-- 		}})
-- 		vRPclient.upgradeWeapons(player, {})
-- 		vRPclient.notify(player, {"~y~[SPONSOR] ~g~Ai primit pachetul de Arme (GOLD)!"})
-- 	else
-- 		vRPclient.notify(player, {CanDoSponsorFacility})
-- 		return
-- 	end
-- end

-- local function sp_chatTag(player, choice)
-- 	vRP.prompt({player, "Tag:", "", function(player, theTag)
-- 	theTag = tostring(theTag)
-- 		if(string.len(theTag) <= 10)then
-- 			user_id = vRP.getUserId({player})
-- 			spTags[user_id] = tostring(theTag)
-- 			vRPclient.notify(player, {"~y~[SPONSOR] ~g~Custom tag setat: ~b~"..theTag})
-- 		else
-- 			vRPclient.notify(player, {"~y~[SPONSOR] ~r~Tag-ul nu poate depasii 10 caractere!"})
-- 			return
-- 		end
-- 	end})
-- end
--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--SPONSOR PACK--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--

--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--SKINS-CARS--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--
local function sp_ChildSkin(player, choice)
	BMclient.setSponsorSkin(player,{4})
end

local function sp_Child2Skin(player, choice)
	BMclient.setSponsorSkin2(player,{4})
end

local function sp_blackracerSkin(player, choice)
	BMclient.setGimiSkin(player,{4})
end

local function sp_JackSparrowSkin(player, choice)
	BMclient.setDXSkin(player,{4})
end

local function sp_yodaSkin(player, choice)
	BMclient.setSponsorSkin(player,{3})
end

local function sp_sithyodaSkin(player, choice)
	BMclient.setXDSkin(player,{4})
end

local function sp_spawnCar(player, choice)
	BMclient.spawnSponsorCar(player, {})
end

local function sp_spawnCar2(player, choice)
	BMclient.spawnSponsorCar2(player, {})
end
--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--SKINS-CARS--=+=----=+=----=+=----=+=----=+=----=+=----=+=----=+=--

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if vRP.isUserSponsors({user_id}) then
			choices["Sponsor Menu"] = {function(player,choice)
				vRP.buildMenu({"Sponsor Menu", {player = player}, function(menu)
					menu.name = "Sponsor Menu"
					menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
					menu["☁️Sky Fall☁️"] = {sp_skyfall,"☁️ > Arunca-te cu parasuta"}
					menu["🔧Fix Masina🔧"] = {sp_fixCar,"🔧 > Repara-ti vehiculul"}
					menu["🏥Refa Viata 🏥"] = {sp_revive,"🏥 > Refati viata"}
					-- menu["🔫Pachet Arme🔫"] = {sp_weapons,"🔫 > Da-ti un pachet de arme"}
					-- menu["🔫Pachet Arme (GOLD)🔫"] = {sp_Goldweapons,"🔫 > Da-ti un pachet de arme (GOLD)"}
					menu["🌈Rainbow Masina🌈"] = {sp_rainbowcar,"🌈 > Coloreaza Masina si Neoanele si Smoke Tyre masinii in care esti actual in toate Culorile"}
					menu["🚁Elicopter Sponsor🚁"] = {sp_spawnCar,"🏎️ > Spawneaza elicopter"}
					menu["🏎️Masina Sponsor🏎️"] = {sp_spawnCar2,"🏎️ > Spawneaza masina sponsor"}
					-- menu["🏷️Custom Chat Tag🏷️"] = {sp_chatTag,"🏷️ > Pune-ti un tag custom in chat"}
					--menu["🕴🏼 Skin JackSparrow 🕴🏼"] = {sp_JackSparrowSkin,"🕴🏼  > Transforma-te in Pirat</br>(SKINUL ACTUAL ITI VA FII STERS)"}
					--menu["🌴Skin SithYoda🌴"] = {sp_sithyodaSkin,"🌴 > Transforma-te in Yoda</br>(SKINUL ACTUAL ITI VA FII STERS)"}
					--menu["🌴Skin Yoda🌴"] = {sp_yodaSkin,"🌴 > Transforma-te in Yoda</br>(SKINUL ACTUAL ITI VA FII STERS)"}
					--menu["💥Skin Black Racer💥"] = {sp_blackracerSkin,"💥 > Transforma-te in Dark Flash</br>(SKINUL ACTUAL ITI VA FII STERS)"}
					-- menu["👶🏻Skin Copil👶🏻"] = {sp_ChildSkin,"👶🏻 > Transforma-te in Copil</br>(SKINUL ACTUAL ITI VA FII STERS)"}
					vRP.openMenu({player,menu})
				end})
			end, "💸Facilitati sponsor💸"}
		end
		add(choices)
	end
end})

function vRPsp.denySponsorCarDriving()
	user_id = vRP.getUserId({source})
	if not(vRP.isUserSponsors({user_id})) then
		BMclient.denySponsorCarDriving(source, {})
	end
end

function vRPsp.getSponsorTag(user_id)
	user_id = tonumber(user_id)
	if(spTags[user_id] == nil)then
		return false
	else
		theTag = spTags[user_id]
		return theTag
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		users = vRP.getUsers({})
		for i, v in pairs(users) do
			if(vRP.isUserSponsors({user_id})) and (spUtils[i] == true)then
				spUtils[i] = nil
				vRPclient.notify(v, {"~y~[SPONSOR] ~b~Acum iti poti folosii meniul sponsor!"})
			end
		end
	end
end)

AddEventHandler("vRP:playerLeave", function(user_id, source)
	if(spCars[user_id] ~= nil)then
		BMclient.deleteSponsorCar(-1, {spCars[user_id]})
		spCars[user_id] = nil
	end
	if(spTags[user_id] ~= nil)then
		spTags[user_id] = nil
	end
end)

RegisterNetEvent("baseevents:enteredVehicle")
AddEventHandler("baseevents:enteredVehicle", function(theVehicle, theSeat, vehicleName)
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	if(theSeat == -1) and (vehicleName == "PROTOTIPO")then
		if not(vRP.isUserSponsors({user_id}))then
			BMclient.teleportOutOfCar(thePlayer, {theVehicle})
			vRPclient.notify(thePlayer, {"[SPONSOR] ~r~Nu poti conduce masina de ~y~Sponsor"})
		end
	end
	if(theSeat == -1) and (vehicleName == "MAVERICK")then
		if not(vRP.isUserSponsors({user_id}))then
			BMclient.teleportOutOfCar(thePlayer, {theVehicle})
			vRPclient.notify(thePlayer, {"[SPONSOR] ~r~Nu poti conduce masina de ~y~Sponsor"})
		end
	end
end)