import { Controller, fetch } from "@hotwired/stimulus"

// Connects to data-controller="form--automation"
export default class extends Controller {
  static targets = [ 'addons', 'submit' ];
  connect() {
    // We need to wait for Stimulus to fully load before we can manipulate the DOM.
    console.log('form/automation in da place', this.element.parentElement);
    this.analyze();
  }

  change() {
    this.analyze();
  }

  analyze() {
    switch (this.element.querySelector('select#period').value) {
      case 'immediate':
        this.addonsTarget.innerHTML = null;
        this.submitTarget.dataset.turboFrame = null;
        this.submitTarget.value = 'Create';
        this.submitTarget.dataset.turboFrame = '_top';

        break;
      case 'delayed':
        this.addonsTarget.innerHTML = `<label class="required" for="execution_time">Execution time</label>
                                        <input type="date"
                                                id="execution_time"
                                                name="execution_time"
                                                required="required"
                                                min="${this.tomorrowISODate()}"
                                                class="w-3/4 min-w-xs">`;
        this.submitTarget.dataset.turboFrame = '_top';
        this.submitTarget.value = 'Schedule';

        break;
      case 'recurring':
        this.addonsTarget.innerHTML = null;
        this.submitTarget.dataset.turboFrame = null;
        this.submitTarget.value = 'Continue';

        break;
    }
  }

  tomorrowISODate() {
    const date = new Date();
    date.setDate(date.getDate() + 1);
  
    return new Date(date).toISOString().split('T')[0];
  }
}
