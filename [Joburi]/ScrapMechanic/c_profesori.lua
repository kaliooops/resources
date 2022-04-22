-- kraneUtility = module(Classes_Config.resource_name, "classes/c_kraneUtility")
-- kranePed = module(Classes_Config.resource_name, "classes/c_kranePED")
-- kraneVeh = module(Classes_Config.resource_name, "classes/c_kraneVehicle")
-- kraneObject = module(Classes_Config.resource_name, "classes/c_kraneObject")


-- already_explaiend = false

-- CreateThread(function()
--     Wait(1000)

--     Mustang = kraneVeh.new()
--     Mustang:Create_Me(-423.81832885742,-1684.8599853516,18.02908706665, 152.89, "infernus", false)
--     Mustang:Freeze()
-- end)

-- CreateThread(function()
--     Wait(1000)

--     Paul = kranePed.new()
--     Paul:Create_Me(-423.14163208008,-1687.0505371094,18.029066085815, 221.97, "s_m_y_cop_01", false)
--     Paul:Set_Name_And_Responsability("Paul", "Sofer de Curse")
--     Paul:Idle()
--     Paul:Ignore_World()
--     Paul:Generic_NPC()
--     Paul:Freeze()
--     Paul:Listen_Interactions(function()
--         if not already_explaiend then
--             Paul:Speak("meet")
--             Paul:Simulate_Talk({
--                 "Salut, uite, asta e masina mea!",
--                 "Iti place? Am construit-o chiar eu.",
--                 "Nu a fost usor, dar merita,",
--                 "Masina prinde 200km/h in 10 secunde.",
--                 "Iti pot face si tie una.",
--                 "Ai nevoie de niste piese anume.",
--                 "Oricum, in orasul acesta sunt multi mecanici",
--                 "Toti au cate o masina facuta de ei",
--                 "Daca ii gasesti le poti cere sa iti faca una",
--             })
--             already_explaiend = true
--             else
--                 TriggerServerEvent("Paul:openMenu", "Paul")
--         end
--     end)
-- end)

-- --if vRP.getInventoryItemAmount({user_id,"aphone"}) >= 1 then