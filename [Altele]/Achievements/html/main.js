// document.getElementById("main").addEventListener("mouseover", (event) => {
//     let openclose = document.getElementById("open_close_achievements")
//     let sageata = document.getElementById("close_open_arrow")    

//     /* if main hovered or any child hovered */
//     if (event.target.id == "main" || event.target.parentElement.id == "main") {
//         sageata.innerText = ">"
//     }
//      /* .main:hover {
//             right: 0px;
//             transition: all 0.5s;
//         } */
//     document.getElementById("main").style.right = "0px"
//     document.getElementById("main").style.transition = "all 0.5s"

// })

setTimeout(() => {
    open();
}, 5000);

function open() {
    document.getElementById("main").style.right = "0px"
    document.getElementById("main").style.transition = "all 0.5s"
    let sageata = document.getElementById("close_open_arrow")  
    sageata.innerText = ">"    

}

function close() {
    document.getElementById("main").style.right = "-250px"
    document.getElementById("main").style.transition = "all 0.5s"
    let sageata = document.getElementById("close_open_arrow")  
    sageata.innerText = "<"
}

let closed = false;
addEventListener("message", function (event) {

    let data = event.data;
    if (data.type == "update") {
        //achievement_title
        //achievement_progress
        //achievement_description
        let title = document.getElementById("achievement_title")
        let progress = document.getElementById("achievement_progress")
        let description = document.getElementById("achievement_description")
        
        title.innerText = data.title
        progress.innerText = data.progress
        description.innerText = data.description
    }
    if (data.type != "update") {
        if (!closed) {
            closed = true;
            close();
        } else {
            closed = false;
            open();
        }    
    }

});



// document.getElementById("main").addEventListener("mouseleave", (event) => {
//     let openclose = document.getElementById("open_close_achievements")
//     let sageata = document.getElementById("close_open_arrow")    

//     /* if main hovered or any child hovered */
//     if (event.target.id == "main" || event.target.parentElement.id == "main") {
//         sageata.innerText = "<"
//     }

//     document.getElementById("main").style.right = "-250px"
//     document.getElementById("main").style.transition = "all 0.5s"
// })

