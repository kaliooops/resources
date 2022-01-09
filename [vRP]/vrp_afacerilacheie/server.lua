-- To create a house first you need to set your house job at line 24 after that you type /createPret type

local Tunnel = module("vrp", "lib/Tunnel") -- Adds Tunnel Module
local Proxy = module("vrp", "lib/Proxy") -- Adds Proxy Module

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_afacerilacheie")
vRPC = Tunnel.getInterface("vrp_afacerilacheie","vrp_afacerilacheie")
vRPS = {}
Tunnel.bindInterface("vrp_afacerilacheie",vRPS)
Proxy.addInterface("vrp_afacerilacheie",vRPS)

wardrobetext = {"\"",false}

-- Interiors - https://wiki.rage.mp/index.php?title=Interiors_and_Locations

housestypeslist = {
  ["Birou"] = {
    exit = {-1902.3682861328,-572.67156982422,19.097217559814},
    inventoryspace = 100
},
["NightClub"] = {
  exit = {246.57621765137,-1589.3984375,-187.00007629395},
  inventoryspace = 500
},
["GalaxyClub"] = {
  exit = {354.81579589844,300.33343505859,104.03701782227},
  inventoryspace = 500
},
["SediuCEO"] = {
  exit = {-1396.0882568359,-480.53219604492,72.042053222656},
  inventoryspace = 500
},
["SediuCEO2"] = {
  exit = {-1581.1705322266,-562.05218505859,108.52291870117},
  inventoryspace = 500
},
["SediuCEO3"] = {
  exit = {-141.4983215332,-617.64764404297,168.82034301758},
  inventoryspace = 500
},
["SediuCEO4"] = {
  exit = {-77.203598022461,-830.1689453125,243.38577270508},
  inventoryspace = 500
},
["Depozit"] = {
  exit = {1048.6702880859,-3097.3342285156,-38.999954223633},
  inventoryspace = 5000
},
["DepozitMare"] = {
  exit = {992.9619140625,-3097.9560546875,-38.99585723877},
  inventoryspace = 10000
},
}

local housejob = "Afacerist"

