local State = "Iesire"

local inafara = vector3(-1467.7224121094,-387.52474975586,38.767654418946)

CreateThread(function()
    while true do
        Citizen.Wait(1000)
        while Vdist(GetEntityCoords(PlayerPedId()), inafara) < 15 do
            Citizen.Wait(0)
            k_draw3DText(inafara.x,inafara.y,inafara.z+0.6, "[~g~E~w~] " .. "Pentru a intra")
            DrawMarker(1, inafara.x, inafara.y, inafara.z-1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 166, 22, 22, 200, 0, 0, 2, 0, 0, 0, 0)
            if IsControlJustPressed(1, 51) then
                Enter_Meta()
            end
        end
    end
end)

CreateThread(function()
    while true do 
        Wait(1000)
        while Vdist(GetEntityCoords(PlayerPedId()), Center_Room.x, Center_Room.y, Center_Room.z) < 70 do
            Wait(0)
            for name, coords in pairs(Work_Points) do
                local dist = Vdist(GetEntityCoords(PlayerPedId()), coords.x, coords.y, coords.z) 
                if dist < 10 then
                    DrawMarker(1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 30, 30, 170, 230, false, true, 2, false, false, false, false)
                    if dist < 2 then
                        k_draw3DText(coords.x,coords.y,coords.z+1.5, "[~g~E~w~] " .. name)
                        if IsControlJustPressed(1, 51) then
                            if ExecuteNewState(State, name) then
                                if name == "Ia produsele" then
                                    State = "Iesire"
                                else
                                    State = name
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

local jerry_can = nil
local drug_package = nil
local product_box = nil
function ExecuteNewState(current_State, want_state)

    if want_state == "Iesire" then
        Exit_Meta()
        return true
    end

    print("Current State: " .. current_State .. " Want State: " .. want_state)

    if current_State == "Iesire" then
        if want_state ~= "Ia cutia" then
            TriggerEvent("toasty:Notify", {type="error", title="[Metamfetamina]", message="Ia cutia de jos si pune-o pe masa"})
        else
            Ia_Cutia()
            return true
        end
    end 

    if current_State == "Ia cutia"  then
        if want_state ~= "Masa de lucru" then
            TriggerEvent("toasty:Notify", {type="error", title="[Metamfetamina]", message="Aseaza cutia la masa de lucru!"})
        else
            local props = Masa_De_Lucru()
            jerry_can = props.jerry_can
            drug_package = props.drug_package
            prepared = true
            return true
        end
    end 

    if current_State == "Masa de lucru" then
        if want_state ~= "Toarna Chimicale" then
            TriggerEvent("toasty:Notify", {type="error", title="[Metamfetamina]", message="Toarna chimicalele!"})
        else
            Toarna_Chimicale(jerry_can)
            return true
        end
    end

    if current_State == "Toarna Chimicale" then
        if want_state ~= "Apasa pe buton" then
            TriggerEvent("toasty:Notify", {type="error", title="[Metamfetamina]", message="Apasa pe buton!"})    
        else
            product_box = Apasa_Pe_Buton()
            return true
        end
    end 

    if current_State == "Apasa pe buton" then
        if want_state ~= "Ia produsele" then
            TriggerEvent("toasty:Notify", {type="error", title="[Metamfetamina]", message="Ia produsele!"})    
        else
            Ia_Produsele(product_box)
            return true
        end
    end
    return false
end
