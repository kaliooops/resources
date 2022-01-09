-- To create a house first you need to set your house job at line 24 after that you type /createPret type

local Tunnel = module("vrp", "lib/Tunnel") -- Adds Tunnel Module
local Proxy = module("vrp", "lib/Proxy") -- Adds Proxy Module

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","lfj_housing")
vRPC = Tunnel.getInterface("lfj_housing","lfj_housing")
vRPS = {}
Tunnel.bindInterface("lfj_housing",vRPS)
Proxy.addInterface("lfj_housing",vRPS)

wardrobetext = {"\"",false}

-- Interiors - https://wiki.rage.mp/index.php?title=Interiors_and_Locations

housestypeslist = {

  ["Ave"] = {
    exit = {-467.51974487305,-708.71990966797,77.088912963867},
    inventoryspace = 500
  },
  ["Integrity"] = {
    exit = {-25.509645462036,-607.33001708984,100.23720550537},
    inventoryspace = 500
  },
  ["Low"] = {
    exit = {265.99789428711,-1002.9628295898,-99.008674621582},
    inventoryspace = 100
  },
  ["Weazel"] = {
    exit = {-907.68957519531,-453.55035400391,126.53206634521},
    inventoryspace = 500
  },
  ["Richards"] = {
    exit = {-907.12536621094,-372.48165893555,109.44027709961},
    inventoryspace = 500
  },
  ["Del"] = {
    exit = {-1450.0091552734,-525.86877441406,69.556587219238},
    inventoryspace = 500
  },
  ["Tinsel"] = {
    exit = {-596.40277099609,56.105251312256,108.03133392334},
    inventoryspace = 500
  },
  ["Eclipse"] = {
    exit = {-774.19219970703,342.2014465332,196.68617248535},
    inventoryspace = 500
  },
  ["Low2"] = {
    exit = {346.46792602539,-1012.4415893555,-99.196281433105},
    inventoryspace = 100
  },
  ["House1"] = {
    exit = {-174.32986450195,497.52966308594,137.66902160645},
    inventoryspace = 500
  },
  ["House2"] = {
    exit = {343.90740966796,439.20233154296,149.38061523438},
    inventoryspace = 500
  },
  ["House3"] = {
    exit = {373.5500793457,423.35952758789,145.90919494629},
    inventoryspace = 500
  },
  ["House4"] = {
    exit = {-682.07635498047,592.24945068359,145.39300537109},
    inventoryspace = 500
  },
  ["House5"] = {
    exit = {-759.02825927734,619.04925537109,144.15390014648},
    inventoryspace = 500
  },
  ["House6"] = {
    exit = {-859.84997558594,690.89971923828,152.8602752685},
    inventoryspace = 500
  },
  ["House 7"] = {
    exit = {117.14981842041,559.662109375,184.30487060547},
    inventoryspace = 500
  },
  ["House8"] = {
    exit = {-1289.7893066406,449.74935913086,97.902503967285},
    inventoryspace = 500
  },

}

local housejob = "Creator"

function vRPS.getHouses()
  exports.ghmattimysql:execute('SELECT * FROM lfj_housing', {}, function(case)
    vRPC.CreateHouses(-1,{case})
  end)
end

-- RegisterCommand("back", function (source)
--   SetPlayerRoutingBucket(source, 0)
-- end)

-- RegisterCommand("ref", function ()
--   vRPS.getHouses()
-- end)

function vRPS.openChest(id, type)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  exports.ghmattimysql:execute('SELECT * FROM lfj_housing WHERE id = @id', {['@id']=id}, function(result)
    if user_id == result[1].owner_id then
      vRP.openChest({player,"home:"..id,housestypeslist[type].inventoryspace,nil,nil,nil})
    else
      vRPclient.notify(player, {"~r~Nu esti proprietarul casei!"})
    end
  end)
end

function vRPS.openWardrobe(id)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  exports.ghmattimysql:execute('SELECT * FROM lfj_housing WHERE id = @id', {['@id']=id}, function(result)
  if user_id == result[1].owner_id then 
  local data = vRP.getUserDataTable({user_id})
  if data.cloakroom_idle ~= nil then
    vRPclient.notify(player,{"Porti o uniforma !"})
  end

  local menu = {name="Wardrobe",css={top = "75px", header_color="rgba(0,255,125,0.75)"}}

  vRP.getUData({user_id, "vRP:home:wardrobe", function(data)
    local sets = json.decode(data)
    if sets == nil then
      sets = {}
    end

    menu["Save"] = {function(player,choice) saveOutfit(player) end, "Salveaza imbracamintea"}

    local choose_set = function(player,choice)
      local custom = sets[choice]
      if custom ~= nil then
        vRPclient.setCustomization(player,{custom})
      end
    end

    for k,v in pairs(sets) do
      menu[k] = {choose_set}
    end

    vRP.openMenu({player,menu})

    function saveOutfit(player)
      vRP.closeMenu({player})
      vRP.prompt({player,"Outfit Name:","",function(player,setname)
        setname = sanitizeString(setname, wardrobetext[1], wardrobetext[2])
        if string.len(setname) > 0 then
          vRPclient.getCustomization(player,{},function(custom)
            sets[setname] = custom
            vRP.setUData({user_id,"vRP:home:wardrobe",json.encode(sets)})
          end)
        else
          vRPclient.notify(player,{"Numele trebuie sa fie mai lung"})
        end
      end})
    end
  end})
else
  vRPclient.notify(player, {"~r~Nu esti proprietarul casei!"})
end
end)
end

