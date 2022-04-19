the_div = document.getElementById("splash");
function splash() {
    the_div.className = "splash";
}

function close_splash() {
    // add class .splash-closed to the_div
    the_div.className = "splash_close";
}

close_splash();

function splash_the_user() {
    splash();
    setTimeout(() => {
        close_splash();
    }, 8000);
}

addEventListener("message", function(e) {
    var data = e.data;
    if (data.cmd == "splash") {
        splash_the_user();
    }
});
