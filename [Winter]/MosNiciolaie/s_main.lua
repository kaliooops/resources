--import all vrp
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

local gifts = {
    'Portocala',
    'Ciocolata',
    'Globulete'
}



AddEventHandler("mosnicoale:giveGift", function (src, u_id)
    
    local src = src
    local user_id = u_id
    local gift = gifts[math.random(1, #gifts)]
    vRP.giveInventoryItem({user_id, gift, 1})


end)