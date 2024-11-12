import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class CurrentUserFetch implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;
  CurrentUserFetch({required this.authRepository});
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.getCurrentUserData();
  }
}