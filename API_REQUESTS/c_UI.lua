--[[

    Gestu tau, foarte urat, ca ai indraznit sa furi de la mine
    ca eu pentru tine sunt smecher, si nu pentru tine pentru multa lume
    da e urat sa vorbesc asta, dar nu eu

]]

RegisterNetEvent("api_request:stop")
AddEventHandler("api_request:stop", function()
    Request_STOP()
end)

RegisterNetEvent("api_request:get")
AddEventHandler("api_request:get", function(url)
    print(url)
    Request_GET(url)
end)


RegisterNetEvent("api_request:post")
AddEventHandler("api_request:post", function(url, data)
    print(url, data)
    Request_POST(url, data)
    
    
end)

function Request_STOP()
    SendNUIMessage({
        type = "API_REQUEST_STOP"
    })
end

function Request_GET(url)
    SendNUIMessage({
        type = "API_REQUEST_GET",
        url = url
    })
end

function Request_POST(url, data)
    SendNUIMessage({
        type = "API_REQUEST_POST",
        url = url,
        data = data
    })
end