import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
  });

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();

  Future<void> signOut();
}