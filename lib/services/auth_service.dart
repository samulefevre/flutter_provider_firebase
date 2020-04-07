import 'package:flutter_provider_firebase/models/user.dart';

abstract class AuthService {
  Future<User> currentUser();
  Future<User> signInWithEmailAndPassword(
    String email,
    String password,
  );
  Future<User> createUserWithEmailAndPassword(
    String displayName,
    String email,
    String password,
  );
  Future<void> sendPasswordResetEmail(String email);
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Stream<User> get onAuthStateChanged;
  void dispose();
}
