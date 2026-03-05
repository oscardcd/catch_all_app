import 'package:catch_all_app/data/services/pokemon_service_impl.dart';
import 'package:catch_all_app/data/services/services.dart';
import 'package:catch_all_app/domain/services/auth_service.dart';
import 'package:catch_all_app/domain/services/pokemon_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_storage/local_storage.dart';
import 'package:get_it/get_it.dart';

Future<void> injectServices() async {
  GetIt.I.registerLazySingleton<LocalStorage>(() => LocalStorage.instance);
  GetIt.I.registerLazySingleton<AuthService>(() => AuthServiceImpl(
        firebaseAuth: FirebaseAuth.instance,
        googleSignIn: GoogleSignIn.instance,
      ));
  GetIt.I.registerLazySingleton<PokemonService>(() => PokemonServiceImpl());
}

class Services {
  const Services._();

  static LocalStorage get localStorage => GetIt.I<LocalStorage>();
  static AuthService get authService => GetIt.I<AuthService>();
  static PokemonService get pokemonService => GetIt.I<PokemonService>();
}
