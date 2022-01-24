playerHousing = {}
theHouses = {}
--[[function tvRP.doesPlayerOwnThisHouse(houseName)
    print(playerHousing[user_id])
	if playerHousing[user_id] == houseName then
		return playerHousing[user_id]
	end
	return false
end]]
local function loadConfig()
    exports.ghmattimysql:execute("SELECT * FROM housing",{},function(houses)
        for key,value in pairs(houses)do
            theHouses[value.id] = {}
            theHouses[value.id].name = value.name
            theHouses[value.id].price = value.price
            theHouses[value.id].position = {value.positionX,value.positionY,value.positionZ}
            theHouses[value.id].chestposition = {value.chestpositionX,value.chestpositionY,value.chestpositionZ}
            theHouses[value.id].haine = {value.haineX,value.haineY,value.haineZ}
            theHouses[value.id].interior = {value.interiorX,value.interiorY,value.interiorZ}
            theHouses[value.id].owned = value.owned
            theHouses[value.id].ownerName = value.ownerName
            theHouses[value.id].ownerId = value.ownerId

        end
    end)
    print('[FRP] Au fost incarcate ^1'..#theHouses.."^0 case din baza de date!")
end
loadConfig()


tvRP.previewHouse = function(theHouse)
    local user_id = vRP.getUserId(source)
    local thePlayer = source

    
end

tvRP.tryBuyHouse = function(theHouse)
    local thePlayer = source
    local user_id = vRP.getUserId({thePlayer})
    exports.ghmattimysql:execute("SELECT * FROM housing WHERE name = @theHouse",{theHouse = theHouse},function(rows)
        if #rows > 0 then

        else
            vRPclient.notify(thePlayer,{"~r~Aceasta casa nu a fost gasita in baza de date!"})
        end
    end)
end