import { api } from '/api';
import { store } from '/store';

import urbitOb from 'urbit-ob';


export class Subscription {
  start() {
    if (api.authTokens) {
      this.initializePottery();
    } else {
      console.error("~~~ ERROR: Must set api.authTokens before operation ~~~");
    }
  }

  initializePottery() {
    api.bind('/primary', 'PUT', api.authTokens.ship, 'pottery',
      this.handleEvent.bind(this),
      this.handleError.bind(this));
  }

  handleEvent(diff) {
    store.handleEvent(diff);
  }

  handleError(err) {
    console.error(err);
    api.bind('/primary', 'PUT', api.authTokens.ship, 'pottery',
      this.handleEvent.bind(this),
      this.handleError.bind(this));
  }
}

export let subscription = new Subscription();
