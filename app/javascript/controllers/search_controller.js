import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['results'];

  connect() {
    console.log("Let's goo!!");
  }

  async loadMoreResults(event) {
    event.preventDefault();

    const form = this.element.querySelector('.see-more-form');
    const formData = new FormData(form);
    const query = formData.get('query');
    const date = formData.get('date');
    const counter = formData.get('start');

    console.log(query, date, counter);

    try {
      const response = await fetch(`/search_events?query=${query}&date=${date}&start=${counter}`);

      if (response.ok) {
        const newResults = await response.json();
        this.appendResults(newResults);
      } else {
        console.error(`Error: ${response.status} - ${response.statusText}`);
      }
    } catch (error) {
      console.error("Error fetching search results", error);
    }
  }
}


// appendResults(results) {
//   // Implement the logic to append new results to the existing results
//   const resultsContainer = this.resultsTarget;
//   // Example: resultsContainer.innerHTML += newResultsHtml;
// }
