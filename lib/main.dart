import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/common/cubits/app_user_cubit.dart';
import 'di/init_dependencies.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/events/presentation/bloc/event_bloc/event_bloc.dart';
import 'features/events/presentation/bloc/event_edition_bloc/event_edition_bloc.dart';
import 'features/events/presentation/bloc/event_removal_bloc/event_removal_bloc.dart';
import 'features/events/presentation/bloc/events_bloc/events_bloc.dart';
import 'main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AppUserCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<EventBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<EventRemovalBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<EventEditionBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<EventsBloc>(),
        ),
      ],
      child: const MainMaterialApp(),
    ),
  );
}
