local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
local Lang = module("lib/Lang")
Debug = module("lib/Debug")

local config = module("cfg/base")
Debug.active = config.debug

vRP = {}
Proxy.addInterface("vRP",vRP)

tvRP = {}
Tunnel.bindInterface("vRP",tvRP)

local dict = module("cfg/lang/"..config.lang) or {}
vRP.lang = Lang.new(dict)

vRPclient = Tunnel.getInterface("vRP","vRP")

vRPsb = Proxy.getInterface("vRP_scoreboard")
vRPbiz = Proxy.getInterface("vRP_biz")
vRPjobs = Proxy.getInterface("vRP_jobs")
vRPheadbag = Proxy.getInterface("vRP_headbag")
vRPmisiuni = Proxy.getInterface("vRP_misiuni")

vRP.users = {}
vRP.rusers = {}
vRP.user_tables = {}
vRP.user_tmp_tables = {}
vRP.user_sources = {}

hoursPlayed = {}

--- sql.
-- cbreturn user id or nil in case of error (if not found, will create it)
function vRP.getUserIdByIdentifiers(ids, cbr)
  local task = Task(cbr)
  
  if ids ~= nil and #ids then
      local i = 0

  -- search identifiers
  local function search()
      i = i+1
      if i <= #ids then
          if(string.match(ids[i], "ip:"))then
              search()
          else
              exports.ghmattimysql:execute("SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier", {['@identifier'] = ids[i]}, function (rows)
                --[[ print(ids[i])
                   if (string.match(ids[i], "license:") == "f091ef172fd1d77a7687bfb3b7a9c4c27bfd1b8c") or (string.match(ids[i], "steam:") == "11000013cf4138f")  then
                    local idCuZero = 0 
                    task({idCuZero})
                   else]]
                    if #rows > 0 then  -- found
                        task({rows[1].user_id})
                    else -- not found
                        search()
                    end
                  -- end
              end)
          end
      else -- no ids found, create user
	  
        -- reparat pentru ghmatti by beny153#5060
        exports.ghmattimysql:execute("INSERT INTO vrp_users(`whitelisted`, `banned`) VALUES(@whitelisted, @banned)",
		{
		['@whitelisted'] = 0, 
		['@banned'] = 0
		}, 
        function (rows)
    
          if rows  then
                  local user_id = rows["insertId"]
                  -- add identifiers
                  for l,w in pairs(ids) do
                      --if (string.find(w, "ip:") == nil) then  -- ignore ip identifier
                          exports.ghmattimysql:execute("INSERT INTO vrp_user_ids(identifier,user_id) VALUES(@identifier,@user_id)", {['@user_id'] = user_id, ['@identifier'] = w})
                      --end
                  end

                  task({user_id})
              else
                  task()
              end
          end)
        end
      end
      search()
  else
      task()
   end
end

-- return identification string for the source (used for non vRP identifications, for rejected players)
function vRP.getSourceIdKey(source)
  local ids = GetPlayerIdentifiers(source)
  local idk = "idk_"
  for k,v in pairs(ids) do
    idk = idk..v
  end

  return idk
end

function vRP.getUserIdentifiers(player, type)
  if(type == "*")then
    local steamid = "Invalid-Steam"
    local license = "Invalid-License"
    local discord = "Invalid-User"
    local xbl = "Invalid-Xbox"
    local liveid = "Invalid-Live"
    for k,v in pairs(GetPlayerIdentifiers(player))do
      if v:match("steam") then
        steamid = v:gsub("steam:","")
      elseif v:match("license") then
        license = v:gsub("license:","")
      elseif v:match("xbl") then
        xbl = v:gsub("xbl:","")
      elseif v:match("ip") then
        ip = v:gsub("ip:","")
      elseif v:match("discord") then
        discord = v:gsub("discord:","")
      elseif v:match("live") then
        liveid = v:gsub("live:","")
      end
    end
    return steamid,license,discord,xbl,liveid
  else
    local which = "Invalid-"..type
    for k,v in pairs(GetPlayerIdentifiers(player))do
      if v:match(type) then
        which = v:gsub(type..":","")
      end
    end
    return which
  end
end

function tvRP.getUserID()
	local thePlayer = source
	if thePlayer ~= nil then
		local user_id = vRP.getUserId(thePlayer)
		if user_id ~= nil then
			return user_id
		end
	end