function vRPS.getHouses()
  exports.ghmattimysql:execute('SELECT * FROM vrp_afacerilacheie', {}, function(case)
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
  exports.ghmattimysql:execute('SELECT * FROM vrp_afacerilacheie WHERE id = @id', {['@id']=id}, function(result)
    if user_id == result[1].owner_id then
      vRP.openChest({player,"home:"..id,housestypeslist[type].inventoryspace,nil,nil,nil})
    else
      vRPclient.notify(player, {"~r~Nu esti proprietar!"})
    end
  end)
end

function vRPS.openWardrobe(id)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  exports.ghmattimysql:execute('SELECT * FROM vrp_afacerilacheie WHERE id = @id', {['@id']=id}, function(result)
  if user_id == result[1].owner_id then 
  local data = vRP.getUserDataTable({user_id})
  if data.cloakroom_idle ~= nil then
    vRPclient.notify(player,{"Porti o uniforma !"})
  end

  local menu = {name="Garderoba",css={top = "75px", header_color="rgba(0,255,125,0.75)"}}

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
  vRPclient.notify(player, {"~r~Nu esti proprietar!"})
end
end)
end

function vRPS.enterHouseMenu(id)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  exports.ghmattimysql:execute('SELECT * FROM vrp_afacerilacheie WHERE id = @id', {['@id']=id}, function(result)
    vRP.buildMenu({"Meniu Afacere", {user_id = user_id, player = player}, function(menu)
			menu.name="Meniu Afacere"
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
          menu["Incuie Afacerea"] = {function(player,choice) lock(player) end}
        elseif result[1].status == true then
          menu["Descuie Afacerea"] = {function(player,choice) unlock(player) end}
        end
      end
      vRP.openMenu({player,menu})
		end})
  end)
  function lock(player)
    vRP.closeMenu({player})
    vRPclient.notify(player, {"~r~Ai incuiat usa !"})
    exports.ghmattimysql:execute("UPDATE vrp_afacerilacheie SET status=@status WHERE id=@id", {["id"]=id, ["status"]=true})
  end
  function unlock(player)
    vRP.closeMenu({player})
    vRPclient.notify(player, {"~g~Ai descuiat usa !"})
    exports.ghmattimysql:execute("UPDATE vrp_afacerilacheie SET status=@status WHERE id=@id", {["id"]=id, ["status"]=false})
  end
  function removeHouseFromSell(player)
    vRP.closeMenu({player})
    exports.ghmattimysql:execute("UPDATE vrp_afacerilacheie SET sellingprice=@sellingprice WHERE id=@id", {["id"]=id, ["sellingprice"]=0})
    vRPclient.notify(player, {"~y~Afacerea nu mai este de vanzare !"})
    Wait(2000)
    vRPS.getHouses()
  end
  function setSellPrice(player)
    vRP.closeMenu({player})
    vRP.prompt({player,"Price:","",function(player,price) 
      if tonumber(price) then 
        if tonumber(price) >= 0 then
          exports.ghmattimysql:execute("UPDATE vrp_afacerilacheie SET sellingprice=@sellingprice WHERE id=@id", {["id"]=id, ["sellingprice"]=tonumber(price)})
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
    exports.ghmattimysql:execute('SELECT * FROM vrp_afacerilacheie WHERE id = @id', {['@id']=id}, function(result)
    if vRP.tryFullPayment({user_id, price}) then
      exports.ghmattimysql:execute("UPDATE vrp_users SET bankMoney= bankMoney + @suma where id=@proprietar", {["suma"]=result[1].sellingprice, ["proprietar"]=result[1].owner_id})
      exports.ghmattimysql:execute("UPDATE vrp_afacerilacheie SET owner_id=@owner_id WHERE id=@id", {["id"]=id, ["owner_id"]=user_id})
      exports.ghmattimysql:execute("UPDATE vrp_afacerilacheie SET sellingprice=@sellingprice WHERE id=@id", {["id"]=id, ["sellingprice"]=0})
      exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_business(user_id,name,description,capital,laundered,reset_timestamp) VALUES(@user_id,@name,'',@capital,0,@time)", {user_id = user_id, name = result[1].type, capital = result[1].sellingprice, time = os.time()},
      exports.ghmattimysql:execute("INSERT IGNORE INTO Joburi(id,patron,jobname,incasari) VALUES(@id,@patron,@jobname,@incasari)", {id = id, patron = user_id, jobname = result[1].type, incasari = 0}))
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
  exports.ghmattimysql:execute('SELECT * FROM vrp_afacerilacheie WHERE id = @id', {['@id']=id}, function(result)
    vRP.buildMenu({"Meniul Casei", {user_id = user_id, player = player}, function(menu)
			menu.name="Meniul Casei"
			menu.css={top="75px",header_color="rgba(255,125,0,0.75)"}
      menu.onclose = function() vRPC.unfreeze(player, {})end
      if result[1].status == false then
        menu["Iesire"] = {function(player,choice) exitHouse(player, result[1].status) end, "Status: <font color='green'> Unlocked"}
      elseif result[1].status == true then
        menu["Iesire"] = {function(player,choice) exitHouse(player, result[1].status) end, "Status: <font color='red'> Locked"}
      end
      if user_id == result[1].owner_id then
        if result[1].status == false then
          menu["Incuie Afacerea"] = {function(player,choice) lock(player) end}
        elseif result[1].status == true then
          menu["UnIncuie Afacerea"] = {function(player,choice) unlock(player) end}
        end
      end
			vRP.openMenu({player,menu})
		end})
  end)
  function lock(player)
    vRP.closeMenu({player})
    vRPclient.notify(player, {"~r~Ai incuiat usa !"})
    exports.ghmattimysql:execute("UPDATE vrp_afacerilacheie SET status=@status WHERE id=@id", {["id"]=id, ["status"]=true})
  end
  function unlock(player)
    vRP.closeMenu({player})
    vRPclient.notify(player, {"~g~Ai descuiat usa !"})
    exports.ghmattimysql:execute("UPDATE vrp_afacerilacheie SET status=@status WHERE id=@id", {["id"]=id, ["status"]=false})
  end
  function exitHouse(player, status)
    vRP.closeMenu({player})
    if status == false then
      exports.ghmattimysql:execute("UPDATE vrp_users SET inhouse=@houseid WHERE id=@id", {["id"]=user_id, ["houseid"]=0})
      -- SetPlayerRoutingBucket(player, 0)
      exports.ghmattimysql:execute('SELECT * FROM vrp_afacerilacheie WHERE id = @id', {['@id']=id}, function(coords)
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
  exports.ghmattimysql:execute('SELECT * FROM vrp_afacerilacheie WHERE id = @id', {['@id']=id}, function(coords)
    vRPclient.teleport(source, {coords[1].x,coords[1].y,coords[1].z})
  end)
end

RegisterCommand("createafacere", function (source, args)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  if vRP.hasGroup({user_id, housejob}) then
  if args[1] ~= nil then
    if args[2] ~= nil then
      local price = tonumber(args[1])
      local coords = vRPclient.getPosition(player,{},function(x,y,z)
        exports.ghmattimysql:execute("INSERT INTO vrp_afacerilacheie (owner_id, sellingprice, type, status, x, y, z) VALUES (@owner_id, @sellingprice, @type, @status, @x, @y, @z)", {["owner_id"]=0,["sellingprice"]=price,["type"]=args[2],["status"]=false,["x"]=x,["y"]=y,["z"]=z})
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
      exports.ghmattimysql:execute('SELECT type FROM vrp_afacerilacheie WHERE id = @id', {['@id']=result[1].inhouse}, function(result)
        -- SetPlayerRoutingBucket(source, result[1].inhouse)
        vRPC.setUpJoinedPlayer(source, {result[1].inhouse, result[1].type})
      end)
    end
  end)
end)