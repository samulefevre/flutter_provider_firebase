import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_provider_firebase/models/user.dart';
import 'package:flutter_provider_firebase/models/user_infos.dart';
import 'package:flutter_provider_firebase/services/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_provider_firebase/services/firestore_database.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            email: user.email,
            displayName: user.displayName,
            photoUrl: user.photoUrl,
          )
        : null;
  }

  Future<FirebaseUser> updateDisplayName(
    FirebaseUser user,
    String displayName,
  ) async {
    if (displayName != null && user != null) {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = displayName;

      await user.updateProfile(userUpdateInfo);
      await user.reload();
    }
    return user;
  }

  Future<User> _userFromFirestore(FirebaseUser user) async {
    if (user == null) {
      return null;
    }

    var currentUser = await FirestoreDatabase(uid: user.uid).getUser();

    return currentUser;
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth
        .signInWithCredential(EmailAuthProvider.getCredential(
      email: email,
      password: password,
    ));
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
    String displayName,
    String email,
    String password,
  ) async {
    try {
      final AuthResult authResult =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = displayName;

      await authResult.user.updateProfile(userUpdateInfo);
      await authResult.user.reload();

      FirebaseUser firebaseUser = await _firebaseAuth.currentUser();

      User user = await _createUser(firebaseUser);

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  _createUser(FirebaseUser firebaseUser) async {
    User user = User(
      uid: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoUrl,
      createdAt: Timestamp.now(),
    );

    if (user != null) {
      await FirestoreDatabase(uid: user.uid).createUser(user);
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final AuthResult authResult = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));

        User user = await _createUser(authResult.user);
        return user;
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<User> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();

    return _userFromFirestore(user);
  }

  Stream<UserInfos> userStream(String uid) {
    Stream<UserInfos> user = FirestoreDatabase(uid: uid).userData();
    return user;
  }

  @override
  Future<void> signOut() async {
    print('signout');
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    return await _firebaseAuth.signOut();
  }

  @override
  void dispose() {}
}
