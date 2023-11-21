import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['itinerarySelect', 'eventIdId'];

  connect() {
  }

  itineraryChange(event) {
    const selectedItineraryId = event.target.value;
    console.log("Selected Itinerary Id: ", selectedItineraryId);

      const eventId = this.eventIdIdTarget.value;
      console.log("Event Id: ", eventId);

      fetch(`/itineraries/${selectedItineraryId}/itinerary_events?query=${eventId}`, {
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
        // window.location.href = `/itineraries/${selectedItineraryId}`;
        // window.location.replace(`/itineraries/${selectedItineraryId}`);
      });
    console.log("Complete");
  }
}
