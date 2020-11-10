import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _loading = false;

  UserData user;
  UserManager() {
    _loadCurrentUser();
  }

  void _loadCurrentUser({User firebaseUser}) async {
    final User currentUser = firebaseUser ?? auth.currentUser;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      user = UserData.fromDocument(docUser);
      notifyListeners();
    }
  }

  get loading => _loading;

  bool get isLoggedIn => user != null;

  Future<void> signIn(
      {UserData userData, Function onSuccess, Function onFail}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: userData.email, password: userData.password);
      _loadCurrentUser(firebaseUser: result.user);
      onSuccess();
    } on FirebaseAuthException catch (err) {
      onFail(getErrorString(err.code));
    }
    loading = false;
  }
  
  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  Future<void> signUp(
      {UserData userData, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: userData.email, password: userData.password);
      userData.id = result.user.uid;
      this.user = userData;
      await userData.saveData();
      onSuccess();
    } on FirebaseAuthException catch (err) {
      onFail(
        getErrorString(err.code),
      );
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
