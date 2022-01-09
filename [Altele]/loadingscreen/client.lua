
local spawn1 = false							-- Varijabla za provjeru

AddEventHandler("playerSpawned", function () 	-- Pričekati da se igrač spawna
	if not spawn1 then
		ShutdownLoadingScreenNui()				-- Zatvaranje skripte zaslona za učitavanje
		spawn1 = true
	end
end)