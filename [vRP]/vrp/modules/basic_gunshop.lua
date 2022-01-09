-- a basic gunshop implementation

local cfg = module("cfg/gunshops")
local lang = vRP.lang

local gunshops = cfg.gunshops
local gunshop_types = cfg.gunshop_types

local gunshop_menus = {}

-- build gunshop menus
for gtype,weapons in pairs(gunshop_types) do
  local gunshop_menu = {
    name=lang.gunshop.title({gtype}),
    css={top = "75px", header_color="rgba(255,0,0,0.75)"}
  }

  -- build gunshop items
  local kitems = {}

  -- item choice
  local gunshop_choice = function(player,choice)
    local weapon = kitems[choice][1]
    local price = kitems[choice][2]
    local price_ammo = kitems[choice][3]

    if weapon then
      local user_id = vRP.getUserId(player)
      if weapon == "body_armor" then -- get player weapons to not rebuy the body
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("body_armor")
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
          if user_id ~= nil and vRP.tryPayment(user_id,price) then
              vRP.giveInventoryItem(user_id,"body_armor",1,true)
              vRPclient.notify(player,{lang.money.paid({price})})
            else
              vRPclient.notify(player,{lang.money.not_enough()})
          end
        else
          vRPclient.notify(player,{"~r~Nu ai spatiu in buzunar"})
        end
      elseif weapon == "grip" then
          local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("grip")
          if new_weight <= vRP.getInventoryMaxWeight(user_id) then
            if user_id ~= nil and vRP.tryPayment(user_id,price) then
              vRP.giveInventoryItem(user_id,"grip",1,true)
              vRPclient.notify(player,{lang.money.paid({price})})
            else
              vRPclient.notify(player,{lang.money.not_enough()})
            end
          else
            vRPclient.notify(player,{"~r~Nu ai spatiu in buzunar"})
          end
      elseif weapon == "yusuf" then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("yusuf")
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
          if user_id ~= nil and vRP.tryPayment(user_id,price) then
            vRP.giveInventoryItem(user_id,"yusuf",1,true)
            vRPclient.notify(player,{lang.money.paid({price})})
          else
            vRPclient.notify(player,{lang.money.not_enough()})
          end
        else
          vRPclient.notify(player,{"~r~Nu ai spatiu in buzunar"})
        end
      elseif weapon == "flash" then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("flash")
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
          if user_id ~= nil and vRP.tryPayment(user_id,price) then
            vRP.giveInventoryItem(user_id,"flash",1,true)
            vRPclient.notify(player,{lang.money.paid({price})})
          else
            vRPclient.notify(player,{lang.money.not_enough()})
          end
        else
          vRPclient.notify(player,{"~r~Nu ai spatiu in buzunar"})
        end
      elseif weapon == "supressor" then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("supressor")
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
          if user_id ~= nil and vRP.tryPayment(user_id,price) then
            vRP.giveInventoryItem(user_id,"supressor",1,true)
            vRPclient.notify(player,{lang.money.paid({price})})
          else
            vRPclient.notify(player,{lang.money.not_enough()})
          end
        else
          vRPclient.notify(player,{"~r~Nu ai spatiu in buzunar"})
        end
      elseif weapon == "scope" then
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight("scope")
        if new_weight <= vRP.getInventoryMaxWeight(user_id) then
          if user_id ~= nil and vRP.tryPayment(user_id,price) then
            vRP.giveInventoryItem(user_id,"scope",1,true)
            vRPclient.notify(player,{lang.money.paid({price})})
          else
            vRPclient.notify(player,{lang.money.not_enough()})
          end
        else
          vRPclient.notify(player,{"~r~Nu ai spatiu in buzunar"})
        end
      elseif weapon == "WEAPON_PISTOL" then
          vRP.prompt(player,lang.gunshop.prompt_ammo({choice}),"",function(player,amount)
            local amount = parseInt(amount)
            if amount >= 0 and amount ~= nil and amount ~= "" then
              if amount <= 250 then
                local total = math.ceil(parseFloat(price_ammo)*parseFloat(amount))
                vRPclient.getWeapons(player,{},function(weapons)
                  if weapons[string.upper(weapon)] == nil then -- add body price if not already owned
                    total = total+price
                  end
                  if user_id ~= nil and vRP.tryPayment(user_id,total) then
                    vRPclient.giveWeapons(player,{{
                    [weapon] = {ammo=amount}
                    }})
                    vRPclient.notify(player,{lang.money.paid({total})})
                  else
                    vRPclient.notify(player,{lang.money.not_enough()})
                  end
                end)
              else
                vRPclient.notify(player,{"~r~Poti cumpara doar pana la 250 de gloante!"})
              end
            else
              vRPclient.notify(player,{"~r~Valoare invalida!"})
            end
          end)
      else
        vRP.prompt(player,lang.gunshop.prompt_ammo({choice}),"",function(player,amount)
          local amount = parseInt(amount)
          if amount >= 0 and amount ~= nil and amount ~= "" then
            if amount <= 250 then
              local total = math.ceil(parseFloat(price_ammo)*parseFloat(amount))
              vRPclient.getWeapons(player,{},function(weapons)
                if weapons[string.upper(weapon)] == nil then -- add body price if not already owned
                  total = total+price
                end
                if user_id ~= nil and vRP.tryPayment(user_id,total) then
                  vRPclient.giveWeapons(player,{{
                  [weapon] = {ammo=amount}
                  }})
                  vRPclient.notify(player,{lang.money.paid({total})})
                else
                  vRPclient.notify(player,{lang.money.not_enough()})
                end
              end)
            else
              vRPclient.notify(player,{"~r~Poti cumpara doar pana la 250 de gloante!"})
            end
          else
            vRPclient.notify(player,{"~r~Valoare invalida!"})
          end
    	  end)
      end
    end
  end

  -- add item options
  for k,v in pairs(weapons) do
    if k ~= "_config" then -- ignore config property
      kitems[v[1]] = {k,math.max(v[2],0),math.max(v[3],0)} -- idname/price/price_ammo
      gunshop_menu[v[1]] = {gunshop_choice,lang.gunshop.info({v[2],v[3],v[4]})} -- add description
    end
  end

  gunshop_menus[gtype] = gunshop_menu
