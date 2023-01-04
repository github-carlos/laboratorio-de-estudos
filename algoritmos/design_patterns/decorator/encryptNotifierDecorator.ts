import { BaseDecorator } from "./baseDecorator";
import { Notifier } from "./notifier.interface";

export class EncryptNotifer extends BaseDecorator {

  constructor(notifier: Notifier) {
    super(notifier);
  }

  send(message: string) {
    message = '$' + message + '$'
    super.send(message);
  }
}