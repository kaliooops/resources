--import all vrp
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

minereuri = {
    "minereu_de_fier", 
    "minereu_de_aur", 
    "minereu_de_argint"
}


RegisterNetEvent("Miner:Give_Minereuri")
AddEventHandler("Miner:Give_Minereuri", function(spart_de_tot)
    src = source
    uid = vRP.getUserId({src})

    chance = math.random(1, 100)

    if not spart_de_tot then
        if chance < 15 then
            amount = math.random(1,2)
            rminer = minereuri[math.random(1, #minereuri)]

            if vRP.getInventoryWeight({uid}) + vRP.getItemWeight({rminer}) <= vRP.getInventoryMaxWeight({uid}) then
                vRP.giveInventoryItem({uid, rminer, amount})
                if rminer == "minereu_de_aur" then
                    TriggerEvent("Achievements:UP_Current_Progress", uid, "Gaseste minereu de aur")
                end
            end
        end
    else
        for i=1, 4 do
            amount = math.random(1,5)
            rminer = minereuri[math.random(1, #minereuri)]
            vRP.giveInventoryItem({uid, rminer, amount})
        end
    end
    TriggerClientEvent("Miner:GiveMinereuri", src)
end)

RegisterNetEvent("Miner:Give_Item")
AddEventHandler("Miner:Give_Item", function(itemname)
    src = source
    uid = vRP.getUserId({src})

    if vRP.getInventoryWeight({uid}) + vRP.getItemWeight({itemname}) <= vRP.getInventoryMaxWeight({uid}) then
        vRP.giveInventoryItem({uid, itemname, 1})
    end
    TriggerClientEvent("Miner:GiveItem", src)

end)

local function buildAmanetMenu(player)
	local menu = {name = "Amanet",css={top="75px",header_color="rgba(0,125,255,0.75)"}}
	menu.name = "Amanet"

	local function ch_silver(player,choice) 
    	local user_id = vRP.getUserId({player})
		if user_id ~= nil then
            a = vRP.tryGetInventoryItem({user_id,"bucata_de_argint",100})
            if a then
                vRP.giveMoney({user_id,3000})
             end
            vRP.closeMenu({player})
        end
    end

    local function ch_gold(player,choice) 
    	local user_id = vRP.getUserId({player})
		if user_id ~= nil then
            a = vRP.tryGetInventoryItem({user_id,"bucata_de_aur",100})
            if a then
                vRP.giveMoney({user_id,10000})
          end
            vRP.closeMenu({player})
        end
    end

	menu['100 Aur'] = {ch_gold,"10.000€"}
	menu['100 Argint'] = {ch_silver,"3.000€"}

	vRP.openMenu({player,menu})
end

RegisterServerEvent("Amanet:openMenu")
AddEventHandler("Amanet:openMenu", function(name)
	local user_id = vRP.getUserId({source})
    buildAmanetMenu(source)
end)