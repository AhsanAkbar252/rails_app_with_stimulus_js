import { Controller } from "@hotwired/stimulus"
import { Modal} from "bootstrap"
// Connects to data-controller="bs-modal"
export default class extends Controller {
  connect() {
    this.modal = new Modal(this.element)
    this.modal.show()
  }

  disconnet() {
    this.modal.hide()
  }

  submit(event) {
    this.modal.hide()
  }
}
