local PlayerData = {}
local wait = 1000
local newsMenu = Config.newsBlip
local job = nil

RegisterNetEvent('gcphone:setAccountMoney')
AddEventHandler('gcphone:setAccountMoney', function(bank, datajob)
    job = datajob
end)

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(newsMenu)
    SetBlipSprite (blip, 135)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.7)
    SetBlipColour (blip, 49)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Weazel News")
    EndTextCommandSetBlipName(blip)
    
end)

local pula = true
RegisterCommand("robert1", function()
        newNews()
end)

RegisterCommand("DeleteNews", function()
    if job and job == Config.newsJobName then 
        newsDelete()
    end
end)

function newNews()
    TriggerServerEvent("gcphone:newNews")
end

function newsDelete()
    TriggerServerCallback('crew-phone:get-news', function(news)
        TriggerServerEvent("gcphone:newDelete", news)
    end)
end

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)

    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)

    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 180
    DrawRect(_x, _y + 0.0150, 0.0 + factor, 0.035, 41, 11, 41, 100)
end

RegisterNUICallback('crew-phone:getNews', function(data, cb)
    TriggerServerCallback('crew-phone:get-news', function(news)
        SendNUIMessage({event = 'news_updateNews', news = news})
    end)
end)