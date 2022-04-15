document.getElementById("container").style.display = 'none';


document.getElementById("sonarimg").onclick = function () {
    updateAdancime()
}

addEventListener("message", function (event) {
    var item = event.data
    if (item.open == true) {
        openMenu();
    }
    if (item.open == false) {
        closeMenu();
    }
    if (item.type =="updateadancime") {
        let two_float = parseFloat(item.adancime).toFixed(2);
        document.getElementById("adancime_valoare").innerText = two_float;
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



function openMenu() {
    document.getElementById("container").style.display = 'block';

}

function closeMenu() {
    document.getElementById("container").style.display = 'none';
}


function updateAdancime() {
    fetch(`https://${GetParentResourceName()}/updateadancime`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            itemId: 'lol'
        })
    }).then(resp => resp.json()).then(resp => console.log(resp));

    
}