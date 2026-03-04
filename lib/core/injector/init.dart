import 'package:catch_all_app/core/injector/services.dart';
import 'package:catch_all_app/core/injector/repositories.dart';

Future<void> configureDependencies() async {
  await injectServices();
  await injectRepositories();
}