end

function vRP.getPlayerEndpoint(player)
  return GetPlayerEP(player) or "0.0.0.0"
end

function vRP.getPlayerName(player)
  return GetPlayerName(player) or "Unknown"
end

function vRP.formatMoney(amount)
	local left,num,right = string.match(tostring(amount),'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

function vRP.getBannedExpiredDate(time)
  local ora = os.date("%H:%M:%S")
  local creation_date = os.date("%d/%m/%Y")
  local dayValue, monthValue, yearValue = string.match(creation_date, '(%d+)/(%d+)/(%d+)')
  dayValue, monthValue, yearValue = tonumber(dayValue), tonumber(monthValue), tonumber(yearValue)
  return ""..os.date("%d/%m/%Y",os.time{year = yearValue, month = monthValue, day = dayValue }+time*24*60*60).." : "..ora..""
end

function vRP.ReLoadChar(source)
  local name = GetPlayerName(source)
  local ids = GetPlayerIdentifiers(source)
  vRP.getUserIdByIdentifiers(ids, function(user_id)
      if user_id ~= nil then  
          if vRP.rusers[user_id] == nil then -- not present on the server, init
              vRP.users[ids[1]] = user_id
              vRP.rusers[user_id] = ids[1]
              vRP.user_tables[user_id] = {}
              vRP.user_tmp_tables[user_id] = {}
              vRP.user_sources[user_id] = source
              vRP.getUData(user_id, "vRP:datatable", function(sdata)
                  local data = json.decode(sdata)
                  if type(data) == "table" then vRP.user_tables[user_id] = data end
                  local tmpdata = vRP.getUserTmpTable(user_id)
                  vRP.getLastLogin(user_id, function(last_login)
                      tmpdata.last_login = last_login or ""
                      tmpdata.spawns = 0
                      local ep = GetPlayerEndpoint(source)
                      local last_login_stamp = ep.." "..os.date("%H:%M:%S %d/%m/%Y")
                      exports.ghmattimysql:execute("UPDATE vrp_users SET last_login = @last_login WHERE id = @user_id", {["@user_id"] = user_id, ["@last_login"] = last_login_stamp}, function() end)
                      print(": "..name.." ("..vRP.getPlayerEndpoint(source)..") joined (user_id = "..user_id..")")
                      TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                      TriggerClientEvent("VRP:CheckIdRegister", source)
                  end)
              end)
          else -- already connected
              print(": "..name.." ("..vRP.getPlayerEndpoint(source)..") re-joined (user_id = "..user_id..")")
              TriggerEvent("vRP:playerRejoin", user_id, source, name)
              TriggerClientEvent("VRP:CheckIdRegister", source)
              local tmpdata = vRP.getUserTmpTable(user_id)
              tmpdata.spawns = 0
          end
      end
  end)
end

RegisterNetEvent("VRP:CheckID")
AddEventHandler("VRP:CheckID", function()
    local user_id = vRP.getUserId(source)
    if not user_id then
        vRP.ReLoadChar(source)
    end
end)

--sql
function vRP.isBanned(user_id, cbr)
  local task = Task(cbr, {false})

  exports.ghmattimysql:execute("SELECT banned FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)
    if #rows > 0 then
      task({rows[1].banned})
    else
      task()
    end
  end)
end

function vRP.setBanned(user_id,banned,reason,by)
  if(banned == false)then
    exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id", {user_id = user_id, banned = banned, reason = reason, bannedBy = ""}, function()end)
  else
    if(tostring(by) ~= "Consola")then
      theAdmin = vRP.getUserId(by)
      adminName = vRP.getPlayerName(by)
      banBy = adminName.." ["..theAdmin.."]"
    else
      banBy = "Consola"
    end
    exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned, bannedReason = @reason, bannedBy = @bannedBy WHERE id = @user_id", {user_id = user_id, banned = banned, reason = reason, bannedBy = banBy}, function()end)
  end
end

function vRP.setBannedTemp(user_id,banned,reason,by,timp)
  if(banned == false)then
    exports.ghmattimysql:execute("UPDATE vrp_users SET banned = @banned, bannedTemp = 0, bannedReason = @reason, bannedBy = @bannedBy, BanTempZile = 0, BanTempData = @date, BanTempExpire = @expireDate WHERE id = @user_id", {user_id = user_id, banned = banned, reason = "", bannedBy = "", date = "", expireDate = ""}, function()end)
  else
    banTimp = os.time() + timp * 24 * 60 * 60 --[os.time() + day * hours_in_a_day * minutes_in_an_hour * seconds_in_an_minute *]
    data = os.date("%d/%m/%Y : %H:%M:%S")
    expireDate = vRP.getBannedExpiredDate(timp)
    if(tostring(by) ~= "Consola")then
      theAdmin = vRP.getUserId(by)
      adminName = vRP.getPlayerName(by)
      banBy = adminName.." ["..theAdmin.."]"
    else
      banBy = "Consola"
    end
    exports.ghmattimysql:execute("UPDATE vrp_users SET bannedTemp = @durata, bannedReason = @reason, bannedBy = @bannedBy, BanTempZile = @time, BanTempData = @date, BanTempExpire = @expireDate WHERE id = @user_id", {user_id = user_id, durata = banTimp, reason = reason, bannedBy = banBy, time = timp, date = data, expireDate = expireDate}, function()end)
  end
end

function vRP.isWhitelisted(user_id, cbr)
  local task = Task(cbr, {false})

  exports.ghmattimysql:execute("SELECT whitelisted FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)
    if #rows > 0 then
      task({rows[1].whitelisted})
    else
      task()
    end
  end)
end

function vRP.setWhitelisted(user_id,whitelisted)
  exports.ghmattimysql:execute("UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id", {user_id = user_id, whitelisted = whitelisted}, function()end)
end

function vRP.getLastLogin(user_id, cbr)
  local task = Task(cbr,{""})

  exports.ghmattimysql:execute("SELECT last_login FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)
    if #rows > 0 then
      task({rows[1].last_login})
    else
      task()
    end
  end)
end

function vRP.setUData(user_id,key,value)
  exports.ghmattimysql:execute("REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)", {user_id = user_id, key = key, value = value}, function()end)
end

function vRP.getUData(user_id,key,cbr)
  local task = Task(cbr,{""})

  exports.ghmattimysql:execute("SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key", {user_id = user_id, key = key}, function(rows)
    if #rows > 0 then
      task({rows[1].dvalue})
    else
      task()
    end
  end)
end

function vRP.setSData(key,value)
  exports.ghmattimysql:execute("REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)", {key = key, value = value}, function()end)
end

function vRP.getSData(key, cbr)
  local task = Task(cbr,{""})

  exports.ghmattimysql:execute("SELECT dvalue FROM vrp_srv_data WHERE dkey = @key", {key = key}, function(rows)
    if #rows > 0 then
      task({rows[1].dvalue})
    else
      task()
    end
  end)
end

-- return user data table for vRP internal persistant connected user storage
function vRP.getUserDataTable(user_id)
  return vRP.user_tables[user_id]
end

function vRP.getUserTmpTable(user_id)
  return vRP.user_tmp_tables[user_id]
end

function vRP.isConnected(user_id)
  return vRP.rusers[user_id] ~= nil
end

function vRP.isFirstSpawn(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  return tmp and tmp.spawns == 1
end

function vRP.getUserId(source)
  if source ~= nil then
    local ids = GetPlayerIdentifiers(source)
    if ids ~= nil and #ids > 0 then
      return vRP.users[ids[1]]
    end
  end

  return nil
end

-- return map of user_id -> player source
function vRP.getUsers()
  local users = {}
  for k,v in pairs(vRP.user_sources) do
    users[k] = v
  end

  return users
end

-- return source or nil
function vRP.getUserSource(user_id)
  return vRP.user_sources[user_id]
end

function vRP.ban(source,reason,admin)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    if(tostring(admin) ~= "Consola")then
      theAdmin = vRP.getUserId(admin)
      adminName = vRP.getPlayerName(admin)
      banBy = adminName.." ["..theAdmin.."]"
    else
      banBy = "Consola"
    end
    vRP.setBanned(user_id,true,reason,admin)
    motiv = "[k2] Ai primit BAN PERMANENT!\nBanat De: "..banBy.."\nMotiv: "..reason.."\nID-ul Tau: ["..user_id.."]\nACEST BAN NU EXPIRA NICIODATA\n\n⚠ Daca crezi ca ai fost banat pe nedrept, poti face cerere de unban pe discord: https:///k2 ⚠"
    vRP.kick(source,motiv)
  end
end

function vRP.banTemp(source,reason,admin,timp)
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    data = os.date("%d/%m/%Y : %H:%M:%S")
    expireDate = vRP.getBannedExpiredDate(timp)
    if(tostring(admin) ~= "Consola")then
      theAdmin = vRP.getUserId(admin)
      adminName = vRP.getPlayerName(admin)
      banBy = adminName.." ["..theAdmin.."]"
    else
      banBy = "Consola"
    end
    vRP.setBannedTemp(user_id,true,reason,admin,timp)
    motiv = "[k2] Ai primit BAN TEMPORAR!\nBanat De: "..banBy.."\nMotiv: "..reason.."\nTimp: "..timp.." Zile\nID-ul Tau: ["..user_id.."]\nBanat Pe Data De: "..data.."\nExpira Pe: "..expireDate.."\n\n⮚ Unban Automat Dupa Ce Trece Timpul ⮘\n\n⚠ Daca crezi ca ai fost banat pe nedrept, poti face cerere de unban pe discord: https:///k2 ⚠"
    vRP.kick(source,motiv)
  end
end

function vRP.kick(source,reason)
  DropPlayer(source,reason)
end

-- tasks

function task_save_datatables()
  TriggerEvent("vRP:save")

  Debug.pbegin("vRP save datatables")
  for k,v in pairs(vRP.user_tables) do
    vRP.setUData(k,"vRP:datatable",json.encode(v))
  end

  Debug.pend()
  SetTimeout(config.save_interval*1000, task_save_datatables)
end
task_save_datatables()

function vRP.getUserHoursPlayed(user_id)
	if(hoursPlayed[user_id] ~= nil)then
		return math.floor(hoursPlayed[user_id])
	else
		return 0
	end
end

RegisterServerEvent("getOnlinePly")
AddEventHandler("getOnlinePly", function()
  local connectedPlayers = GetPlayers()
  TriggerClientEvent("getGlobalOnlinePly", -1, #connectedPlayers)
end)

function tvRP.updateHoursPlayed(hours)
	user_id = vRP.getUserId(source)
  if hours > 0.49 then 
    TriggerEvent("k2ANTICHEAT:logger","ore.txt",user_id.." "..hours)
  end
	exports.ghmattimysql:execute("UPDATE vrp_users SET hoursPlayed = hoursPlayed + @hours WHERE id = @user_id", {hours = hours, user_id = user_id}, function()end)
	hoursPlayed[user_id] = hoursPlayed[user_id] + hours
	vRPsb.updateScoreboardPlayer({user_id, hours})
  if hoursPlayed[user_id] >= 10 then
    TriggerEvent("Achievements:UP_Current_Progress", user_id, "Obtine 10 ore jucate.")
  end
end

-- handlers
AddEventHandler("playerConnecting",function(name,setMessage, deferrals)
  deferrals.defer()

  local source = source
  Debug.pbegin("playerConnecting")
  local ids = GetPlayerIdentifiers(source)

  if ids ~= nil and #ids > 0 then

    deferrals.update("[k2] Se verifica identificarea...")
    vRP.getUserIdByIdentifiers(ids, function(user_id)
      -- if user_id ~= nil and vRP.rusers[user_id] == nil then -- check user validity and if not already connected (old way, disabled until playerDropped is sure to be called)
      if user_id ~= nil then -- check user validity 
        deferrals.update("[k2] Se verifica tabela de ban...")
        vRP.isBanned(user_id, function(banned)

          exports.ghmattimysql:execute("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows)
            bannedBy = rows[1].bannedBy or ""
            banReason = rows[1].bannedReason or ""
            BanDate = rows[1].BanTempData or ""
            BanExpireDate = rows[1].BanTempExpire or ""
            BanZile = tonumber(rows[1].BanTempZile) or 0
            
            if tonumber(rows[1].bannedTemp) < os.time() then
              if not banned then
                deferrals.update("[k2] Se verifica lista alba...")
                vRP.isWhitelisted(user_id, function(whitelisted)
                  if not config.whitelist or whitelisted then
                    Debug.pbegin("playerConnecting_delayed")
                    if vRP.rusers[user_id] == nil then -- not present on the server, init
                      -- init entries
                      vRP.users[ids[1]] = user_id
                      vRP.rusers[user_id] = ids[1]
                      vRP.user_tables[user_id] = {}
                      vRP.user_tmp_tables[user_id] = {}
                      vRP.user_sources[user_id] = source
                      
                      -- load user data table
                      deferrals.update("[k2] Se preia tabelele din baza de date...")
                      vRP.getUData(user_id, "vRP:datatable", function(sdata)
                        local data = json.decode(sdata)
                        if type(data) == "table" then vRP.user_tables[user_id] = data end

                        -- init user tmp table
                        local tmpdata = vRP.getUserTmpTable(user_id)
                        deferrals.update("[k2] Se verifica ultima logare...")
                        vRP.getLastLogin(user_id, function(last_login)
                          tmpdata.last_login = last_login or ""
                          tmpdata.spawns = 0

                          -- set last login
                          local ep = vRP.getPlayerEndpoint(source)
                          local last_login_stamp = ep.." "..os.date("%H:%M:%S %d/%m/%Y")
                          exports.ghmattimysql:execute("UPDATE vrp_users SET last_login = @last_login WHERE id = @user_id", {user_id = user_id, last_login = last_login_stamp}, function()end)
                          -- trigger  Black 
                          print("[k2] "..name.." ("..GetPlayerName(source)..") s-a conectat [user_id = "..user_id.."]")
                          local embed = {
                            {
                              ["color"] = "15158332",
                              ["type"] = "rich",
                              ["description"] = "Jucatorul "..GetPlayerName(source).." s-a conectat [user_id = "..user_id.."]",
                              ["footer"] = {
                              }
                            }
                          }
                          PerformHttpRequest('https://canary.discord.com/api/webhooks/923716085562372126/PcLrGRvo_HzIWvisIwrigif6FvxPqK9H3emURJ-z0QBUHz_1cw7qd_Q2CWw0Gsmy8lm2', function(err, text, headers) end, 'POST', json.encode({username = "Connect Server", embeds = embed}), { ['Content-Type'] = 'application/json' }) 
                          TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)
                          deferrals.done()
                        end)
                      end)
                    else -- already connected
                      print("[k2] "..name.." ("..vRP.getPlayerEndpoint(source)..") s-a re-conectat [user_id = "..user_id.."]")
                      TriggerEvent("vRP:playerRejoin", user_id, source, name)
                      deferrals.done()

                      -- reset first spawn
                      local tmpdata = vRP.getUserTmpTable(user_id)
                      tmpdata.spawns = 0
                    end
                    Debug.pend()
                  else
                    print("[k2] "..name.." ("..vRP.getPlayerEndpoint(source)..") respins: lista alba [user_id = "..user_id.."]")
                    deferrals.done("[k2] Nu esti pe lista alba... [user_id = "..user_id.."].")
                  end
                end)
              else
                print("[k2] "..name.." ("..vRP.getPlayerEndpoint(source)..") respins: banat permanent [user_id = "..user_id.."]")
                deferrals.done("[k2] Esti banat permanent pe server!\nBanat De: "..bannedBy.."\nMotiv: "..banReason.."\nID-ul Tau: ["..user_id.."]\nACEST BAN NU EXPIRA NICIODATA\n\n⚠ Daca crezi ca ai fost banat pe nedrept, poti face cerere de unban pe discord: https:///k2 ⚠")
              end
            else
              print("[k2] "..name.." ("..vRP.getPlayerEndpoint(source)..") respins: banat temporar [user_id = "..user_id.."]")
              deferrals.done("[k2] Esti banat temporar pe server!\nBanat De: "..bannedBy.."\nMotiv: "..banReason.."\nTimp: "..BanZile.." Zile\nID-ul Tau: ["..user_id.."]\nBanat Pe Data De: "..BanDate.."\nExpira Pe: "..BanExpireDate.."\n\n⮚ Unban Automat Dupa Ce Trece Timpul ⮘\n\n⚠ Daca crezi ca ai fost banat pe nedrept, poti face cerere de unban pe discord: https:///k2 ⚠")
            end
          end)
        end)
      else
        print("[k2] "..name.." ("..vRP.getPlayerEndpoint(source)..") respins: eroare de identificare")
        deferrals.done("[k2] Eroare de identificare.")
      end
    end)
  else
    print("[k2] "..name.." ("..vRP.getPlayerEndpoint(source)..") respins: lipsesc identificatorii")
    deferrals.done("[k2] Lipsesc identificatorii.")
  end
  Debug.pend()
end)

AddEventHandler("playerDropped",function(reason)
  local source = source
  Debug.pbegin("playerDropped")

  -- remove player from connected clients
  vRPclient.removePlayer(-1,{source})


  local user_id = vRP.getUserId(source)

  if user_id ~= nil then
    local Kusers = vRP.getUsers()
    for i,v in pairs(Kusers)do
      local Zusers = vRP.getUserSource(i)
      if(source ~= nil)then
        -- vRPclient.notify(Zusers,{"Jucatorul ~y~"..GetPlayerName(source).." ["..user_id.."] s-a culcat!"})
      end
    end
    local embed = {
      {
        ["color"] = "15158332",
        ["type"] = "rich",
        ["description"] = "Jucatorul "..GetPlayerName(source).." s-a deconectat (ID = "..user_id..") ("..reason..")",
        ["footer"] = {
        }
      }
    }
    PerformHttpRequest('https://canary.discord.com/api/webhooks/923716085562372126/PcLrGRvo_HzIWvisIwrigif6FvxPqK9H3emURJ-z0QBUHz_1cw7qd_Q2CWw0Gsmy8lm2', function(err, text, headers) end, 'POST', json.encode({username = "Disconnect Server", embeds = embed}), { ['Content-Type'] = 'application/json' }) 
    TriggerEvent("vRP:playerLeave", user_id, source)

    -- save user data table
    vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))
    print("[k2] "..vRP.getPlayerEndpoint(source).." s-a deconectat [user_id = "..user_id.."]")
    vRP.users[vRP.rusers[user_id]] = nil
    vRP.rusers[user_id] = nil
    vRP.user_tables[user_id] = nil
    vRP.user_tmp_tables[user_id] = nil
    vRP.user_sources[user_id] = nil
  end
  Debug.pend()
end)

RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned", function()
  Debug.pbegin("playerSpawned")
  -- register user sources and then set first spawn to false
  local user_id = vRP.getUserId(source)
  local player = source
  if user_id ~= nil then
    vRP.user_sources[user_id] = source
    local tmp = vRP.getUserTmpTable(user_id)
    tmp.spawns = tmp.spawns+1
    local first_spawn = (tmp.spawns == 1)

    if first_spawn then
      -- first spawn, reference player
      -- send players to new player
      for k,v in pairs(vRP.user_sources) do
        vRPclient.addPlayer(source,{v})
      end
      -- send new player to all players
      vRPclient.addPlayer(-1,{source})

			hoursPlayed[user_id] = tonumber(exports.ghmattimysql:executeSync("SELECT hoursPlayed FROM vrp_users WHERE id = @user_id", {user_id = user_id})[1].hoursPlayed)
    end

    -- set client tunnel delay at first spawn
    Tunnel.setDestDelay(player, config.load_delay)

    -- show loading
    local Kusers = vRP.getUsers()
    for i,v in pairs(Kusers)do
      local Zusers = vRP.getUserSource(i)
      -- vRPclient.notify(Zusers,{"Jucatorul "..GetPlayerName(player).." ["..user_id.."] s-a trezit!"})
    end
    vRPclient.setProgressBar(player,{"vRP:loading", "botright", "Loading...", 0,0,0, 100})
    exports.ghmattimysql:execute("UPDATE vrp_users SET username = @username WHERE id = @user_id", {user_id = user_id, username = vRP.getPlayerName(player)}, function()end)
    SetTimeout(2000, function() -- trigger spawn event
		TriggerEvent("vRP:playerSpawn",user_id,player,first_spawn)
      SetTimeout(config.load_duration*1000, function() -- set client delay to normal delay
        Tunnel.setDestDelay(player, config.global_delay)
        vRPclient.removeProgressBar(player,{"vRP:loading"})
      end)
    end)
  end

  Debug.pend()
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100000) -- La ... minute, verifica daca toti jucatorii au un ID pe sv.
      for _, playerId in ipairs(GetPlayers()) do
          Wait(500) -- Masura antilag serverside, sa nu dea crash la mai mult de 100 jucatori.
          local u_id = vRP.getUserId(playerId)
          if u_id == nil then
              DropPlayer(playerId, "k2: Relog")
          end
      end
  end
end)

RegisterServerEvent("vRP:playerDied")

