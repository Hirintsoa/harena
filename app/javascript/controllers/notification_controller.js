import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer";
// Connects to data-controller="notification"
export default class extends Controller {
  connect() {
  }
  
  mark_as_seen(elt) {
    this.sub = this.createActionCableChannel();
    this.sub.perform('mark_as_seen', { id: +elt.target.id });
    this.sub.unsubscribe();
  }

  createActionCableChannel() {
    return consumer.subscriptions.create(
      "TransactionChannel",
      {
        connected() {
          console.log('Hello from embedded channel');
          // Called when the subscription is ready for use on the server
        },
        
        disconnected() {
          // Called when the subscription has been terminated by the server
        },

        received(data) {
          // Called when there's incoming data on the websocket for this channel
          console.log('Log from embedded channel received function');
        },
      }
    );
  }
}
