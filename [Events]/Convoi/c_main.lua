kraneUtility = module(Classes_Config.resource_name, "classes/c_kraneUtility")
kranePed = module(Classes_Config.resource_name, "classes/c_kranePED")
kraneVeh = module(Classes_Config.resource_name, "classes/c_kraneVehicle")
kraneObject = module(Classes_Config.resource_name, "classes/c_kraneObject")


soundlink = "https://www.youtube.com/watch?v=7VUGr0QSIX8"

local xSound = exports.xsound
started = false
main_ped = nil
main_veh = nil

function start_event()
    main_veh = kraneVeh.new()
    main_ped = kranePed.new()

    start_x, start_y, start_z = Main_Vehicle.start_pos.x, Main_Vehicle.start_pos.y, Main_Vehicle.start_pos.z
    main_veh:Create_Me(start_x, start_y, start_z, 0, "fbi2", true)

    
    scnd_x, scnd_y, scnd_z = Main_Vehicle.second_pos.x, Main_Vehicle.second_pos.y, Main_Vehicle.second_pos.z
    main_ped:Create_Me(0,0,0, 0, "s_m_y_cop_01", true)
    main_ped:Give_Weapon("WEAPON_ASSAULTRIFLE")
    main_ped:Equip_Weapon()
    SetPedIntoVehicle(main_ped.ped, main_veh.veh, -1)

    for i=0,6 do
        __ped = kranePed.new()
        __ped:Create_Me(0,0,0, 0, "s_m_y_cop_01", true)
        __ped:Give_Weapon("WEAPON_ASSAULTRIFLE")
        __ped:Equip_Weapon()
        SetPedIntoVehicle(__ped.ped, main_veh.veh, i)
    end

    Wait(3000)
    main_ped:Drive_To_Coords(scnd_x, scnd_y, scnd_z)
    CreateThread(function()
        while started do
            Wait(1000)
            -- if is close to the sncd pos end event
        end
    end)
end


RegisterNetEvent("CONVOI:Follow")
AddEventHandler("CONVOI:Follow", function()
    while not started do Wait(5000) end
    while started do
        Wait(1000)
        utility.Destory_Generic_Follow_Blip()
        x,y,z = table.unpack(GetEntityCoords(main_ped.ped))
        utility.Generic_Follow_Blip(x,y,z) -- rgb optional
    end
end)

RegisterNetEvent("CONVOI:START")
AddEventHandler("CONVOI:START", function()
    started = true
    start_event()
end)