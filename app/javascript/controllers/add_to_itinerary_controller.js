import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['itinerarySelect'];

  connect() {
  }

  itineraryChange(event) {
    const selectedItineraryId = event.target.value;
    console.log("Selected Itinerary Id: ", selectedItineraryId);

    const addButton = document.getElementById('addToItineraryButton');
    addButton.addEventListener("click", function () {
      const eventId = document.getElementById('event_id').value;

      fetch(`/itineraries/${selectedItineraryId}/itinerary_events`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        },
        body: JSON.stringify({ event_id: eventId }),
      })
      .then(response => response.json())
      .then(data => {
        console.log(data);
        window.location.href = `/itineraries/${selectedItineraryId}`;
      });
    });
    console.log("Complete");
  }
}
