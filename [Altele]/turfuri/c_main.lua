
a_trimis_tignalu = false
turfs_activ = false
CreateThread(function()
    while true do
        Wait(1000)
        for _, t in pairs(turfuri) do
            if am_I_InsideTurf(t) and turfs_activ then
                if GetEntityHealth(PlayerPedId()) > 120 then
                    TriggerServerEvent("turfuri:Capture", t)     
                    TriggerServerEvent("turfuri:Get_Turfs")           
                else
                    if not a_trimis_tignalu then
                        TriggerServerEvent("turfuri:Mortaciune", t)
                        a_trimis_tignalu = true
                    end
                end
            end
        end

        if a_trimis_tignalu and GetEntityHealth(PlayerPedId()) > 120 then
            a_trimis_tignalu = false
        end
    end
end)