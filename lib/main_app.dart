import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/common/cubits/app_user_cubit.dart';
import 'core/theme/app_themes.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'routing/router.dart';

class MainMaterialApp extends StatefulWidget {
  const MainMaterialApp({super.key});

  @override
  State<MainMaterialApp> createState() => _MainMaterialAppState();
}

class _MainMaterialAppState extends State<MainMaterialApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCurrentUserFetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        if (state is AppUserInitial) {
          return _loadingCurrentUserIndicator();
        }
        if (state is AppUserSignOut) {
          return _loadedCurrentUser("/welcome");
        }
        return _loadedCurrentUser("/home");
      },
    );
  }

  Widget _loadingCurrentUserIndicator() {
    return MaterialApp(
      title: "Main Material App",
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _loadedCurrentUser(String initialRoute) {
    return MaterialApp.router(
      title: "Main Material App",
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: getRouter(initialRoute),
    );
  }
}