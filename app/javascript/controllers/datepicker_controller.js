import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    console.log(this.element)
    flatpickr(this.element, {
      mode: "range",
      minDate: "today",
      dateFormat: "Y-m-d",
  })
}
}
