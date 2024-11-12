import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/exception/exceptions.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({required String email, required String password, required String username, required String phoneNumber}) async {
    try {
      final userModel = await authRemoteDataSource.signUpWithEmailAndPassword(
          email: email,
          password: password,
          username: username,
          phoneNumber: phoneNumber
      );
      return right(UserEntity.fromModel(userModel));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userModel = await authRemoteDataSource.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      return right(UserEntity.fromModel(userModel));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUserData() async {
    try {
      final userModel = await authRemoteDataSource.getCurrentUserData();
      if (userModel == null) {
        return left(Failure("User is not signed in."));
      }
      return right(UserEntity.fromModel(userModel));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await authRemoteDataSource.signOut();
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}