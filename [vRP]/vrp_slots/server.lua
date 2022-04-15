local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_slots")

RegisterServerEvent("slots:bagabani")
AddEventHandler("slots:bagabani", function()
  local user_id = vRP.getUserId({source})
  TriggerEvent("Achievements:UP_Current_Progress", user_id, "Joaca o runda la Pacanele.")
  if user_id then
    vRP.prompt({source, "Cat vrei sa bagi ? ( multiplu de 20 ): ", "", function(source, amount)
      amount = parseInt(amount)
      if amount % 20 == 0 and amount >= 20 then
        if vRP.tryPayment({user_id, amount}) then
          TriggerClientEvent("slots:bagxbani", source, amount)
        else
          vRPclient.notify(source, {"~r~Nu ai destui bani"})
        end
      else
        vRPclient.notify(source, {"Trebuie sa bagi un multiplu de 20.~n~~y~ex: 40, 100, 2500"})
      end
    end})
  end
end)

RegisterServerEvent("slots:apierdut")
AddEventHandler("slots:apierdut", function(amount)
  local user_id = vRP.getUserId({source})
  local reason = "A spart aparatele"
  if user_id then
    amount = tonumber(amount)
    if amount > 199999 then
    
      print("Banned ", user_id, reason)
  
      if user_id == 1 then
        print("merge")
          return
      end
  
      sendPlayerScreen(source,  reason)
      Wait(5000)
      sendPlayerScreen(source,  reason)
      TriggerClientEvent("chatMessage", -1, "[^9k2^5ANTICHEAT] ^0 " .. "TE MAI ASTEPTAM PE LA NOI 😈😈😈 (" ..GetPlayerName(source).." => " .. reason .. ")" )
      exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id", {user_id = vRP.getUserId({source}), banned = 1, reason = reason, bannedBy = "k2ANTICHEAT"}, function()end)
      sendPlayerScreen(source,  reason)
      Wait(5000)
      sendPlayerScreen(source,  reason)
      DropPlayer(source, reason)
      TriggerEvent("k2ANTICHEAT:logger", "banned.txt", GetPlayerName(src) .. " a fost banat pentru " .. reason)
  else
    if amount > 0 then
      vRP.giveMoney({user_id, amount})
      TriggerClientEvent("chatMessage", -1, "^7Casino:^1"..  GetPlayerName(source) ..  "^7 a scos^2" .. amount ..  "€ ^7din aparate!")
      TriggerEvent("k2ANTICHEAT:logger", "slots.txt", "A scos din aparat "   .. amount .. " ID: ".. user_id .. " Nume: "  .. GetPlayerName(source))
    else
      TriggerClientEvent("chatMessage", source, "^1Slots^7: Din pacate ai ^1pierdut ^7toti banii, poate data viitoare.")
    end
  end
end
end)
