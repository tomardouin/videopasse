import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  fire() {
    this.togglableElementTarget.classList.toggle("d-none");
  }
  connect() {
  }
}
