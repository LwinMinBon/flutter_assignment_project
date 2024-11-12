import '../../domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.phoneNumber,
  });

  factory UserModel.fromJsonByAuthentication(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"] ?? "",
      email: map["email"] ?? "",
      username: map["user_metadata"]["username"] ?? "",
      phoneNumber: map["user_metadata"]["phoneNumber"] ?? "",
    );
  }

  factory UserModel.fromJsonByDatabase(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"] ?? "",
      email: map["email"] ?? "",
      username: map["username"] ?? "",
      phoneNumber: map["phone_number"] ?? "",
    );
  }
}
