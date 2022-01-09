$(function() {
    function hideHud(bool)
    {
        if (bool == true) 
        {
            var money = document.getElementsByClassName("div_money");
            var bmoney = document.getElementById("bmoney");
            money.style.display = "none";
            bmoney.style.display = "none";
            document.body.append("<h1>aasdasdasdadas</h1>");

        }
        if (bool == false)
        {
            var money = document.getElementById("money");
            var bmoney = document.getElementById("bmoney");
            money.style.display = "block";
            bmoney.style.display = "block";
        }
        
    }
    window.addEventListener("message", function(event) {
        var item = event.data
        console.log("item: " + item.type);
        if (item.type == "hideHud") {
            if (item.status == true) {
                hideHud(true)

            }else{
                hideHud(false)
            }
            
        }

    }, false);
})
