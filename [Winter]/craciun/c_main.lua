--import xsound

local xSound = exports.xsound

RegisterNetEvent("craciun:playMusic")
RegisterNetEvent("craciun:stopMusic")
RegisterNetEvent("craciun:bonus")


AddEventHandler("craciun:bonus", function ()
    TriggerEvent("toasty:Notify", {type = "info", title="[Craciun]", message = "Ai primit bonusul!"})
end)

AddEventHandler("craciun:stopMusic", function()
    xSound:Pause("craciun")
end)

AddEventHandler("craciun:playMusic", function()
    xSound:PlayUrlPos("craciun", "https://www.youtube.com/watch?v=cyIY6Fb0p4Y", 0.3, GetEntityCoords(PlayerPedId()))
    xSound:Distance("craciun", 100000)

    TriggerClientEvent("toasty:Notify", {type = "info", title="Craciun", message = "A fost activat bonusul de craciun!"})
    
    CreateThread(function()
        while true do
            Wait(0)
            local t = xSound:getTimeStamp("craciun")
            print(t)
            if t >= 60 then
                xSound:Pause("craciun")
                xSound:Pause("craciun")
                xSound:Pause("craciun")
                xSound:Pause("craciun")
                xSound:Pause("craciun")
                
                break
            end   
        end
    end)
end)

