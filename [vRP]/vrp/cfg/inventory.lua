
local cfg = {}

cfg.inventory_weight_per_strength = 15 -- weight for an user inventory per strength level (no unit, but thinking in "kg" is a good norm)

-- default chest weight for vehicle trunks
cfg.default_vehicle_chest_weight = 50

-- define vehicle chest weight by model in lower case
cfg.vehicle_chest_weights = {
  ["s65amg"] = 65,
  ["rtr"] = 80,
  ["rmodveneno"] = 95,
  ["fenyr"] = 110,
  ["a8fsi"] = 125,
  ["ktkzr"] = 140,
  ["p1gtr"] = 155,
  ["lex570"] = 170,
  ["p1"] = 185,
  ["e92"] = 200,
  ["felon"] = 215,
  ["contgt13"] = 230
}

return cfg
