import '../../../../core/common/entity/app_user_entity.dart';
import '../../data/model/user_model.dart';

class UserEntity {
  final String id;
  final String email;
  final String username;
  final String phoneNumber;

  UserEntity(
      {required this.id,
      required this.email,
      required this.username,
      required this.phoneNumber});

  factory UserEntity.fromModel(UserModel userModel) {
    return UserEntity(
      id: userModel.id,
      email: userModel.email,
      username: userModel.username,
      phoneNumber: userModel.phoneNumber,
    );
  }

  AppUserEntity toAppUserEntity() {
    return AppUserEntity(
        id: id,
        email: email,
        username: username,
        phoneNumber: phoneNumber
    );
  }
}
