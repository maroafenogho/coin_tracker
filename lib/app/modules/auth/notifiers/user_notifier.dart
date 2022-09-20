import 'package:coin_tracker/app/modules/auth/models/user.dart';
import 'package:coin_tracker/app/modules/auth/notifiers/auth_state.dart';
import 'package:coin_tracker/app/modules/auth/repository/user_repository.dart';
import 'package:coin_tracker/app/modules/auth/services/firebase_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvder = StreamProvider<FirebaseUser?>(
  (ref) {
    return ref.watch(firebaseClientProvider).currentUser;
  },
);

final loggedInUserProvider =
    StateProvider<FirebaseUser>((ref) => FirebaseUser('', '', false, ''));

final loogedOut = FutureProvider.autoDispose<bool>((ref) {
  ref.watch(firebaseClientProvider).signOut();
  return true;
});

final authLoadingStateProvider = StateProvider((ref) => false);

final firebaseClientProvider =
    Provider<FirebaseClient>((ref) => FirebaseClient());

final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');

final firebaseLoginProvider = FutureProvider((ref) => ref
    .watch(firebaseClientProvider)
    .signIn(ref.watch(emailProvider.notifier).state,
        ref.watch(passwordProvider.notifier).state));

final authRepoProvider = Provider((ref) => UserRepository());

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
    (ref) => AuthNotifier(ref.watch(authRepoProvider)));

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._userRepository) : super(AuthState.initial());
  final UserRepository _userRepository;

  login({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final user =
          await _userRepository.login(email: email, password: password);
      if (user != null) {
        state = state.copyWith(user: user, status: AuthStatus.success);
      }
    } catch (error) {
      print(error);
      state = state.copyWith(status: AuthStatus.error);
    }
  }
}

// final authLoadingNotifier = StateProvider<bool>((ref) => false);
// final loginFurtureProvider = FutureProvider<FirebaseUser?>((ref) {
//   final user = FirebaseClient().
// });
