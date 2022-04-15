RegisterCommand("referral", function(src, args, x)
    TriggerServerEvent("Referral:Activate_Code", args[1])
end, false)