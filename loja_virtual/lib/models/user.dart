import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  UserData(
      {this.id, this.email, this.password, this.name, this.confirmPassword});
  UserData.fromDocument(DocumentSnapshot document) {
    name = document.data()['name'];
    email = document.data()['email'] as String;
    id = document.id;
  }
  String id;
  String name;
  String email;
  String password;
  String confirmPassword;

  DocumentReference get firestoreRef {
   return FirebaseFirestore.instance.doc('users/$id');
  }

  CollectionReference get cartReference {
    return firestoreRef.collection('cart');
  }

  Future<void> saveData() async {
    await firestoreRef.set(
      toMap(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email};
  }
}
