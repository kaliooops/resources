
local cfg = {}

-- minimum capital to open a business
cfg.minimum_capital = 1

-- capital transfer reset interval in minutes
-- default: reset every 24h
cfg.transfer_reset_interval = 1440

-- commerce chamber {blipid,blipcolor}
cfg.blip = {} 

-- positions of commerce chambers
cfg.commerce_chambers = {
	{-1911.4100341797,-572.93243408203,19.097215652466},  --Birou Plaja
	{390.82907104492,269.80429077148,94.991004943848}, --NightClub GTA
	{1049.0548095703,-3100.673828125,-38.999954223633}, --Depozit
	{994.57690429688,-3100.021484375,-38.995853424072}, --DepozitMare
	{223.76760864258,-1599.7541503906,-181.08294677734},
	{-1371.2712402344,-464.07504272461,72.046356201172},
	{-125.82186126709,-642.80932617188,168.8246307373},
	{-1554.8768310547,-576.07690429688,108.53788757324},
	{-80.063262939453,-800.47802734375,243.39007568359},
}

return cfg
