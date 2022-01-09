local cfg = module("cfg/survival")
local lang = vRP.lang

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  local data = vRP.getUserDataTable(user_id)
  vRPclient.setPolice(source,{cfg.police})
  vRPclient.setFriendlyFire(source,{cfg.pvp})
end)

local revive_seq = {
  {"amb@medic@standing@kneel@enter","enter",1},
  {"amb@medic@standing@kneel@idle_a","idle_a",1},
  {"amb@medic@standing@kneel@exit","exit",1}
}

local bandaj_seq = {
  {"amb@medic@standing@tendtodead@enter","enter",1},
  {"amb@medic@standing@tendtodead@idle_a","idle_a",1},
  {"amb@medic@standing@tendtodead@exit","exit",1}
}

bandaged = {}
function vRP.useBandaje(player)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.isInComa(player,{}, function(in_coma)
      if (in_coma == false) then
        if(bandaged[user_id] == nil)then
          if vRP.tryGetInventoryItem(user_id,"bandaj",1,true) then
            vRPclient.playAnim(player,{false,bandaj_seq,false})
            bandaged[user_id] = true
            SetTimeout(5000, function()
              vRPclient.stopAnim(player,{true})
              vRPclient.varyHealth(player,{15})
              vRPclient.notify(player,{"Ti-ai aplicat un Bandaj si ti-ai revenit cu 15%!"})
              bandaged[user_id] = nil
            end)
          end
        else
          vRPclient.notify(player,{"~r~Ti-ai aplicat un bandaj deja!, asteapta 5 secunde"})
          return
        end
      else
        vRPclient.notify(player,{"~r~Esti lesinat doar Medicul te poate ajuta!"})
      end
    end)
  end
end

local choice_revive = {function(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRPclient.isInComa(player,{}, function(in_coma)
      if in_coma then
        vRPclient.notify(player,{"~r~Esti lesinat, nu poti ajuta persoana"})
      else
        if vRP.isUserInFaction(user_id,"Smurd") then
          vRPclient.getNearestPlayer(player,{2},function(nplayer)
            local nuser_id = vRP.getUserId(nplayer)
            if nuser_id ~= nil then
              vRPclient.isInComa(nplayer,{}, function(in_coma)
                if in_coma then
                  if vRP.tryGetInventoryItem(user_id,"medkit",1,true) then
                    vRPclient.playAnim(player,{false,revive_seq,false})
                    SetTimeout(15000, function()
                      vRPclient.varyHealth(nplayer,{100})
                      Wait(10000)
                      vRPclient.notify(nplayer,{"Se pare ca ai revenit pe pamant dar cu dureri de cap."})
                      if in_coma then
                        vRPclient.varyHealth(nplayer,{100})
                      end
                    end)
                  end
                else
                  vRPclient.notify(player,{lang.emergency.menu.revive.not_in_coma()})
                end
              end)
            else
              vRPclient.notify(player,{lang.common.no_player_near()})
            end
          end)
        end
      end
    end)
  else
    vRPclient.notify(player,{"~r~Esti Off Duty Nu Poti Folosi Acest Lucru"})
  end
end,lang.emergency.menu.revive.description()}

-- add choices to the main menu (emergency)
vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}

    if vRP.isUserInFaction(user_id,"Politia Romana") or vRP.isUserInFaction(user_id,"Smurd") or vRP.isUserInFaction(user_id,"S.I.A.S") or vRP.isUserInFaction(user_id,"SRI") or vRP.isUserHelper(user_id) then
      choices[lang.emergency.menu.revive.title()] = choice_revive
    end

    add(choices)
  end
end)