end

local function build_client_gunshops(source)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    for k,v in pairs(gunshops) do
      local gtype,x,y,z = table.unpack(v)
      local group = gunshop_types[gtype]
      local menu = gunshop_menus[gtype]

      if group and menu then
        local gcfg = group._config

        local function gunshop_enter()
			    local user_id = vRP.getUserId(source)
			    if user_id ~= nil and gcfg.faction == nil and gcfg.fType == nil then
			    	vRP.openMenu(source,menu)
			    elseif(gcfg.fType ~= nil and gcfg.fType ~= "")then
			    	theFaction = vRP.getUserFaction(user_id)
			    	if(vRP.hasGroup(user_id,"onduty") and tostring(vRP.getFactionType(theFaction)) == tostring(gcfg.fType))then
			    		vRP.openMenu(source,menu)
			    	end
			    elseif(gcfg.faction ~= nil and gcfg.faction ~= "")then
			    	if(vRP.hasGroup(user_id,"onduty") and vRP.isUserInFaction(user_id,gcfg.faction))then
			    		vRP.openMenu(source,menu)
			    	end
			    end
        end

        local function gunshop_leave()
          vRP.closeMenu(source)
        end
        
        --[[if(gtype == " Market")then
          vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,0,0,125})
        else]]
          if(gtype == gcfg.faction)then
            if gtype == "Politia Romana" or gtype == "S.I.A.S" or gtype == "Smurd" then
              vRPclient.addBlip(source,{x,y,z,gcfg.blipid,gcfg.blipcolor,lang.gunshop.title({gtype})})
              vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,255,125,125})
              vRPclient.addMarkerNames(source,{x, y, z, "Armament: ~b~"..tostring(gtype), 1, 1.0})
            else
              vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,124,0,0,125})
              vRPclient.addMarkerNames(source,{x, y, z, "~r~Arsenal: ~y~"..tostring(gtype), 1, 1.0})
            end
          else
            vRPclient.addBlip(source,{x,y,z,gcfg.blipid,gcfg.blipcolor,lang.gunshop.title({gtype})})
            vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,255,125,125})
            vRPclient.addMarkerNames(source,{x, y, z, "~r~Magazin Armament: ~b~"..tostring(gtype), 1, 1.0})
          end
        --end
        vRP.setArea(source,"vRP:gunshop"..k,x,y,z,1,1.5,gunshop_enter,gunshop_leave)
      end
    end
  end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    build_client_gunshops(source)
  end
end)