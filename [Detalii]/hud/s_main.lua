--import all vrp
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")
cfg = module("vrp", "cfg/money")


RegisterNetEvent("DisableHud")
AddEventHandler("DisableHud", function(bool)

    if bool then        
        vRPclient.setDiv(source,{"money","",""})
        vRPclient.setDiv(source,{"bmoney","",""})
        vRPclient.setDiv(source,{"krCoins","",""})
    end

end)

--[[
        -- vRPclient.setDiv(source,{"money",cfg.display_css,"<span class=\"symbol\"></span>",vRP.formatMoney(vRP.getMoney({user_id}))})
    	-- vRPclient.setDiv(source,{"bmoney",cfg.display_css,"<span class=\"symbol\"></span>",vRP.formatMoney(vRP.getBankMoney({user_id}))})
	    -- vRPclient.setDiv(source,{"krCoins",cfg.display_css,"<span class=\"symbol\"></span>",vRP.formatMoney(vRP.getKRCoins({user_id}))})
]]