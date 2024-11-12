import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UserSignIn implements UseCase<UserEntity, UserSignInParams> {
  final AuthRepository authRepository;
  UserSignIn({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(UserSignInParams params) async {
    return await authRepository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;
  UserSignInParams({
    required this.email,
    required this.password,
  });
}