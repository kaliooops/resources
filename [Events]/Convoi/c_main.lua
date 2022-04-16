kraneUtility = module(Classes_Config.resource_name, "classes/c_kraneUtility")
kranePed = module(Classes_Config.resource_name, "classes/c_kranePED")
kraneVeh = module(Classes_Config.resource_name, "classes/c_kraneVehicle")
kraneObject = module(Classes_Config.resource_name, "classes/c_kraneObject")


soundlink = "https://www.youtube.com/watch?v=7VUGr0QSIX8"

local xSound = exports.xsound

function start_event()
    print("started")
    main_veh = kraneVeh.new()
    main_ped = kranePed.new()

    start_x, start_y, start_z = Main_Vehicle.start_pos.x, Main_Vehicle.start_pos.y, Main_Vehicle.start_pos.z
    main_veh:Create_Me(start_x, start_y, start_z, 0, "infernus", false)

    
    scnd_x, scnd_y, scnd_z = Main_Vehicle.second_pos.x, Main_Vehicle.second_pos.y, Main_Vehicle.second_pos.z
    main_ped:Create_Me(0,0,0, 0, "s_m_y_cop_01", false)
    SetPedIntoVehicle(main_ped.ped, main_veh.veh, -1)
    Wait(3000)
    main_ped:Drive_To_Coords(scnd_x, scnd_y, scnd_z)

    CreateThread(function()
        while true do
            Wait(1000)
            x,y,z = table.unpack(GetEntityCoords(main_ped.ped))
            utility.setRoute(x,y,z) -- rgb optional
            print(x,y,z)
        end
    end)
    print("ended")
end

CreateThread(function()

    start_event()
end)
-- local started = false
-- CreateThread(function()
--     while true do
--         Wait(1000)
--         if GetClockHours() == 18 then
--             if not started then
--                 started = true
--                 start_event()
--             end
--         else
--             if started then
--                 started = false
--             end
--         end
--     end
-- end)

RegisterCommand("event", function()
    start_event()
end, false)