function vRPS.enterHouseMenu(id)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  exports.ghmattimysql:execute('SELECT * FROM lfj_housing WHERE id = @id', {['@id']=id}, function(result)
    vRP.buildMenu({"Meniul Casei", {user_id = user_id, player = player}, function(menu)
			menu.name="Meniul Casei"
			menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
      menu.onclose = function () vRPC.unfreeze(player, {}) end
      if result[1].status == false then
        menu["Intra"] = {function(player,choice) enterHouse(player,result[1].status,result[1].type) end, "Status: <font color='green'> Unlocked"}
      else
        menu["Intra"] = {function(player,choice) enterHouse(player,result[1].status,result[1].type) end, "Status: <font color='red'> Locked"}
      end
      if result[1].owner_id == 0 then
        menu["Cumpara"] = {function(player,choice) buyHouse(player,result[1].sellingprice) end, "Price: <font color='green'> "..result[1].sellingprice}
      elseif result[1].owner_id ~= 0 and result[1].owner_id ~= user_id then
        if result[1].sellingprice ~= 0 then
          menu["Cumpara"] = {function(player,choice) buyHouse(player,result[1].sellingprice) end, "Price: <font color='green'> "..result[1].sellingprice}
        end
      end
      if user_id == result[1].owner_id then
        if result[1].sellingprice == 0 then
          menu["Vinde"] = {function(player,choice) setSellPrice(player) end}
        else
          menu["Anuleaza Vanzarea"] = {function(player,choice) removeHouseFromSell(player) end}
        end
      end
      if user_id == result[1].owner_id then
        if result[1].status == false then
          menu["Incuie Casa"] = {function(player,choice) lock(player) end}
        elseif result[1].status == true then
          menu["Descuie Casa"] = {function(player,choice) unlock(player) end}
        end
      end
      vRP.openMenu({player,menu})
		end})
  end)
  function lock(player)
    vRP.closeMenu({player})
    vRPclient.notify(player, {"~r~Ai incuiat usa !"})
    exports.ghmattimysql:execute("UPDATE lfj_housing SET status=@status WHERE id=@id", {["id"]=id, ["status"]=true})
  end
  function unlock(player)
    vRP.closeMenu({player})
    vRPclient.notify(player, {"~g~Ai descuiat usa !"})
    exports.ghmattimysql:execute("UPDATE lfj_housing SET status=@status WHERE id=@id", {["id"]=id, ["status"]=false})
  end
  function removeHouseFromSell(player)
    vRP.closeMenu({player})
    exports.ghmattimysql:execute("UPDATE lfj_housing SET sellingprice=@sellingprice WHERE id=@id", {["id"]=id, ["sellingprice"]=0})
    vRPclient.notify(player, {"~y~Casa nu mai este de vanzare !"})
    Wait(2000)
    vRPS.getHouses()
  end
  function setSellPrice(player)
    vRP.closeMenu({player})
    vRP.prompt({player,"Price:","",function(player,price) 
      if tonumber(price) then 
        if tonumber(price) >= 0 then
          exports.ghmattimysql:execute("UPDATE lfj_housing SET sellingprice=@sellingprice WHERE id=@id", {["id"]=id, ["sellingprice"]=tonumber(price)})
          vRPclient.notify(player, {"Pret: ~g~"..price})
          Wait(2000)
          vRPS.getHouses()
        else
          vRPclient.notify(player, {"~r~Pretul trebuie sa fie mai mare de 0 !"})
        end
      end
  end})
  end
  function buyHouse(player,price)
    local user_id = vRP.getUserId({player})
    vRP.closeMenu({player})
    exports.ghmattimysql:execute('SELECT * FROM lfj_housing WHERE id = @id', {['@id']=id}, function(result)
    if vRP.tryFullPayment({user_id, price}) then
      exports.ghmattimysql:execute("UPDATE vrp_users SET bankMoney= bankMoney + @suma where id=@proprietar", {["suma"]=result[1].sellingprice, ["proprietar"]=result[1].owner_id})
      exports.ghmattimysql:execute("UPDATE lfj_housing SET owner_id=@owner_id WHERE id=@id", {["id"]=id, ["owner_id"]=user_id})
      exports.ghmattimysql:execute("UPDATE lfj_housing SET sellingprice=@sellingprice WHERE id=@id", {["id"]=id, ["sellingprice"]=0})
      Wait(2000)
      vRPS.getHouses()
    else
      vRPclient.notify(player, {"~r~Nu ai destui bani !"})
    end
	end)
