import consumer from "./consumer"

consumer.subscriptions.create("TransactionChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(`Received this via Transaction channel`);
    console.dir(data)
    this.displayNotification(data);
  },

  displayNotification(data) {
    this.perform('receive', data)
  },
});
