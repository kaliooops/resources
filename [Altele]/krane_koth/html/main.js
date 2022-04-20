container = document.getElementById('container');
scout = document.getElementById("scout");
heavy = document.getElementById("heavy");
sniper = document.getElementById("sniper");
assault = document.getElementById("assault");
gunner = document.getElementById("gunner");

bottom_rewards = document.getElementById("bottom_rewards");

splash_screen = document.getElementById("splash_screen");
splash_screen.style.display = "none";
function splash_user_kill(playername) {
    splash_screen.style.display = "flex";
    splash_screen.classList.remove("splash_screen_close");
    splash_screen.classList.add("splash_screen");

    document.getElementById("killed_player").innerText = playername;

    setTimeout(() => {
        splash_screen.classList.remove("splash_screen");
        splash_screen.classList.add("splash_screen_close");
    }, 3000);
}

function hide_ui() {
    scout.style.display = "none";
    heavy.style.display = "none";
    sniper.style.display = "none";
    assault.style.display = "none";
    gunner.style.display = "none";
}

function show_ui() {
    scout.style.display = "flex";
    heavy.style.display = "flex";
    sniper.style.display = "flex";
    assault.style.display = "flex";
    gunner.style.display = "flex";
}

hide_ui();

let gold_paint_kills = document.getElementById("kills_for_gold_paint");
let silencer_kills = document.getElementById("kills_for_suppressor");
let total_kills = document.getElementById("total_kills");
let current_kills = 0

function got_kill(playername) {
    current_kills += 1;
    gold_paint_kills.innerText = current_kills;
    gold_paint_kills.innerText = current_kills + "/20";
    silencer_kills.innerText = current_kills + "/10";
    total_kills.innerText = current_kills;

    if (silencer_kills.innerText == "10/10") {
        // hide the parent
        parentxx = silencer_kills.parentNode.parentNode;
        parentxx.style.display = "none";
    }

    if (gold_paint_kills.innerText == "20/20") {
        // hide the parent
        parentxx = gold_paint_kills.parentNode.parentNode;
        parentxx.style.display = "none";     
    }

    if (current_kills > 20) {
        total_kills.parentNode.style.top = "0px";
    }

    splash_user_kill(playername);
}


function display_rewards() {
    bottom_rewards.style.display = "flex";
    parentxx = silencer_kills.parentNode.parentNode;
    parentxx.style.display = "flex";

    parentxx = gold_paint_kills.parentNode.parentNode;
    parentxx.style.display = "flex";  
    total_kills.parentNode.style.top = "-50px";
}

function hide_rewards() {
    bottom_rewards.style.display = "none";
}

hide_rewards();
addEventListener("message", function(event) {

    if (event.data.type == "hide_ui") {
        hide_ui();
    } else if (event.data.type == "show_ui") {
        show_ui();
        setTimeout(() => {
            display_rewards();            
        }, 30000);
    }

    if (event.data.type == "cleanup") {
        // remove the class "card_chosen_for_spawn" from everyone that has it
        var cards = document.getElementsByClassName("card_chosen_for_spawn");
        for (var i = 0; i < cards.length; i++) {
            cards[i].classList.remove("card_chosen_for_spawn");
        }
        current_kills = 0;
        hide_rewards();
           
    }
    if (event.data.type == "kill") {
        got_kill(event.data.name);
    } 
});

addEventListener("click", function() {
    var id = event.target.parentNode.id;
    if (id == "scout" || id == "heavy" || id == "sniper" || id == "assault" || id == "gunner") {
        el = document.getElementById(id);
        
        // remove the class "card_chosen_for_spawn" from everyone that has it
        var cards = document.getElementsByClassName("card_chosen_for_spawn");
        for (var i = 0; i < cards.length; i++) {
            cards[i].classList.remove("card_chosen_for_spawn");
        }

        el.classList.add("card_chosen_for_spawn")


        fetch(`https://${GetParentResourceName()}/Selected_Class`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                class_chosen: id,
            })
        }).then(resp => resp.json()).then(resp => console.log(resp));


    }
});

// add an event handler if any scout heavy sniper is hovered highlight
scout.addEventListener("mouseover", function(){
    // add class card_selected
    scout.classList.add("card_selected");
    scout.classList.remove("card_unselected");
});

scout.addEventListener("mouseout", function(){
    // remove class card_selected
    scout.classList.remove("card_selected");
    scout.classList.add("card_unselected");
});

gunner.addEventListener("mouseover", function(){
    // add class card_selected
    gunner.classList.add("card_selected");
    gunner.classList.remove("card_unselected");
});

gunner.addEventListener("mouseout", function(){
    // remove class card_selected
    gunner.classList.remove("card_selected");
    gunner.classList.add("card_unselected");
});

assault.addEventListener("mouseover", function(){
    // add class card_selected
    assault.classList.add("card_selected");
    assault.classList.remove("card_unselected");
});

assault.addEventListener("mouseout", function(){
    // remove class card_selected
    assault.classList.remove("card_selected");
    assault.classList.add("card_unselected");
});

heavy.addEventListener("mouseover", function(){
    // add class card_selected
    heavy.classList.add("card_selected");
    heavy.classList.remove("card_unselected");
});

heavy.addEventListener("mouseout", function(){
    heavy.classList.remove("card_selected");
    heavy.classList.add("card_unselected");
});

sniper.addEventListener("mouseover", function(){
    // add class card_selected
    sniper.classList.add("card_selected");
    sniper.classList.remove("card_unselected");
});

sniper.addEventListener("mouseout", function(){
    sniper.classList.remove("card_selected");
    sniper.classList.add("card_unselected");
});