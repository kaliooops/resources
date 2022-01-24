local lang = vRP.lang
local playerMoney = {}
local cfg = module("cfg/money")

function round(n)
	return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

-- get money
-- cbreturn nil if error
function vRP.getMoney(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].wallet
	else
		return 0
	end
end

-- set krCoins
function vRP.setKRCoins(user_id,value)

	if(playerMoney[user_id])then
		playerMoney[user_id].krCoins = value
	end
	exports.ghmattimysql:execute("UPDATE vrp_users SET krCoins = @krCoins WHERE id = @user_id", {krCoins = value, user_id = user_id}, function()end)

	local source = vRP.getUserSource(user_id)
	if source ~= nil then
		vRPclient.setDivContent(source,{"krCoins",lang.money.krCoins({vRP.formatMoney(value)})})
	end
end

-- get krCoins
-- cbreturn nil if error
function vRP.getKRCoins(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].krCoins
	else
		return 0
	end
end

-- set money
function vRP.setMoney(user_id,value)
	if(tonumber(value) >= 0)then
		if(playerMoney[user_id])then
			playerMoney[user_id].wallet = value
		end
		exports.ghmattimysql:execute("UPDATE vrp_users SET walletMoney = @wallet WHERE id = @user_id", {wallet = value, user_id = user_id}, function()end)
	end

  -- update client display
  local source = vRP.getUserSource(user_id)
  if source ~= nil then
    vRPclient.setDivContent(source,{"money",lang.money.display({vRP.formatMoney(value)})})
  end
end

function vRP.takeMoney(user_id,amount)
	local money = vRP.getMoney(user_id)
	local newBani = money - amount
	vRP.setMoney(user_id,newBani)
end

function vRP.getTransferLimit(user_id)
    return 10000000
end

-- set transfer limit 
function vRP.setTransferLimit(user_id,value)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.transfer_limit = value
	end
end

-- try a payment
-- return true or false (debited if true)
function vRP.tryPayment(user_id,amount)
  local money = vRP.getMoney(user_id)
  if (money >= amount) and (amount >= 0) then
    vRP.setMoney(user_id,money-amount)
    return true
  else
    return false
  end
end

-- give money
function vRP.giveMoney(user_id,amount)
  local money = vRP.getMoney(user_id)
  vRP.setMoney(user_id,money+amount)
  TriggerClientEvent("winter_misiuni_handler:obtine_bani", vRP.getUserSource(user_id), amount)
end

-- give krCoins
function vRP.giveKRCoins(user_id,amount)
  local krCoins = vRP.getKRCoins(user_id)
  vRP.setKRCoins(user_id,krCoins+amount)
end



-- get bank money
function vRP.getBankMoney(user_id)
	if(playerMoney[user_id])then
		return playerMoney[user_id].bank
	else
		return 0
	end
end

-- set bank money
function vRP.setBankMoney(user_id,value)
	if(playerMoney[user_id])then
		playerMoney[user_id].bank = value
	end
	exports.ghmattimysql:execute("UPDATE vrp_users SET bankMoney = @bank WHERE id = @user_id", {bank = value, user_id = user_id}, function()end)
	local source = vRP.getUserSource(user_id)
	if source ~= nil then
		vRPclient.setDivContent(source,{"bmoney",lang.money.bdisplay({vRP.formatMoney(value)})})
	end
end

-- give bank money
function vRP.giveBankMoney(user_id,amount)
  if amount > 0 then
    local money = vRP.getBankMoney(user_id)
    vRP.setBankMoney(user_id,money+amount)
  end
end

-- try a withdraw
-- return true or false (withdrawn if true)
function vRP.tryWithdraw(user_id,amount)
  local money = vRP.getBankMoney(user_id)
  if amount > 0 and money >= amount then
    vRP.setBankMoney(user_id,money-amount)
    vRP.giveMoney(user_id,amount)
    return true
  else
    return false
  end
end

