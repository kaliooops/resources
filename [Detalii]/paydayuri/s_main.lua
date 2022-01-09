--import all vrp related

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")


cfg = {
    ['Politia Romana'] = {
        ['Cadet'] = 1000,
        ['Ofiter'] = 1500,
        ['Detectiv'] = 2000,
        ['Serif Adjunct'] = 3000,
        ['Serif'] = 3500,
        ['Locotenent'] = 5000,
        ['Chestor Principal'] = 10000,
        ['Chestor General'] = 10000,
    },

    ['Smurd'] = {
        ['Asistent'] = 1000,
        ['Paramedic'] = 2000,
        ['Doctor Chirurg'] = 3000,
        ['Co-Lider'] = 4000,
        ['Lider'] = 5000,
    },

    ['Taxi'] = {
        ['Trainee'] = 500,
        ['Rookie'] = 700,
        ['Dispatcher'] = 1000,
        ['Supervisor'] = 1500,
        ['Company Manager'] = 2000,
        ['Company Owner'] = 2000,
    },

    ['KMN Gang'] = {
        ['Azet'] = 1000,
        ['Nash'] = 1000,
        ['O.G.']= 1000,
        ['Capi'] = 1000,
        ['Zuna'] = 1000,
    },

    ['Groove Street'] = {
        ['Membru'] = 200,
        ['Tester'] = 400,
        ['Baza'] = 700,
        ['Colider'] = 1000,
        ['Lider']= 1000,
    },

    ['Los Vagos'] = {
        ['Membru'] = 200,
        ['Tester'] = 400,
        ['Baza'] = 700,
        ['Colider'] = 1000,
        ['Lider']= 2500,
    },

    ['Y.A.D'] = {
        ['Membru'] = 200,
        ['Tester'] = 400,
        ['Baza'] = 700,
        ['Colider'] = 1000,
        ['Lider']= 1000,
    },
    ['Gloria Gang'] = {
        ['Membru'] = 100,
        ['Tester'] = 150,
        ['Lider']= 500,
        ['Colider'] = 220,
    }
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
