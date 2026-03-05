import 'package:catch_all_app/core/core.dart';
import 'package:catch_all_app/data/repositories/repositories.dart';
import 'package:catch_all_app/domain/domain.dart';
import 'package:get_it/get_it.dart';

Future<void> injectRepositories() async {
  // Register your repositories here as the app grows.
  // Example:
  // GetIt.I.registerLazySingleton<IAuthRepository>(
  //   () => AuthRepository(Services.secureStorage),
  // );

  GetIt.I.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(authService: Services.authService, localStorage: Services.localStorage),
  );
}

class Repositories {
  const Repositories._();

  static IAuthRepository get auth => GetIt.I<IAuthRepository>();
}
