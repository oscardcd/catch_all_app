import 'package:catch_all_app/core/injector/injector.dart';
import 'package:catch_all_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: HomeScreen.route,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final user = await Repositories.auth.getCurrentUser();
      final isLoggingIn = state.matchedLocation == LoginScreen.route;

      if (user == null) {
        return isLoggingIn ? null : LoginScreen.route;
      }

      if (isLoggingIn) {
        return HomeScreen.route;
      }

      return null;
    },
    routes: [
      GoRoute(path: LoginScreen.route, name: LoginScreen.name, builder: LoginScreen.builder),
      GoRoute(path: HomeScreen.route, name: HomeScreen.name, builder: HomeScreen.builder),
      GoRoute(path: PokemonDetailScreen.route, name: PokemonDetailScreen.name, builder: PokemonDetailScreen.builder),
    ],
  );
}
