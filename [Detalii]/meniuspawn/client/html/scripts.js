

$(document).ready(function () {
  setTheme();
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.open == true) {
      openMenu();
    }
    if (item.open == false) {
      closeMenu();
    }
    if (item.notification == true) {
      Swal.fire({
        text: item.notification_msg,
        type: 'success',
        showCancelButton: true,
        confirmButtonColor: configs.theme.primary_color,
        confirmButtonText: 'OK',
        showCancelButton: false
      });
    }
  });
  document.onkeyup = function (data) {
    if (data.key == "Escape") {
      $.post('http://vrp_panou/close', JSON.stringify({}));
    }
  };

  $(".btnClose").click(function () {
    
  fetch(`https://${GetParentResourceName()}/closemenu`, {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify({
        itemId: 'lol'
    })
}).then(resp => resp.json()).then(resp => console.log(resp));

  });
  $(".selectJob").click(function () {
    let jobID = $(this).data("jobID");
    if(!configs.jobs[jobID].whitelisted) {
      let group = configs.jobs[jobID].group;
      $.post('http://vrp_panou/selectJob', JSON.stringify({
        group: group
      }));
    }
  });
  $('.scrollbox').bind('scroll',scrollChecker);
});

function openMenu() {
  $(".container").fadeIn();
  openHome();
}
function closeMenu() {
  $(".container").fadeOut();
  $("#wrap").css("display", "block");
  $("#home").css("display", "none");
  $("#showJobs").css("display", "none");
  $("#jobSelection").css("display", "none");

  


}

function openHome() {
  $("#wrap").css("display", "block");
  $("#home").css("display", "block");
  $("#showJobs").css("display", "none");
  $("#jobSelection").css("display", "none");
}

function openShowJobs() {
  $("#wrap").css("display", "block");
  $("#home").css("display", "none");
  $("#showJobs").css("display", "block");
  $("#jobSelection").css("display", "none");
  $(".whitelisted-jobs").empty();
  $(".unwhitelisted-jobs").empty();
  configs.jobs.forEach(function(element, index) {
    if(element.whitelisted) {
      $(".whitelisted-jobs").append(`
        <div onclick="openJobSelection(${index})">
          <h3>${element.title}</h3>
          <p>${element.shortDescription}</p>
        </div>
      `);
    } else {
      $(".unwhitelisted-jobs").append(`
        <div onclick="openJobSelection(${index})">
          <h3>${element.title}</h3>
          <p>${element.shortDescription}</p>
        </div>
      `);
    }
  });
}

function openJobSelection(id) {
  if(configs.jobs[id].title.length !== null || configs.jobs[id].title.length !== undefined  || configs.jobs[id].title.length > 0) {
    $("#wrap").css("display", "block");
    $("#home").css("display", "none");
    $("#showJobs").css("display", "none");
    $("#jobSelection").css("display", "block");
    $(".jobIcon").attr("src","icons/"+configs.jobs[id].iconName);
    $(".jobTitle").html(configs.jobs[id].title);
    $(".jobDescription").html(configs.jobs[id].description);
    $(".jobRequirements").empty();
    $('.scrollbox').scrollTop(0);
    configs.jobs[id].requirements.forEach(element => {
      $(".jobRequirements").append("<p> - " + element + "</p>");
    });
  }
}

function scrollChecker(e) {
    var elem = $(e.currentTarget);
    if (elem[0].scrollHeight - elem.scrollTop() == elem.outerHeight()) {
        $(".scrollToBottom").css("display", "none");
    } else {
      $(".scrollToBottom").css("display", "block");
    }
}

function scrollToBottom() {
  var objDiv = document.getElementById("scrollbox");
  objDiv.scrollTop = objDiv.scrollHeight;
}

function setTheme() {
  if(configs.theme.primary_color && configs.theme.secondary_color) {
    let primary_color = `--primary-color: ${configs.theme.primary_color}; `;
    let secondary_color = `--secondary-color: ${configs.theme.secondary_color}; `;
    $(":root").attr("style", primary_color + secondary_color);
  }
}