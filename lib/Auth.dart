import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      debugPrint("Auth: Signed in successfully: ${credential.user?.email} (UID: ${credential.user?.uid})");
    } catch (e) {
      debugPrint("Auth: Sign in error: $e");
      rethrow;
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      debugPrint("Auth: Account created successfully: ${credential.user?.email} (UID: ${credential.user?.uid})");
    } catch (e) {
      debugPrint("Auth: Sign up error: $e");
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    debugPrint("Auth: Signed out successfully");
  }
}
