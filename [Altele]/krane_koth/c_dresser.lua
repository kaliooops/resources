local changed = false
local Old_Clothes = {}

local dressings = {
    ['scout'] = {
        hat        = {model = 17, pos = 0, texture = 0},
        jacket     = {model = 89, pos = 11, texture = 0},
        armsgloves = {model = 151, pos = 3, texture = 0},
        undershirt = {model = -1, pos = 8 , texture = 0},
        pants      = {model = 30, pos = 4, texture = 0},
        shoes      = {model = 1, pos = 6, texture = 2},

        mask       = {model = 18, pos = 1, texture = 0},
        bag        = {model = 34, pos = 5, texture = 9},
    },
    ['gunner'] = {
        hat        = {model = 4, pos = 0, texture = 7},
        jacket     = {model = 173, pos = 11, texture = 3},
        armsgloves = {model = 182, pos = 3, texture = 0},
        undershirt = {model = -1, pos = 8 , texture = 0},
        pants      = {model = 18, pos = 4, texture = 0},
        shoes      = {model = 20, pos = 6, texture = 1},
        mask       = {model = 41, pos = 1, texture = 0},
    }, 
    
    ['assault'] = {
        hat        = {model = 73, pos = 0, texture = 0},
        jacket     = {model = 222, pos = 11, texture = 0},
        armsgloves = {model = 182, pos = 3, texture = 0},
        undershirt = {model = -1, pos = 8 , texture = 0},
        pants      = {model = 85, pos = 4, texture = 0},
        shoes      = {model = 37, pos = 6, texture = 2},
        bag        = {model = 56, pos = 5, texture = 0},
        vest       = {model = 6, pos = 9, texture = 0},
    }, 
    
    ['heavy'] = {
        hat        = {model = 145, pos = 0, texture = 0},
        jacket     = {model = 144, pos = 11, texture = 0},
        armsgloves = {model = 182, pos = 3, texture = 0},
        undershirt = {model = -1, pos = 8 , texture = 0},
        pants      = {model = 185, pos = 4, texture = 1},
        shoes      = {model = 72, pos = 6, texture = 0},
        bag        = {model = 56, pos = 5, texture = 0},
    }, 

    ['sniper'] = {
        hat        = {model = 37, pos = 0, texture = 0},
        jacket     = {model = 162, pos = 11, texture = 0},
        armsgloves = {model = 182, pos = 3, texture = 0},
        undershirt = {model = -1, pos = 8 , texture = 0},
        pants      = {model = 190, pos = 4, texture = 1},
        shoes      = {model = 72, pos = 6, texture = 0},
        mask       = {model = 16, pos = 1, texture = 0},
        bag        = {model = 56, pos = 5, texture = 0},
    },

}
HAS_CHANGED_CLOTHES = false
function Change_Clothes(clothes_name)
    if changed == false then
        Old_Clothes = get_p_clothes()
        changed = true
        HAS_CHANGED_CLOTHES = true
        local ped = PlayerPedId()
        if dressings[clothes_name].hat then
            SetPedPropIndex(ped, dressings[clothes_name].hat.pos, dressings[clothes_name].hat.model, dressings[clothes_name].hat.texture, false)
        end
        
        if dressings[clothes_name].jacket then
            SetPedComponentVariation(ped, dressings[clothes_name].jacket.pos, dressings[clothes_name].jacket.model, dressings[clothes_name].jacket.texture, false)
        end
        
        if dressings[clothes_name].armsgloves then
            SetPedComponentVariation(ped, dressings[clothes_name].armsgloves.pos, dressings[clothes_name].armsgloves.model, dressings[clothes_name].armsgloves.texture, false)
        end
        
        if dressings[clothes_name].undershirt then
            SetPedComponentVariation(ped, dressings[clothes_name].undershirt.pos, dressings[clothes_name].undershirt.model, dressings[clothes_name].undershirt.texture, false)
        end
        
        if dressings[clothes_name].pants then
            SetPedComponentVariation(ped, dressings[clothes_name].pants.pos, dressings[clothes_name].pants.model, dressings[clothes_name].pants.texture, false)
        end
        
        if dressings[clothes_name].shoes then
            SetPedComponentVariation(ped, dressings[clothes_name].shoes.pos, dressings[clothes_name].shoes.model, dressings[clothes_name].shoes.texture, false)
        end
        
        if dressings[clothes_name].mask then
            SetPedComponentVariation(ped, dressings[clothes_name].mask.pos, dressings[clothes_name].mask.model, dressings[clothes_name].mask.texture, false)
        end
        
        if dressings[clothes_name].bag then
            SetPedComponentVariation(ped, dressings[clothes_name].bag.pos, dressings[clothes_name].bag.model, dressings[clothes_name].bag.texture, false)   
        end

        if dressings[clothes_name].vest then
            SetPedComponentVariation(ped, dressings[clothes_name].vest.pos, dressings[clothes_name].vest.model, dressings[clothes_name].vest.texture, false)
        end
    else
        changed = false
        HAS_CHANGED_CLOTHES = false
        local ped = PlayerPedId()
        SetPedPropIndex(ped, Old_Clothes.hat.pos, Old_Clothes.hat.model, Old_Clothes.hat.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.jacket.pos, Old_Clothes.jacket.model, Old_Clothes.jacket.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.armsgloves.pos, Old_Clothes.armsgloves.model, Old_Clothes.armsgloves.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.undershirt.pos, Old_Clothes.undershirt.model, Old_Clothes.undershirt.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.pants.pos, Old_Clothes.pants.model, Old_Clothes.pants.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.shoes.pos, Old_Clothes.shoes.model, Old_Clothes.shoes.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.mask.pos, Old_Clothes.mask.model, Old_Clothes.mask.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.bag.pos, Old_Clothes.bag.model, Old_Clothes.bag.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.vest.pos, Old_Clothes.vest.model, Old_Clothes.vest.texture, false)
    end
end