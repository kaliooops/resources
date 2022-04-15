before_crate_model = "ex_prop_crate_closed_bc"
after_crate_model = "ex_prop_crate_biohazard_bc"
-- time_to_wait = 900000
time_to_wait = 900
local isOpen = false
local event_finished = true
local b = nil
local b_sp = nil
local function ms_to_s(miliseconds)
    -- return as minutes:seconds
    return string.format("%d:%02d", miliseconds / 60000, (miliseconds % 60000) / 1000)
end

function open_crate(crate_obj)
    crate_obj:Swap_Model(after_crate_model)
    CreateThread(function()
        Wait(900000)
        crate_obj:Destroy()
        isOpen = false
        time_to_wait = 15
        event_finished = true
        RemoveBlip(b)
        RemoveBlip(b_sp)
        b = nil
        b_sp = nil
        TriggerServerEvent("Barca:Finish")
    end)

    crate_obj:Listen_Interactions(function()
        ExecuteCommand("e pickup")
        Wait(500)
        ExecuteCommand("me ~r~ Ia din cutie")
        TriggerServerEvent("Barca:Give_Drop")
        Wait(500)
    end)
end


function spawn_crate()
    event_finished = false
    x,y,z = crate_position.x, crate_position.y, crate_position.z
    crate = kraneObject.new()
    crate:Create_Me(x,y,z, 0, before_crate_model, false)
    crate:Generic_Object()

    
    b = AddBlipForArea(x, y, z, 200.0, 200.0)
    SetBlipColour(b, 1)
    SetBlipAlpha(b, 200)
    b_sp = AddBlipForCoord(x, y, z)
    SetBlipSprite(b_sp, 501)
    
   
    CreateThread(function()
        while not event_finished do
            Wait(0)
            if time_to_wait > 0 then
                crate:Draw_Info("Crate-ul se deschide in " .. time_to_wait , 4.0)
            else
                crate:Draw_Info("Crate-ul se inchide curand" , 4.0)
            end
            kraneUtility.Generic_Marker(x,y,z, kraneUtility.rgb_rainbow.r, kraneUtility.rgb_rainbow.g, kraneUtility.rgb_rainbow.b, 5.0, 5.0, 10.0) --rgb optional

        end
    end)


    crate:Internal_Cycle(function()
        if time_to_wait > 0 then
            time_to_wait = time_to_wait - 1 
        else
            if not isOpen then
               open_crate(crate)
                isOpen = true
            end
        end
    end, 1000)

    
end