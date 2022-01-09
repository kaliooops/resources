local CreateThread = Citizen.CreateThread
local isPressed = IsDisabledControlJustPressed

local function Draw3DText123(x,y,z, text,font,scl)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local scale = scl or 0.5
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
local config = { 
    -- ['Casino'] = {
    --     posJoin = vector3(935.11743164063,46.733543395996,81.095756530762),
    --     posLeave = vector3(2468.9240722656,-287.49111938477,-58.267490386963)
    -- }, -- Casino
    ['Casa Cayo'] = {
        posJoin = vector3(4981.5122070312,-5709.6904296875,19.886943817139),
        posLeave = vector3(4990.1606445312,-5717.5512695312,19.880201339722)
    }, -- Cayo Perico Mansion
    ["Club"] = {
        posJoin = vector3(-1388.37109375,-586.78924560547,30.2181224823),
        posLeave = vector3(-1394.2359619141,-596.32763671875,30.319561004639)
    },  
    ['Lift'] = {
        posJoin = vector3(136.17347717286,-761.71496582032,45.752040863038),
        posLeave = vector3(115.21756744384,-741.29388427734,258.15209960938)
    }, -- Lift
    ['Spital'] = {
        posLeave = vector3(251.70481872559,-1366.5817871094,39.534374237061),
        posJoin = vector3(-497.97027587891,-335.70068359375,34.501731872559)
    } -- Spital
}

CreateThread(function()
    local ticks = 500
    while true do
        ped = PlayerPedId()
        coords = GetEntityCoords(ped)
        for i,v in pairs(config) do
            --print(#(GetEntityCoords(ped) - v.posJoin)) [[ debug pentru distanta dintre vectori ]]
            distanceJoin = #(coords - v.posJoin) 
            distanceLeave = #(coords - v.posLeave)
            if distanceJoin < 1.0 then
                ticks = 1
                Draw3DText123(v.posJoin[1], v.posJoin[2], v.posJoin[3], 'Apasa ~g~E~w~ pentru a intra in ~r~'..i,0,0.4) 
                DrawMarker(1, v.posJoin[1], v.posJoin[2], v.posJoin[3]-1.3, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255,255,255, 200, 0, 0, 2, 0, 0, 0, 0)
                if isPressed(0,38) then
                    SetEntityCoords(ped,v.posLeave)
                end
            elseif distanceLeave < 1.0 then
                ticks = 1
                Draw3DText123(v.posLeave[1], v.posLeave[2], v.posLeave[3], 'Apasa ~g~E~w~ pentru a iesii din ~r~'..i,0,0.4) 
                DrawMarker(1, v.posLeave[1], v.posLeave[2], v.posLeave[3]-1.3, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255,255,255, 200, 0, 0, 2, 0, 0, 0, 0)
                if isPressed(0,38) then
                    SetEntityCoords(ped,v.posJoin)
                end
            end
        end
        Wait(ticks)
        ticks = 500
    end
end)