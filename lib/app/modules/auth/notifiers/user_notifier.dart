import 'package:coin_tracker/app/modules/auth/models/user.dart';
import 'package:coin_tracker/app/modules/auth/services/firebase_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvder = StreamProvider<FirebaseUser?>(
  (ref) {
    return FirebaseClient().currentUser;
  },
);

// final authLoadingNotifier = StateProvider<bool>((ref) => false);
// final loginFurtureProvider = FutureProvider<FirebaseUser?>((ref) {
//   final user = FirebaseClient().
// });
