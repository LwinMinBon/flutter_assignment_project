import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class UserSignOut implements UseCase<Unit, NoParams> {
  final AuthRepository authRepository;
  UserSignOut({required this.authRepository});
  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await authRepository.signOut();
  }
}