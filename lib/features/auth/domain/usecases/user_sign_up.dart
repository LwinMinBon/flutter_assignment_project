import 'package:eventify/core/error/failure.dart';
import 'package:eventify/core/usecase/Usecase.dart';
import 'package:eventify/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
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