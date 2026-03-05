import 'package:catch_all_app/core/core.dart';
import 'package:catch_all_app/data/repositories/repositories.dart';
import 'package:catch_all_app/domain/domain.dart';
import 'package:catch_all_app/domain/repositories/pokemon_repository.dart';
import 'package:get_it/get_it.dart';

Future<void> injectRepositories() async {
  GetIt.I.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(authService: Services.authService, localStorage: Services.localStorage),
  );

  GetIt.I.registerLazySingleton<PokemonRepository>(
    () => PokemonRepositoryImpl(Services.pokemonService),
  );
}

class Repositories {
  const Repositories._();

  static IAuthRepository get auth => GetIt.I<IAuthRepository>();
  static PokemonRepository get pokemonRepository => GetIt.I<PokemonRepository>();
}
