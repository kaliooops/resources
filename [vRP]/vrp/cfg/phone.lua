
local cfg = {}

-- size of the sms history
cfg.sms_history = 15

-- maximum size of an sms
cfg.sms_size = 500

-- duration of a sms position marker (in seconds)
cfg.smspos_duration = 300

-- define phone services
-- blipid, blipcolor (customize alert blip)
-- alert_time (alert blip display duration in seconds)
-- alert_permission (permission required to receive the alert)
-- alert_notify (notification received when an alert is sent)
-- notify (notification when sending an alert)
cfg.services = {
  ["Politie"] = {
    blipid = 304,
    blipcolor = 38,
    alert_time = 30, -- 5 minutes
    alert_permission = "police.service",
    alert_notify = "~r~Alerta:~n~~s~",
    notify = "~b~Ai sunat la Politie !",
    answer_notify = "~b~Un echipaj de Politie este pe drum !"
  },
  ["Smurd"] = {
    blipid = 153,
    blipcolor = 1,
    alert_time = 30, -- 5 minutes
    alert_permission = "emergency.service",
    alert_notify = "~r~Alerta:~n~~s~",
    notify = "~b~Ai suna la Smurd !",
    answer_notify = "~b~Un echipaj de Smurd este pe drum !"
  },
  ["Taxi"] = {
    blipid = 153,
    blipcolor = 1,
    alert_time = 30, -- 5 minutes
    alert_permission = "taxi.service",
    alert_notify = "~r~Alerta:~n~~s~",
    notify = "~b~Ai suna la Taxi !",
    answer_notify = "~b~Un Taxi este pe drum !"
  },
  
}

-- define phone announces
-- image: background image for the announce (800x150 px)
-- price: amount to pay to post the announce
-- description (optional)
-- permission (optional): permission required to post the announce
cfg.announces = {
  ["Anunt in Ziar"] = {
    --image = "nui://vrp_mod/announce_commercial.png",
    image = "https://i.imgur.com/62yekgw.png",
    description = "Anunta ceva in ziar.",
    price = 30
  },
}

return cfg
