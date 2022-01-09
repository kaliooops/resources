function miner() {
    var x = document.getElementById("infoos")
    x.style.display = "block"
}


$(function () {
    function display(bool) {
        if (bool) {
            $("#ui").show();
        } else {
            $("#ui").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
        this.document.getElementById("cost").innerHTML = item.price + "$"
    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://vrp_carwash/milbei', JSON.stringify({action : "leave"}));
            return
        }
    };

    $("#cls").click(function () {
        $.post('https://vrp_carwash/milbei', JSON.stringify({action : "leave"}));
        return
    }) 
    $("#buy").click(function () {
        $.post('https://vrp_carwash/milbei', JSON.stringify({action : "buy"}));
        $.post('https://vrp_carwash/milbei', JSON.stringify({action : "leave"}));
        return
    })

})