utility = module(Classes_Config.resource_name, "classes/c_kraneUtility")
kranePed = module(Classes_Config.resource_name, "classes/c_kranePED")
kraneVeh = module(Classes_Config.resource_name, "classes/c_kraneVehicle")
RemovePedFromGroup(PlayerPedId())
songs = {
    "https://www.youtube.com/watch?v=B07sWjiO758",
    "https://www.youtube.com/watch?v=QYZ8J8aEdXE",
    "https://www.youtube.com/watch?v=lqLOv72BU0M",  
    "https://www.youtube.com/watch?v=oyPq7sh4-TE",
    "https://www.youtube.com/watch?v=Vzo-q-gTI4c",
    "https://www.youtube.com/watch?v=0p6n10oRLwc",
    "https://www.youtube.com/watch?v=NNVb5J6FVQM",
    "https://www.youtube.com/watch?v=LvBaFejrTIM",
    "https://www.youtube.com/watch?v=zTIBlbUutNY",
    "https://www.youtube.com/watch?v=bZC2kQNfYz0",
    
}
local xSound = exports.xsound
xSound:Destroy("ganglife")

function playnewsong()
    rsong = songs[math.random(#songs)]
    if not xSound:soundExists("ganglife") then
        xSound:PlayUrlPos("ganglife", tostring(rsong), 0.2, vector3(-444.11743164062,6221.0537109375,43.101253509521), false)            
        xSound:Distance("ganglife", 100)
    end

    if xSound:getMaxDuration("ganglife") - xSound:getTimeStamp("ganglife") < 5 then
        xSound:PlayUrlPos("ganglife", tostring(rsong), 0.2, vector3(-444.11743164062,6221.0537109375,43.101253509521), false)
        xSound:Distance("ganglife", 100)
    end

end

gangsters = {}

last_free_weed = 0
CreateThread(function()
    Wait(1000)
    local xSound = exports.xsound
    
    CreateThread(function()
        while true do
            Wait(1000)
            playnewsong()
        end
    end)

    car = kraneVeh.new()
    car:Create_Me(-439.97650146484,6225.1689453125,29.676321029663, 226.67, "1016urus")
    car:Open_Front_Doors()
    car:Turn_On_Engine()
    car:Turn_On_Headlights()

    car_gangster1 = kranePed.new()
    car_gangster2 = kranePed.new()

    car_gangster1:Create_Me(-439.00860595703,6221.90234375,28.684734344482, 284.84, "g_m_y_azteca_01")
    car_gangster2:Create_Me(-438.18, 6223.12, 28.73, 193.09, "g_m_y_armgoon_02")


    car_gangster1:Idle()
    car_gangster2:Idle("WORLD_HUMAN_DRUG_DEALER")

    car_gangster1:Set_Name_And_Responsability("Juan", "Pendejo")
    car_gangster2:Set_Name_And_Responsability("Pedro", "Pendejo")


    femeia_lu_cardealer = kranePed.new()
    femeia_lu_cardealer:Create_Me(-450.56729125977,6223.4604492188,28.553405761719, 238.55, "g_f_y_ballas_01")
    femeia_lu_cardealer:Set_Name_And_Responsability("Karla", "Prostituata")
    femeia_lu_cardealer:Play_Animation("switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", true)

    SetPedComponentVariation(femeia_lu_cardealer.ped, 4, 3, 0, 0)

    grill_gangster = kranePed.new()
    grill_gangster2 = kranePed.new()
    grill_gangster3 = kranePed.new()
    grill_gangster4 = kranePed.new()
    grill_gangster5 = kranePed.new()

    girl_dancing = kranePed.new()
    girl_dancing2 = kranePed.new()
    
    girl2_dancing_partner = kranePed.new()
    
    girl2_dancing_partner:Create_Me(-447.28, 6214.76, 28.52, 159.19, "s_m_y_cop_01")
    girl2_dancing_partner:Set_Name_And_Responsability("Karlos", "Politist Corupt")
    girl2_dancing_partner:Play_Animation("anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", true)
    

    girl_dancing:Create_Me(-449.8359375,6212.3564453125,29.424325942993, 106.18, "g_f_y_lost_01")
    girl_dancing:Set_Name_And_Responsability("Mika", "Dansatoare")
    girl_dancing:Play_Animation("anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", true)

    girl_dancing2:Create_Me(-447.69790649414,6213.5415039062,29.460544586182, 0.0, "g_f_y_ballas_01")
    girl_dancing2:Set_Name_And_Responsability("Ale", "Zdreanta")
    girl_dancing2:Play_Animation("anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", true)


    grill_gangster:Create_Me(-452.39, 6213.36, 28.0, 263.32, "g_m_m_chigoon_02")
    grill_gangster:Set_Name_And_Responsability("Andreas", "Cop Killer")
    grill_gangster:Idle("WORLD_HUMAN_DRINKING")

    grill_gangster2:Create_Me(-449.51, 6214.04, 28.43, 133.59, "g_m_m_korboss_01")
    grill_gangster2:Set_Name_And_Responsability("Marko", "Bank Robber")
    grill_gangster2:Idle("WORLD_HUMAN_DRUG_DEALER")

    grill_gangster3:Create_Me(-448.80, 6211.2, 28.47, 41.80, "g_m_m_mexboss_01")
    grill_gangster3:Set_Name_And_Responsability("Murda", "Bank Robber")
    grill_gangster3:Idle("WORLD_HUMAN_PARTYING")

    grill_gangster4:Create_Me(-450.6, 6210.28, 28.42, 0.28, "g_m_y_famdnf_01")
    grill_gangster4:Set_Name_And_Responsability("Unchiu", "Drug Dealelr")
    grill_gangster4:Idle("WORLD_HUMAN_SMOKING_CLUBHOUSE")

    grill_gangster5:Create_Me(-451.32, 6211.90, 28.38, 283.62, "g_m_y_korean_02")
    grill_gangster5:Set_Name_And_Responsability("Krampus", "Dresor de lei si fraieri") 
    grill_gangster5:Idle("WORLD_HUMAN_MUSCLE_FLEX")

    table.insert(gangsters, car_gangster1)
    table.insert(gangsters, car_gangster2)
    table.insert(gangsters, grill_gangster)
    table.insert(gangsters, grill_gangster2)
    table.insert(gangsters, grill_gangster3)
    table.insert(gangsters, grill_gangster4)
    table.insert(gangsters, grill_gangster5)

    for _, gangster in pairs(gangsters) do
        gangster:Listen_Interactions(function()
            gangster:Bro_Hug()
            gangster:Set_Friendly(PlayerPedId())
            
        
            if last_free_weed == 0 then
                Wait(3000)
                gangster:Trade(function()
                    TriggerServerEvent("bro:GiveSomeWeed")
                end)
                last_free_weed = 1
            end
            Wait(5000)
            gangster:Idle(gangster.idle_animation)
        end)

        gangster:Give_Weapon("WEAPON_PISTOL")
        gangster:Speak("nice car")
        gangster:Aggresive_Response()

        for __, g2 in pairs(gangsters) do
            if g2 ~= gangster then
                gangster:Set_Friendly(g2.ped)
            end
        end        
    end

    for _, g1 in pairs(gangsters) do
        for __, g2 in pairs(gangsters) do
            g1:Set_Neutral(PlayerPedId())
        end
    end


    catel = kranePed.new()
    catel:Create_Me(-437.76773071289,6217.8090820312,29.642839431763, 0.0, "a_c_rottweiler")
    catel:Set_Name_And_Responsability("Machitoru", "Caine")
    CreateThread(function()
        steps = 0
        while true do
            steps = steps + 1
            Wait(3000)
            x,y,z = table.unpack(utility.Get_Random_Coords_Around_Entity(catel.ped, 10))
            catel:Move_To(x,y,z)
            if steps > 5 then
                steps = 0
                x,y,z = -437.76773071289,6217.8090820312,29.642839431763
                catel:Move_To(x,y,z)
                Wait(10000)
            end
        end
    end)
end)
