import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pyggybank/models/user.dart';
import 'package:pyggybank/services/firebase_provider.dart';

class Repository {
  final _firebaseProvider = FirebaseProvider();

  Future<FirebaseUser> getCurrentUser() => _firebaseProvider.getCurrentUser();
  Future<void> signOut() => _firebaseProvider.signOut();
  Future<FirebaseUser> signIn() => _firebaseProvider.signIn();
  Future<bool> authenticateUser(FirebaseUser user) =>
      _firebaseProvider.authenticateUser(user);
  Future<void> addDataToDb(FirebaseUser user) =>
      _firebaseProvider.addDataToDb(user);
  Future<void> signUpUser(context, name, email, password) =>
      _firebaseProvider.signUpUser(context, name, email, password);
  Future<FirebaseUser> signInEmail(email, password) =>
      _firebaseProvider.signInEmail(email, password);
  Future<User> fetchUserDetailsById(String uid) =>
      _firebaseProvider.fetchUserDetailsById(uid);
}