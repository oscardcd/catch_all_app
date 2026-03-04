import 'package:catch_all_app/ui/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: LoginScreen.route,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: LoginScreen.route,
        name: LoginScreen.name,
        builder: LoginScreen.builder,
      ),
    ],
  );
}
