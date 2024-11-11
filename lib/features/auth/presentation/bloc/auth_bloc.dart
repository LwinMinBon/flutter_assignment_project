import 'package:eventify/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(
        AuthLoading()
      );
      final result = await _userSignUp(UserSignUpParams(
          email: event.email,
          password: event.password,
          userName: event.userName,
          phoneNumber: event.phoneNumber));
      result.fold((error) {
        print(error.message);
        emit(AuthFailure(
          errorMessage: error.message,
        ));
      }, (userId) {
        emit(AuthSuccess(
          userId: userId,
        ));
      });
    });
  }
}
