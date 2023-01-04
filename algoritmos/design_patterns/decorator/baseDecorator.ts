import { Notifier } from "./notifier.interface";

export class BaseDecorator implements Notifier {

  constructor(private wrappee: Notifier) {}

  send(message: string): void {
    this.wrappee.send(message);
  }
}