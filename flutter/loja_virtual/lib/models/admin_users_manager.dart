import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_virtual/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier {
  List<UserData> users = [];
  void updateUser(UserManager usermanager) {
    if (usermanager.adminEnabled) {
      _listenToUsers();
    }
  }

  void _listenToUsers() {
    const faker = Faker();
    for (int i = 0; i < 1000; i ++) {
        users.add(UserData(
          name: faker.person.name(),
          email: faker.internet.email(),
          id: faker.randomGenerator.toString()
        ));
    }

    users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    notifyListeners();
  }

  List<String> get names {
    return users.map((e) => e.name).toList();
  }
}