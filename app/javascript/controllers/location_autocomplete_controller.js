import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.initializeAutocomplete();
  }

  initializeAutocomplete() {
    const inputTarget = this.inputTarget;
    const formGroup = inputTarget.closest('.search');

    inputTarget.addEventListener("input", async () => {
      const query = inputTarget.value.trim();

      if (query.length >= 3) {
        const suggestionsContainer = formGroup.querySelector('.suggestions-container');
        if (suggestionsContainer) {
          suggestionsContainer.remove();
        }

        fetch(`https://api.geoapify.com/v1/geocode/autocomplete?text=${query}&apiKey=7a32f76dc5af4a8abf8663729e6a057a`)
          .then(response => response.json())
          .then(results => {
            this.showAutocompleteResults(results.features);
          })
          .catch(error => console.log('error', error));
      } else {
        this.clearAutocompleteResults();
      }
    });
  }

  showAutocompleteResults(results) {
    const inputField = this.inputTarget;
    const suggestionsContainer = document.createElement('div');
    suggestionsContainer.classList.add('suggestions-container');
    suggestionsContainer.innerHTML = '';

    const maxResults = 5;
    let displayedResults = 0;

    results.forEach(result => {
      if (displayedResults < maxResults) {
        const suggestion = document.createElement('div');
        suggestion.classList.add('suggestion');
        suggestion.textContent = result.properties.formatted;

        suggestion.addEventListener('click', () => {
          inputField.value = result.properties.formatted;
          suggestionsContainer.innerHTML = '';
        });

        suggestionsContainer.appendChild(suggestion);
        displayedResults++;
      }
    });

    const formGroup = inputField.closest('.search');
    formGroup.appendChild(suggestionsContainer);
  }

  clearAutocompleteResults() {
    const suggestionsContainer = document.querySelector('.suggestions-container');
    if (suggestionsContainer) {
      suggestionsContainer.remove();
    }
  }
}
