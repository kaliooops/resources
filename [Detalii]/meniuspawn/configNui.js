var configs = {
    theme: {
        "primary_color": "#0cc7c4",
        "secondary_color": "#0cc7c4"
    },
    jobs: [
        // Whitelisted jobs
        {
            "title": "PUBG Cayo Perico",
            "shortDescription": "Te poti juca PUBG pe Cayo Perico!",
            "description": "Este un sistem nou creat la sugestia unui jucator, te poti juca PUBG pe insula folosind comanda /pubg",
            "group": "",
            "whitelisted": true,
            "iconName": "pubg.png",
            requirements: ["Scrie (/pubg) pentru a intra in lobby.", "Meciul incepe cand in lobby se afla minim 6 playeri.","Poti pune waypoint unde vrei sa te spawnezi la inceputul meciului.","Cauta crate-urile cu arme/medicamente/armuri.", "Pentru a iesi din lobby folosesti comanda (/leavepubg)"]
        },
        {
            "title": "Pet Shop",
            "shortDescription": "Cumpara un catelus de la Pet Shop!",
            "description": "Daca vrei un animal de companie, poti achizitiona unul de la magazinul de animalute din Sandy, (k>GPS>PetShop)",
            "group": "",
            "whitelisted": true,
            "iconName": "pets.png",
            requirements: ["Cumpara pet de la magazinul de animale.","Acceseaza meniul animalutului de pe tasta [F8]","Cumpara mancare pentru animalut de la magazinul alimentar."]
        },
        // Unwhitelisted jobs
        {
            "title": "Patroni",
            "shortDescription": "Poti devenii patron la un job.",
            "description": "In orasul k2 ai posibilitatea de a achizitiona un loc de munca unde playerii is vor asigura un venit sigur!",
            "group": "",
            "whitelisted": false,
            "iconName": "afaceri.png",
            requirements: ["Ca patron ai urmatoarele beneficii:", "Primesti 10% din castigul muncitorilor", "Ai posibilitatea de a spala bani murdari fara limita", "Patronul se poate obtine doar de pe Shop k2 (vezi discord)."]
        },
        {
            "title": "Afaceri",
            "shortDescription": "Poti detine o afacere la cheie.",
            "description": "Pentru a spala bani murdari ai nevoie de o afacere propriuzisa, mai jos ai o lista cu toate din oras (incluzand beneficiile lor)",
            "group": "",
            "whitelisted": false,
            "iconName": "afaceri.png",
            requirements: ["2 NightCluburi care iti ofera posibilitatea de a spala bani cu un capital initial de 200.000€ + primesti banii pe biletele platite de oamenii care intra in club", "Sediu CEO iti ofera un interior dragut unde iti poti desfasura activitatea + posibilitatea de a spala bani cu un capital initial de 150.000€", "Depozitul mic iti ofera posibilitatea de a depozita pana la 1.000KG + posibilitatea de a spala bani cu un capital initial de 50.000€", "Depozitul mare iti permite sa depozitezi pana la 5.000KG + posibilitatea de a spala bani cu un capital initial de 100.000€","Pentru inceput poti achizitiona un birou care iti ofera doar posibilitatea de a spala bani, iar capitalul initial este de 0€", "Afacerile sunt marcate pe harta cu o cheita aurie."]
        },
        {
            "title": "Inchirieri Auto",
            "shortDescription": "Poti inchiria o masina scumpa.",
            "description": "Sa infiintat o parcare de inchirieri auto in spate la Tequila-La de unde poti inchiria o masina la alegere (pretul este incasat o data la un minut)",
            "group": "",
            "whitelisted": false,
            "iconName": "rent.png",
            requirements: ["Parcul de inchirieri auto este marcat pe harta cu o [masina rosie]."]
        },

        {
            "title": "Job Center",
            "shortDescription": "Daca ai nevoie de bani, angajeaza-te.",
            "description": "In orasul k2 avem cele mai unice locuri de munca, viziteaza [Job Center] pentru a te angaja.(k>GPS>[Job Center], sau /jobs)",
            "group": "",
            "whitelisted": false,
            "iconName": "rent.png",
            requirements: ["Bodyguard (trebuie sa pazesti clubul Tequila)", "Constructor (Lucrezi pe santierul din Los Santos)", "Aprovizionari (Trebuie sa livrezi marfa la magazine)", "Car Dealer (Furi masini de lux pentru a le vinde, ai nevoie de 10 ore si un pistol)", "Drug Dealer (Livrezi droguri obtinute de la Mafioti/Doctori)", "Spargator de Case (Furi lucruri din case, apoi le vinzi la amanet)"]
        },

    ]
}