import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';

class UserManager {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signIn({UserData user, Function onSuccess, Function onFail}) async {
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(email: user.email, password: user.password);
      onSuccess(result);
    } on FirebaseAuthException catch(err) {
      onFail(getErrorString(err.code));
    }
  }
}