function convert_miliseconds_to_minutes(ms)
    if not ms then return "" end
    --return minutes:seconds
    local minutes = math.floor(ms / 60000)
    local seconds = math.floor((ms % 60000) / 1000)
    return minutes .. ":" .. seconds
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
    clothes.bag = {model = GetPedDrawableVariation(ped, 5), texture = GetPedTextureVariation(ped, 5), pos = 5 }
    clothes.vest = {model = GetPedDrawableVariation(ped, 9), texture = GetPedTextureVariation(ped, 9), pos = 9 }
    return clothes
end
