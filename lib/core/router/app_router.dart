import 'package:catch_all_app/ui/ui.dart';
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
      GoRoute(
        path: HomeScreen.route,
        name: HomeScreen.name,
        builder: HomeScreen.builder,
      ),
      GoRoute(
        path: PokemonDetailScreen.route,
        name: PokemonDetailScreen.name,
        builder: PokemonDetailScreen.builder,
      ),
    ],
  );
}
