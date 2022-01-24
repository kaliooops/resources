
local function drawDebug(text)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.5)
    SetTextColour(128, 128, 128, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(0.005, 0.005)
end

local data = {}

local debug = false
Citizen.CreateThread(function()
    while true do
        while not debug do Wait(1000) end
        Wait(100)
        
        data.coords = GetEntityCoords(PlayerPedId())
        data.heading = GetEntityHeading(PlayerPedId())
        data.speed = GetEntityVelocity(PlayerPedId())
        local retval --[[ boolean ]], groundZ --[[ number ]] =GetGroundZFor_3dCoord(
            data.coords.x --[[ number ]], 
            data.coords.y --[[ number ]], 
            data.coords.z --[[ number ]], 
            true --[[ boolean ]]
        )
        data.groundZ = groundZ
        data.closestSnowPile = GetClosestObjectOfType(data.coords, 10.0, GetHashKey("prop_snow_bush_02_a"), false)
        data.closestSnowPileCoords = GetEntityCoords(data.closestSnowPile)
        data.rotation = GetEntityRotation(PlayerPedId())
        -- local pedCoords = GetEntityCoords(PlayerPedId())
        -- local objectId = GetClosestObjectOfType(pedCoords, 5.0, GetHashKey("prop_plant_int_02a"), false)


        print("\n")
        print(string.format("X: %.2f <> Y: %.2f <> Z: %.2f", data.coords.x, data.coords.y, data.coords.z) )
        print(string.format("Heading: %.2f", data.heading) )
        print(string.format("GroundZ: %.2f", data.groundZ) )
        print(string.format("s:%s Snow X: %.2f <> Snow Y: %.2f <> Snow Z: %.2f", data.closestSnowPile, data.closestSnowPileCoords.x, data.closestSnowPileCoords.y, data.closestSnowPileCoords.z))
        print(string.format("ROT: X: %.2f <> Y: %.2f <> Z: %.2f", data.rotation.x, data.rotation.y, data.rotation.z))
        
        
        
    end

end)


RegisterCommand("debug", function ()
    debug = not debug
end)
