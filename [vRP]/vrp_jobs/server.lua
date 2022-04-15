local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
--MySQL = module("vrp_mysql", "MySQL")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_jobs")
vRPCjobs = Tunnel.getInterface("vRP_jobs","vRP_jobs")

vRPjobs = {}
Tunnel.bindInterface("vRP_jobs",vRPjobs)
Proxy.addInterface("vRP_jobs",vRPjobs)
vRPlevel = Proxy.getInterface("vrp_level")


jobCheckpoint = {-548.19915771484,-633.74169921875,33.797542572021}

--jobs = {"Sofer Autobuz", "Fermier", "Pescar", "Constructor","Uber Eats","Tirist","Tamplar","Gunoier","Croitor"}
jobs = {"Aprovizionari", "Dezapezitor"}

function vRPjobs.getPlayerJob(user_id)
	local tmp = vRP.getUserTmpTable({user_id})
	if (tmp.job ~= nil) then
		return tostring(tmp.job)
	end
	return "Somer"
end

function vRPjobs.hasPlayerJob(user_id)
	local tmp = vRP.getUserTmpTable({user_id})
	if tmp then
		theJob = tostring(tmp.job)
		if(tostring(theJob) ~= "Somer")then
			return true
		else
			return false
		end
	else
		return false
	end
	return false
end


function vRPjobs.setPlayerJob(user_id, theJob)
	--vRP.setPlayerJob({user_id, theJob})
	--print(user_id .. " <> " .. theJob)
	exports["GHMattiMySQL"]:QueryAsync("UPDATE vrp_users SET job = @theJob WHERE id = @user_id",{user_id = user_id,theJob = theJob}, function(data)end)
end

function vRPjobs.setAsUnemployed(user_id)
	vRP.setPlayerJob({user_id, "Somer"})
	exports["GHMattiMySQL"]:QueryAsync("UPDATE vrp_users SET job = @theJob WHERE id = @user_id",{user_id = user_id,theJob = "Somer"}, function(data)end)
end

for i, v in pairs(jobs) do
	local jobName = tostring(v)
	jobs_menu[jobName] = {function(player, choice) 
		local user_id = vRP.getUserId({player})
		if(vRPjobs.hasPlayerJob(user_id))then
			local playerJob = vRPjobs.getPlayerJob(user_id)
			vRPclient.notify(player, {"[JOB] ~r~Esti deja angajat ca ~g~"..playerJob.."~r~! Demisioneaza mai intai!"})
		else

			if(jobName == "Aprovizionari")then
				vRPjobs.initTheSantier(player)
				vRPclient.notify(player, {"[JOB] ~g~Te-ai angajat ca ~r~"..jobName.."! "})

			end
			vRPjobs.setPlayerJob(user_id, jobName)
			vRP.closeMenu({player})
		end
	end, "Angajeaza-te ca <font color='green'>"..jobName.."</font>"}
end

local function build_client_jobs(source)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		local function jobs_enter()
			local user_id = vRP.getUserId({source})
			if user_id ~= nil then
				vRP.openMenu({source,jobs_menu})
			end
		end

		local function jobs_leave()
			vRP.closeMenu({source})
		end
		x, y, z = jobCheckpoint[1], jobCheckpoint[2], jobCheckpoint[3]
		vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,255,125,125,150})
      vRPclient.addMarkerNames(source,{x, y, z, "~g~Job Selector", 0.8})
		vRPclient.adaugaImagineCumetre(source, {"jobsIcon","jobsIcon",x,y,z+0.3,0.11, 0.20,255,255,255,255,165,true,true})
		--vRPclient.addMarkerSign(source,{29,x,y,z-1.,0.7,0.5,0.7,0, 255, 0,150,150,true,0,0})
		--vRPclient.addBlip(source,{-149.21870422363,6297.9770507813,31.489519119263,181,4,"~g~Primarie",1.0}) exports.ghmattimysq:execute

		vRP.setArea({source,"vRP:jobs",x,y,z,1,1.5,jobs_enter,jobs_leave,true,"Apasa ~g~[E]~w~ pentru a te ~r~Angaja"}) 
	end
end
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	--if first_spawn then
	--	build_client_jobs(source)
	--	exports["GHMattiMySQL"]:QueryResultAsync('SELECT * FROM vrp_users WHERE id = @user_id', {["user_id"] = user_id}, function(rows)
	--		if #rows > 0 then
	--			theJob = tostring(rows[1].job)
	--			if(theJob ~= "Somer")then
	--				vRP.setPlayerJob({user_id, theJob})
	--				vRPclient.notify(source, {"[JOB] ~g~Esti angajat ca ~b~"..theJob})
	--			else
	--				vRPclient.notify(source, {"[JOB] ~g~Nu ai loc de munca! Du-te la ~g~Primarie ~r~pentru a te angaja!"})
	--			end
	--		end
	--	end)
	--end
end)

RegisterCommand("fixjobs",function(source)
	print("^2FIXED - JOBS")
	print(vRPjobs.getPlayerJob(vRP.getUserId({source})))
	build_client_jobs(source)
end)

function unInitAllJobs(source)
	vRPCjobs.unInitFisherJob(source,{})
	vRPCjobs.UninitBuilderJob(source,{})
end