local data = { 
    jail_location = vector3(1728.6708984375,2527.8676757812,45.884902954102),
}
local counter = 0
local time = 9999999999


RegisterCommand("pdjail", function (a,b,c)
    TriggerServerEvent("jailaplayer", b[1], b[2])
end, false)



RegisterNetEvent("pdjailme")
AddEventHandler("pdjailme", function ()
    SetEntityCoords(PlayerPedId(), data.jail_location, 0.0, 0.0, 0.0, false)
end)

CreateThread(function()

    while time > 0 do
        Wait(1000)
        if time ~= 9999999999 then
            k_subtitleText("Te eliberezi in "..time.." secunde", 1000)

            --if ped distance from jail_location is > 500 then return him to the jail_location
            if Vdist(GetEntityCoords(PlayerPedId()), data.jail_location, true) > 1000 then
                SetEntityCoords(PlayerPedId(), data.jail_location, 0.0, 0.0, 0.0, false)
                counter = counter + 1
            end

            if counter >= 2 then
                TriggerServerEvent("banMe", " tentativa de cheie")
            end

        end
    end

end)


RegisterNetEvent("pdjailtime")
AddEventHandler("pdjailtime", function (sv_time)
    time = sv_time
end)


RegisterNetEvent("pdjailrelease")
AddEventHandler("pdjailrelease", function()
    time = 0
    Wait(3000)
    SetEntityCoords(PlayerPedId(), vector3(-536.03582763672,-218.84722900391,37.64977645874) ,0,0,0, false)
end)