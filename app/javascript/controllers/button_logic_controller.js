import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["saveButtonForm", "eventName"];

  async handleSaveClick(event) {
      const eventName = this.eventNameTarget.textContent;

    try {
      const response = await fetch(`/events/check_event_exists?name=${encodeURIComponent(eventName)}`, {
        method: 'GET',
      });

      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }

      const data = await response.json();

      if (data.exists) {
        const errorModal = new bootstrap.Modal(document.getElementById("errorModal"));
        errorModal.show();
      } else {
        const successModal = new bootstrap.Modal(document.getElementById("successModal"));
        successModal.show();
      }
    } catch (error) {
      console.error("Save Event failed", error);
    }
  }
}
