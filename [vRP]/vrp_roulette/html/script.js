if (!String.prototype.format) {
    String.prototype.format = function () {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function (match, number) {
            return typeof args[number] != 'undefined'
                ? args[number]
                : match;
        });
    };
}


const luckyNumber = 150

var rolled = false;

var isRolling = false;

$(window).load(function () {

    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    function getPositionOfWinner(winner) {
        var widthOfImg = $('#roulette-img0').width();
        var minDistanceToEdgeAllowed = 4;

        var desiredImg = $('#roulette-img' + winner.toString());

        var minPos = desiredImg.position().left + minDistanceToEdgeAllowed;
        var maxPos = desiredImg.position().left + widthOfImg - minDistanceToEdgeAllowed;

        return getRandomInt(minPos, maxPos);
    }

    function printLeftOfRouletteSpinner() {
        var pos = $('#roulette-images-list').position().left;
        if (pos % 100 == 0) console.log(pos);
    }

  function timelineFinished(){

    const desiredImg = $('#roulette-img' + luckyNumber.toString());
    const middle = desiredImg.position().left + (Math.floor(desiredImg.width()/2))

    var tl = new TimelineMax({ }),
        rouletteImages = $('#roulette-images-list'),
        startLeft = rouletteImages.position().left;

    tl.to(rouletteImages, 0.7, {x: middle * -1, ease:10000});


    $('#roulette-images-list li').each(function() {
        if($(this).attr('id') != 'aWinner') {
            $(this).children().animate({
                'opacity': '0.0'
            }, 1300);
        } else {
            $(this).children().css({
                'box-shadow': 'inset 0px 0px 12px #F9CB40'
            });
        }
    });

    isRolling = false;
  }

  function generateRouletteObj(type, id) {
    var imgTemplate = '<img src="{0}" class="{1}" id="roulette-img{2}"/>';
    var imgClass = 'roulette-img';
    var imgSrcTemplate = 'img/{0}.png';

    var imgSrc = imgSrcTemplate.format(type);
    var completedTemplate = imgTemplate.format(imgSrc, imgClass, id);

    return completedTemplate;
  }
  
    function rouletteSpin(destImg, winImg) {
        rolled = true;
        if (!destImg) destImg = 40;

        $('#aWinner').html(generateRouletteObj(winImg, luckyNumber));

        var tl = new TimelineMax({ onComplete: timelineFinished }),
            rouletteImages = $('#roulette-images-list'),
            startLeft = rouletteImages.position().left;

        tl.to(rouletteImages, 10, {x: getPositionOfWinner(destImg) * -1, ease:Power4.easeOut});
    }

    window.addEventListener('message', function(event) {
        if(event.data.type == "toggle") {
            togglePrizes();
        } else if(event.data.type == "spinTo") {
            if(isOpen) rouletteSpin(luckyNumber, event.data.itemId);
        } else if(event.data.type == "noteng") {
        	isRolling = false
        } else if(event.data.type == "setPrice") {
            $('#rollPrice').html(event.data.price);
            $('#rollDmd').html(event.data.dmdPrice);
        }
    });


    function getRandomPrize() {
        const possibleItems = [
            "Money1", 
            "Money2",
            "Motocicleta",
            "Masina"
        ]

        const randomElement = possibleItems[Math.floor(Math.random() * possibleItems.length)];
        return randomElement;
    }

    function generateRouletteImages(howMany) {

        var completedRouletteImages = [];
        for (var i = 0; i < howMany; i++) {
            var completedTemplate = generateRouletteObj(getRandomPrize(), i);
            if(i == luckyNumber) {
                completedRouletteImages.push('<li id="aWinner">' + completedTemplate + '</li>');
            } else {
                completedRouletteImages.push('<li>' + completedTemplate + '</li>');
            }
        }
        return completedRouletteImages;
    }


    var isOpen = false;
    function togglePrizes() {

        if(isOpen && isRolling) return;
        
        isOpen = !isOpen;
        isRolling = false;
        $('.container').css("display", isOpen ? "block" : "none");

        if(isOpen) {
            $('#roulette-images-list').html(generateRouletteImages(luckyNumber + 7));

            var tl = new TimelineMax({}),
                rouletteImages = $('#roulette-images-list');

            tl.to(rouletteImages, 0, {x: -500});

            rolled = false;
        } else {
            $('#roulette-images-list').empty();
            $.post("http://vrp_roulette/exit");
        }
    }

    $('#spin').click(function() {
        if(!isRolling) {
            isRolling = true;
            $.post("http://vrp_roulette/tryGetPrize", 
                JSON.stringify({
                    withDmd: false
                })
            );


            if(rolled) {
                $('#roulette-images-list').html(generateRouletteImages(luckyNumber + 7));

                var tl = new TimelineMax({}),
                    rouletteImages = $('#roulette-images-list');

                tl.to(rouletteImages, 0, {x: -500});
                rolled = false;
            }
        }
    });

    $('#spinDmd').click(function() {
        if(!isRolling) {
            isRolling = true;
            $.post("http://vrp_roulette/tryGetPrize", 
                JSON.stringify({
                    withDmd: true
                })
            );


            if(rolled) {
                $('#roulette-images-list').html(generateRouletteImages(luckyNumber + 7));

                var tl = new TimelineMax({}),
                    rouletteImages = $('#roulette-images-list');

                tl.to(rouletteImages, 0, {x: -500});
                rolled = false;
            }
        }
    });

    $('body').keyup(function(e){
        if(isOpen) {
            switch (e.keyCode) {
                case 27: togglePrizes(); // ESC
                    break;
                case 80: togglePrizes(); // P - Pause Menu
                    break;
            }
        }
    });
});
