
document.getElementById("panou_main").style.display = 'none';
document.getElementById("informatii").style.display = 'none';
document.getElementById("pagina_informativ").style.display = 'none';

function ce_job_sa_fac() {
    let data = {
        Title: 'Ce job sa fac?',
        Description: `
        <div class="pas"><p class="pas-pointer"><> </p><p class="pas-text"> <b>Pescarul</b> este un job bun de inceput</p> </div>
        <div class="pas"><p class="pas-pointer">-> </p><p class="pas-text"> Trebuie sa vorbesti cu Angajatorul de la Job Center</p> </div>
        <div class="pas"><p class="pas-pointer">-> </p><p class="pas-text"> Sa-l vizitezi pe Mircea (Pescarul Satului)</p> </div>
        <div class="pas"><p class="pas-pointer">-> </p><p class="pas-text"> Vei avea o discutie cu el si iti va explica tot ce ai nevoie sa stii</p> </div>
        <div class="pas"><p class="pas-pointer">-> </p><p class="pas-text"> Vei primi de asemenea o undita si un sonar pe care le poti folosi din inventar (alt)</p> </div>
        <br/>

        <div class="pas"><p class="pas-pointer">* </p><p class="pas-text"> Sunt mai multe joburi care merita incercate</p> </div>
        <div class="pas"><p class="pas-pointer"><> </p><p class="pas-text"> <b>Vanatorul</b> este un job la fel de bun de inceput</p> </div>
        <div class="pas"><p class="pas-pointer">-> </p><p class="pas-text"> Primesti arme pentru a vana</p> </div>
        <div class="pas"><p class="pas-pointer">-> </p><p class="pas-text"> Esti pe munte, in natura</p> </div>
        <div class="pas"><p class="pas-pointer">-> </p><p class="pas-text"> O sa ai un ATV cu care te plimbi pe munte</p> </div>
        `,
    }
    //fade out
    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';


    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;
}

function primele_10_minute() {
    let data = {
        Title: 'Primele 10 minute',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> In roleplay conteaza foarte mult sa ai un start bun.</p> </div>
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Pentru inceput ar trebuii sa iti explorezi variantele.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Joburi poti gasii la Job Center <u>[/jobs]</u>, dar unele sunt ascunse </p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Sistemele de jocuri le gasesti in panou la rubrica de sisteme, iti recomand <u>[/pubg]</u> </p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Poti gasii un motor de inchiriat in parcarea din fata primariei, banii se iau pe minut si poti da <u>[/dv]</u> dupa ce ai terminat sa-l folosesti</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Pe acest server roleplay-ul se apreciaza, incearca sa-ti faci prieteni, vei putea face multe lucruri cu ei ca de exemplu jobul de: <u>Hot de Masini</u>, in care te vei impusca cu boti in scopul de a fura masini impreuna cu prietenii tai</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Pentru a intelege economia, aici $100.000 inseamna multi bani, si armele se vand la pretul de $5.000 majoritatea armelor grele</p> </div>

        `
    }
    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}

function arme_si_ilegalitati() {
    let data = {
        Title: 'Arme si ilegalitati',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Aceste 2 lucruri sunt o parte importanta pentru noi. </p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Armele se pot procura de la mafioti sau de la jobul de <u>Weapons Dealer</u>. </p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Daca vrei sa jefuiesti un player, nu uita sa o faci conform regulamentului.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Ilegalitatile se pot face de la ora <u>20:00</u>, dar exista exceptii.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Este recomandat sa eviti scoterea armelor in zone publice, pentru a nu atrage asupra ta atentia.</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;
}

function pubg() {
    let data = {
        Title: 'PUBG',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Unul dintre cele mai interactive sisteme. </p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Folosind comanda [/pubg] te vei spawna in lobby pe insula Cayo Perico. </p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Cand in lobby se afla mai mult de 6 persoane porneste o numaratoare inversa de la 60 secunde. </p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Cand numaratoarea se termina vei fi spawnat intr-un punct random pe insula. </p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Scopul tau este sa cauti crateuri asemanatoare celui de mai jos: </p> </div>
        <center><img width="250px" height="250px" alt="crate pubg" src="img/cratepubg.png"></center>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Din crate vei primii arme si/sau munitie pe care le vei putea echipa folosind inventarul de pe <u>alt</u>. </p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Trebuie sa supravietuiesti pana la sfarsit, daca vei castiga primesti $3.000 </p> </div>
        
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}

function race() {
    let data = {
        Title: 'Race',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Curse ilegale, cu sistem de lobby si plata.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Folosind comanda <u>[/race]</u>, vei putea crea un lobby in care iti poti invita prietenii si poti seta o suma pe care vei paria.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Sunt 5 curse in 3 zone diferite in care te poti intrece  </p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> In meniu trebuie sa selectezi zona in care va avea parte cursa, apoi cursa in sine, cand harta se va incercuii cu verde cursa este pregatita.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Odata ce ai pregatit tot, trebuie doar sa inchizi meniul apasand tasta [ESC] si un waypoint va fi setat in zona cursei.</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}

function carMusic() {
    let data = {
        Title: 'Car Music',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Muzica din masina sponsorului</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Sponsorii au acces la comanda <u>[/cm]</u> pentru a pune muzica ce se aude din masina lor personala (sau in cea in care a urcat ultima data)</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Comenzi: <ul>
        <li>[/cmvolume 0.0-1.0] pentru a seta volumul</li>
        <li>[/cmstop]pentru a opri muzica</li>                                                                                    
        <li>[/cm link_youtube] pentru a pune muzica de pe youtube</li>                                                                                    
        
        </ul></p> </div>
        
        `
    }
    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;
}


