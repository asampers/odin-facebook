import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    this.modal = new bootstrap.Modal(this.element, {
      keyboard: false
    })
    this.modal.show()
    console.log('connected', this.modal)
  }

  disconnect() {
    this.modal.hide()
    console.log('goodbye', this.modal)
  }
}
