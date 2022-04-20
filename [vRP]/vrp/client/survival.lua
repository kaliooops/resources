function tvRP.varyHealth(variation)
  local ped = GetPlayerPed(-1)

  local n = math.floor(GetEntityHealth(ped)+variation)
  SetEntityHealth(ped,n)
end

function tvRP.getHealth()
  return GetEntityHealth(GetPlayerPed(-1))
end

function tvRP.setHealth(health)
  local n = math.floor(health)
  SetEntityHealth(GetPlayerPed(-1),n)
  Citizen.CreateThread(function()
    Wait(1000)
    SetEntityHealth(GetPlayerPed(-1), n)
  end)
end

-- impact thirst and hunger when the player is running (every 5 seconds)
Citizen.CreateThread(function()
      while true do
          Citizen.Wait(5000)

          if IsPlayerPlaying(PlayerId()) then
              local ped = GetPlayerPed(-1)

              -- variations for one minute
              local vthirst = 0
              local vhunger = 0

              -- on foot, increase thirst/hunger in function of velocity
              if IsPedOnFoot(ped) and not tvRP.isNoclip() then
                  local factor = math.min(tvRP.getSpeed(), 10)

                  vthirst = vthirst + 1 * factor
                  vhunger = vhunger + 0.5 * factor
              end

              -- in melee combat, increase
              if IsPedInMeleeCombat(ped) then
                  vthirst = vthirst + 10
                  vhunger = vhunger + 5
              end

              -- injured, hurt, increase
              if IsPedHurt(ped) or IsPedInjured(ped) then
                  vthirst = vthirst + 2
                  vhunger = vhunger + 1
              end

              -- do variation
              if vthirst ~= 0 then
                  vRPserver.varyThirst({vthirst / 12.0})
              end

              if vhunger ~= 0 then
                  vRPserver.varyHunger({vhunger / 12.0})
              end
          end
      end

end)

-- COMA SYSTEM
local in_coma = false
local coma_left = cfg.coma_duration*60

local function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x, y)
end

local comaText = ""

Citizen.CreateThread(function() -- coma thread
  while true do
    Citizen.Wait(0)
    local ped = GetPlayerPed(-1)

    if comaText:len() > 1 then
  		drawTxt(comaText, 4, 1, 0.5, 0.85, 0.6, 184, 0, 0, 255)
      drawTxt("Apelurile la medici trebuie sa fie RolePlay~n~Nu este RolePlay sa vorbesti daca esti mort", 4, 1, 0.5, 0.75, 0.5, 255, 255, 255, 255)

		  DrawRect(0.5, 0.87, 0.3, 0.035, 0, 0, 0, 100)
    	DrawRect(0.5, 0.87, 0.3*(coma_left*0.0033), 0.035, 255, 255, 255, 180)

		  DisableControlAction(0,24, true) -- disable attack
	    DisableControlAction(0,25, false) -- disable aim
	    DisableControlAction(0, 1, true) -- LookLeftRight
	    DisableControlAction(0, 2, true) -- LookUpDown
    end
    
    local health = GetEntityHealth(ped)
    if health <= cfg.coma_threshold and coma_left > 0 then
      if not in_coma then -- go to coma state
        if IsEntityDead(ped) then -- if dead, resurrect

            local killer_ped, killer_cause = GetPedSourceOfDeath(ped), GetPedCauseOfDeath(ped)
            local ped_name = GetPlayerName(NetworkGetEntityOwner(killer_ped))
            retval, bone = GetPedLastDamageBone(ped)
            TriggerServerEvent("ezDamage:Killed", ped_name, killer_cause, bone)

          local x,y,z = tvRP.getPosition()
          NetworkResurrectLocalPlayer(x, y, z, true, true, false)
          Citizen.Wait(0)
        end

        -- coma state
        in_coma = true
        vRPserver.updateHealth({cfg.coma_threshold}) -- force health update
        SetEntityHealth(ped, cfg.coma_threshold)
        SetEntityInvincible(ped,true)
        tvRP.playScreenEffect(cfg.coma_effect,-1)
        tvRP.ejectVehicle()
        tvRP.setRagdoll(true)
      else -- in coma
        -- maintain life
        if health < cfg.coma_threshold then 
          SetEntityHealth(ped, cfg.coma_threshold) 
        end
      end
    else
      if in_coma then -- get out of coma state
        Citizen.CreateThread(function()
          comaText = "Apasa ~w~E ~s~pentru a primii respawn"
          in_coma = false
          
          while GetEntityHealth(ped)-1 <= cfg.coma_threshold do
            Wait(1)
            if IsControlJustPressed(0, 38) or tooMutch then
              RemoveAllPedWeapons(ped, false)      
              TriggerServerEvent("DEATH_KRANE:Respawn_and_Remove")        
              break
            end
          end
          SetEntityInvincible(ped,false)
          tvRP.setRagdoll(false)
          tvRP.stopScreenEffect(cfg.coma_effect)
          comaText = ""

          if coma_left <= 0 then -- get out of coma by death
            if GetEntityHealth(ped)-1 <= cfg.coma_threshold then
              SetEntityHealth(ped, 0)
            end
          end

          SetTimeout(5000, function()  -- able to be in coma again after coma death after 5 seconds
            coma_left = cfg.coma_duration*60
          end)
        end)
      end
    end
  end
end)

function tvRP.isInComa()
  return in_coma
end

-- kill the player if in coma
function tvRP.killComa()
  if in_coma then
    coma_left = 0
  end
end

Citizen.CreateThread(function() -- coma decrease thread
  while true do 
    Citizen.Wait(1000)
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    if in_coma then
      coma_left = coma_left-1
      comaText = string.format("Respawn in ~w~%03d ~s~secunde", coma_left)
    end
  end
end)

Citizen.CreateThread(function()
  local timesDetected = 0

  local playerPed = GetPlayerPed(-1)
	local playerHealth = GetEntityHealth(playerPed)

  while false do
  	if timesDetected > 20 then
  		TriggerServerEvent("Diamond:BanHackerBruh", "God Mode")
    end
    
	  playerPed = GetPlayerPed(-1)
	  playerHealth = GetEntityHealth(playerPed)

    if playerHealth > 30 then

      SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
      SetEntityHealth(playerPed, playerHealth - 2)

      Citizen.Wait(500)

      if GetEntityHealth(playerPed) > (playerHealth - 2) then
        timesDetected = timesDetected + 1
      elseif timesDetected > 0 then
        timesDetected = timesDetected - 1
      end

      SetEntityHealth(playerPed, GetEntityHealth(playerPed) + 2)
    elseif timesDetected > 0 then
      timesDetected = timesDetected - 1
    end
	end
end)