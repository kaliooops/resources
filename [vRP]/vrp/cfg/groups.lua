
local cfg = {}

-- define each group with a set of permissions
-- _config property:
--- gtype (optional): used to have only one group with the same gtype per player (example: a job gtype to only have one job)
--- onspawn (optional): function(player) (called when the player spawn with the group)
--- onjoin (optional): function(player) (called when the player join the group)
--- onleave (optional): function(player) (called when the player leave the group)
--- (you have direct access to vRP and vRPclient, the tunnel to client, in the config callbacks)

cfg.groups = {
  ["sponsors"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{"Te-ai logat ca ~b~~h~Sponsor"}) end},   
	  "emergency.revive"  
  },
  ["vip"] = {
    _config = {onspawn = function(player) vRPclient.notify(player,{"Te-ai logat ca ~b~~p~V.I.P"}) end},
    "vip.chat"
  },  
  ["youtuber"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{"Te-ai logat cu gradul de ~u~You~r~Tuber."}) end},
		"player.phone"
  },

  ["silver"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{"Ai pachetul de arme SILVER"}) end},
		"player.phone"
  },

  ["gold"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{"Ai pachetul de arme GOLD"}) end},
		"player.phone"
  },

  ["diamond"] = {
		_config = {onspawn = function(player) vRPclient.notify(player,{"Ai pachetul de arme DIAMOND"}) end},
		"player.phone"
  },
  
  -- the group user is auto added to all logged players
  ["user"] = {
    "player.phone",
    "player.calladmin",
    "player.askid",
    "player.skip_coma",
    "police.seizable"	-- can be seized
  },
  ["onduty"] = {
    _config = {onspawn = function(player) vRPclient.notify(player,{"Ai grija, esti ~g~ON ~w~Duty"}) end},
    "police.heist"
  },

  ["Avocat"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Esti avocat, esti cineva."}) end
	},
    "avocat.service"
  },

  ["smurd"] = {
    _config = { gtype = "job",
    onspawn = function(player) vRPclient.notify(player,{""}) end
    },
    "emergency.revive",
    "emergency.shop",
    "smurd.service",
    "emergency.cloakroom",
    "emscheck.revive",
    "emergency.vehicle",
    "emergency.market",
    "ems.whitelisted",
    "ems.loadshop",
    "asistent.paycheck",
  },

  ["Creator"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Poti creea case"}) end},
  },
  ["Afacerist"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Poti creea afaceri"}) end},
  },
  ["Constructor"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Esti un Constructor."}) end
	},
	  "mission.builder.home",
    "mission.builder.strong",
	  "build.market"
  },
  ["Mecanic"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Esti Mecanic"}) end
	},
    "vehicle.repair",
    "vehicle.replace",
    "repair.service",
	  "mission.repair.satellite_dishes",
	  "mission.repair.wind_turbines",
	  "repair.vehicle",
	  "repair.market"
  },
  ["Taxi"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Esti Taximetrist"}) end
	},
    "uber.service",
	  "uber.vehicle",
  	"uber.mission"
  },
  ["Somer"] = {
    _config = { gtype = "job",
	onspawn = function(player) vRPclient.notify(player,{"Esti Somer"}) end},
  },
}

cfg.users = {
  [1] = { -- give superadmin and admin group to the first created user on the database
    "user"
  }
}

-- group selectors
-- _config
--- x,y,z, blipid, blipcolor, permissions (optional)

cfg.selectors = {
  ["Grade Joburi"] = {
    _config = {x = 0, y = 0, z = -100, blipcolor = 205}, -- -545.06488037109,-217.89282226562,37.649826049805
    "Somer",
    "Constructor",
   }
}

return cfg
