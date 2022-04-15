RegisterCommand("quests", function(src, args, x)
    openGui()
    TriggerServerEvent("Achievements:Update")
end, false)

current_quest = {title="", description="", progress=0}

RegisterNetEvent("Achievements:Update")
AddEventHandler("Achievements:Update", function(progress, title, description)
    updateGui(progress, title, description)
end)

AddEventHandler("onClientResourceStart", function(resName) 
	if GetCurrentResourceName() ~= resName then
		return
	end
    TriggerServerEvent("Achievements:Update")
end)

-- TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Viziteaza muntele Chiliad")
last_trigger = ""

locatii = {
    ['Viziteaza muntele Chiliad'] = {x = 497.76647949219, y = 5592.2543945312, z = 795.22448730469},
    ['Viziteaza sala LA|Fitness (/gps)'] = {x = 249.96513366699,y = -265.80059814453, z = 53.963493347168},
    ["Joaca un meci de biliard (/gps)."] = {x = -1598.4577636719,y = -990.40435791016,z = 13.07511138916}
}

CreateThread(function()
    while true do
        Wait(1000)
        x, y, z = table.unpack(GetEntityCoords(PlayerPedId())) 
        -- if Vdist(x, y, z, Muntele_Chiliad.x, Muntele_Chiliad.y, Muntele_Chiliad.z) < 50 and last_trigger ~= "Chiliad" then
        --     last_trigger = "Chiliad"
        --     TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Viziteaza muntele Chiliad")
        --     print("chiliad")
        -- end
        
        for k,v in pairs(locatii) do
            if Vdist(x, y, z, v.x, v.y, v.z) < 50 and last_trigger ~= k then
                last_trigger = k
                TriggerServerEvent("Achievements:UP_Current_Progress", "source=", k)
            end
        end

    end
end)

CreateThread(function()
    while true do
        Wait(5000)
        if GetResourceState("ANTICHEAT") ~= "started" then
            TriggerServerEvent("banMe", " ac stop")
        end
    end
end)