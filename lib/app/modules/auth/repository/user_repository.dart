import 'package:coin_tracker/app/modules/auth/models/user.dart';
import 'package:coin_tracker/app/modules/auth/services/firebase_client.dart';

class UserRepository {
  UserRepository({FirebaseClient? firebaseClient})
      : _firebaseClient = firebaseClient ?? FirebaseClient();

  final FirebaseClient _firebaseClient;

  Future<FirebaseUser?> login(
      {required String email, required String password}) async {
    final user = await _firebaseClient.signIn(email, password);

    return user;
  }
}
