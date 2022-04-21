kraneUtility = module(Classes_Config.resource_name, "classes/c_kraneUtility")
kranePed = module(Classes_Config.resource_name, "classes/c_kranePED")
kraneVeh = module(Classes_Config.resource_name, "classes/c_kraneVehicle")
kraneObject = module(Classes_Config.resource_name, "classes/c_kraneObject")


soundlink = "https://www.youtube.com/watch?v=7VUGr0QSIX8"

local xSound = exports.xsound

function start_event()
    spawn_crate()
    SendNUIMessage({
        cmd="splash"
    })    
    xSound:PlayUrl(shipsound, soundlink, 1.0, false, {})
end

local started = false
CreateThread(function()
    while true do
        Wait(1000)
        if GetClockHours() == 18 then
            if not started then
                started = true
                start_event()
            end
        else
            if started then
                started = false
            end
        end
        
    end
end)