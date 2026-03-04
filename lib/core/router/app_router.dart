import 'package:catch_all_app/ui/login/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  const AppRouter._();

  GoRouter goRouter(GoRouterRedirect? redirect) => GoRouter(
        initialLocation: LoginScreen.route,
        routes: [
          GoRoute(
            path: LoginScreen.route,
            name: LoginScreen.name,
            builder: LoginScreen.builder,
          ),
        ],
        redirect: redirect,
      );
}
