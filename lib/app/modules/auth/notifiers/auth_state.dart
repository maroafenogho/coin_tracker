import 'package:coin_tracker/app/modules/auth/models/user.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, success, error }

extension AuthStatusExtension on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isLoading => this == AuthStatus.loading;
  bool get isSuccess => this == AuthStatus.success;
  bool get isError => this == AuthStatus.error;
}

class AuthState extends Equatable {
  final FirebaseUser? user;
  final AuthStatus status;

  const AuthState({this.status = AuthStatus.initial, this.user});

  factory AuthState.initial() {
    return const AuthState(user: null);
  }

  AuthState copyWith({AuthStatus? status, FirebaseUser? user}) {
    return AuthState(status: status ?? this.status, user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status];
}
