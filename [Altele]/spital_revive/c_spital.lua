CreateThread(function()
    local waittime = 1000

    while true do
        Wait(waittime)
if Vdist2(GetEntityCoords(PlayerPedId()), 321.92041015625,-590.86767578125,43.283988952637) < 15 then
    waittime = 0
    k_draw3DText(321.92041015625,-590.86767578125,43.283988952637+1.0,"Apasa [~g~E~w~] sa te tratezi", 2, 1)  
    if IsControlJustPressed(1, 51) then
        -- TriggerServerEvent("spital_heal")
        FreezeEntityPosition(PlayerPedId(), true)
        Wait(20000)
        SetEntityHealth(PlayerPedId(), 200)
        FreezeEntityPosition(PlayerPedId(), false)
        TriggerEvent("toasty:Notify", {type = "info", title="Spital", message = "Ai fost tratat, ai grija de tine :*"})
         end
        end
    end
end)

RegisterNetEvent("cspital_heal")
AddEventHandler("cspital_heal", function ()
    FreezeEntityPosition(PlayerPedId(), true)
    Wait(30000)
    SetEntityHealth(PlayerPedId(), 100)
    FreezeEntityPosition(PlayerPedId(), false)
end)