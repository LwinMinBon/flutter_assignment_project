import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../entity/app_user_entity.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateAppUser(AppUserEntity? appUserEntity) {
    if (appUserEntity == null) {
      emit(AppUserSignOut());
    } else {
      emit(
        AppUserSignedIn(appUserEntity: appUserEntity),
      );
    }
  }
}
