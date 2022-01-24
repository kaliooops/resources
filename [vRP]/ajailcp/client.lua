vRPbm = {}
Tunnel.bindInterface("vRP_basic_menu", vRPbm)
vRPserver = Tunnel.getInterface("vRP", "vRP_basic_menu")
HKserver = Tunnel.getInterface("vrp_hotkeys", "vRP_basic_menu")
BMserver = Tunnel.getInterface("vRP_basic_menu", "vRP_basic_menu")
vRP = Proxy.getInterface("vRP")

checkpoints = 0
aJailReason = " "

function text_drawTxt(text, font, centre, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

local frozen = false
local unfrozen = false
local freeze = false
function vRPbm.loadFreeze(freeze)
    freeze = not freeze
    frozen = true
end

function vRPbm.setInAJail(jailTime, jailReason)
    aJailReason = jailReason
    checkpoints = jailTime
end
local quests = {
    leafblower = {pos = vector3(2042.5650634766,2836.2014160156,50.281497955322), anim = "WORLD_HUMAN_GARDENER_LEAF_BLOWER", active = false},
    sapaliga = {pos = vector3(2047.5006103516,2848.8566894531,49.618061065674), anim = "WORLD_HUMAN_GARDENER_PLANT", active = false},
    hammer = {pos = vector3(2048.2194824219,2842.7924804688,49.508934020996), anim = "WORLD_HUMAN_PUSH_UPS", active = false},
    situps = {pos = vector3(2032.9693603516,2829.2446289062,50.30615234375), anim = "WORLD_HUMAN_SIT_UPS", active = false},
    Weights = {pos = vector3(2054.0124511719,2846.3071289062,49.598670959473), anim = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS", active = false},
    Pushups = {pos = vector3(2069.2905273438,2842.3234863281,49.724613189697), anim = "WORLD_HUMAN_PUSH_UPS", active = false},
    Jogging = {pos = vector3(2054.6105957031,2851.6325683594,49.702239990234), anim = "WORLD_HUMAN_JOG_STANDING", active = false},
    drill = {pos = vector3(2050.4045410156,2844.6833496094,49.438919067383), anim = "WORLD_HUMAN_CONST_DRILL", active = false}

}

function start(task)
    vRP.playAnim({false, {task = task.anim}, false})
    SetTimeout(12000, function()
        vRP.stopAnim({false})
        task.active = true
        checkpoints = checkpoints - 1
        BMserver.updateCheckpoints({checkpoints})
        SetTimeout(1000 * 10, function()task.active = false; end)
    end)
end




Citizen.CreateThread(function()
    local waittime = 1000    
    while true do
        Wait(waittime)
        while (checkpoints > 0) do
            Wait(waittime)
            local playerPos = nil
            local px, py, pz = nil,nil,nil
            for k, v in pairs(quests) do
                local once = false;
                while not v.active and checkpoints > 0 do 
                    local playerPos = GetEntityCoords(PlayerPedId(), true)
                    local px, py, pz = playerPos.x, playerPos.y, playerPos.z
                    Wait(10)
                    SetEntityHealth(PlayerPedId(), 200)
                    DisableControlAction(0, 21, true)
                    DisableControlAction(0, 22, true)
                    DisableControlAction(0, 24, true)
                    DisableControlAction(0, 25, true)
                    DisableControlAction(0, 47, true)
                    DisableControlAction(0, 58, true)
                    DisableControlAction(0, 263, true)
                    DisableControlAction(0, 264, true)
                    DisableControlAction(0, 257, true)
                    DisableControlAction(0, 140, true)
                    DisableControlAction(0, 141, true)
                    DisableControlAction(0, 142, true)
                    DisableControlAction(0, 143, true)
                    DisableControlAction(0, 75, true)
                    DisableControlAction(27, 75, true)
                    text_drawTxt("Checkpoint-uri ramase: " .. checkpoints, 1, 1, 0.5, 0.8, 0.65, 255, 255, 255, 255)
                    text_drawTxt("Motiv: " .. aJailReason, 1, 1, 0.5, 0.85, 0.55, 255, 255, 255, 255)
                    local playerPos = GetEntityCoords(PlayerPedId(), true)
                    DrawMarker(2, v.pos, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.7, 255, 0, 0, 90, 1, 0, 0, 0)
                    if #(playerPos - v.pos) <= 1.0 and not once  then 
                        once = true
                        start(v)
                    end
                    if (GetDistanceBetweenCoords(2050.4045410156,2844.6833496094,49.438919067383, px, py, pz, true) > 100.0) then
                        SetEntityCoords(PlayerPedId(), 2050.4045410156,2844.6833496094,49.438919067383)
                    end
                end
            end
            
        end
    end
end)

AddEventHandler("playerSpawned", function()-- delay state recording
    state_ready = false
    
    Citizen.CreateThread(function()
        Citizen.Wait(30000)
        state_ready = true
    end)
end)