-- try a deposit
-- return true or false (deposited if true)
function vRP.tryDeposit(user_id,amount)
  if amount > 0 and vRP.tryPayment(user_id,amount) then
    vRP.giveBankMoney(user_id,amount)
    return true
  else
    return false
  end
end

function vRP.tryFullPayment(user_id,amount)
  local money = vRP.getMoney(user_id)
  if money >= amount  and (amount >= 0) then
    return vRP.tryPayment(user_id, amount)
  else  -- not enough, withdraw -> payment
    if vRP.tryWithdraw(user_id, amount-money) then -- withdraw to complete amount
      return vRP.tryPayment(user_id, amount)
    end
  end

  return false
end


-- events, init user account if doesn't exist at connection
AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local rows = exports.ghmattimysql:executeSync("SELECT bankMoney, walletMoney, krCoins FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	if #rows > 0 then
		playerMoney[user_id] = {bank = rows[1].bankMoney, wallet = rows[1].walletMoney, krCoins = rows[1].krCoins}
	end
end)

AddEventHandler("vRP:playerLeave",function(user_id,source)
	playerMoney[user_id] = nil
end)


AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
  if first_spawn then
    -- add money display
    vRPclient.setDiv(source,{"money",cfg.display_css,lang.money.display({vRP.formatMoney(vRP.getMoney(user_id))})})
	vRPclient.setDiv(source,{"bmoney",cfg.display_css,lang.money.bdisplay({vRP.formatMoney(vRP.getBankMoney(user_id))})})
	vRPclient.setDiv(source,{"krCoins",cfg.display_css,lang.money.krCoins({vRP.formatMoney(vRP.getKRCoins(user_id))})})

  end
end)

local function ch_give(player,choice)
	-- get nearest player
	local user_id = vRP.getUserId(player)
	if user_id ~= nil then
		vRPclient.getNearestPlayers(player,{15},function(nplayers)
			usrList = ""
			for k,v in pairs(nplayers) do
				usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
			end
			if usrList ~= "" then
				vRP.prompt(player,"Jucatori in apropiere: " .. usrList .. "","",function(player,nuser_id) 
					nuser_id = nuser_id
					if nuser_id ~= nil and nuser_id ~= "" then 
						local target = vRP.getUserSource(tonumber(nuser_id))
						if target ~= nil then
							vRP.prompt(player,lang.money.give.prompt(),"",function(player,amount)
								local amount = parseInt(amount)
								local transfer_limit = vRP.getTransferLimit(user_id)
								local is_admin = vRP.hasPermission(user_id,"player.givemoney")
								if amount > 0 then
									if is_admin or amount <= transfer_limit then
										if vRP.tryPayment(user_id,amount) then
											local pID = vRP.getUserId(target)
											local money = vRP.getMoney(pID)										
											vRP.giveMoney(pID,amount)
											vRPclient.notify(player,{lang.money.given({amount})})
											vRPclient.notify(target,{lang.money.received({amount})})
											vRP.logInfoToFile("TransferBaniLogs.txt", vRP.getPlayerName(player).." ("..user_id..") i-a transferat suma de "..vRP.formatMoney(amount).." (de) $ lui "..vRP.getPlayerName(target).." ("..pID..") [IN MANA]")
											if not is_admin then 
												vRP.setTransferLimit( user_id, transfer_limit - amount)
											end
										else
											vRPclient.notify(player,{lang.money.not_enough()})
										end
									else
										vRPclient.notify(player,{lang.money.exceeded_limit()})
									end
								else
									vRPclient.notify(player,{lang.common.invalid_value()})
								end
							end)
						else
							vRPclient.notify(player,{lang.common.no_player_near()})
						end
					else
						vRPclient.notify(player,{lang.common.no_player_near()})
					end
				end)
			end
		end)
	end
end
vRP.registerMenuBuilder("main", function(add, data)
  local user_id = vRP.getUserId(data.player)
  if user_id ~= nil then
    local choices = {}
    choices[lang.money.give.title()] = {ch_give, lang.money.give.description()}

    add(choices)
  end
end)



----halloween

