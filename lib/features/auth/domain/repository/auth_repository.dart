import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entity/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
  });

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> getCurrentUserData();

  Future<Either<Failure, Unit>> signOut();
}