part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserEntity userEntity;

  AuthSuccess({
    required this.userEntity,
  });
}

final class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({
    required this.errorMessage,
  });
}

final class AuthSignOutSuccess extends AuthState {}