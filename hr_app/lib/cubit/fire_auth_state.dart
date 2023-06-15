import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum FireAuthStatus { initial, logging, success, error }

class FireAuthState extends Equatable {
  final User? user;
  final bool loading;
  final String email;
  final String password;
  final FireAuthStatus status;

  const FireAuthState(
      {required this.email,
      required this.password,
      required this.status,
      this.user,
      this.loading = false});
  factory FireAuthState.initial() {
    return const FireAuthState(
        email: "", password: "", status: FireAuthStatus.initial);
  }

  FireAuthState copyWith(
      {User? user,
      bool? loading,
      String? email,
      String? password,
      FireAuthStatus? status}) {
    return FireAuthState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  @override
  List<Object?> get props => [user, loading, email, password, status];
}

// class AuthFailed extends AuthState {}