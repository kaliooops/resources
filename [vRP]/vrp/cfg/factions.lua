local cfg = {}

cfg.factions = {
	---Guvern----
	["Politia Romana"] = {
		fType = "Lege",
		fSlots = 35,
		fRanks = {
			[1] = {rank = "Cadet", salary = 2500}, 
			[2] = {rank = "Ofiter", salary = 4000}, 
			[3] = {rank = "Detectiv", salary = 5500},  
			[4] = {rank = "Serif Adjunct", salary = 7000},  
			[5] = {rank = "Serif", salary = 8500},  
			[6] = {rank = "Locotenent", salary = 10000}, 
			[7] = {rank = "Chestor Principal", salary = 11500}, 
			[8] = {rank = "Chestor General", salary = 13000}
		}
	},

	
	["Smurd"] = {
		fType = "Lege",
		fSlots = 100,
		fRanks = {
			[1] = {rank = "Asistent", salary = 3000}, 
			[2] = {rank = "Paramedic", salary = 4500}, 
			[3] = {rank = "Doctor Chirurg", salary = 6000},  
			[4] = {rank = "Co-Lider", salary = 7500},  
			[5] = {rank = "Lider", salary = 9000},
		}
	},

	["Taxi"] = {
		fSlots = 30,
		fType = "Stat",
		fRanks = {
			[1] = {rank = "Trainee", salary = 1000}, 
			[2] = {rank = "Rookie", salary = 2000},  
			[3] = {rank = "Dispatcher", salary = 3000},
			[4] = {rank = "Supervisor", salary = 4000},  
			[5] = {rank = "Company Manager", salary = 5000},
			[6] = {rank = "Company Owner", salary = 6000}
		}
	},
	
	
	--Mafii

	["Bloods"] = {
		fSlots = 21,
		fType = "Mafie",
		coords = {-1545.4847412109,-399.5793762207,41.98770904541},
        color = 32,
		fRanks = {
		    [1] = {rank = "Membru", salary = 200},
			[2] = {rank = "Tester", salary = 400},
			[3] = {rank = "Baza", salary = 600},
			[4] = {rank = "Co-Lider", salary = 800},
			[5] = {rank = "Lider", salary = 1000}
		}
	},

	["Ballas"] = {
		fSlots = 21,
		fType = "Mafie",
		coords = {-1545.4847412109,-399.5793762207,41.98770904541},
        color = 32,
		fRanks = {
		    [1] = {rank = "Membru", salary = 200},
			[2] = {rank = "Tester", salary = 400},
			[3] = {rank = "Baza", salary = 600},
			[4] = {rank = "Co-Lider", salary = 800},
			[5] = {rank = "Lider", salary = 1000}
		}
	},

    ["Clanu` Tiganilor"] = {
		fSlots = 21,
		fType = "Mafie",
		coords = {-1545.4847412109,-399.5793762207,41.98770904541},
        color = 32,
		fRanks = {
		    [1] = {rank = "Membru", salary = 200},
			[2] = {rank = "Tester", salary = 400},
			[3] = {rank = "Baza", salary = 600},
			[4] = {rank = "Co-Lider", salary = 800},
			[5] = {rank = "Lider", salary = 1000}
		}
	},

	["Crips"] = {
		fSlots = 11,
		fType = "Mafie",
		coords = {-588.44738769532,529.81256103516,108.01602935792},
        color = 32,
		fRanks = {
		    [1] = {rank = "Membru", salary = 200},
			[2] = {rank = "Tester", salary = 400},
			[3] = {rank = "Baza", salary = 600},
			[4] = {rank = "Co-Lider", salary = 800},
			[5] = {rank = "Lider", salary = 1000}
		}
	},

	["Los Vagos"] = {
		fSlots = 12,
		fType = "Mafie",
		coords = {-1545.4847412109,-399.5793762207,41.98770904541},
        color = 29,
		fRanks = {
		    [1] = {rank = "Soldat", salary = 100},
			[2] = {rank = "Sergent", salary = 100},
			[3] = {rank = "Sergent Avansat", salary = 200},
			[4] = {rank = "Contra Capitan", salary = 300},
			[5] = {rank = "Capitan de brigata", salary = 500}
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


}
return cfg