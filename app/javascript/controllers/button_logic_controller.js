import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["saveButtonForm"];

  connect() {
    console.log("ButtonLogicController connected");
  }

  async handleSaveClick(event) {
    // event.preventDefault();
    console.log("Save Event button clicked");

    try {
      const form = event.currentTarget.form;

      if (!form) {
        throw new Error('Missing form element for "button-logic" controller');
      }

      const formData = new FormData(form);

      const response = await fetch(form.action, {
        method: form.method,
        body: formData,
      });

      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }

      const data = await response.json();

      if (data.status === "success") {
        console.log(data);


        const successModal = new bootstrap.Modal(document.getElementById("successModal"));
        successModal.show();
      } else {
        console.error("Failed to save event", data.message);

        const errorModal = new bootstrap.Modal(document.getElementById("errorModal"));
        errorModal.show();
      }
    } catch (error) {
      console.error("Save Event failed", error);
    }
  }
}
