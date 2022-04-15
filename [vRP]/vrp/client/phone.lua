function tvRP.backgroundPhone(url)
    SendNUIMessage({action = "switch_bg", url = url})
end

function tvRP.changePositionPhone()
    SetNuiFocus(true, true)
    SendNUIMessage({action = "position_phone"})
end

function tvRP.positionPhone(position)
    position = json.decode(position)
    SendNUIMessage({action = "set_pos_phone", top = position[1], left = position[2]})
end

function tvRP.changeColorPhone(color)
    print(color)
    SendNUIMessage({action = "set_color_phone", color = color})
end

RegisterNUICallback("position_phone",function(data,cb)
    SetNuiFocus(false, false)
    tvRP.notify("~g~Ai schimbat pozitia telefonului cu succes!")
    TriggerServerEvent("vRP:updatePosition", {data.top, data.left})
end)
