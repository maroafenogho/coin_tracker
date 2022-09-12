import 'package:coin_tracker/app/modules/auth/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';

class FirebaseClient {
  final _firebaseAuth = auth.FirebaseAuth.instance;
  FirebaseUser? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    } else {
      return FirebaseUser(
          user.email, user.uid, user.emailVerified, user.displayName);
    }
  }

  Stream<FirebaseUser?> get currentUser {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<FirebaseUser?> createUser(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final credential = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        sendVerEmail();
        Get.snackbar(
          'Registration Successful',
          'Account created successfully',
          duration: const Duration(seconds: 5),
        );
        // Get.to(() => Login());?
        _firebaseAuth.currentUser!.updateDisplayName(displayName);
      });
      return _userFromFirebase(credential.user);
    } catch (error) {
      print(error);
    }
  }

  Future<FirebaseUser?> signIn(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  void sendVerEmail() {
    auth.User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      firebaseUser.sendEmailVerification().then((user) {
        Get.snackbar('Verification', 'Email Verification sent');
      });
    }
  }
}
