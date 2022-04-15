--import all vrp related

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")


cfg = {
    ['Politia Romana'] = {
        ['Cadet'] = 2500,
        ['Ofiter'] = 4000,
        ['Detectiv'] = 5500,
        ['Serif Adjunct'] = 7000,
        ['Serif'] = 8500,
        ['Locotenent'] = 10000,
        ['Chestor Principal'] = 11500,
        ['Chestor General'] = 13000,
    },

    ['Smurd'] = {
        ['Asistent'] = 3000,
        ['Paramedic'] = 4500,
        ['Doctor Chirurg'] = 6000,
        ['Co-Lider'] = 7500,
        ['Lider'] = 9000,
    },

    ['Taxi'] = {
        ['Trainee'] = 1000,
        ['Rookie'] = 2000,
        ['Dispatcher'] = 3000,
        ['Supervisor'] = 4000,
        ['Company Manager'] = 5000,
        ['Company Owner'] = 6000,
    },

    ['KMN Gang'] = {
        ['Azet'] = 1000,
        ['Nash'] = 1000,
        ['O.G.']= 1000,
        ['Capi'] = 1000,
        ['Zuna'] = 1000,
    },

    ['Bloods'] = {
        ['Membru'] = 200,
        ['Tester'] = 400,
        ['Baza'] = 700,
        ['Colider'] = 800,
        ['Lider']= 1000,
    },

    ['Clanu` Tiganilor'] = {
        ['Membru'] = 200,
        ['Tester'] = 400,
        ['Baza'] = 700,
        ['Colider'] = 800,
        ['Lider']= 1000,
    },
    

    ['Crips'] = {
        ['Membru'] = 200,
        ['Tester'] = 400,
        ['Baza'] = 700,
        ['Colider'] = 800,
        ['Lider']= 1000,
    },

    ['Los Vagos'] = {
        ['Soldat'] = 100,
        ['Sergent'] = 100,
        ['Sergent Avansat'] = 200,
        ['Contra Capitan'] = 300,
        ['Capitan de brigata']= 500,
    },

    ['Ballas'] = {
        ['Membru'] = 100,
        ['Tester'] = 100,
        ['Baza'] = 200,
        ['Colider'] = 300,
        ['Lider']= 500,
    },
}

CreateThread(function()
    while true do     
        for _, p in pairs( vRP.getUsers() ) do
            local user_id = vRP.getUserId({p})

            for fname, ftable in pairs(cfg) do -- for each faction
                if vRP.isUserInFaction({user_id, fname}) then -- check if the user is in the faction
                    local rank = vRP.getFactionRank({user_id, fname}) -- get the rank of the user in the faction
                    for frank, rankpay in pairs(ftable) do -- for each rank
                        if frank == rank then -- if the rank is the same as the user's rank
                            vRP.giveMoney({user_id, rankpay}) -- give the user the salary
                            TriggerClientEvent("toasty:Notify", p, {type = "info", title="Payday", message = "Ai primit " .. rankpay  .. "$"})
                        end
                    end
                end
            end
        
        end
        Wait(1800000)
    end
end)
