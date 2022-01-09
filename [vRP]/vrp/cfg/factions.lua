local cfg = {}

cfg.factions = {
	---Guvern----
	["Politia Romana"] = {
		fType = "Lege",
		fSlots = 35,
		fRanks = {
			[1] = {rank = "Cadet", salary = 1000}, 
			[2] = {rank = "Ofiter", salary = 1500}, 
			[3] = {rank = "Detectiv", salary = 2000},  
			[4] = {rank = "Serif Adjunct", salary = 3000},  
			[5] = {rank = "Serif", salary = 3500},  
			[6] = {rank = "Locotenent", salary = 5000}, 
			[7] = {rank = "Chestor Principal", salary = 10000}, 
			[8] = {rank = "Chestor General", salary = 10000}
		}
	},

	
	["Smurd"] = {
		fType = "Lege",
		fSlots = 100,
		fRanks = {
			[1] = {rank = "Asistent", salary = 800}, 
			[2] = {rank = "Paramedic", salary = 900}, 
			[3] = {rank = "Doctor Chirurg", salary = 1000},  
			[4] = {rank = "Co-Lider", salary = 1100},  
			[5] = {rank = "Lider", salary = 1200},
		}
	},

	["Taxi"] = {
		fSlots = 30,
		fType = "Stat",
		fRanks = {
			[1] = {rank = "Trainee", salary = 500}, 
			[2] = {rank = "Rookie", salary = 750},  
			[3] = {rank = "Dispatcher", salary = 1000},
			[4] = {rank = "Supervisor", salary = 2000},  
			[5] = {rank = "Company Manager", salary = 3500},
			[6] = {rank = "Company Owner", salary = 5000}
		}
	},
	
	
	--Mafii
	["Groove Street"] = {
		fSlots = 21,
		fType = "Mafie",
		coords = {75.576934814453,-1970.2274169922,21.125188827515},
        color = 46,
		fRanks = {
		    [1] = {rank = "Membru", salary = 500},
			[2] = {rank = "Tester", salary = 700},
			[3] = {rank = "Baza", salary = 800},
			[4] = {rank = "Co-Lider", salary = 1000},
			[5] = {rank = "Lider", salary = 2000}
		}
	},

	["Los Vagos"] = {
		fSlots = 12,
		fType = "Mafie",
		coords = {75.576934814453,-1970.2274169922,21.125188827515},
        color = 46,
		fRanks = {
		    [1] = {rank = "Membru", salary = 500},
			[2] = {rank = "Tester", salary = 700},
			[3] = {rank = "Baza", salary = 800},
			[4] = {rank = "Co-Lider", salary = 1000},
			[5] = {rank = "Lider", salary = 2000}
		}
	},



	["KMN Gang"] = {
		fSlots = 21,
		fType = "Mafie",
		coords = {-3028.6284179688,73.328544616699,12.902225494385},
        color = 46,
		fRanks = {
		    [1] = {rank = "Azet", salary = 5000},
			[2] = {rank = "Nash", salary = 5000},
			[3] = {rank = "O.G.", salary = 5000},
			[4] = {rank = "Capi", salary = 5000},
			[5] = {rank = "Zuna", salary = 5000}
		}
	},

	["Y.A.D"] = {
		fSlots = 12,
		fType = "Mafie",
		coords = {0,0,0},
        color = 46,
		fRanks = {
		    [1] = {rank = "Membru", salary = 200},
			[2] = {rank = "Tester", salary = 200},
			[3] = {rank = "Baza", salary = 500},
			[4] = {rank = "Colider", salary = 500},
			[5] = {rank = "Lider", salary = 700}
		},
	},
	["Crips Gang"] = {
		fSlots = 8,
		fType = "Gang",
		coords = {0,0,0},
        color = 46,
		fRanks = {
		    [1] = {rank = "Membru", salary = 100},
			[2] = {rank = "Tester", salary = 200},
			[3] = {rank = "Colider", salary = 500},
			[5] = {rank = "Lider", salary = 500}
		},
	}


}
return cfg