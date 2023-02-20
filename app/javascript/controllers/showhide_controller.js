import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showhide"
export default class extends Controller {
  static targets = ["input", "output"]
  static values = { showIf: String }
  connect() {
    // this.toggle()
    this.toggle()
  }
  
  toggle() {
    // console.log(this.showIfValue)
    // console.log(this.inputTarget.value)
    if (this.inputTarget.value != this.showIfValue) {
      this.outputTarget.hidden = true
      console.log("yes")
    } else if (this.inputTarget.value = this.showIfValue) {
      this.outputTarget.hidden = false
      console.log("no")
    }
  }
}
