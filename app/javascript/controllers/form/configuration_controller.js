import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form--configuration"
export default class extends Controller {
  connect() {
  }

  exception_changed(e) {
    this.analyze(e.currentTarget);
  }

  add_exception(e) {
    const parent = e.currentTarget.parentElement;
    let content = parent.querySelector('article').cloneNode(true);
    content.querySelector('.addons').innerHTML = null;
    content.insertAdjacentHTML("beforeend", `<button
                                              class='absolute top-2 right-2 btn btn-error min-w-[unset] min-h-[unset] h-8 p-0'
                                              data-action="form--configuration#remove_exception"
                                            >
                                              <svg clip-rule="evenodd" fill-rule="evenodd" stroke-linejoin="round" stroke-miterlimit="2" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" class="min-w-6 min-h-6" fill="white">
                                                <path d="m4.015 5.494h-.253c-.413 0-.747-.335-.747-.747s.334-.747.747-.747h5.253v-1c0-.535.474-1 1-1h4c.526 0 1 .465 1 1v1h5.254c.412 0 .746.335.746.747s-.334.747-.746.747h-.254v15.435c0 .591-.448 1.071-1 1.071-2.873 0-11.127 0-14 0-.552 0-1-.48-1-1.071zm14.5 0h-13v15.006h13zm-4.25 2.506c-.414 0-.75.336-.75.75v8.5c0 .414.336.75.75.75s.75-.336.75-.75v-8.5c0-.414-.336-.75-.75-.75zm-4.5 0c-.414 0-.75.336-.75.75v8.5c0 .414.336.75.75.75s.75-.336.75-.75v-8.5c0-.414-.336-.75-.75-.75zm3.75-4v-.5h-3v.5z" fill-rule="nonzero"/>
                                              </svg>
                                            </button>`)
    parent.insertBefore(content, e.currentTarget);
  }

  remove_exception(e) {
    const parent = e.currentTarget.parentElement;
    parent.remove();
  }

  async analyze(element) {
    const id = document.querySelector('section#exceptions').querySelectorAll('article').length;
    let article = element.parentElement.parentElement;
    switch (element.value) {
      case 'weekend':
        article.querySelector('.addons').innerHTML = null;

        break;
      case 'holiday':
        article.querySelector('.addons').innerHTML = await this.fetchTag('holiday', id);

        break;
      case 'day':
        article.querySelector('.addons').innerHTML = await this.fetchTag('day', id);

        break;
      case 'month':
        article.querySelector('.addons').innerHTML = await this.fetchTag('month', id);

        break;
    }
  }

  async fetchTag(type, order) {
    return await fetch(`/new_movement/tag?tag[type]=${type}&tag[order]=${order}`, { method: 'GET' })
      .then((response) => response.text())
      .catch((err) =>  console.error(`Fetch error: ${err}`))
  }
}
