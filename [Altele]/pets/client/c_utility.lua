function spawn_doggo_local(model, pos)
    while HasModelLoaded(model) == false do
        RequestModel(model)
        Wait(0)
    end
    --make a friends group and add the husky and owner to that group

    local pet = CreatePed(1, model, pos, 0, false, false)
    SetEntityCollision(pet, false, false)
    FreezeEntityPosition(pet, true)
    SetEntityInvincible(pet, true)
    SetEntityHeading(pet, 90.0)
    return pet
end


function k_draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
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


function is_in_table(table, value)
    for k, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end


function k_subtitle_text(text, time)
    ClearPrints()
	SetTextEntry_2("STRING")
	SetTextFont(1)
	AddTextComponentString(text)
	DrawSubtitleTimed(1, 1)
end

--take money amount and convert it to string with , to print it
function k_money_to_string(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end