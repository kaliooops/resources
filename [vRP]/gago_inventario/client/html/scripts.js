
var itemName = null;
var itemAmount = null;
var itemIdname = null;

$(document).ready(function () {
  setTheme();
  $(".container").hide();
  window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.show == true) {
      open();
      openHome();
    }
    if (item.show == false) {
      close();
    }
    if (item.inventory) {
      // console.log(JSON.stringify(item.inventory, null, 2));
      $("#items").empty();
      item.inventory.forEach(element => {
        $("#items").append(`
          <div onclick="selectItem(this)" data-name="${element.name}" data-amount="${element.amount}" data-idname="${element.idname}" data-itemWeight="${element.item_peso}" style="background-image: url('assets/icons/${element.icon}'); background-size: 80px 80px;">
            <p class="amount">${element.amount} <span class="peso">${element.item_peso}Kg</span></p>
            <p class="name">${element.name}</p>
          </div>
        `);
      });
    }
    if (item.notification == true) {
      Swal.fire(
        item.title,
        item.message,
        item.type
      )
    }
    if(item.weight && item.maxWeight) {
      // convert item.weight into a string with 2 floating points
      let weight = item.weight.toString();

      $(".weight").html(weight + "/" + item.maxWeight + " kg");
      //$(".weight").html("200.00/200.00 KG");
    }
  });
  document.onkeyup = function (data) {
    if (data.key == "Escape") {
      $.post('http://gago_inventario/close', JSON.stringify({}));
    }
  };
  $(".btnClose").click(function () {
    $.post('http://gago_inventario/close', JSON.stringify({}));
  });
});

function open() {
  $(".container").fadeIn();
  clearSelectedItem();
}
function close() {
  $(".container").fadeOut();
  $("#home").css("display", "none");
  clearSelectedItem();
}
function openHome() {
  $("#home").css("display", "block");
}

function selectItem(element) {
  itemName = element.dataset.name;
  itemAmount = element.dataset.amount;
  itemIdname = element.dataset.idname;
  $("#items div").css("background-color", "rgba(47, 71, 143,0.3)");
  $(element).css("background-color", "rgba(24, 139, 216)");
}

function useItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      
      'Atentie',
      'Va rugam să introduceti o cantitate valida!',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atentie',
      'Nu ai destule.',
      'warning'
    )
  } else {
    if(itemIdname) {
      $.post('http://gago_inventario/useItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atentie',
        'Selecteaza un item',
        'warning'
      )
    }
  }
}
function eqItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      
      'Atentie',
      'Alege un slot intre 1-6',
      'warning'
    )
  }  else {
    if(itemIdname) {
      $.post('http://gago_inventario/eqItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atentie',
        'Selecteaza un item',
        'warning'
      )
    }
  }
}

function dropItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Atentie',
      'Va rugam să introduceti o cantitate valida.',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atentie',
      'Nu ai destule.',
      'warning'
    )
  } else {
    if(itemIdname !== null) {
      $.post('http://gago_inventario/dropItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atentie',
        'Selecione um item',
        'warning'
      )
    }
  }
}

function giveItem() {
  let amount = $("#amount").val();
  if (amount == "0" || amount == "" || amount == null) {
    Swal.fire(
      'Atentie',
      'Va rugam să introduceti o cantitate valida.',
      'warning'
    )
  } else if (parseInt(amount) > parseInt(itemAmount)) {
    Swal.fire(
      'Atentie',
      'Nu aveti cantitatea selectata în inventar.',
      'warning'
    )
  } else {
    if(itemIdname) {
      $.post('http:/gago_inventario/giveItem', JSON.stringify({
        idname: itemIdname,
        amount: amount
      }))
      .then(() => {
        clearSelectedItem();
      });
    } else {
      Swal.fire(
        'Atentie',
        'Selecteaza un item',
        'warning'
      )
    }
  }
}

function setTheme() {
  if(configs.theme.primary_color && configs.theme.secondary_color) {
    let primary_color = `--primary-color: ${configs.theme.primary_color}; `;
    let secondary_color = `--secondary-color: ${configs.theme.secondary_color}; `;
    $(":root").attr("style", primary_color + secondary_color);
  }
}

function clearSelectedItem() {
  itemName = null;
  itemAmount = null;
  itemIdname = null;
  $("#items div").css("background-color", "#ececec");
}