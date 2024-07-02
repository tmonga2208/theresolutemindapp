import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try{
      UserCredential userCredential = await _auth.signUpWithEmailAndPassword(
        email: email, password: password);
        return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }

  }

  Future<void> signout() async {
    return await _auth.signOut();
  }
}
