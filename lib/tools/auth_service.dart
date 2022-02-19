import 'package:coin_tracker/screens/auth_screens/login.dart';
import 'package:coin_tracker/tools/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';

class AuthController extends GetxController {
  bool isLoading = false;
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    } else {
      return User(user.email, user.uid, user.emailVerified, user.displayName);
    }
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  void sendVerEmail() {
    auth.User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      firebaseUser.sendEmailVerification().then((user) {
        Get.snackbar('Verification', 'Email Verification sent');
      });
    }
  }

  Future<User?> signIn(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<User?> createUser(
    String email,
    String password,
    String displayName,
  ) async {
    print('touch');
    final credential = await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      sendVerEmail();
      isLoading = false;
      Get.snackbar(
        'Registration Successful',
        'Account created successfully',
        duration: const Duration(seconds: 5),
      );
      Get.to(() => Login());
      _firebaseAuth.currentUser!.updateDisplayName(displayName);
    });
    return _userFromFirebase(credential.user);
  }

  void signOut() async {
    await _firebaseAuth.signOut().then((value) {
      Get.snackbar(
        'Logout',
        'User logged out',
        duration: const Duration(seconds: 5),
      );
      Get.to(() => Login());
    });
  }

  String warningLength = '', warningDifferent = '';

  void showWarning() {
    warningLength = 'Password must be at least 6 characters';
    update();
  }

  void showWarningDifferent() {
    warningDifferent = 'Password don\'t match';
    update();
  }

  void hideWarningDifferent() {
    warningDifferent = '';
    update();
  }

  void hideWarning() {
    warningLength = '';
    update();
  }

  void showCofirmWarning() {
    warningDifferent = 'Password must be at least 6 characters';
    update();
  }

  void loading() {
    isLoading = !isLoading;
    print(isLoading);
    update();
  }
}
