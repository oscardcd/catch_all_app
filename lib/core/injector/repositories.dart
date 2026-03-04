import 'package:catch_all_app/core/injector/services.dart';

Future<void> injectRepositories() async {
  // Register your repositories here as the app grows.
  // Example:
  // GetIt.I.registerLazySingleton<IAuthRepository>(
  //   () => AuthRepository(Services.secureStorage),
  // );
}

class Repositories {
  const Repositories._();
  // Add repository getters here.
}
