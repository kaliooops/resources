local titles = { "Silver", "Gold", "Platinum", "Diamond" }

function vRP.getUserVipRank(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		vipRank = tmp.vipRank
	end
	return vipRank or 0
end

function vRP.isUserVip(user_id)
	local vipRank = vRP.getUserVipRank(user_id)
	if(vipRank > 0)then
		return true
	else
		return false
	end
end

function vRP.isUserSilverVip(user_id)
	local vipRank = vRP.getUserVipRank(user_id)
	if(vipRank >= 1)then
		return true
	else
		return false
	end
end

function vRP.isUserGoldVip(user_id)
	local vipRank = vRP.getUserVipRank(user_id)
	if(vipRank >= 2)then
		return true
	else
		return false
	end
end

function vRP.isUserPlatinumVip(user_id)
	local vipRank = vRP.getUserVipRank(user_id)
	if(vipRank >= 3)then
		return true
	else
		return false
	end
end

function vRP.isUserDiamondVip(user_id)
	local vipRank = vRP.getUserVipRank(user_id)
	if(vipRank >= 4)then
		return true
	else
		return false
	end
end

function vRP.setUserVip(user_id,vip)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.vipRank = vip
	end
	exports.ghmattimysql:execute("UPDATE vrp_users SET vipLvl = @vip WHERE id = @user_id", {user_id = user_id, vip = vip}, function()end)
end

function vRP.getUserVipTitle(user_id)
    local text = titles[vRP.getUserVipRank(user_id)] or "V.I.P"
    return text
end

function vRP.getOnineVips(group)
	local oUsers = {}
	for k,v in pairs(vRP.rusers) do
		if vRP.isUserVip(tonumber(k)) then table.insert(oUsers, tonumber(k)) end
	end
	return oUsers
end

AddEventHandler("vRP:playerJoin",function(user_id,source,name,last_login)
	local rows = exports.ghmattimysql:executeSync("SELECT vipLvl FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	local vipRank = tonumber(rows[1].vipLvl)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.vipRank = vipRank
	end
end)