function CarDelivery() {
    let data = {
        Title: 'Hot de Masini',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Pentru a te angaja ca Hot de Masini ai nevoie de o arma si 10 ore.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Afla in oras unde se afla locatia acestui Job.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Vei primii mesaje cu locatii in care se afla masini foarte scumpe</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Scopul este sa furi masinile ca mai apoi sa i le vinzi lui [Giany Versace].</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Pentru a ajunge la masina trebuie sa omori un numar de Inamici care te vor ataca cu pistoale.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Poti face aceasta misiune in echipa, numarul de Inamici se multiplica in functie de numarul de playeri care sunt cu tine, lafel si suma de bani castigati.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Inamicii se spawneaza cand te aflii la o distanta de 100m.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Daca vrei sa faci misiunea impreuna cu alti playeri, acestia trebuie sa se afle in apropierea ta cand inamicii se spawneaza.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Poti seta nivelul de dificultate prin comanda (/cd_dificulty nivel), nivelul este intre 1 si 3.</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}
function Pescar() {
    let data = {
        Title: 'Pescar',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Te poti angaja ca Pescar vorbind cu angajatorul de la Job Center, acesta te va trimite la Mircea, Pescarul satului Paleto Bay.[/jobs]</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Vei avea o discutie cu Mircea, el iti va explica tot ce trebuie sa stii.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Acesta iti va oferii uneltele necesare pentru a pescuii (Sonar si Undita).</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Dupa ce ai facut rost de unelte, mergi la pontonul din Los Santos pentru a lua o barca.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Foloseste sonarul pentru a vedea la ce adancime te aflii si ce rase de pesti poti prinde la adancimea respectiva.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Cand esti la adancimea corecta foloseste undita pentru a pescui (apasa click cand ai undita in mana).</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Dupa ce ai terminat de pescuit, mergi inapoi la Pescarul satului Paleto Bay pentru a vinde pestele.</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}
function Vanator() {
    let data = {
        Title: 'Vanator',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Vanatorul poate fi facut oricand fara a fi nevoit sa demisionezi de la locul de munca actual</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Mergi la Job Center pentru a vorbii cu Vanatorul, Acesta te va indruma inspre locatia unde se afla echipamentul.[/jobs]</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Odata ajuns la locatie, vei primii un Musket, un cutit, si un ATW pentru a calatorii pe munte.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Caprioarele vor aparea pe harta ca niste X-uri rosii.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Dupa ce ucizi o caprioara foloseste cutitul pentru a colecta Carne si Piele.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Cand nu mai vrei sa vanezi, mergi inapoi la locatia pentru echipament si mai apasa odata pe E pentru a incheia sesiunea de vanatoare.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Mergi la [Abator] pentru a vinde produsele obtinute (Cutia alba din Paleto).</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}
function Spargator_de_Case() {
    let data = {
        Title: 'Spargator de Case',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Spargatorul de case poate fi facut oricand fara a fi nevoit sa demisionezi de la locul de munca actual.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Mergi la [Dacian], vanzatorul magazinului (Rolex) si vorbeste cu acesta.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> El iti va oferii 2 lockpick-uri si iti va nota pe GPS un Waypoint catre o casa.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Foloseste lockpick-ul pentru a intra in casa.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Cauta toate dulapurile care contin obiecte pretioase si lasa-le la intrare.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Cand ai strans toate obiectele pretioase la intrare, le poti duce inapoi la [Dacian], acesta iti va oferi o suma de bani.</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}
function Aprovizionari() {
    let data = {
        Title: 'Aprovizionari',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Te poti angaja la Aprovizionari vorbind cu angajatorul de la Job Center.[/jobs]</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Dupa ce te-ai angajat, mergi la sediu pentru a te schimba de haine folosind vestiarul.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Dupa ce te-ai imbracat, vorbeste cu patronul de la sediu pentru a incepe munca.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Vei primii o masina cu care va trebuii sa livrezi marfa la diferite magazine.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Cand nu mai vrei sa lucrezi du-te si raporteaza patronului de la sediu, apoi schimba-te la vestiar.</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}
function Demolari() {
    let data = {
        Title: 'Demolari',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Te poti angaja la Demolari vorbind cu angajatorul de la Job Center.[/jobs]</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Dupa ce te-ai angajat, mergi la sediu pentru a te schimba de haine folosind vestiarul.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Dupa ce te-ai imbracat, vorbeste cu patronul de la sediu pentru a incepe munca.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Vei primii o masina cu care va trebuii sa mergi la diferite lucrari.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Cand nu mai vrei sa lucrezi du-te si raporteaza patronului de la sediu, apoi schimba-te la vestiar.</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}
function BodyGuard() {
    let data = {
        Title: 'BodyGuard',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Te poti angaja ca BodyGuard vorbind cu angajatorul de la Job Center.[/jobs]</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Dupa ce te-ai angajat, mergi la casino, pe dreapta dupa intrare este echipamentul (un baston si un teaser).</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Daca te-ai echipat trebuie sa pazesti perimetrul Casino-ului.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Cat timp esti in perimetrul Casino-ului vei primii bani.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Daca pleci fara sa lasi echipamentul vei primii 2.000E penalizare!!</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Daca iti dai disconnect cu echipamentul pe tine vei primii automat 20cp Jail pentru tentativa de Bug Abuse!!!</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}
function Chimist() {
    let data = {
        Title: 'Chimist',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Locatia laboratorului trebuie aflata IC.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Dupa ce termini toate sarcinile din laborator vei primii chimicale.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Chimicalele sunt de 3 feluri (Speed, MDMA, Cristal).</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Chimicalele pot fi vandute unui Traficant de Droguri.</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}
function Traficant_de_Droguri() {
    let data = {
        Title: 'Traficant de Droguri',
        Description: `
        <div class="pas"><p class="pas-pointer">*</p><p class="pas-text"> Traficantul livreaza droguri in diferite locatii de pe harta</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Pentru a te angaja ca traficant mergi la pastiluta de pe harta</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Poti face rost de droguri de la mafioti.</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Poti procura (Speed, MDMA, Cristal, Purple Haze, Lemon Haze, Kush, Scooby Snaks, Jamaika, Bonzai).</p> </div>
        <div class="pas"><p class="pas-pointer">></p><p class="pas-text"> Pentru ca traficul sa fie profitabil este bine sa transporti toate substantele.</p> </div>
        `
    }

    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'block';
    document.getElementById("informatii_title").innerHTML = data.Title;
    document.getElementById("informatii_descriere").innerHTML = data.Description;

}

addEventListener("message", function (event) {
    var item = event.data
    if (item.open == true) {
        openMenu();
    }
    if (item.open == false) {
        closeMenu();
    }
});

addEventListener("keydown", function (event) {
    if (event.key == "Escape") {
        fetch(`https://${GetParentResourceName()}/closemenu`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                itemId: 'lol'
            })
        }).then(resp => resp.json()).then(resp => console.log(resp));
    }
});

addEventListener('click', function (event) {
    if (event.target.id == "btnInapoi") {
        document.getElementById("panou_main").style.display = 'block';
        document.getElementById("informatii").style.display = 'none';
    }
    if (event.target.id == 'ce_job_sa_fac') {
        ce_job_sa_fac();
    }
    if (event.target.id == 'primele_10_minute') {
        primele_10_minute();
    }
    if (event.target.id == 'arme_si_ilegalitati') {
        arme_si_ilegalitati();
    }
    if (event.target.id == 'pubg') {
        pubg();
    }
    if (event.target.id == 'race') {
        race();
    }
    if (event.target.id == "carMusic") {
        carMusic();
    }
    if (event.target.id == "car_delivery") {
        CarDelivery()
    }
    if (event.target.id == "Pescar") {
        Pescar()
    }
    if (event.target.id == "Vanator") {
        Vanator()
    }
    if (event.target.id == "Spargator_de_Case") {
        Spargator_de_Case()
    }
    if (event.target.id == "Aprovizionari") {
        Aprovizionari()
    }
    if (event.target.id == "Demolari") {
        Demolari()
    }
    if (event.target.id == "BodyGuard") {
        BodyGuard()
    }
    if (event.target.id == "Chimist") {
        Chimist()
    }
    if (event.target.id == "Traficant_de_Droguri") {
        Traficant_de_Droguri()
    }
    
});


function openMenu() {
    document.getElementById("panou_main").style.display = 'block';
    document.getElementById("informatii").style.display = 'none';
    document.getElementById("pagina_informativ").style.display = 'block';
}

function closeMenu() {
    document.getElementById("panou_main").style.display = 'none';
    document.getElementById("informatii").style.display = 'none';
    document.getElementById("pagina_informativ").style.display = 'none';        
}