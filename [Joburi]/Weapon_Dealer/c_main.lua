
Formule_De_Salut = {
    function() return "Salut, uite despre ce e vorba..." end,
    function() return "Fii atent, am primit o informatie..." end,
    function() return "Tu ma stii pe mine, mereu am cate o combinatie" end,
    function() return "Am auzit azi pe statie, se vorbea despre..." end,
    function() return "Curand o sa fie un transport urias..." end,
}

Formule_De_Criterii = {
    function() return "Ai nevoie de 1 pachet cu explozibil pentru a deschide usa cutiei blindate" end,
    function() return "Usa cutiei este bine aparata, si ai nevoie de un explozibil sa o spargi" end,
    function() return "Vei sparge o cutie, trebuie sa te asigur ca-ti iei la tine un explozibil" end,
    function() return "Explozibilul este obligatoriu pentru misiunea asta" end,
        
}

Formule_De_Informatii = {
    function() return "Alarma o sa fie pornita cand se misca cutia, asa ca vei fi atacat" end,
    function() return "Asigura-te ca ai un pistol la tine, pentru ca o sa fie scandal" end,
    function() return "Este un risc foarte mare sa patrunzi acolo, ai nevoie de un pistol" end,
    function() return "Armele trebuiesc aici, fara el nu ai sanse la misiunea asta" end,
    
}

Formule_De_Inchiere = {
    function() return "Ti-am notat pe GPS locatia de la urmatorul transport de arme" end,
    function() return "Sper ca ai primit locatia, acolo v-a fi urmatorul transport" end,
    function() return "Daca ai GPS ul pornit, ai sa vezi locatia" end,
    function() return "Sa fie intr-un ceas bun, poftim locatia" end,

}


isDealer = false
location_assigned = nil
my_crate = nil
is_planted = false

RegisterNetEvent("Weapon_Dealer:IsDealer")
AddEventHandler("Weapon_Dealer:IsDealer", function(hasDealer)
    isDealer = hasDealer
end)


finished = false
hasExplosive = nil
RegisterNetEvent("Weapon_Dealer:Has_Explosive")
AddEventHandler("Weapon_Dealer:Has_Explosive", function(has)
    hasExplosive = has
end)
CreateThread(function()
    ped = spawn_local_npc(Angajator.x, Angajator.y, Angajator.z, "s_m_m_armoured_02", Angajator.heading, "WORLD_HUMAN_SMOKING")

    CreateThread(function()
        while true do
            Wait(1000)
            while Vdist(GetEntityCoords(ped), GetEntityCoords(PlayerPedId())) < 5.0 do
                Wait(0)
                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent("Weapon_Dealer:IsDealer")
                    TriggerEvent("toasty:Notify", {type="info", title="Verificam", message="Verificam daca esti dealer..."})
                    Wait(3500)
                    print("isdealer " .. tostring(isDealer))
                    if isDealer then
                        location_assigned = possible_spawns[math.random(1, #possible_spawns)]
                        print(location_assigned)
                        setRoute(location_assigned.x, location_assigned.y, location_assigned.z)
                        my_crate = spawn_net_object(location_assigned.x, location_assigned.y, location_assigned.z, "ex_prop_crate_closed_bc", location_assigned.heading)
                        finished = false
                        talk(ped, Formule_De_Salut[math.random(1, #Formule_De_Salut)]())
                        talk(ped, Formule_De_Criterii[math.random(1, #Formule_De_Criterii)]())
                        talk(ped, Formule_De_Informatii[math.random(1, #Formule_De_Informatii)]())
                        talk(ped, Formule_De_Inchiere[math.random(1, #Formule_De_Inchiere)]())
                    end
                end
            end
        end
    end)
end)

CreateThread(function()
    while true do
        Wait(1000)
        if location_assigned then
            while Vdist(GetEntityCoords(PlayerPedId()), location_assigned.x, location_assigned.y, location_assigned.z) < 5.0 do
                Wait(0)
                if not is_planted then
                    k_draw3DText(location_assigned.x, location_assigned.y, location_assigned.z, "~r~[E]~w~ pentru a planta explozibil")
                end
                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent("Weapon_Dealer:Has_Explosive")
                    ExecuteCommand("me cauta explozibilul")
                    FreezeEntityPosition(PlayerPedId(), true)
                    Wait(5000)
                    FreezeEntityPosition(PlayerPedId(), false)
                    if hasExplosive then
                        if not is_planted then
                            Handle_Bombs_And_Replace_Box(my_crate, location_assigned.lname)          
                        end
                        is_planted = true
                    else
                        TriggerEvent("toasty:Notify", {type="error",title="Explozibil", message="Nu ai explozibil"})
                    end
                end
            end
            
            if is_planted and finished then
                is_planted = false
                location_assigned = nil
                finished = false
                my_crate = nil
            end
        end
    end
end)