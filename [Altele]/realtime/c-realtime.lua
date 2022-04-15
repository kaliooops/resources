
RegisterNetEvent("WEATHER:UPDATE")
AddEventHandler("WEATHER:UPDATE", function(weather)
	ClearOverrideWeather()
	ClearWeatherTypePersist()
	SetWeatherTypeNow(weather)
	SetWeatherTypePersist(weather)
	SetWeatherTypeNowPersist(weather)
	print("Syncing weather " .. weather)
end)

Citizen.CreateThread(function() 
	Wait(1000)
	-- GET_UTC_TIME
	local year --[[ integer ]], month --[[ integer ]], day --[[ integer ]], hour --[[ integer ]], minute --[[ integer ]], second --[[ integer ]] = GetUtcTime()
	if hour >= 22 then
		hour = 0
	end
	NetworkOverrideClockTime(hour+2, minute, second)
	-- ClearOverrideWeather()
	-- ClearWeatherTypePersist()
	-- SetWeatherTypePersist("XMAS")
	-- SetWeatherTypeNow("XMAS"s)
	-- SetWeatherTypeNowPersist("XMAS")
	-- SetForceVehicleTrails(true)
	-- SetForcePedFootstepsTracks(true)
	SetMillisecondsPerGameMinute(60000)

	-- local a1 = ClearWeatherTypePersist(), ClearOverrideWeather(), SetWeatherTypePersist("EXTRASUNNY"), SetWeatherTypeNow("EXTRASUNNY"), SetWeatherTypeNowPersist("EXTRASUNNY")
	-- local a2 = ClearWeatherTypePersist(), ClearOverrideWeather(), SetWeatherTypePersist("CLEAR"), SetWeatherTypeNow("CLEAR"), SetWeatherTypeNowPersist("CLEAR")
	-- local a3 = ClearWeatherTypePersist(), ClearOverrideWeather(), SetWeatherTypePersist("NEUTRAL"), SetWeatherTypeNow("NEUTRAL"), SetWeatherTypeNowPersist("NEUTRAL")



end)

-- this function exist in ezDamage
-- exports("ana", function()
--     print("muie")
-- end)

-- RegisterCommand("ana", function()
-- 	classes = exports.ezFiveM:Get_Classes()
-- 	c_kranePED = classes.ped
-- 	c_kraneUtility = classes.utility
--     c_kraneVehicle = classes.veh
--     c_kraneObject = classes.obj

-- 	c_kranePED.utility = c_kraneUtility
-- 	local ped = setmetatable({}, c_kranePED)

-- 	local veh = setmetatable({}, c_kraneVehicle)
-- 	local obj = setmetatable({}, c_kraneObject)
-- 	local util = setmetatable({}, c_kraneUtility)


	
-- 	x,y,z = GetEntityCoords(PlayerPedId())
-- 	ped:Create_Me(x,y,z, 0.0, "g_m_y_azteca_01")
-- 	print(ped.ped)

-- 	ped:Set_Name_And_Responsability("Marius","aaa")

-- end, false)


