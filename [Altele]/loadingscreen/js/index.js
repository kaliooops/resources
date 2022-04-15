$( document ).ready(function() {
  setTimeout(loadDatSkweenie, 2000);
  document.getElementsByTagName('video')[0].volume = 0.35;

});

// var video = document.createElement("video");
// video.setAttribute("id", "myVideo");
// video.setAttribute("autoplay", "autoplay");
// video.setAttribute("muted", "muted");
// video.setAttribute("loop", "loop");
// video.setAttribute("type", "video/mp4");
// video.setAttribute("src", "http://fivem.k2roleplay.com/luciano.mp4");
// document.getElementById("parent_video").appendChild(video);
// var vid = document.getElementById("myVideo");
// vid.style.width = "100%";
// vid.style.height = "100%";
// vid.style.position = "absolute";
// vid.style.top = "0px";
// vid.style.left = "0px";
// vid.style.zIndex = "-1";
// vid.style.objectFit = "cover";
// vid.style.objectPosition = "center";
// video.play();


function loadDatSkweenie() {
  var banner = ["&nbsp", "k" ,"2", "&nbsp", "R", "o", "l", "e", "p", "l", "a", "y"]
  var rules = ["Sistemele noastre sunt noi si complexe, de aceea am pus un panou informativ la spawn, acolo sunt explicate majoritatea sistemelor",
              "Nu iesii din pielea personajului!", 
               "Doar un admin iti poate permite limbajul OOC!", 
               "Fara intrebari de genul (permiti chineza?)!", 
               "Fail-RP este sanctionat foarte aspru!", 
               "Incearca sa dai dovada de seriozitate",
               "Fara Suferinte/Copilarii",
               "Post hunting este sanctionat!"
              ]
  var fadeTime = 500
  var fadeTime2 = 500
  $(".infohold").fadeIn(900)
  $(".steamid").show(900)
  $(banner).each(function( i ) {
    var tCount = Number(i)
    fadeTime = fadeTime + 200
    $(".banner p:nth-child("+tCount+")").hide()
    $( ".banner" ).append( "<p>"+banner[tCount]+"</p>" );
    $(".banner p:nth-child("+tCount+")").fadeIn(fadeTime)
  })
  $(rules).each(function( i ) {
    var rCount = Number(i) 
    fadeTime2 = fadeTime2 + 300
    $(".block .text:nth-child("+rCount+")").hide()
    $( ".block:nth-child(1)" ).append( "<p class='text'>"+rules[rCount]+"</p>" )
    $(".block .text:nth-child("+rCount+")").show(fadeTime2)
  })

  
  /* if user interacted with the dom element play the video */
  
}
