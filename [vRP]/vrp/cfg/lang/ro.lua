
-- define all language properties

local lang = {
  common = {
    welcome = "~w~Bine ai venit pe ~y~Server",
    no_player_near = "~r~Niciun jucator in jurul tau.",
    invalid_value = "~r~Valoare invalida.",
    invalid_name = "~r~Numa invalid.",
    not_found = "~r~Nu a fost gasit.",
    request_refused = "~r~Cerere refuzata.",
    wearing_uniform = "~r~Ai grija, porti o uniforma.",
    not_allowed = "~r~Nu este permis."
  },
  weapon = {
    pistol = "Pistol"
  },
  survival = {
    starving = "infometat",
    thirsty = "insetat"
  },
  money = {
    display = "<span class=\"symbol\"></span> {1}",
    bdisplay = "<span class=\"symbol\"></span> {1}",
    krCoins = "<span class=\"symbol\"></span> {1}",

    given = "Ai dat ~r~{1} ~w~(de) €.",
    received = "Ai primit ~g~{1} ~w~(de) €.",
    not_enough = "~r~Nu ai suficienti bani.",
    paid = "Ai platit ~r~{1} ~w~(de) €.",
    give = {
      title = "Ofera Bani",
      description = "Ofera bani celui mai apropiat jucator.",
      prompt = "Suma oferita:"
    }
  },
  inventory = {
    title = "Inventar",
    description = "Deschide inventarul.",
    iteminfo = "{1}<br><img src='nui://vrp/gui/items/{2}.png' height='70' width='70'><br/>{3}<br/><em>{4} KG</em>",
    
    info_weight = "Greutate {1}/{2} KG",
    give = {
      title = "Ofera",
      description = "Ofera obiecte celui mai apropiat jucator.",
      prompt = "Numar oferit (max {1}):",
      given = "Ai oferit ~r~{1} ~s~{2}.",
      received = "Ai primit ~g~{1} ~s~{2}.",
    },
    trash = {
      title = "Arunca",
      description = "Distruge obiectele.",
      prompt = "Obiecte de aruncat (max {1}):",
      done = "Aruncate ~r~{1} ~s~{2}."
    },
    missing = "~r~Lipsesc {2} {1}.",
    full = "~r~Inventar plin.",
    chest = {
      title = "Cufar",
      already_opened = "~r~Acest cufar este deja folosit de altcineva.",
      full = "~r~Cufar plin.",
      take = {
        title = "Scoate",
        prompt = "Numar de scos (max {1}):"
      },
      put = {
        title = "Pune",
        prompt = "Numar de pus (max {1}):"
      }
    }
  },
  business = {
    title = "Camera de comert",
    directory = {
      title = "Lista firme",
      description = "Lista firmelor.",
      dprev = ".> Prev",
      dnext = ".> Next",
      info = "<em>capital: </em>{1} (de) euro.<br /><em>proprietar: </em>{2} {3}"
    },
    info = {
      title = "Informatii Afacere",
      info = "<em>nume: </em>{1}<br /><em>capital: </em>{2} (de) euro.<br /><em>transfer capital: </em>{3} (de) euro.<br /><br/>Transferul de capital este suma de bani transferata pentru o perioada economica, maximul este capitalul afacerii."
    },
    addcapital = {
      title = "Adauga capital",
      description = "Adauga capital afacerii tale.",
      prompt = "Suma de adaugat la capital:",
      added = "~r~{1} (de) euro. ~s~adaugati la capitalul afacerii."
    },
    launder = {
      title = "Spalare de bani",
      description = "Foloseste-ti afacerea pentru a spala bani murdari.",
      prompt = "Suma de bani murdari de spalat (max {1} (de) euro): ",
      laundered = "~g~{1} (de) euro ~s~spalati.",
      not_enough = "~r~Nu ai destui bani murdari."
    },
    open = {
      title = "Deschide o afacere",
      description = "Deschide o afacere, capitalul minim este {1} (de) euro.",
      prompt_name = "Numele afacerii (nu poate fi schimbat ulterior, max {1} caractere):",
      prompt_capital = "Capital initial (min {1})",
      created = "~g~Afacere creata."

    }
  },
  cityhall = {
    title = "Primarie",
    identity = {
      title = "Identitate noua",
      description = "Creaza o identitate noua, pret = {1} (de) euro.",
      prompt_firstname = "Introdu prenumele:",
      prompt_name = "Introdu numele (de familie):",
      prompt_age = "Introdu varsta:",
    },
    menu = {
      title = "Identitate",
      info = "<em>Nume: </em>{1}<br /><em>Prenume: </em>{2}<br /><em>Varsta: </em>{3}<br /><em>Adresa: </em>{5}, {4}"
    }
  },
  police = {
    title = "Politie",
    wanted = "Grad de cautare {1}",
    not_handcuffed = "~r~Nu este incatusat",
    cloakroom = {
      title = "Vestiar",
      uniform = {
        title = "Uniforma",
        description = "Pune uniforma."
      }
    },
    pc = {
      title = "PC",
      searchreg = {
        title = "Cautare nr. inregistrare",
        description = "Cauta identitate dupa nr. inregistrare.",
        prompt = "Introdu numar inregistrare:"
      },
      closebusiness = {
        title = "Inchide afacere",
        description = "Inchide afacerea celui mai apropiat om.",
        request = "Esti sigur ca vrei sa inchizi afacerea {3} detinuta de {1} {2} ?",
        closed = "~g~Afacere inchisa."
      },
      trackveh = {
        title = "Urmareste vehiculul",
        description = "Urmareste un vehicul dupa nr. inmatriculare.",
        prompt_reg = "Introdu nr. de inmatriculare:",
        prompt_note = "Introdu motivul urmaririi:",
        tracking = "~b~Urmarirea a inceput.",
        track_failed = "~b~Urmarirea lui {1}~s~ ({2}) ~n~~r~a esuat.",
        tracked = "Urmarit {1} ({2})"
      },
      records = {
        show = {
          title = "Arata cazierul",
          description = "Arata cazierul celui mai apropiat om."
        },
        delete = {
          title = "Curata cazierul",
          description = "Curata cazierul celui mai apropiat om.",
          deleted = "~b~Cazierul curatat"
        }
      }
    },
    menu = {
      handcuff = {
        title = "Incatuseaza",
        description = "Incatuseaza/elibereaza cel mai apropiat jucator."
      },
      putinveh = {
        title = "Pune in vehicul",
        description = "Pune cel mai apropiat jucator incatusat in vehicul, ca pasager."
      },
      getoutveh = {
        title = "Scoate din vehicul",
        description = "Scoate din vehicul cel mai apropiat jucator incatusat."
      },
      askid = {
        title = "Cere buletin",
        description = "Cere buletinul celui mai apropiat jucator.",
        request = "Vrei sa arati buletinul?",
        request_hide = "Ascunde buletinul.",
        asked = "Asteapta buletinul..."
      },
      check = {
        title = "Perchezitioneaza",
        description = "Verifica banii, inventarul si armele celui mai apropiat jucator.",
        request_hide = "Ascunde rezultatele perchezitiei.",
        info = "<em>Bani: </em>{1} (de) euro<br /><br /><em>Inventar: </em>{2}<br /><br /><em>Arme: </em>{3}",
        info2 = "<em>Bani: </em>{1} (de) euro<br /><br /><em>Arme: </em>{2}",
        checked = "Ai fost perchezitionat."
      },
      seize = {
        seized = "Ai confiscat {2} ~r~{1}",
        weapons = {
          title = "Confisca armele",
          description = "Confisca armele celui mai apropiat jucator",
          seized = "~b~Armele tale au fost confiscate."
        },
        items = {
          title = "Confisca obiecte ilegale",
          description = "Confisca obiectele ilegale",
          seized = "~b~Obiectele tale ilegale au fost confiscate."
        }
      },
      jail = {
        title = "Aresteaza",
        description = "Baga/Scoate de la inchisoare cel mai apropiat jucator.",
        not_found = "~r~Nicio inchisoare gasita.",
        jailed = "~b~A fost inchis.",
        unjailed = "~b~A fost eliberat.",
        notify_jailed = "~b~Ai fost inchis.",
        notify_unjailed = "~b~Ai fost eliberat."
      },
      fine = {
        title = "Amendeaza",
        description = "Amendeaza cel mai apropiat jucator.",
        fined = "~b~Ai dat amenda ~s~{2} (de) euro pentru ~b~{1}.",
        notify_fined = "~b~Ai fost amendat ~s~ {2} (de) euro pentru ~b~{1}.",
        record = "[Amenda] {2} (de) euro pentru {1}"
      },
      store_weapons = {
        title = "Strange armele",
        description = "Strange armele in inventar."
      }
    },
    identity = {
      info = "<em>Nume: </em>{1}<br /><em>Prenume: </em>{2}<br /><em>Varsta: </em>{3}<br /><em>Afacere: </em>{4}<br /><em>Capitalul afacerii: </em>{5} (de) euro<br /><em>Adresa: </em>{7}, {6}"
    }
  },
  emergency = {
    menu = {
      revive = {
        title = "Reanimeaza",
        description = "Reanimeaza cel mai apropiat jucator.",
        not_in_coma = "~r~Nu este in coma."
      }
    }
  },
  phone = {
    title = "Telefon",
    directory = {
      title = "Contacte",
      description = "Deschide agenda telefonului.",
      add = {
        title = "> Adauga",
        prompt_number = "Adauga numarul:",
        prompt_name = "Adauga numele:",
        added = "~g~Numar salvat."
      },
      sendsms = {
        title = "Trimite SMS",
        prompt = "Introdu mesajul (max {1} caractere):",
        sent = "~g~ Trimis catre n°{1}.",
        not_sent = "~r~ n°{1} indisponibil."
      },
      sendpos = {
        title = "Trimite pozitie",
      },
      remove = {
        title = "Sterge"
      }
    },
    sms = {
      title = "Istoric SMS",
      description = "Istoricul SMS-urilor primite.",
      info = "<em>{1}</em><br /><br />{2}",
      notify = "SMS~b~ {1}:~s~ ~n~{2}"
    },
    smspos = {
      notify = "SMS-Pozitie ~b~ {1}"
    },
    service = {
      title = "Servicii",
      description = "Apeleaza la servicii sau urgente.",
      prompt = "Daca e necesar, adauga un mesaj:",
      ask_call = "Primit {1} apel by: {2}, raspunzi ? <em>{3}</em>",
      taken = "~r~Acest apel a fost preluat deja."
    },
    announce = {
      title = "Anunt",
      description = "Posteaza un anunt vizibil tuturor pentru cateva secunde.",
      item_desc = "{1} (de) euro<br /><br/>{2}",
      prompt = "Continutul anuntului (10-1000 chars): "
    }
  },
  emotes = {
    title = "Animatii",
    clear = {
      title = "> Termina",
      description = "Termina toate animatiile."
    }
  },
  home = {
    buy = {
      title = "Cumpara",
      description = "Cumpara o casa aici, pretul este {1} (de) euro.",
      bought = "~g~Cumparata.",
      full = "~r~Nu mai este loc :(.",
      have_home = "~r~Ai deja o casa."
    },
    sell = {
      title = "Vinde",
      description = "Vinde casa pentru {1} (de) euro",
      sold = "~g~Vanduta.",
      no_home = "~r~Nu este casa ta."
    },
    intercom = {
      title = "Interfon",
      description = "Foloseste interfonul pentru a intra intr-o casa.",
      prompt = "Numarul:",
      not_available = "~r~Cineva este deja in casa, asteapta.",
      refused = "~r~Cerere refuzata.",
      prompt_who = "Spune cine esti:",
      asked = "Astepti raspuns...",
      request = "Cineva vrea sa intre in casa: <em>{1}</em>"
    },
    slot = {
      leave = {
        title = "Iesi"
      },
      ejectall = {
        title = "Scoate vizitatorii",
        description = "Scoate toti vizitatorii, iesi, si incuie casa."
      }
    },
    wardrobe = {
      title = "Garderoba",
      save = {
        title = "> Salveaza",
        prompt = "Numele:"
      }
    },
    gametable = {
      title = "Masa de joc",
      bet = {
        title = "Porneste pariu",
        description = "Fa un pariu cu jucatorii de langa tine, castigatorul e ales aleatoriu.",
        prompt = "Suma pariului:",
        request = "[BET] Vrei sa pariezi {1} (de) euro ?",
        started = "~g~Pariul a inceput."
      }
    }
  },
  garage = {
    title = "Garaj ({1})",
    owned = {
      title = "Detinute",
      description = "Vehicule detinute."
    },
    buy = {
      title = "Cumpara",
      description = "Cumpara vehicule.",
      info = "{1} (de) euro<br /><br />{2}"
    },
    sell = {
      title = "Vinde",
      description = "Vinde vehicule."
    },
    rent = {
      title = "Inchiriaza",
      description = "Inchiriaza masina pana la deconectare."
    },
    store = {
      title = "Parcheaza",
      description = "Baga in garaj."
    }
  },
  vehicle = {
    title = "Vehicul",
    no_owned_near = "~r~Niciun vehicul propriu in preajma.",
    trunk = {
      title = "Portbagaj",
      description = "Deschide portbagajul."
    },
    detach_trailer = {
      title = "Detaseaza remorca",
      description = "Detaseaza remorca."
    },
    detach_towtruck = {
      title = "Detaseaza towtruck",
      description = "Detaseaza towtruck."
    },
    detach_cargobob = {
      title = "Detaseaza cargobob",
      description = "Detaseaza cargobob."
    },
    lock = {
      title = "Incuie/Descuie",
      description = "Incuie sau descuie vehiculul."
    },
    engine = {
      title = "Motor on/off",
      description = "Porneste sau opreste motorul."
    },
    asktrunk = {
      title = "Cere sa deschida portbagajul",
      asked = "~g~Asteapta...",
      request = "Vrei sa deschizi portbagajul ?"
    },
    replace = {
      title = "Repune vehiculul",
      description = "Repune cel mai apropiat vehicul pe pamant."
    },
    repair = {
      title = "Repara vehicul",
      description = "Repara cel mai apropiat vehicul."
    },
    sellTP = {
  	  title = "Vinde masina unui jucator",
	    description = "Vinde cea mai apropiata masina a ta catre un jucator."  
    } 
  },
  gunshop = {
    title = "Echipament ({1})",
    prompt_ammo = "Canitate munitie pentru {1}:",
    info = "<em>Pret: </em> {1} (de) euro<br /><em>Munitie: </em> {2} (de) euro/u<br /><br />{3}"
  },
  market = {
    title = "Magazin ({1})",
    prompt = "Cantitate de {1} de cumparat:",
    info = "<img src='nui://vrp/gui/items/{4}.png' height='70' width='70'><br />{1}<br />{2}<br /><br />Pret: <font color='red'>{3} (de) euro</font>"
  },
  skinshop = {
    title = "Magazin de haine"
  },
  cloakroom = {
    title = "Vestiar ({1})",
    undress = {
      title = "> Dezbraca-te"
    }
  },
  itemtr = {
    informer = {
      title = "Informator ilegal",
      description = "{1} (de) euro",
      bought = "~g~Pozitie marcata pe GPS."
    }
  },
  mission = {
    blip = "Misiunea ({1}) {2}/{3}",
    display = "<span class=\"name\">{1}</span> <span class=\"step\">{2}/{3}</span><br /><br />{4}",
    cancel = {
      title = "Anuleaza misiunea"
    }
  },
  aptitude = {
    title = "Abilitati",
    description = "Vezi abilitatile.",
    lose_exp = "Abilitatea ~b~{1}/{2} ~r~-{3} ~s~exp.",
    earn_exp = "Abilitatea ~b~{1}/{2} ~g~+{3} ~s~exp.",
    level_down = "Abilitatea ~b~{1}/{2} ~r~nivel pierdut ({3}).",
    level_up = "Abilitatea ~b~{1}/{2} ~g~nivel crescut ({3}).",
    display = {
      group = "{1}: ",
      aptitude = "--- {1} | EXP {2} | LVL {3} | progress {4}%"
    }
  }
}

return lang
