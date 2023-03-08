import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showhide"
export default class extends Controller {
  static targets = ["input", "output", "board"]
  static values = { showIf: String }
  connect() {
    // this.toggle()
    this.toggle()
  }
  
  toggle() {
    // console.log(this.showIfValue)
    // console.log(this.inputTarget.value)
    if (this.inputTarget.value != this.showIfValue) {
      this.outputTarget.hidden = false
      if (this.inputTarget.value != "Principal Delegate") {
        this.boardTarget.hidden = true
      } else {
        this.boardTarget.hidden = false
      }
    } else if (this.inputTarget.value = this.showIfValue) {
      this.outputTarget.hidden = true
    
    } 
  }
}
