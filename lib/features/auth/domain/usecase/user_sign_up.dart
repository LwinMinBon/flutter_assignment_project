import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UserSignUp implements UseCase<UserEntity, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(UserSignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
        email: params.email,
        password: params.password,
        username: params.userName,
        phoneNumber: params.phoneNumber,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String userName;
  final String phoneNumber;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.userName,
    required this.phoneNumber,
  });
}