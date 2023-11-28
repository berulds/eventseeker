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
    const start = formData.get('start');

    console.log(query, date, start);

    const dateParam = date.gsub('-', '+');
    const url = `https://serpapi.com/search.json?engine=google_events&q=${query}+${dateParam}&start=${start}&hl=en&api_key=#{ENV["API_KEY"]}`;

    console.log(url);
  }

}




// listen for click
// submit form
// append results
// data-controller="search"
// , data: { action: "click->search#loadMoreResults" }
