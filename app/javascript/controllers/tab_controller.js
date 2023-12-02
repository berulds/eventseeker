import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tab"];

  connect() {
    console.log("Heyheyherewego");
  }

  activateTab(event) {
    event.preventDefault();
    const tabTarget = event.currentTarget.dataset.tabTarget;
    this.tabTargets.forEach((tab) => {
      tab.classList.remove("show", "active");
    });

    this.tabTargetNamed(tabTarget).classList.add("show", "active");
  }

}
