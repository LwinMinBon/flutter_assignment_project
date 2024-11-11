import 'package:eventify/core/exception/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
  });
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<String> signUpWithEmailAndPassword({required String email, required String password, required String username, required String phoneNumber}) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          "username": username,
          "phoneNumber": phoneNumber,
        }
      );
      if (response.user == null) {
        throw ServerException(message: "User is null!");
      }
      return response.user!.id;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> signInWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

}