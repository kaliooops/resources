Config = {

    License = 'QvE1aXznQzP4ZHiXTZKRm7H4R8Q7cfWDFeBmgiM0sbQ', -- Insert your rcore license
    NotificationDistance = 10.0,
    PropsToRemove = {
        vector3(1992.803, 3047.312, 46.22865),
    },

    --[[
        -- To use custom notifications, implement client event handler, example:

        AddEventHandler('rcore_pool:notification', function(serverId, message)
            print(serverId, message)
        end)
    ]]
    CustomNotifications = false,

    --[[
        -- To use custom menu, implement following client handlers
        AddEventHandler('rcore_pool:openMenu', function()
            -- open menu with your system
        end)

        AddEventHandler('rcore_pool:closeMenu', function()
            -- close menu, player has walked far from table
        end)


        -- After selecting game type, trigger one of the following setupTable events
        TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_8_BALL')
        TriggerEvent('rcore_pool:setupTable', 'BALL_SETUP_STRAIGHT_POOL')
    ]]
    CustomMenu = false,

    --[[
        When you want your players to pay to play pool, set this to true
        AND implement the following server handler in your framework of choice.
        The handler MUST deduct money from the player and then CALL the callback
        if the payment is successful, or inform the player of payment failure.

        This script itself DOES NOT implement ESX/vRP logic, you have to do that yourself.

        AddEventHandler('rcore_pool:payForPool', function(playerServerId, cb)
            print("This should be replaced by deducting money from " .. playerServerId)
            cb() -- successfuly set balls on table
        end)
    ]]
    PayForSettingBalls = false,
    BallSetupCost = nil, -- for example: "$1" or "$200" - any text

    --[[
        You can integrate pool cue into your system with

        SERVERSIDE HANDLERS
            - rcore_pool:onReturnCue - called when player takes cue
            - rcore_pool:onTakeCue   - called when player returns cue

        CLIENTSIDE EVENTS
            - rcore_pool:takeCue   - forces player to take cue in hand
            - rcore_pool:removeCue - removes cue from player's hand

        This prevents players from taking cue from cue rack if `false`
    ]]
    AllowTakePoolCueFromStand = true,

    --[[
        This option is for servers whose anticheats prevents
        this script from setting players invisible.

        When player's ped is blocking camera when aiming,
        set this to true
    ]]
    DoNotRotateAroundTableWhenAiming = false,

    MenuColor = {255, 0, 0},
    Keys = {
        BACK = {code = 200, label = 'INPUT_FRONTEND_PAUSE_ALTERNATE'},
        ENTER = {code = 38, label = 'INPUT_PICKUP'},
        SETUP_MODIFIER = {code = 21, label = 'INPUT_SPRINT'},
        CUE_HIT = {code = 179, label = 'INPUT_CELLPHONE_EXTRA_OPTION'},
        CUE_LEFT = {code = 174, label = 'INPUT_CELLPHONE_LEFT'},
        CUE_RIGHT = {code = 175, label = 'INPUT_CELLPHONE_RIGHT'},
        AIM_SLOWER = {code = 21, label = 'INPUT_SPRINT'},
        BALL_IN_HAND = {code = 29, label = 'INPUT_SPECIAL_ABILITY_SECONDARY'},

        BALL_IN_HAND_LEFT = {code = 174, label = 'INPUT_CELLPHONE_LEFT'},
        BALL_IN_HAND_RIGHT = {code = 175, label = 'INPUT_CELLPHONE_RIGHT'},
        BALL_IN_HAND_UP = {code = 172, label = 'INPUT_CELLPHONE_UP'},
        BALL_IN_HAND_DOWN = {code = 173, label = 'INPUT_CELLPHONE_DOWN'},
    },
    Text = {
        BACK = "Spate",
        HIT = "Loveste",
        BALL_IN_HAND = "Minge-In-Mana",
        BALL_IN_HAND_BACK = "Spate",
        AIM_LEFT = "Tinteaza spre stanga",
        AIM_RIGHT = "Tinteaza spre dreapta",
        AIM_SLOWER = "Tinteaza mai usor",

        POOL = 'Biliard',
        POOL_GAME = 'Joc de biliard',
        POOL_SUBMENU = 'Selecteaza configuratia bilei',
        TYPE_8_BALL = '8-Ball',
        TYPE_STRAIGHT = 'Biliard Drept',

        HINT_SETUP = 'Fa masa',
        HINT_TAKE_CUE = 'Ia un tac de biliard',
        HINT_RETURN_CUE = 'Pune inapoi tacul ',
        HINT_HINT_TAKE_CUE = 'Ca sa joci Biliard, ia un tac de la stand.',
        HINT_PLAY = 'Joaca',

        BALL_IN_HAND_LEFT = 'Stanga',
        BALL_IN_HAND_RIGHT = 'Dreapta',
        BALL_IN_HAND_UP = 'Sus',
        BALL_IN_HAND_DOWN = 'Jos',
        BALL_POCKETED = 'Bila %s a fost pusa in buzunar.',
        BALL_IN_HAND_NOTIFY = 'Jucatorul a luat bila in mana.',
        BALL_LABELS = {
            [-1] = 'Tac',
            [1] = '~y~Solid 1~r~',
            [2] = '~b~Solid 2~r~',
            [3] = '~r~Solid 3~r~',
            [4] = '~p~Solid 4~r~',
            [5] = '~o~Solid 5~r~',
            [6] = '~g~Solid 6~r~',
            [7] = '~r~Solid 7~r~',
            [8] = 'Solid Negru 8',
            [9] = '~y~Dungi 9~r~',
            [10] = '~b~Dungi 10~r~',
            [11] = '~r~Dungi 11~r~',
            [12] = '~p~Dungi 12~r~',
            [13] = '~o~Dungi 13~r~',
            [14] = '~g~Dungi 14~r~',
            [15] = '~r~Dungi 15~r~',
         }
    },
}

--   Citizen.CreateThread(function()
--     local blip = AddBlipForCoord(-1595.92578125,-989.53930664062,13.075116157532)
--     SetBlipSprite(blip, 509)
--     SetBlipScale(blip, 0.8)
--     SetBlipColour(blip, 0)
--     SetBlipAsShortRange(blip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentString("BILIARD")
--     EndTextCommandSetBlipName(blip)
--   end)