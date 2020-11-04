import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';

class UserManager {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signIn(UserData user) async {
    print('eae');
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(email: user.email, password: user.password);
    } on FirebaseAuthException catch(err) {
      print(getErrorString(err.code));
    }
  }
}