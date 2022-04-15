local center_room = {x = 458.21643066406,y = -991.43395996094, z = 30.689584732056}

local dresser_location = {
    ['Cadet'] = {x = 459.47546386718, y = -992.96173095704, z = 30.689599990844},
    ['Detectiv'] = {x = 456.61871337891,y = -993.03845214844, z = 30.689601898193},
    ['Serif'] = {x = 452.361328125, y = -993.03643798828, z = 30.689599990844},
}
local changed = false
local Old_Clothes = {}

local dressings = {
    ['Cadet'] = {
        hat        = {model = -1, pos = 0, texture = 0},
        jacket     = {model = 101, pos = 11, texture = 0},
        armsgloves = {model = 30, pos = 3, texture = 0},
        undershirt = {model = 32, pos = 8 , texture = 0},
        pants      = {model = 24, pos = 4, texture = 0},
        shoes      = {model = 21, pos = 6, texture = 0},
    },
    ['Detectiv'] = {
        hat        = {model = -1, pos = 0, texture = 0},
        jacket     = {model = 9, pos = 11, texture = 0},
        armsgloves = {model = 30, pos = 3, texture = 0},
        undershirt = {model = -1, pos = 8 , texture = 0},
        pants      = {model = 24, pos = 4, texture = 0},
        shoes      = {model = 18, pos = 6, texture = 0},
        mask       = {model = 121, pos = 0, texture = 0},
        vest       = {model = 30, pos = 9, texture = 0},
    },
    ['Serif'] = {
        hat        = {model = -1, pos = 0, texture = 0},
        jacket     = {model = 101, pos = 11, texture = 1},
        armsgloves = {model = 30, pos = 3, texture = 0},
        undershirt = {model = 44, pos = 8 , texture = 0},
        pants      = {model = 24, pos = 4, texture = 0},
        shoes      = {model = 20, pos = 6, texture = 0},
        mask       = {model = 121, pos = 0, texture = 0},
        vest       = {model = 30, pos = 9, texture = 0},
    }
}

CreateThread(function()
    while true do
        Wait(300)
        while Vdist(GetEntityCoords(PlayerPedId()), center_room.x, center_room.y, center_room.z) < 7.0 do
            Wait(0)
            for dresser, table in pairs(dresser_location) do
                DrawMarker(1, table.x, table.y, table.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 7, 141, 219, 200, 0, 0, 0, 0)
                if Vdist(GetEntityCoords(PlayerPedId()), table.x, table.y, table.z) < 1.5 then
                    k_draw3DText(table.x, table.y, table.z + 0.5, '~b~[E] ~w~Pentru a te schimba in ~b~' .. dresser, 1, 1)
                end
            end

            if IsControlJustPressed(1, 51) then
                for dresser, table in pairs(dresser_location) do
                    if Vdist(GetEntityCoords(PlayerPedId()), table.x, table.y, table.z) < 2 then
                        Change_Clothes(dresser)
                        FreezeEntityPosition(PlayerPedId(), true)
                        ExecuteCommand("e adjust")
                        Wait(3000)
                        FreezeEntityPosition(PlayerPedId(), false)                        
                    end
                end
            end
        end
    end
end)



