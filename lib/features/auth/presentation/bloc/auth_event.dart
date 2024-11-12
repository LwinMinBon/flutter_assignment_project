part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String userName;
  final String phoneNumber;
  AuthSignUp({
    required this.email,
    required this.password,
    required this.userName,
    required this.phoneNumber
  });
}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  AuthSignIn({
    required this.email,
    required this.password,
  });
}

final class AuthCurrentUserFetch extends AuthEvent {}

final class AuthSignOut extends AuthEvent {}