import 'package:eventify/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:eventify/features/auth/data/repository/auth_repository_impl.dart';
import 'package:eventify/features/auth/domain/repository/auth_repository.dart';
import 'package:eventify/features/auth/domain/usecases/user_sign_up.dart';
import 'package:eventify/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: dotenv.env["projectUrl"]!,
    anonKey: dotenv.env["anonKey"]!,
  );

  getIt.registerLazySingleton<SupabaseClient>(
    () => supabase.client,
  );
  _initAuth();
  _initBloc();
}

void _initAuth() {
  getIt.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      supabaseClient: getIt(),
    ),
  );
  getIt.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: getIt(),
    ),
  );
  getIt.registerFactory<UserSignUp>(
    () => UserSignUp(
      authRepository: getIt(),
    ),
  );
}

void _initBloc() {
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      userSignUp: getIt(),
    ),
  );
}
