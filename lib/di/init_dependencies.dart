import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/common/cubits/app_user_cubit.dart';
import '../features/auth/data/data_source/auth_remote_data_source.dart';
import '../features/auth/data/data_source/auth_remote_data_source_impl.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';
import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/usecase/current_user_fetch.dart';
import '../features/auth/domain/usecase/user_sign_in.dart';
import '../features/auth/domain/usecase/user_sign_out.dart';
import '../features/auth/domain/usecase/user_sign_up.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/events/data/data_source/event_remote_data_source.dart';
import '../features/events/data/data_source/event_remote_data_source_impl.dart';
import '../features/events/data/repository/event_repository_impl.dart';
import '../features/events/domain/repository/event_repository.dart';
import '../features/events/domain/usecase/create_event.dart';
import '../features/events/domain/usecase/get_all_events.dart';
import '../features/events/domain/usecase/get_event.dart';
import '../features/events/domain/usecase/remove_event.dart';
import '../features/events/domain/usecase/update_event.dart';
import '../features/events/presentation/bloc/event_bloc/event_bloc.dart';
import '../features/events/presentation/bloc/event_edition_bloc/event_edition_bloc.dart';
import '../features/events/presentation/bloc/event_removal_bloc/event_removal_bloc.dart';
import '../features/events/presentation/bloc/events_bloc/events_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: dotenv.env["projectUrl"]!,
    anonKey: dotenv.env["anonKey"]!,
  );
  _initSupabaseDependencies(supabase.client);
  _initCoreDependencies();
  _initAuthDependencies();
  _initEventDependencies();
  _initBlocDependencies();
}

void _initSupabaseDependencies(SupabaseClient client) {
  getIt.registerLazySingleton<SupabaseClient>(
    () => client,
  );
}

void _initCoreDependencies() {
  getIt.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(),
  );
}

void _initAuthDependencies() {
  getIt
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: getIt(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: getIt(),
      ),
    )
    ..registerFactory<UserSignUp>(
      () => UserSignUp(
        authRepository: getIt(),
      ),
    )
    ..registerFactory<UserSignIn>(
      () => UserSignIn(
        authRepository: getIt(),
      ),
    )
    ..registerFactory<CurrentUserFetch>(
      () => CurrentUserFetch(
        authRepository: getIt(),
      ),
    )
    ..registerFactory(
      () => UserSignOut(
        authRepository: getIt(),
      ),
    );
}

void _initEventDependencies() {
  getIt
    ..registerFactory<EventRemoteDataSource>(
      () => EventRemoteDataSourceImpl(
        supabaseClient: getIt(),
      ),
    )
    ..registerFactory<EventRepository>(
      () => EventRepositoryImpl(
        eventRemoteDataSource: getIt(),
      ),
    )
    ..registerFactory<CreateEvent>(
      () => CreateEvent(
        eventRepository: getIt(),
      ),
    )
    ..registerFactory<GetAllEvents>(
      () => GetAllEvents(
        eventRepository: getIt(),
      ),
    )
    ..registerFactory<GetEvent>(
      () => GetEvent(
        eventRepository: getIt(),
      ),
    )
    ..registerFactory<RemoveEvent>(
      () => RemoveEvent(
        eventRepository: getIt(),
      ),
    )
    ..registerFactory<UpdateEvent>(
          () => UpdateEvent(
        eventRepository: getIt(),
      ),
    );
}

void _initBlocDependencies() {
  getIt
    ..registerLazySingleton<AuthBloc>(
      () => AuthBloc(
        userSignUp: getIt(),
        userSignIn: getIt(),
        currentUserFetch: getIt(),
        appUserCubit: getIt(),
        userSignOut: getIt(),
      ),
    )
    ..registerLazySingleton<EventBloc>(
      () => EventBloc(
        createEvent: getIt(),
        getEvent: getIt(),
      ),
    )
    ..registerLazySingleton<EventRemovalBloc>(
      () => EventRemovalBloc(
        removeEvent: getIt(),
      ),
    )
    ..registerLazySingleton<EventEditionBloc>(
          () => EventEditionBloc(
        updateEvent: getIt(),
      ),
    )
    ..registerLazySingleton<EventsBloc>(
      () => EventsBloc(
        getAllEvents: getIt(),
      ),
    );
}
