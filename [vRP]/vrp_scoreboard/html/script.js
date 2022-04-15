
window.addEventListener("message", function(event){
  let data = event.data
  if (data.action == "deschideUsaCrestine") {
    document.getElementById("scoreboard").style.display = "block";
        document.querySelector("#tablepplm").innerHTML = ''+data.info;
    $('#idsiuseritext').html(data.idsiuseritext)
  }
});

$("#close").click(function () {
  $.post('http://vrp_scoreboard/exit', JSON.stringify({}));
  return
})

$(document).ready(function(){
    document.onkeyup = function (data) {
      if (data.which == 27 ) {
        document.querySelector("#idsiuseritext").innerHTML = data.idsiuseritext + '/80 players ' ;
        document.getElementById("scoreboard").style.display = "none";
        $.post('http://vrp_scoreboard/inchideusacrestine', JSON.stringify({}));
      }
    };
});