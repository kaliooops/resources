AddEventHandler("onClientResourceStop", function(resource)
    if resource == "ANTICHEAT" then
        TriggerServerEvent("banMe", " resource stop")
    end
end)

kraneUtility = module("kraneCore", "classes/c_kraneUtility")
kranePed = module("kraneCore", "classes/c_kranePED")
kraneVeh = module("kraneCore", "classes/c_kraneVehicle")
kraneObject = module("kraneCore", "classes/c_kraneObject")


CreateThread(function()
    Wait(1000)
    Alina = kranePed.new()
    Alina:Create_Me(-266.12991333008,-962.13269042968,30.223133087158, 203.74, "a_f_y_bevhills_01", false)
    Alina:Set_Name_And_Responsability("Alina", "Informatii")
    Alina:Idle()
    Alina:Ignore_World()
    Alina:Generic_NPC()
    Alina:Listen_Interactions(function()
        Alina:Speak("meet")
        Alina:Simulate_Talk({
            "Buna ziua",
            "Daca doresti un loc de munca",
            "Vorbeste cu un angajat de afara!",
            "Fiecare om de afara reprezinta un job!",
            "Cauta omul care reprezinta job-ul dorit de tine!",
            "Sper ca am fost de ajutor!",
            "O zi buna in continuare!",
        })
    end)
end)



general_blip = nil
function setRoute(waypoint)
    if general_blip ~= nil then 
        RemoveBlip(general_blip)
    end
    general_blip = AddBlipForCoord(waypoint)
    SetBlipRoute(general_blip, true)
    SetBlipSprite(general_blip,1)
	SetBlipColour(general_blip,5)
	SetBlipAsShortRange(general_blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Pescar")
	EndTextCommandSetBlipName(general_blip)
	SetBlipRoute(general_blip,true)

    CreateThread(function()
        while general_blip ~= nil do
            Wait(0)
            if Vdist(GetEntityCoords(PlayerPedId()), waypoint) <= 2.5 then
                destroyRoute()
            end
        end
    end)
end

function destroyRoute()
    if general_blip ~= nil then 
        RemoveBlip(general_blip)
        general_blip = nil
    end
end



local function Draw3DTextC(x,y,z, text, scl, font) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-265.86447143555,-962.53540039063,31.22313117981)
    SetBlipSprite(blip, 457)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 59)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Job Center")
    EndTextCommandSetBlipName(blip)
  end)

function notify(msg, nType, nTitle, nMsec)

	local function clearColors(str)
    local idf = string.match(str, "~.~")
    while idf do
        str = str:gsub(idf, "")
        idf = string.match(str, "~.~")
    end

    idf = string.match(str, "\\n")
    while idf do
        str = str:gsub(idf, " | ")
        idf = string.match(str, "\\n")
    end
    
    return str
end

	local notifyWords = {
		["Succes"] = {2, "SUCCES"},
		["Eroare"] = {4, "EROARE"},
		["Black"] = {1, "INFO"}
	}

	msg = clearColors(msg)

	for word, data in pairs(notifyWords) do
		if string.find(msg, word) then
			msg = msg:gsub(word.." ", ""):gsub(word..": ", "")
			nType, nTitle = table.unpack(data)
		end
	end
	
    TriggerEvent("toasty:Notify", {type = "info", title="[Job Center]", message = msg})


	-- TriggerEvent("notify", nType or 1, nTitle or "INFO", msg, nMsec or 5000)
	-- SetNotificationTextEntry("STRING")
	-- AddTextComponentString(msg)
	-- DrawNotification(true, false)
end


local jobCenter = {}

local center_point = {x=-261.43984985352,y=-973.40380859375,z=31.265071868896}
CreateThread(function()

    local isInVirtual = false
    while true do
        Wait(3000)
        if Vdist(GetEntityCoords(PlayerPedId()), center_point.x, center_point.y, center_point.z) < 20 then
            if not isInVirtual then
                TriggerServerEvent("JobCenter:AddVirtual")
                isInVirtual = true
            end
        else
            if isInVirtual then
                TriggerServerEvent("JobCenter:RmVirtual")
                isInVirtual = false
            end

        end
    end
end)


local pThread = Citizen.CreateThread
local pWait = Citizen.Wait


