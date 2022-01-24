function setCrypto(mevcut)
    SendNUIMessage({event = 'updateCrypto', mevcut = mevcut})
end

RegisterNUICallback('buyCrypto', function(data)
  TriggerServerEvent('gcPhone:buyCrypto', data.islem, data.id, data.adet, data.fiyat)
end)

RegisterNUICallback('getCrypto', function(data)
    TriggerServerCallback('gcPhone:getCrypto', function(data)
        setCrypto(data)
    end, data.id)
end)

RegisterNetEvent('updateCrypto')
AddEventHandler('updateCrypto', function(coin)
    TriggerServerCallback('gcPhone:getCrypto', function(data)
        setCrypto(data)
    end, coin)
end)
