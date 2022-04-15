local cfg = module("cfg/survival")
local lang = vRP.lang

-- api

function vRP.getHunger(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    return data.hunger
  end

  return 0
end

function vRP.getThirst(user_id)
  local data = vRP.getUserDataTable(user_id)
  if data then
    return data.thirst
  end

  return 0
end

function vRP.setHunger(user_id,value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.hunger = value
    if data.hunger < 0 then data.hunger = 0
    elseif data.hunger > 100 then data.hunger = 100 
    end

    -- update bar
    local source = vRP.getUserSource(user_id)
    TriggerClientEvent("vrp_ladderhud:updateBasics",source, data.hunger, data.thirst)
    --vRPclient._setProgressBarValue(source, "vRP:hunger",data.hunger)
    if data.hunger >= 100 then
      --vRPclient._setProgressBarText(source,"vRP:hunger",lang.survival.starving())
    else
      --vRPclient._setProgressBarText(source,"vRP:hunger","")
    end
  end
end

function vRP.setThirst(user_id,value)
  local data = vRP.getUserDataTable(user_id)
  if data then
    data.thirst = value
    if data.thirst < 0 then data.thirst = 0
    elseif data.thirst > 100 then data.thirst = 100 
    end

    -- update bar
    local source = vRP.getUserSource(user_id)
    TriggerClientEvent("vrp_ladderhud:updateBasics",source, data.hunger, data.thirst)
    --vRPclient._setProgressBarValue(source, "vRP:thirst",data.thirst)
    if data.thirst >= 100 then
      --vRPclient._setProgressBarText(source,"vRP:thirst",lang.survival.thirsty())
    else
      --vRPclient._setProgressBarText(source,"vRP:thirst","")
    end
  end
end

function vRP.varyHunger(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    local was_starving = data.hunger >= 100
    data.hunger = data.hunger + variation
    local is_starving = data.hunger >= 100

    -- apply overflow as damage
    local overflow = data.hunger-100
    if overflow > 0 then
      vRPclient._varyHealth(vRP.getUserSource(user_id),-overflow*cfg.overflow_damage_factor)
    end

    if data.hunger < 0 then data.hunger = 0
    elseif data.hunger > 100 then data.hunger = 100 
    end

    -- set progress bar data
    local source = vRP.getUserSource(user_id)
    TriggerClientEvent("vrp_ladderhud:updateBasics",source, data.hunger, data.thirst)
    --vRPclient._setProgressBarValue(source,"vRP:hunger",data.hunger)
    if was_starving and not is_starving then
      --vRPclient._setProgressBarText(source,"vRP:hunger","")
    elseif not was_starving and is_starving then
      --vRPclient._setProgressBarText(source,"vRP:hunger",lang.survival.starving())
    end
  end
end

function vRP.varyThirst(user_id, variation)
  local data = vRP.getUserDataTable(user_id)
  if data then
    local was_thirsty = data.thirst >= 100
    data.thirst = data.thirst + variation
    local is_thirsty = data.thirst >= 100

    -- apply overflow as damage
    local overflow = data.thirst-100
    if overflow > 0 then
      vRPclient._varyHealth(vRP.getUserSource(user_id),-overflow*cfg.overflow_damage_factor)
    end

    if data.thirst < 0 then data.thirst = 0
    elseif data.thirst > 100 then data.thirst = 100 
    end

    -- set progress bar data
    local source = vRP.getUserSource(user_id)
    TriggerClientEvent("vrp_ladderhud:updateBasics",source, data.hunger, data.thirst)
    --vRPclient._setProgressBarValue(source,"vRP:thirst",data.thirst)
    if was_thirsty and not is_thirsty then
      --vRPclient._setProgressBarText(source,"vRP:thirst","")
    elseif not was_thirsty and is_thirsty then
      --vRPclient._setProgressBarText(source,"vRP:thirst",lang.survival.thirsty())
    end
  end
end

-- tunnel api (expose some functions to clients)

function tvRP.varyHunger(variation)
  local user_id = vRP.getUserId(source)
  if user_id then
    vRP.varyHunger(user_id,variation)
  end
end

function tvRP.varyThirst(variation)
  local user_id = vRP.getUserId(source)
  if user_id then
    vRP.varyThirst(user_id,variation)
  end
end

-- tasks

-- hunger/thirst increase
function task_update()
  for k,v in pairs(vRP.users) do
    vRP.varyHunger(v,cfg.hunger_per_minute)
    vRP.varyThirst(v,cfg.thirst_per_minute)
  end

  SetTimeout(60000,task_update)
end

  task_update()


-- handlers

-- init values
AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
  local data = vRP.getUserDataTable(user_id)
  if data.hunger == nil then
    data.hunger = 0
    data.thirst = 0
  end
end)

-- add survival progress bars on spawn
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  local data = vRP.getUserDataTable(user_id)

  -- disable police
  vRPclient._setPolice(source,cfg.police)
  -- set friendly fire
  vRPclient._setFriendlyFire(source,cfg.pvp)

  TriggerClientEvent("vrp_ladderhud:updateBasics",source, data.hunger, data.thirst)
  --vRPclient._setProgressBar(source,"vRP:hunger","minimap",htxt,255,153,0,0)
  --vRPclient._setProgressBar(source,"vRP:thirst","minimap",ttxt,0,125,255,0)
  vRP.setHunger(user_id, data.hunger)
  vRP.setThirst(user_id, data.thirst)
end)


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


RegisterNetEvent("DEATH_KRANE:Respawn_and_Remove")
AddEventHandler("DEATH_KRANE:Respawn_and_Remove", function()
    src = source
    local user_id = vRP.getUserId(src)
    vRP.clearInventory(user_id)
    local maxmoney = vRP.getMoney(user_id)
    vRP.takeMoney(user_id, maxmoney)
    TriggerClientEvent("toasty:Notify", src, {type="info", title="[Bv mane]", message="Ai pierdut tot ce aveai la tine si " .. maxmoney .. " $"})
end)