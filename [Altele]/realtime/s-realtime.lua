local waittime = 1800000
local weather_randomer = math.random(1, 1000)

function set_weather(rnumber)
    if weather_randomer < 800 then
        TriggerClientEvent("WEATHER:UPDATE", -1, "CLEAR")    
        waittime = 1800000
    end

    if weather_randomer > 850 and weather_randomer < 900 then
        TriggerClientEvent("WEATHER:UPDATE", -1, "RAIN")
        waittime = 500000
    end

    if weather_randomer > 900 and weather_randomer < 999 then
        TriggerClientEvent("WEATHER:UPDATE", -1, "CLEARING")
        waittime = 1800000
    end
end

CreateThread(function() -- auto reset
    while true do
        Wait(2000)
        weather_randomer = math.random(1, 1000)
        set_weather(weather_randomer)
        
        Wait(waittime)
    end
end)

AddEventHandler("playerJoining", function ()
    set_weather(weather_randomer)
end)


RegisterCommand("__weather", function(x, args, y)
    TriggerClientEvent("WEATHER:UPDATE", -1, args[1])
end, false)


        
