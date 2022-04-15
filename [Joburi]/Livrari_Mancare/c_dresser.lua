local dresser_location = {
    ['Incepator'] = {x = 135.29733276367, y = -1061.8262939453, z = 21.960227966309},
}

CreateThread(function()
    while true do
        Wait(1000)
        while Vdist(dresser_location['Incepator'].x, dresser_location['Incepator'].y, dresser_location['Incepator'].z, GetEntityCoords(PlayerPedId())) < 5 do
            Wait(0)
            k_Draw3D(dresser_location['Incepator'].x, dresser_location['Incepator'].y, dresser_location['Incepator'].z+1.8, "Schimba-ti Hainele [~b~E~w~]")
            generic_marker(dresser_location['Incepator'].x, dresser_location['Incepator'].y, dresser_location['Incepator'].z)
            if IsControlJustPressed(1, 51) then
                ExecuteCommand("e adjust")
                FreezeEntityPosition(PlayerPedId(), true)
                Change_Clothes()
                Wait(1000)
                FreezeEntityPosition(PlayerPedId(), false)
            end
        end
    end
end)

local changed = false
local Old_Clothes = {}

local dressings = {
    ['1'] = {
        hat        = {model = 75, pos = 0, texture = 0},
        jacket     = {model = 391, pos = 11, texture = 10},
        armsgloves = {model = 1, pos = 3, texture = 0},
        undershirt = {model = -1, pos = 8 , texture = 0},
        pants      = {model = 75, pos = 4, texture = 1},
        shoes      = {model = 1, pos = 6, texture = 2},
    },
}

function Change_Clothes()
    if changed == false then
        Old_Clothes = get_p_clothes()
        changed = true
        local ped = PlayerPedId()
        SetPedPropIndex(ped, dressings['1'].hat.pos, dressings['1'].hat.model, dressings['1'].hat.texture, false)
        SetPedComponentVariation(ped, dressings['1'].jacket.pos, dressings['1'].jacket.model, dressings['1'].jacket.texture, false)
        SetPedComponentVariation(ped, dressings['1'].armsgloves.pos, dressings['1'].armsgloves.model, dressings['1'].armsgloves.texture, false)
        SetPedComponentVariation(ped, dressings['1'].undershirt.pos, dressings['1'].undershirt.model, dressings['1'].undershirt.texture, false)
        SetPedComponentVariation(ped, dressings['1'].pants.pos, dressings['1'].pants.model, dressings['1'].pants.texture, false)
        SetPedComponentVariation(ped, dressings['1'].shoes.pos, dressings['1'].shoes.model, dressings['1'].shoes.texture, false)
           
    else
        changed = false
        --revert clothes
        local ped = PlayerPedId()
        SetPedPropIndex(ped, Old_Clothes.hat.pos, Old_Clothes.hat.model, Old_Clothes.hat.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.jacket.pos, Old_Clothes.jacket.model, Old_Clothes.jacket.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.armsgloves.pos, Old_Clothes.armsgloves.model, Old_Clothes.armsgloves.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.undershirt.pos, Old_Clothes.undershirt.model, Old_Clothes.undershirt.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.pants.pos, Old_Clothes.pants.model, Old_Clothes.pants.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.shoes.pos, Old_Clothes.shoes.model, Old_Clothes.shoes.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.mask.pos, Old_Clothes.mask.model, Old_Clothes.mask.texture, false)
    end
end