end
  function enterHouse(player,status, type)
    vRP.closeMenu({player})
    if status == false then
      exports.ghmattimysql:execute("UPDATE vrp_users SET inhouse=@houseid WHERE id=@id", {["id"]=user_id, ["houseid"]=id})
      local housetype = tostring(type)
      -- SetPlayerRoutingBucket(player, id)
      vRPclient.teleport(player, {housestypeslist[housetype].exit[1], housestypeslist[housetype].exit[2], housestypeslist[housetype].exit[3]})
    else
      vRPclient.notify(player,{"~r~Usa este incuiata !"})
    end
	end
end

function vRPS.exitHouseMenu(id)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  exports.ghmattimysql:execute('SELECT * FROM lfj_housing WHERE id = @id', {['@id']=id}, function(result)
    vRP.buildMenu({"Meniul Casei", {user_id = user_id, player = player}, function(menu)
			menu.name="Meniul Casei"
			menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
      menu.onclose = function() vRPC.unfreeze(player, {})end
      if result[1].status == false then
        menu["Exit House"] = {function(player,choice) exitHouse(player, result[1].status) end, "Status: <font color='green'> Unlocked"}
      elseif result[1].status == true then
        menu["Exit House"] = {function(player,choice) exitHouse(player, result[1].status) end, "Status: <font color='red'> Locked"}
      end
      if user_id == result[1].owner_id then
        if result[1].status == false then
          menu["Incuie Casa"] = {function(player,choice) lock(player) end}
        elseif result[1].status == true then
          menu["UnIncuie Casa"] = {function(player,choice) unlock(player) end}
        end
      end
			vRP.openMenu({player,menu})
		end})
  end)
  function lock(player)
    vRP.closeMenu({player})
    vRPclient.notify(player, {"~r~Ai incuiat usa !"})
    exports.ghmattimysql:execute("UPDATE lfj_housing SET status=@status WHERE id=@id", {["id"]=id, ["status"]=true})
  end
  function unlock(player)
    vRP.closeMenu({player})
    vRPclient.notify(player, {"~g~Ai descuiat usa !"})
    exports.ghmattimysql:execute("UPDATE lfj_housing SET status=@status WHERE id=@id", {["id"]=id, ["status"]=false})
  end
  function exitHouse(player, status)
    vRP.closeMenu({player})
    if status == false then
      exports.ghmattimysql:execute("UPDATE vrp_users SET inhouse=@houseid WHERE id=@id", {["id"]=user_id, ["houseid"]=0})
      -- SetPlayerRoutingBucket(player, 0)
      exports.ghmattimysql:execute('SELECT * FROM lfj_housing WHERE id = @id', {['@id']=id}, function(coords)
        vRPclient.teleport(player, {coords[1].x,coords[1].y,coords[1].z})
      end)
    elseif status == true then
      vRPclient.notify(player,{"~r~Usa este inchisa !"})
    end
	end
end

function vRPS.enterHouse(id, type)
  local source = source
  local housetype = tostring(type)
  -- SetPlayerRoutingBucket(source, id)
  vRPclient.teleport(source, {housestypeslist[housetype].exit[1], housestypeslist[housetype].exit[2], housestypeslist[housetype].exit[3]})
end

function vRPS.exitHouse(id)
  local source = source
  -- SetPlayerRoutingBucket(source, 0)
  exports.ghmattimysql:execute('SELECT * FROM lfj_housing WHERE id = @id', {['@id']=id}, function(coords)
    vRPclient.teleport(source, {coords[1].x,coords[1].y,coords[1].z})
  end)
end

RegisterCommand("createhouse", function (source, args)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  if vRP.hasGroup({user_id, housejob}) then
  if args[1] ~= nil then
    if args[2] ~= nil then
      local price = tonumber(args[1])
      local coords = vRPclient.getPosition(player,{},function(x,y,z)
        exports.ghmattimysql:execute("INSERT INTO lfj_housing (owner_id, sellingprice, type, status, x, y, z) VALUES (@owner_id, @sellingprice, @type, @status, @x, @y, @z)", {["owner_id"]=0,["sellingprice"]=price,["type"]=args[2],["status"]=false,["x"]=x,["y"]=y,["z"]=z})
        Wait(2000)
        vRPS.getHouses()
      end)
    end
  end
  end
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  vRPS.getHouses()
  exports.ghmattimysql:execute('SELECT inhouse FROM vrp_users WHERE id = @id', {['@id']=user_id}, function(result)
    if result[1].inhouse ~= 0 then
      exports.ghmattimysql:execute('SELECT type FROM lfj_housing WHERE id = @id', {['@id']=result[1].inhouse}, function(result)
        -- SetPlayerRoutingBucket(source, result[1].inhouse)
        vRPC.setUpJoinedPlayer(source, {result[1].inhouse, result[1].type})
      end)
    end
  end)
end)