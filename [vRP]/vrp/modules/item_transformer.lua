
-- this module define a generic system to transform (generate, process, convert) items and money to other items or money in a specific area
-- each transformer can take things to generate other things, using a unit of work
-- units are generated periodically at a specific rate
-- reagents => products (reagents can be nothing, as for an harvest transformer)

local cfg = module("cfg/item_transformers")
local lang = vRP.lang

-- api

local transformers = {}

local function tr_remove_player(tr,player) -- remove player from transforming
  local recipe = tr.players[player] or ""
  tr.players[player] = nil -- dereference player
  vRPclient.removeProgressBar(player,{"vRP:tr:"..tr.name})
  vRP.closeMenu(player)

  -- onstop
  if tr.itemtr.onstop then tr.itemtr.onstop(player,recipe) end
end

local function tr_add_player(tr,player,recipe) -- add player to transforming
  tr.players[player] = recipe -- reference player as using transformer
  vRP.closeMenu(player)
  vRPclient.setProgressBar(player,{"vRP:tr:"..tr.name,"center",recipe.."...",tr.itemtr.r,tr.itemtr.g,tr.itemtr.b,0})

  -- onstart
  if tr.itemtr.onstart then tr.itemtr.onstart(player,recipe) end
end

local function tr_tick(tr) -- do transformer tick
  for k,v in pairs(tr.players) do
    local user_id = vRP.getUserId(tonumber(k))
    if v and user_id ~= nil then -- for each player transforming
      local recipe = tr.itemtr.recipes[v]
      if tr.units > 0 and recipe then -- check units
        -- check reagents
        local reagents_ok = true
        for l,w in pairs(recipe.reagents) do
          reagents_ok = reagents_ok and (vRP.getInventoryItemAmount(user_id,l) >= w)
        end

        -- check money
        local money_ok = (vRP.getMoney(user_id) >= recipe.in_money)

        -- weight check
        local out_witems = {}
        for k,v in pairs(recipe.products) do
          out_witems[k] = {amount=v}
        end
        local in_witems = {}
        for k,v in pairs(recipe.reagents) do
          in_witems[k] = {amount=v}
        end
        local new_weight = vRP.getInventoryWeight(user_id)+vRP.computeItemsWeight(out_witems)-vRP.computeItemsWeight(in_witems)

        local inventory_ok = true
        if new_weight > vRP.getInventoryMaxWeight(user_id) then
          inventory_ok = false
          vRPclient.notify(tonumber(k), {lang.inventory.full()})
        end

        if money_ok and reagents_ok and inventory_ok then -- do transformation
          tr.units = tr.units-1 -- sub work unit

          -- consume reagents
          if recipe.in_money > 0 then vRP.tryPayment(user_id,recipe.in_money) end
          for l,w in pairs(recipe.reagents) do
            vRP.tryGetInventoryItem(user_id,l,w,true)
          end

          -- produce products
          if recipe.out_money > 0 then vRP.giveMoney(user_id,recipe.out_money) end
          for l,w in pairs(recipe.products) do
            vRP.giveInventoryItem(user_id,l,w,true)
          end

          -- give exp
          for l,w in pairs(recipe.aptitudes or {}) do
            local parts = splitString(l,".")
            if #parts == 2 then
              vRP.varyExp(user_id,parts[1],parts[2],w)
            end
          end

          -- onstep
          if tr.itemtr.onstep then tr.itemtr.onstep(tonumber(k),v) end
        end
      end
    end
  end

  -- display transformation state to all transforming players
  for k,v in pairs(tr.players) do
    vRPclient.setProgressBarValue(k,{"vRP:tr:"..tr.name,math.floor(tr.units/tr.itemtr.max_units*100.0)})
    
    if tr.units > 0 then -- display units left
      vRPclient.setProgressBarText(k,{"vRP:tr:"..tr.name,v.."... "..tr.units.."/"..tr.itemtr.max_units})
    else
      vRPclient.setProgressBarText(k,{"vRP:tr:"..tr.name,"empty"})
    end
  end
end

local function bind_tr_area(player,tr) -- add tr area to client
  vRP.setArea(player,"vRP:tr:"..tr.name,tr.itemtr.x,tr.itemtr.y,tr.itemtr.z,tr.itemtr.radius,tr.itemtr.height,tr.enter,tr.leave)
