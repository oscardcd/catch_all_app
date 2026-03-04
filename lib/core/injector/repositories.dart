import 'package:catch_all_app/domain/repositories/auth_repository.dart';
import 'package:get_it/get_it.dart';

Future<void> injectRepositories() async {}

class Repositories {
  const Repositories._();

  static IAuthRepository get auth => GetIt.I<IAuthRepository>();
}
