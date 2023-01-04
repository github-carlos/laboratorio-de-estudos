import { EmailNotifier } from "./emailNotifier";
import { EncryptNotifer } from "./encryptNotifierDecorator";

const emailNotifier = new EmailNotifier()
const encryptNotifier = new EncryptNotifer(emailNotifier);

encryptNotifier.send('Testing');