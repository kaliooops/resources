local titles = {"SPONSOR"}

function vRP.getUserSponsorRank(user_id)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		sponsorRank = tmp.sponsorRank
	end
	return sponsorRank or 0
end

function vRP.isUserSponsor(user_id)
	local sponsorRank = vRP.getUserSponsorRank(user_id)
	if(sponsorRank > 0)then
		return true
	else
		return false
	end
end

function vRP.isUserSponsors(user_id)
	local sponsorRank = vRP.getUserSponsorRank(user_id)
	if(sponsorRank >= 1)then
		return true
	else
		return false
	end
end

function vRP.setUserSponsor(user_id,sponsor)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.sponsorRank = sponsor
	end
	exports.ghmattimysql:execute("UPDATE vrp_users SET sponsorRank = @sponsor WHERE id = @user_id", {user_id = user_id, sponsor = sponsor}, function()end)
end

function vRP.getUserSponsorTitle(user_id)
    local text = titles[vRP.getUserSponsorRank(user_id)] or "SPONSOR"
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
	local rows = exports.ghmattimysql:executeSync("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = user_id})
	local sponsorRank = tonumber(rows[1].sponsorRank)
	local tmp = vRP.getUserTmpTable(user_id)
	if tmp then
		tmp.sponsorRank = sponsorRank
	end
end)