local src = 0
local user_id = 0

local veh_data = {}

local plate_caught = 0
local running = true
function cancelRader()
    CreateThread(function ()
        while true do
            Wait(100)
            if running then
                if GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) *3.6 > 10 then
                    running = false
                    TriggerEvent("toasty:Notify", {type = "info", title="Radar", message = "Ai oprit radarul"})

                end
            end
        end
    end)
end

function Radar()
    while true do
        while not running do Wait(1000) end
        Wait(100)

        
        for _,v in pairs(GetActivePlayers()) do
            v = GetPlayerPed(v)
            local d = Vdist(GetEntityCoords(v), GetEntityCoords(PlayerPedId()))
            if d < 25 then
                if GetEntitySpeed(GetVehiclePedIsIn(v, false)) * 3.6 > 80 then
                    veh_data.veh = GetVehiclePedIsIn(v, false)
                    veh_data.speed = GetEntitySpeed(veh_data.veh) * 3.6
                    veh_data.plate = GetVehicleNumberPlateText(veh_data.veh)
                    veh_data.model = GetDisplayNameFromVehicleModel(GetEntityModel(veh_data.veh))
                    


                    for _, tabla in pairs(vehicles) do 
                        for __, car in pairs(tabla) do
                            if veh_data.model == car.numeVehicul then
                                veh_data.model = car.numemasina
                            end
                        end
                    end

                    veh_data.color = GetVehicleColours(veh_data.veh)

                    for _, color in pairs(colors) do
                        if veh_data.color == color[1] then
                            veh_data.color = color[2]
                        end
                    end


                    local printed_data = "\n^0[^4RADAR^0]: Viteza: ^3" .. string.format("%.2f",veh_data.speed) .. " ^0km/h\n" .. "^0[^4RADAR^0]: Nr. masina: ^3" .. veh_data.plate .. "\n" .. "^0[^4RADAR^0]: Model: ^3" .. veh_data.model .. "\n" .. "^0[^4RADAR^0]: Culoare: ^3" .. veh_data.color .. "^0\n"
                    local discord_data = "\n📷RADAR📷 Viteza: " .. string.format("%.2f",veh_data.speed) .. " km/h\n" .. "📷RADAR📷: Nr. masina: " .. veh_data.plate .. "\n" .. "📷RADAR📷: Model: " .. veh_data.model .. "\n" .. "📷RADAR📷 Culoare: " .. veh_data.color .. "\n"

                    if plate_caught ~= veh_data.plate then

                        print(printed_data)
                        veh_data.color2 = GetVehicleExtraColours(veh_data.veh)
                        TriggerEvent('chat:addMessage', { -- notify player
                        color = {255, 255, 255}, -- red
                        multiline = true, -- multiline
                        args = {printed_data}
                        })
                        TriggerServerEvent("Politie:SendToDiscord", discord_data)
                                                    
                    end
    

                    plate_caught = veh_data.plate
                    

                end
            end
        end
    end    

end

RegisterNetEvent("Politie:Radar")
AddEventHandler("Politie:Radar", function(player)

    running = true
    src = player
    TriggerEvent("toasty:Notify", {type = "info", title="Radar", message = "Ai activat radarul"})

    CreateThread(function()
        Radar()
    end)

    cancelRader()

end)