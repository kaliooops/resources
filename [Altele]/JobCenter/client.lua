AddEventHandler("onClientResourceStop", function(resource)
    if resource == "ANTICHEAT" then
        TriggerServerEvent("banMe", " resource stop")
    end
end)
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
    SetBlipColour(blip, 11)
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
        local constructorPed = k_CreatePed(0xB3B3F5E6, -269.20303344727,-955.45819091797,31.22313117981, 200.0)
        local bodyguardPed = k_CreatePed(0x2EFEAFD5, -270.89047241211,-956.15258789062,31.223142623901, 200.0)
        -- local dezapezitorPed = k_CreatePed(0xB76A330F, -267.55, -954.65, 31.22, 200.0)
        local demolariPed = k_CreatePed(0xB76A330F, -267.55, -954.65, 31.22, 200.0)
        local aprovizionariPed = k_CreatePed(0xB7C61032, -265.46, -957.16, 31.22, 115.01)
        local vanatorPed = k_CreatePed(0xA1435105, -269.66, -960.20, 31.22, 282.05)
        local cardeliveryPed = k_CreatePed(0xCF623A2C, 2404.23, 3127.58, 48.15, 238.08)


        while true do
            local constructorLoc = GetEntityCoords(constructorPed)
            local bodyguardLoc = GetEntityCoords(bodyguardPed)
            local aprovizionariLoc = GetEntityCoords(aprovizionariPed)
            local vanatorLoc = GetEntityCoords(vanatorPed)
            -- local dezapezitorLoc = GetEntityCoords(dezapezitorPed)
            local demolariLoc = GetEntityCoords(demolariPed)
            local cardeliveryLoc = GetEntityCoords(cardeliveryPed)

            --constructor
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),constructorLoc[1], constructorLoc[2], constructorLoc[3]) <= 1.5) do
                Draw3DTextC(constructorLoc[1], constructorLoc[2], constructorLoc[3]+1.0, "Recrutor", 0.9, 1)
                Draw3DTextC(constructorLoc[1], constructorLoc[2], constructorLoc[3]+0.9, "[ ~b~Constructor~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu recrutorul")
                if IsControlJustPressed(1, 51) then
                    SetNewWaypoint(141.15771484375,-379.478515625)
                    TaskStartScenarioInPlace(constructorPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                    Wait(3000)
                    ClearPedTasksImmediately(constructorPed)
                    notify("Uita-te pe telefon, ti-am notat pe GPS locatia", 1, "[Angajator]")
                end
                Wait(0)
            end

            --bodyguard
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),bodyguardLoc[1], bodyguardLoc[2], bodyguardLoc[3]) <= 1.5) do
                Draw3DTextC(bodyguardLoc[1], bodyguardLoc[2], bodyguardLoc[3]+1.0, "Angajator", 0.9, 1)
                Draw3DTextC(bodyguardLoc[1], bodyguardLoc[2], bodyguardLoc[3]+0.9, "[ ~b~BodyGuard~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu angajatorul")
                if IsControlJustPressed(1, 51) then

                    if GetEntityModel(PlayerPedId()) == -1667301416 then
                        TriggerEvent("toasty:Notify", {type = "info", title="BodyGuard", message = "Nu angajam femei!"})
                    else
                        SetNewWaypoint(934.99108886719,46.821365356445,81.09578704834)
                        TriggerServerEvent("AngajeazaBodyGuard")
                        TaskStartScenarioInPlace(bodyguardPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                        Wait(3000)
                        ClearPedTasksImmediately(bodyguardPed)
                        notify("Mergi si echipeaza-te la Casino!", 1, "[Job Center]")
                        TriggerServerEvent("bodyguard_InsertInDatabase")
                    end
                    
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
                    TriggerServerEvent("AngajeazaDemolari")
                    TaskStartScenarioInPlace(demolariPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                    Wait(3000)
                    ClearPedTasksImmediately(demolariPed)
                    SetNewWaypoint(1382.8193359375,-2075.1520996094,51.998558044434)
                    notify("Ti-am trimis locatia pe gps!", 1, "[Job Center]")
                end
                Wait(0)
            end

            --aprovizionari
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),aprovizionariLoc[1], aprovizionariLoc[2], aprovizionariLoc[3]) <= 1.5) do
                Draw3DTextC(aprovizionariLoc[1], aprovizionariLoc[2], aprovizionariLoc[3]+1.1, "Angajator", 0.9, 1)
                Draw3DTextC(aprovizionariLoc[1], aprovizionariLoc[2], aprovizionariLoc[3]+1.0, "[ ~b~Aprovizionari~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu angajatorul")
                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent("AngajeazaAprovizionari")
                    TaskStartScenarioInPlace(aprovizionariPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                    Wait(3000)
                    ClearPedTasksImmediately(aprovizionariPed)
                    SetNewWaypoint(867.48468017578,-1642.1925048828,30.193651199341)
                    notify("Ti-am trimis locatia pe gps", 1, "[Job Center]")
                end
                Wait(0)
            end

             --vanator
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),vanatorLoc[1], vanatorLoc[2], vanatorLoc[3]) <= 1.5) do
                  Draw3DTextC(vanatorLoc[1], vanatorLoc[2], vanatorLoc[3]+1.1, "Angajator", 0.9, 1)
                  Draw3DTextC(vanatorLoc[1], vanatorLoc[2], vanatorLoc[3]+1.0, "[ ~b~Vanator~w~ ]", 0.7, 4)
                  drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu angajatorul")
                  if IsControlJustPressed(1, 51) then
                     TaskStartScenarioInPlace(vanatorPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                     Wait(3000)
                     ClearPedTasksImmediately(vanatorPed)
                     SetNewWaypoint(-769.23736572266,5595.6215820313,33.485694885254)
                     notify("Ti-am trimis locatia pe gps", 1, "[Job Center]")
                  end
                Wait(0)
              end

            --car delivery
            while(Vdist(GetEntityCoords(GetPlayerPed(-1)),cardeliveryLoc[1], cardeliveryLoc[2], cardeliveryLoc[3]) <= 1.5) do
                Draw3DTextC(cardeliveryLoc[1], cardeliveryLoc[2], cardeliveryLoc[3]+1.0, "Angajator", 0.9, 1)
                Draw3DTextC(cardeliveryLoc[1], cardeliveryLoc[2], cardeliveryLoc[3]+0.9, "[ ~b~Car Delivery~w~ ]", 0.7, 4)
                drawSubtitleText("Apasa [~b~E~w~] sa vorbesti cu angajatorul")
                if IsControlJustPressed(1, 51) then
                    TaskStartScenarioInPlace(cardeliveryPed, "WORLD_HUMAN_CLIPBOARD", 0, false)
                    Wait(3000)
                    ClearPedTasksImmediately(cardeliveryPed)
                    if HasPedGotWeapon(PlayerPedId(), "WEAPON_PISTOL", false) or HasPedGotWeapon(PlayerPedId(), "WEAPON_PISTOL50", false) or HasPedGotWeapon(PlayerPedId(), "WEAPON_COMBATPISTOL", false) then
                        notify("Ma bucur ca ai aplicat la noi, trebuie sa ai 10 ore in oras!", 1, "[Job Center]")
                        TriggerServerEvent("AngajeazaCarDelivery")
                    else
                        notify("Intoarce-te cand ai un pistol!", 1, "[Job Center]")
                    end
                end
                Wait(0)
            end




            Wait(700)
        end
    end)

end
init()



return jobCenter
