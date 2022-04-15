function create_local_npc(x,y,z, model, heading)
    mhash = GetHashKey(model)
    RequestModel(mhash)
    while not HasModelLoaded(mhash) do
        Wait(0)
    end
    local ped = CreatePed(1, mhash, x, y, z, heading, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    SetModelAsNoLongerNeeded(mhash)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    return ped
end

function generic_marker(x,y,z)
    DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 0, 0, 255, 200, 0, 0, 0, 0)
end

function k_Draw3D(x,y,z, text, s)
    if not s then s = 2 end
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*s
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
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


function k_Subtitle(text)
    ClearPrints()
	SetTextEntry_2("STRING")
	SetTextFont(4)
	AddTextComponentString(text)
	DrawSubtitleTimed(1, 1)
end



function get_p_clothes()
    local ped = PlayerPedId()
    local clothes = {}
    clothes.hat = {model = GetPedPropIndex(ped, 0), texture = GetPedPropTextureIndex(ped, 0), pos = 0 }
    clothes.jacket = {model = GetPedDrawableVariation(ped, 11), texture = GetPedTextureVariation(ped, 11), pos = 11 }
    clothes.undershirt = {model = GetPedDrawableVariation(ped, 8), texture = GetPedTextureVariation(ped, 8), pos = 8 }
    clothes.armsgloves = {model = GetPedDrawableVariation(ped, 3), texture = GetPedTextureVariation(ped, 3), pos = 3 }
    clothes.pants = {model = GetPedDrawableVariation(ped, 4), texture = GetPedTextureVariation(ped, 4), pos = 4 }
    clothes.shoes = {model = GetPedDrawableVariation(ped, 6), texture = GetPedTextureVariation(ped, 6), pos = 6 }
    clothes.mask = {model = GetPedDrawableVariation(ped, 1), texture = GetPedTextureVariation(ped, 1), pos = 1 }

    return clothes
end



function spawn_ped_in_net_created_vehicle(x,y,z, model, heading)
    local ped = PlayerPedId()
    mhash = GetHashKey(model)
    RequestModel(mhash)
    while not HasModelLoaded(mhash) do
        Wait(0)
        print("waiting for model")
    end
    local veh = CreateVehicle(mhash, x, y, z, heading, true, true)
    NetworkRegisterEntityAsNetworked(VehToNet(veh))
    SetPedIntoVehicle(ped, veh, -1)
    SetVehicleNumberPlateText(veh, "Pizzerie")
    SetVehicleOnGroundProperly(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetEntityAsMissionEntity(veh, true, true)
    SetVehicleAsNoLongerNeeded(veh)
end


function ms_to_minutes(ms)
    -- transofrm 1000 to 0:59 seconds
    local seconds = math.floor(ms/1000)
    local minutes = math.floor(seconds/60)
    local seconds = seconds - minutes*60
    -- return as string
    return string.format("%02d:%02d", minutes, seconds)
end

function ms_to_seconds(ms)
    -- transofrm 1000 to 59 seconds
    local seconds = math.floor(ms/1000)
    -- return as string
    return string.format("%02d", seconds)
end

general_blip = nil
function setRoute(x, y, z)
    if general_blip ~= nil then 
        RemoveBlip(general_blip)
    end
    general_blip = AddBlipForCoord(x, y, z)
    SetBlipRoute(general_blip, true)
    SetBlipSprite(general_blip,1)
	SetBlipColour(general_blip,5)
	SetBlipAsShortRange(general_blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Weapon_delivery")
	EndTextCommandSetBlipName(general_blip)
	SetBlipRoute(general_blip,true)

    CreateThread(function()
        while general_blip ~= nil do
            Wait(0)
            if Vdist(GetEntityCoords(PlayerPedId()), x, y, z) <= 2.5 then
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

function drawHudText(x,y ,width,height,scale, text, r,g,b,a, outline, font, center)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    
    SetTextCentre(center)
    if(outline)then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
