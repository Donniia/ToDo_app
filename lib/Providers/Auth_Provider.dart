import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/Database/Model/User.dart' as MyUser;
import 'package:flutter/material.dart';

import '../Database/UserDao.dart';

class Auth_Provider extends ChangeNotifier {
  User? firebaseAuthUser;
  MyUser.User? databaseUser;

  Future<void> register(
      String email, String password, String userName, String fullName) async {
    var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await UserDao.createUser(MyUser.User(
        id: result.user?.uid,
        userName: userName,
        fullName: fullName,
        email: email));
  }

  Future<void> login(String email, String password) async {
    var result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    var user = await UserDao.getUser(result.user!.uid);
    databaseUser = user;
    firebaseAuthUser = result.user;
  }

  void logout() {
    databaseUser = null;
    FirebaseAuth.instance.signOut();
  }

  bool isUserLoggedInBefore() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> retrieveUserFromDatabase() async {
    firebaseAuthUser = FirebaseAuth.instance.currentUser;
    databaseUser = await UserDao.getUser(firebaseAuthUser!.uid);
  }
}