end

local function unbind_tr_area(player,tr) -- remove tr area from client
  vRP.removeArea(player,"vRP:tr:"..tr.name)
end

-- add an item transformer
-- name: transformer id name
-- itemtr: item transformer definition table
--- name
--- max_units
--- units_per_minute
--- x,y,z,radius,height (area properties)
--- r,g,b (color)
--- action
--- description
--- in_money
--- out_money
--- reagents: items as idname => amount
--- products: items as idname => amount
function vRP.setItemTransformer(name,itemtr)
  vRP.removeItemTransformer(name) -- remove pre-existing transformer

  local tr = {itemtr=itemtr}
  tr.name = name
  transformers[name] = tr

  -- init transformer
  tr.units = 0
  tr.players = {}

  -- build menu
  tr.menu = {name=itemtr.name,css={top="75px",header_color="rgba("..itemtr.r..","..itemtr.g..","..itemtr.b..",0.75)"}}

  -- build recipes
  for action,recipe in pairs(tr.itemtr.recipes) do
    local info = "<br /><br />"
    if recipe.in_money > 0 then info = info.."- "..recipe.in_money end
    for k,v in pairs(recipe.reagents) do
      local item = vRP.items[k]
      if item then
        info = info.."<br />"..v.." "..item.name
      end
    end
    info = info.."<br /><span style=\"color: rgb(0,255,125)\">=></span>"
    if recipe.out_money > 0 then info = info.."<br />+ "..recipe.out_money end
    for k,v in pairs(recipe.products) do
      local item = vRP.items[k]
      if item then
        info = info.."<br />"..v.." "..item.name
      end
    end
    for k,v in pairs(recipe.aptitudes or {}) do
      local parts = splitString(k,".")
      if #parts == 2 then
        local def = vRP.getAptitudeDefinition(parts[1],parts[2])
        if def then
          info = info.."<br />[EXP] "..v.." "..vRP.getAptitudeGroupTitle(parts[1]).."/"..def[1]
        end
      end
    end

    tr.menu[action] = {function(player,choice) tr_add_player(tr,player,action) end, recipe.description..info}
  end

  -- build area
  tr.enter = function(player,area)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermissions(user_id,itemtr.permissions or {}) then
      vRP.openMenu(player, tr.menu) -- open menu
    end
  end

  tr.leave = function(player,area)
    tr_remove_player(tr, player)
  end

  -- bind tr area to all already spawned players
  for k,v in pairs(vRP.rusers) do
    local source = vRP.getUserSource(k)
    if source ~= nil then
      bind_tr_area(source,tr)
    end
  end
end

-- remove an item transformer
function vRP.removeItemTransformer(name)
  local tr = transformers[name]
  if tr then
    -- copy players (to remove while iterating)
    local players = {}
    for k,v in pairs(tr.players) do
      players[k] = v
    end

    for k,v in pairs(players) do -- remove players from transforming
      tr_remove_player(tr,k)
    end

    -- remove tr area from all already spawned players
    for k,v in pairs(vRP.rusers) do
      local source = vRP.getUserSource(k)
      if source ~= nil then
        unbind_tr_area(source,tr)
      end
    end

    transformers[name] = nil
  end
end

-- task: transformers ticks (every 3 seconds)
local function transformers_tick()
  SetTimeout(0,function() -- error death protection for transformers_tick() 
    for k,tr in pairs(transformers) do
      tr_tick(tr)
    end
  end)

  SetTimeout(3000,transformers_tick)
end
transformers_tick()

-- task: transformers unit regeneration
local function transformers_regen()
  for k,tr in pairs(transformers) do
    tr.units = tr.units+tr.itemtr.units_per_minute
    if tr.units >= tr.itemtr.max_units then tr.units = tr.itemtr.max_units end
  end

  SetTimeout(60000,transformers_regen)
end
transformers_regen()

-- add transformers areas on player first spawn
AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    for k,tr in pairs(transformers) do
      bind_tr_area(source,tr)
    end
  end
end)

-- STATIC TRANSFORMERS

SetTimeout(5000,function()
  -- delayed to wait items loading
  -- load item transformers from config file
  for k,v in pairs(cfg.item_transformers) do
    vRP.setItemTransformer("cfg:"..k,v)
  end
end)
