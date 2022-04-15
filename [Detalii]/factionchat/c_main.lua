RegisterCommand("f", function (a, msg, b)

    local mesaj = ""
    for i = 1, #msg do
        mesaj  = mesaj .. msg[i] .. " "
    end

    
    TriggerServerEvent("fmessage", mesaj)
end, false)
