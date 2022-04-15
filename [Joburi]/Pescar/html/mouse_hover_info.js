// on div hover, display text at mouse pointer

document.getElementById("sonarimg").onmouseover = function () {
    document.getElementById("manual_text").innerHTML =
        `
        <div class="tab_data">
            <p class="tab_info_prefix">> </p>
            <p class="tab_info">Apasa pentru a folosi sonarul</p>
        </div>
    `;
};

document.getElementById("sonartitle").onmouseover = function () {
    document.getElementById("manual_text").innerHTML =
        `
        <div class="tab_data">
            <p class="tab_info_prefix">> </p>
            <p class="tab_info">Sonarul este folosit pentru a prelua informatiile din mare si sa fie prezentate digital</p>
        </div>
        <div class="tab_data">
            <p class="tab_info_prefix">> </p>
            <p class="tab_info">Adancimea maxima reperata de sonar este de aprox. -300 metri</p>
        </div>
        <div class="tab_data">
            <p class="tab_info_prefix">> </p>
            <p class="tab_info">Rasele de pesti cunoscute de sonar sunt: Platica, Somn, Caras, Pui de Rechin, Rechin Bolnav, Pui de Balena</p>
        </div>
        
    `;
};

/* detect mouse wheel movement without scroll */
document.addEventListener('wheel', function(e) {
    if (e.deltaY > 0) {
        var adancime_valoare = document.getElementById("adancime_valoare");
        adancime_valoare.innerText = parseInt(adancime_valoare.innerText) + 1;
    }
    if (e.deltaY < 0) {
        var adancime_valoare = document.getElementById("adancime_valoare");
        adancime_valoare.innerText = parseInt(adancime_valoare.innerText) - 1;
    }
    
    
});

document.getElementById("adancime_grup").onmouseover = function () {
    let v = document.getElementById("adancime_valoare").innerText

    possible_fishes = []
    if ( v <= -15) {
        possible_fishes.push("Platica")
        possible_fishes.push("Somn")
    }
    if ( v <= -50) {
        possible_fishes.push("Caras")
        possible_fishes.push("Pui de Rechin")
       
    }
    if ( v <= -100) {
        possible_fishes.push("Rechin bolnav")
    }
    document.getElementById("manual_text").innerHTML =
    `
    <div class="tab_data">
        <p class="tab_info_prefix">> </p>
        <p class="tab_info">La aceasta adancime se pot pescui:</p>
    </div>
    `;

    possible_fishes.forEach(element => {
        document.getElementById("manual_text").innerHTML +=
        `
        <div class="tab_data peste_tabdata">
            <p class="tab_info_prefix">* </p>
            <p class="tab_info">${element}</p>
        </div>

        `;
    });
};

document.getElementById("rase_de_pesti_grup").onmouseover = function () {
    document.getElementById("manual_text").innerHTML =
    `
    <div class="tab_data">
        <p class="tab_info_prefix">> </p>
        <p class="tab_info">Aici sunt prezentate tipurile de pesti care au fost detectat de sonar</p>
    </div>
    `;
}

document.getElementById("manual_titlu").onmouseover = function () {
    document.getElementById("manual_text").innerHTML =
    `
    <div class="tab_data">
        <p class="tab_info_prefix">> </p>
        <p class="tab_info">Aici vor fi prezentat informatii despre cum se foloseste Sonarul</p>
    </div>
    `;
}