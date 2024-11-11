import 'package:eventify/core/error/failure.dart';
import 'package:eventify/core/exception/exceptions.dart';
import 'package:eventify/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:eventify/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword({required String email, required String password, required String username, required String phoneNumber}) async {
    try {
      final userId = await authRemoteDataSource.signUpWithEmailAndPassword(
          email: email,
          password: password,
          username: username,
          phoneNumber: phoneNumber
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }
}