for (var images = bguse, $body = $("#bg2"), $bg = $("#bg"), n = images.length, c = 0, i = 0; i < n; i++) {
    var tImg = new Image();
    tImg.src = images[i];
}
$body.css({ backgroundImage: "url(" + images[Math.floor(images.length * Math.random() + 0)] + ")" }),
    $body.css({ backgroundRepeat: "no-repeat" }),
    $body.css({ backgroundSize: "cover" }),
    (function a() {
        var o = Math.floor(images.length * Math.random() + 0);
        $bg.hide()
            .css({ backgroundImage: "url(" + images[++o % n] + ")" })
            .delay(5e3)
            .fadeTo(1200, 1, function () {
                $body.css({ backgroundImage: "url(" + images[o % n] + ")" }), $body.css({ backgroundRepeat: "no-repeat" }), $body.css({ backgroundSize: "cover" }), a();
            });
    })();