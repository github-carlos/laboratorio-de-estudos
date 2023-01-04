import { Notifier } from "./notifier.interface";

export class EmailNotifier implements Notifier {
  send(message: string): void {
    console.log('sending Email...', message);
  }
}