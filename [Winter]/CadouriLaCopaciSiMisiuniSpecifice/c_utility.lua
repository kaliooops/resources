function draw_brad_info (pos)
    local x,y,z = table.unpack(pos)
    DrawMarker(
    0, 
    x,y,z+1.0,
    0,0,0,
    0,0,0, 
    1.0,1.0,1.0,
    50, 168, 82,
    80, true, true, 2, false, false, false, false)  
end


function drawSubtitleText(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	SetTextFont(fontId)
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end


function spawn_pet_husky()
    local huskey = 0x4E8F95A2
    while HasModelLoaded(huskey) == false do
        RequestModel(huskey)
        Wait(0)
    end
    --make a friends group and add the husky and owner to that group


    local pet = CreatePed(1, huskey, GetEntityCoords(PlayerPedId()), 0, true, false)

    AddRelationshipGroup('owner')
    AddRelationshipGroup('pet')
    

    SetRelationshipBetweenGroups(0, 'owner', 'pet')
    SetRelationshipBetweenGroups(0, 'pet', 'owner')

    SetPedRelationshipGroupHash(PlayerPedId(), GetHashKey('owner'))
    SetPedRelationshipGroupHash(pet, GetHashKey("pet"))

    SetEntityMaxHealth(pet, 300)
    SetEntityHealth(pet, 300)

    table.insert(pets, pet)

    CreateThread(function()
        while GetEntityHealth(pet) > 0 do
            TaskGoToEntity(pet, GetPlayerPed(-1), -1, 1.0, 10.0, 1073741824.0, 0)
            SetPedKeepTask(pet, true)
            local ped_veh = GetVehiclePedIsIn(PlayerPedId(), false) 

            if ped_veh then
                if Vdist(GetEntityCoords(pet), GetEntityCoords(ped_veh)) < 4 then
                    TaskWarpPedIntoVehicle(pet, ped_veh, 0)                
                end
            end
            Wait(5000)    
        end
    end)    
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


function setRoute(waypoint)
    local blip = nil
    blip = AddBlipForCoord(waypoint)
    SetBlipRoute(blip, true)
    SetBlipSprite(blip,1)
	SetBlipColour(blip,5)
	SetBlipAsShortRange(blip,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Viata e un examen strada ramane un test")
	EndTextCommandSetBlipName(blip)
	SetBlipRoute(blip,true)
    return blip
end