function Change_Clothes(rank)
    if not changed then
        Old_Clothes = get_p_clothes()
        local ped = PlayerPedId()
        --change to rank
        if rank == "Cadet" then
            SetPedPropIndex(ped, dressings['Cadet'].hat.pos, dressings['Cadet'].hat.model, dressings['Cadet'].hat.texture, false)
            SetPedComponentVariation(ped, dressings['Cadet'].jacket.pos, dressings['Cadet'].jacket.model, dressings['Cadet'].jacket.texture, false)
            SetPedComponentVariation(ped, dressings['Cadet'].armsgloves.pos, dressings['Cadet'].armsgloves.model, dressings['Cadet'].armsgloves.texture, false)
            SetPedComponentVariation(ped, dressings['Cadet'].undershirt.pos, dressings['Cadet'].undershirt.model, dressings['Cadet'].undershirt.texture, false)
            SetPedComponentVariation(ped, dressings['Cadet'].pants.pos, dressings['Cadet'].pants.model, dressings['Cadet'].pants.texture, false)
            SetPedComponentVariation(ped, dressings['Cadet'].shoes.pos, dressings['Cadet'].shoes.model, dressings['Cadet'].shoes.texture, false)
            changed = true
            TriggerEvent("chatMessage", "",{255, 0, 0}, "^0[^1Factiuni^0] ^2Politie^0: ^1Te-ai echipat cu succes")
        end
        
        if rank == "Detectiv" then
            SetPedPropIndex(ped, dressings['Detectiv'].hat.pos, dressings['Detectiv'].hat.model, dressings['Detectiv'].hat.texture, false)
            SetPedComponentVariation(ped, dressings['Detectiv'].jacket.pos, dressings['Detectiv'].jacket.model, dressings['Detectiv'].jacket.texture, false)
            SetPedComponentVariation(ped, dressings['Detectiv'].armsgloves.pos, dressings['Detectiv'].armsgloves.model, dressings['Detectiv'].armsgloves.texture, false)
            SetPedComponentVariation(ped, dressings['Detectiv'].undershirt.pos, dressings['Detectiv'].undershirt.model, dressings['Detectiv'].undershirt.texture, false)
            SetPedComponentVariation(ped, dressings['Detectiv'].pants.pos, dressings['Detectiv'].pants.model, dressings['Detectiv'].pants.texture, false)
            SetPedComponentVariation(ped, dressings['Detectiv'].shoes.pos, dressings['Detectiv'].shoes.model, dressings['Detectiv'].shoes.texture, false)
            SetPedComponentVariation(ped, dressings['Detectiv'].vest.pos, dressings['Detectiv'].vest.model, dressings['Detectiv'].vest.texture, false)
            SetPedComponentVariation(ped, dressings['Detectiv'].mask.pos, dressings['Detectiv'].mask.model, dressings['Detectiv'].mask.texture, false)
            changed = true
            TriggerEvent("chatMessage", "",{255, 0, 0}, "^0[^1Factiuni^0] ^2Politie^0: ^1Te-ai echipat cu succes")

        end

        if rank == "Serif" then
            SetPedPropIndex(ped, dressings['Serif'].hat.pos, dressings['Serif'].hat.model, dressings['Serif'].hat.texture, false)
            SetPedComponentVariation(ped, dressings['Serif'].jacket.pos, dressings['Serif'].jacket.model, dressings['Serif'].jacket.texture, false)
            SetPedComponentVariation(ped, dressings['Serif'].armsgloves.pos, dressings['Serif'].armsgloves.model, dressings['Serif'].armsgloves.texture, false)
            SetPedComponentVariation(ped, dressings['Serif'].undershirt.pos, dressings['Serif'].undershirt.model, dressings['Serif'].undershirt.texture, false)
            SetPedComponentVariation(ped, dressings['Serif'].pants.pos, dressings['Serif'].pants.model, dressings['Serif'].pants.texture, false)
            SetPedComponentVariation(ped, dressings['Serif'].shoes.pos, dressings['Serif'].shoes.model, dressings['Serif'].shoes.texture, false)
            SetPedComponentVariation(ped, dressings['Serif'].vest.pos, dressings['Serif'].vest.model, dressings['Serif'].vest.texture, false)
            SetPedComponentVariation(ped, dressings['Serif'].mask.pos, dressings['Serif'].mask.model, dressings['Serif'].mask.texture, false)
            changed = true
            TriggerEvent("chatMessage", "",{255, 0, 0}, "^0[^1Factiuni^0] ^2Politie^0: ^1Te-ai echipat cu succes")

        end
    else
        --revert clothes
        local ped = PlayerPedId()
        SetPedPropIndex(ped, Old_Clothes.hat.pos, Old_Clothes.hat.model, Old_Clothes.hat.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.jacket.pos, Old_Clothes.jacket.model, Old_Clothes.jacket.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.armsgloves.pos, Old_Clothes.armsgloves.model, Old_Clothes.armsgloves.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.undershirt.pos, Old_Clothes.undershirt.model, Old_Clothes.undershirt.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.pants.pos, Old_Clothes.pants.model, Old_Clothes.pants.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.shoes.pos, Old_Clothes.shoes.model, Old_Clothes.shoes.texture, false)
        SetPedComponentVariation(ped, Old_Clothes.mask.pos, Old_Clothes.mask.model, Old_Clothes.mask.texture, false)
        changed = false
    end

end

