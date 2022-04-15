function spin_logo() {
    var logo = document.getElementById("logoimg");
    logo.classList.add("spinning_logo");
    // wait 1 sec then remove
    setTimeout(function() {
        logo.classList.remove("spinning_logo");
    }, 1000);
}

function flip_logo() {
    var logo = document.getElementById("logoimg");
    logo.classList.toggle("flipping_logo");
    // wait 1 sec then remove
    setTimeout(function() {
        logo.classList.remove("flipping_logo");
    }, 1000);

}


function rubberBand() {
    var logo = document.getElementById("logoimg");
    logo.classList.toggle("rubber_band_logo");
    // wait 1 sec then remove
    setTimeout(function() {
        logo.classList.remove("rubber_band_logo");
    }, 1000);
}

function pressed() {
    var logo = document.getElementById("logoimg");
    logo.classList.toggle("pressed");
    // wait 1 sec then remove
    setTimeout(function() {
        logo.classList.remove("pressed");
    }, 1000);
}

function pixelated_logo() {
    var logo = document.getElementById("logoimg");
    logo.classList.toggle("pixelated_logo");
    // wait 1 sec then remove
    setTimeout(function() {
        logo.classList.remove("pixelated_logo");
    }, 1000);
}

function fade() {
    var logo = document.getElementById("logoimg");
    logo.classList.toggle("fade");
    // wait 1 sec then remove
    setTimeout(function() {
        logo.classList.remove("fade");
    }, 1000);
}


function formatMoney(value) {
    str = (value).toFixed(1).replace(/\d(?=(\d{3})+\.)/g, '$&,');  // 12,345.67
    // remove the .0 thing
    str = str.replace(".0", "");
    return str
}

function do_random_anim() {
    // selet random animation
    var random = Math.floor(Math.random() * 6);

    switch (random) {
        case 0:
            spin_logo();
            break;
        case 1:
            flip_logo();
            break;
        case 2:
            rubberBand();
            break;
        case 3:
            pressed();
            break;
        case 4:
            pixelated_logo();
            break;
        case 5:
            fade();
            break;
        default:
            break;
    }
}

setInterval(() => {
    do_random_anim();
}, 15000);

let display = false
addEventListener("message", function (event) {
    var item = event.data
    if (item.type == "money") {
        document.getElementById("bani_wallet").innerHTML = formatMoney(item.value);
    } 
    if (item.type == "bankmoney") {
        document.getElementById("bani_bank").innerHTML = formatMoney(item.value);
    }
    if (item.type == "diamante") {
        document.getElementById("diamante").innerHTML = formatMoney(item.value);
    }

    if (item.type == "toggle") {
        if (display == true) {
            document.getElementById("container").style.display = "block";
            display = false
        } else {
            document.getElementById("container").style.display = "none";
            display = true
        }
    }

    if (item.type == "logo") {
        do_random_anim();
    }
});
