import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/signin_page.dart';
import '../features/auth/presentation/pages/signup_page.dart';
import '../features/auth/presentation/pages/welcome_page.dart';
import '../features/events/presentation/pages/create_event_page.dart';
import '../features/events/presentation/pages/home_page.dart';

GoRouter getRouter(String initialRoute) {
  return GoRouter(
    initialLocation: initialRoute,
    routes: <RouteBase>[
      GoRoute(
        name: "/welcome",
        path: "/welcome",
        builder: (context, state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        name: "/sign_in",
        path: "/sign_in",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SignInPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset(0.0, 0.0);
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: "/sign_up",
        path: "/sign_up",
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const SignUpPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset(0.0, 0.0);
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        name: "/home",
        path: "/home",
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        name: "/create_event",
        path: "/create_event",
        builder: (context, state) {
          return const CreateEventPage();
        },
      ),
    ],
  );
}
