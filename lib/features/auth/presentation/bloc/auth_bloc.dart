import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/cubits/app_user_cubit.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/usecase/current_user_fetch.dart';
import '../../domain/usecase/user_sign_in.dart';
import '../../domain/usecase/user_sign_out.dart';
import '../../domain/usecase/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUserFetch _currentUserFetch;
  final UserSignOut _userSignOut;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUserFetch currentUserFetch,
    required AppUserCubit appUserCubit,
    required UserSignOut userSignOut,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUserFetch = currentUserFetch,
        _appUserCubit = appUserCubit,
        _userSignOut = userSignOut,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);

    on<AuthSignIn>(_onAuthSignIn);

    on<AuthCurrentUserFetch>(_onAuthCurrentUserFetch);

    on<AuthSignOut>(_onAuthSignOut);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        userName: event.userName,
        phoneNumber: event.phoneNumber,
      ),
    );
    result.fold((error) {
      emit(AuthFailure(
        errorMessage: error.message,
      ));
    }, (userEntity) {
      emit(AuthSuccess(
        userEntity: userEntity,
      ));
      _appUserCubit.updateAppUser(userEntity.toAppUserEntity());
    });
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );
    result.fold((error) {
      emit(AuthFailure(
        errorMessage: error.message,
      ));
    }, (userEntity) {
      emit(AuthSuccess(
        userEntity: userEntity,
      ));
      _appUserCubit.updateAppUser(userEntity.toAppUserEntity());
    });
  }

  void _onAuthCurrentUserFetch(
      AuthCurrentUserFetch event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _currentUserFetch(NoParams());
    result.fold((error) {
      _appUserCubit.updateAppUser(null);
      emit(AuthFailure(
        errorMessage: error.message,
      ));
    }, (userEntity) {
      emit(AuthSuccess(
        userEntity: userEntity,
      ));
      _appUserCubit.updateAppUser(userEntity.toAppUserEntity());
    });
  }

  void _onAuthSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _userSignOut(NoParams());
    result.fold((error) {
      emit(AuthFailure(
        errorMessage: error.message,
      ));
    }, (unit) {
      emit(AuthSignOutSuccess());
      _appUserCubit.updateAppUser(null);
    });
  }
}
