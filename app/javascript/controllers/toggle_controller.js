import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = [ 
    "btn",
    "menu"
   ]

  connect() {
     //  this.btnTarget.addEventListener("click", () => {
    //  this.menuTarget.classList.toggle("hidden");
   // });
   console.log("togl")
  }

  toggler = function()  {
    console.log("toggler function is working")
   // this.btnTarget.onclick(
      this.menuTarget.classList.toggle("hidden")
   // )
  }
  
}
