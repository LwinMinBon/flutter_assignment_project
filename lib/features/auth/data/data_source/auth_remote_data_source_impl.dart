import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exception/exceptions.dart';
import '../model/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
        required String password,
        required String username,
        required String phoneNumber}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(email: email, password: password, data: {
        "username": username,
        "phoneNumber": phoneNumber,
      });
      if (response.user == null) {
        throw ServerException(message: "User is null!");
      }
      final userJson = response.user!.toJson();
      return UserModel.fromJsonByAuthentication(userJson);
    }  on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw ServerException(message: "User doesn't exist.");
      }
      final userJson = response.user!.toJson();
      return UserModel.fromJsonByAuthentication(userJson);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from("profiles").select().eq("id", currentUserSession!.user.id);
        final userModel = UserModel.fromJsonByDatabase(userData.first);
        return userModel;
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut(scope: SignOutScope.local);
    } on AuthException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}