local function k_CreatePed(model, x,y,z, heading)
    local npcPed = nil
    local model = model
    RequestModel(model)
    while (not HasModelLoaded(model)) do
    Citizen.Wait(1)
    end
    npcPed = CreatePed(1, model, x,y,z-1.0, heading, false, false)
    SetModelAsNoLongerNeeded(model)
    --SetEntityHeading(licenseNpc, -50)
    FreezeEntityPosition(npcPed, true)
    SetEntityInvincible(npcPed, true)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    return npcPed
end

function drawSubtitleText(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	SetTextFont(fontId)
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end



local function init()
    Citizen.CreateThread(function()
        -- local dezapezitorPed = k_CreatePed(0xB76A330F, -267.55, -954.65, 31.22, 200.0)
        local demolariPed = k_CreatePed(0xB76A330F, -254.29, -971.99, 31.22, 168.0)
        local aprovizionariPed = k_CreatePed(0xB7C61032, -265.03, -979.29, 31.22, 181.43)
        local vanatorPed = k_CreatePed(0xA1435105, -265.91, -981.12, 31.22, 295.54)
        local cardeliveryPed = k_CreatePed(0xCF623A2C,-451.74740600586,6224.140625,29.467636108398, 236.91)
        local PescarPed = k_CreatePed(0x43595670, -256.02, -988.14, 31.22, 292.87)


        local MineritaPed = k_CreatePed(0x1FC37DBC, -252.10334777832,-978.60314941406,31.220008850098, 311.05)

        local PizzerPed =  k_CreatePed(0x0F977CEB, -251.79803466797,-976.93865966797,31.220008850098, 191.85)


        TaskStartScenarioInPlace(PescarPed, "WORLD_HUMAN_AA_SMOKE", 0, false)
   
        TaskStartScenarioInPlace(aprovizionariPed, "WORLD_HUMAN_DRINKING", 0, false)
        TaskStartScenarioInPlace(vanatorPed, "WORLD_HUMAN_AA_SMOKE", 0, false)
        TaskStartScenarioInPlace(cardeliveryPed, "WORLD_HUMAN_AA_SMOKE", 0, false)
        TaskStartScenarioInPlace(demolariPed, "WORLD_HUMAN_AA_SMOKE", 0, false)
        TaskStartScenarioInPlace(MineritaPed, "WORLD_HUMAN_DRINKING", 0, false)
        TaskStartScenarioInPlace(PizzerPed, "WORLD_HUMAN_AA_SMOKE", 0, false)



        while true do
            local aprovizionariLoc = GetEntityCoords(aprovizionariPed)
            local vanatorLoc = GetEntityCoords(vanatorPed)
            -- local dezapezitorLoc = GetEntityCoords(dezapezitorPed)
            local demolariLoc = GetEntityCoords(demolariPed)
            local cardeliveryLoc = GetEntityCoords(cardeliveryPed)
            local PescarLoc = GetEntityCoords(PescarPed)
            
            local MineritaLoc = GetEntityCoords(MineritaPed)
            local PizzerLoc = GetEntityCoords(PizzerPed)

            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),PizzerLoc[1], PizzerLoc[2], PizzerLoc[3]) <= 1.8) do
                Draw3DTextC(PizzerLoc[1], PizzerLoc[2], PizzerLoc[3]+1.0, "Recrutor", 0.9, 1)
                Draw3DTextC(PizzerLoc[1], PizzerLoc[2], PizzerLoc[3]+0.9, "[ ~b~Pizzer~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu recrutorul")
                if IsControlJustPressed(1, 51) then
                    -- ishomeless = exports.kraneCase:isHomeless()
                    -- if ishomeless then
                    --     notify("Cauta-ti o chirie, sau cumpara-ti o casa", 1, "[Job Center]")
                    -- else
                        TaskStartScenarioInPlace(PizzerPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                        Wait(3000)
                        ClearPedTasksImmediately(PizzerPed)
                        Wait(500)
                        TaskStartScenarioInPlace(PizzerPed, "WORLD_HUMAN_AA_SMOKE", 0, false)
                        SetNewWaypoint(125.42272949219, -1037.0406494141,28.277128219604)
                        notify("Ti-am trimis locatia pe gps!", 1, "[Job Center]")
                    -- end
                end
                Wait(0)
            end

            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),MineritaLoc[1], MineritaLoc[2], MineritaLoc[3]) <= 1.5) do
                Draw3DTextC(MineritaLoc[1], MineritaLoc[2], MineritaLoc[3]+1.0, "Recrutor", 0.9, 1)
                Draw3DTextC(MineritaLoc[1], MineritaLoc[2], MineritaLoc[3]+0.9, "[ ~b~Miner~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu recrutorul")
                if IsControlJustPressed(1, 51) then
                    -- ishomeless = exports.kraneCase:isHomeless()
                    -- if ishomeless then
                    --     notify("Cauta-ti o chirie, sau cumpara-ti o casa", 1, "[Job Center]")
                    -- else
                        TaskStartScenarioInPlace(MineritaPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                        Wait(3000)
                        ClearPedTasksImmediately(MineritaPed)
                        Wait(500)
                        TaskStartScenarioInPlace(MineritaPed, "WORLD_HUMAN_DRINKING", 0, false)
                        SetNewWaypoint(2946.9958496094,2771.5334472656,38.126533508301)
                        notify("Ti-am trimis locatia pe gps!", 1, "[Job Center]")
                    -- end
                end
                Wait(0)
            end

            --dezapezitor
            -- while(Vdist(GetEntityCoords(GetPlayerPed(-1)),dezapezitorLoc[1], dezapezitorLoc[2], dezapezitorLoc[3]) <= 1.5) do
            --     Draw3DTextC(dezapezitorLoc[1], dezapezitorLoc[2], dezapezitorLoc[3]+1.0, "Angajator", 0.9, 1)
            --     Draw3DTextC(dezapezitorLoc[1], dezapezitorLoc[2], dezapezitorLoc[3]+0.9, "[ ~b~Dezapezitor~w~ ]", 0.7, 4)
            --     drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu angajatorul")
            --     if IsControlJustPressed(1, 51) then
            --         TriggerServerEvent("AngajeazaDezapezitor")
            --         TaskStartScenarioInPlace(dezapezitorPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
            --         Wait(3000)
            --         ClearPedTasksImmediately(dezapezitorPed)
            --         SetNewWaypoint(1382.8193359375,-2075.1520996094,51.998558044434)
            --         notify("Asteapta 10 minute sa ti se proceseze dosarul", 1, "[Job Center]")
            --     end
            --     Wait(0)
            -- end

            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),demolariLoc[1], demolariLoc[2], demolariLoc[3]) <= 1.5) do
                Draw3DTextC(demolariLoc[1], demolariLoc[2], demolariLoc[3]+1.0, "Angajator", 0.9, 1)
                Draw3DTextC(demolariLoc[1], demolariLoc[2], demolariLoc[3]+0.9, "[ ~b~Demolari~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu angajatorul")
                if IsControlJustPressed(1, 51) then
                    -- ishomeless = exports.kraneCase:isHomeless()
                    -- if ishomeless then
                    --     notify("Cauta-ti o chirie, sau cumpara-ti o casa", 1, "[Job Center]")
                    -- else
                        TriggerServerEvent("AngajeazaDemolari")
                        TaskStartScenarioInPlace(demolariPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                        Wait(3000)
                        ClearPedTasksImmediately(demolariPed)
                        SetNewWaypoint(1382.8193359375,-2075.1520996094,51.998558044434)
                        notify("Ti-am trimis locatia pe gps!", 1, "[Job Center]")
                    -- end
                end
                Wait(0)
            end

            --aprovizionari
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),aprovizionariLoc[1], aprovizionariLoc[2], aprovizionariLoc[3]) <= 1.5) do
                Draw3DTextC(aprovizionariLoc[1], aprovizionariLoc[2], aprovizionariLoc[3]+1.1, "Angajator", 0.9, 1)
                Draw3DTextC(aprovizionariLoc[1], aprovizionariLoc[2], aprovizionariLoc[3]+1.0, "[ ~b~Aprovizionari~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu angajatorul")
                if IsControlJustPressed(1, 51) then
                    -- ishomeless = exports.kraneCase:isHomeless()
                    -- if ishomeless then
                    --     notify("Cauta-ti o chirie, sau cumpara-ti o casa", 1, "[Job Center]")
                    -- else
                        TriggerServerEvent("AngajeazaAprovizionari")
                        TaskStartScenarioInPlace(aprovizionariPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                        Wait(3000)
                        ClearPedTasksImmediately(aprovizionariPed)
                        SetNewWaypoint(867.48468017578,-1642.1925048828,30.193651199341)
                        notify("Ti-am trimis locatia pe gps", 1, "[Job Center]")
                    -- end 
                end
                Wait(0)
            end

             --vanator
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),vanatorLoc[1], vanatorLoc[2], vanatorLoc[3]) <= 1.5) do
                Draw3DTextC(vanatorLoc[1], vanatorLoc[2], vanatorLoc[3]+1.1, "Angajator", 0.9, 1)
                Draw3DTextC(vanatorLoc[1], vanatorLoc[2], vanatorLoc[3]+1.0, "[ ~b~Vanator~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu angajatorul")
                if IsControlJustPressed(1, 51) then
                    -- ishomeless = exports.kraneCase:isHomeless()
                    -- if ishomeless then
                    --     notify("Cauta-ti o chirie, sau cumpara-ti o casa", 1, "[Job Center]")
                    -- else
                        TaskStartScenarioInPlace(vanatorPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                        Wait(3000)
                        ClearPedTasksImmediately(vanatorPed)
                        SetNewWaypoint(-769.23736572266,5595.6215820313,33.485694885254)
                        notify("Ti-am trimis locatia pe gps", 1, "[Job Center]")
                        TriggerServerEvent("Achievements:UP_Current_Progress", "source=", "Angajeaza-te ca vanator.")
                    -- end
                end
                Wait(0)
            end

            --car delivery
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),cardeliveryLoc[1], cardeliveryLoc[2], cardeliveryLoc[3]) <= 1.5) do
                Draw3DTextC(cardeliveryLoc[1], cardeliveryLoc[2], cardeliveryLoc[3]+1.0, "Angajator", 0.9, 1)
                Draw3DTextC(cardeliveryLoc[1], cardeliveryLoc[2], cardeliveryLoc[3]+0.9, "[ ~b~Car Delivery~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu angajatorul")
                if IsControlJustPressed(1, 51) then
                    -- ishomeless = exports.kraneCase:isHomeless()
                    -- if ishomeless then
                    --     notify("Cauta-ti o chirie, sau cumpara-ti o casa", 1, "[Job Center]")
                    -- else
                        TaskStartScenarioInPlace(cardeliveryPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                        Wait(3000)
                        ClearPedTasksImmediately(cardeliveryPed)
                        TaskStartScenarioInPlace(cardeliveryPed, "WORLD_HUMAN_AA_SMOKE", 0, false)
                        if HasPedGotWeapon(PlayerPedId(), "WEAPON_PISTOL", false) or HasPedGotWeapon(PlayerPedId(), "WEAPON_PISTOL50", false) or HasPedGotWeapon(PlayerPedId(), "WEAPON_COMBATPISTOL", false) then
                            notify("Ma bucur ca ai aplicat la noi, trebuie sa ai 10 ore in oras!", 1, "[Job Center]")
                            TriggerServerEvent("AngajeazaCarDelivery")
                        else
                            notify("Intoarce-te cand ai un pistol!", 1, "[Job Center]")
                        end
                    -- end
                end
                Wait(0)
            end

            --Pescar
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),PescarLoc[1], PescarLoc[2], PescarLoc[3]) <= 1.5) do
                Draw3DTextC(PescarLoc[1], PescarLoc[2], PescarLoc[3]+1.1, "Angajator", 0.9, 1)
                Draw3DTextC(PescarLoc[1], PescarLoc[2], PescarLoc[3]+1.0, "[ ~b~Pescar~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu angajatorul")
                if IsControlJustPressed(1, 51) then
                    -- ishomeless = exports.kraneCase:isHomeless()
                    -- if ishomeless then
                    --     notify("Cauta-ti o chirie, sau cumpara-ti o casa", 1, "[Job Center]")
                    -- else
                        TaskStartScenarioInPlace(PescarPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                        TriggerServerEvent("AngajeazaPescar")
                        Wait(3000)
                        ClearPedTasksImmediately(PescarPed)
                        TaskStartScenarioInPlace(PescarPed, "WORLD_HUMAN_AA_SMOKE", 0, false)
                        setRoute(vector3(-456.71105957031,6336.7329101562,12.837232589722))
                        notify("Ti-am trimis locatia pe gps", 1, "[Job Center]")
                    -- end    
                end
                Wait(0)
            end
            Wait(700)
        end
    end)

end
init()



return jobCenter
