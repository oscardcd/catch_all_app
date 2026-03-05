import 'package:catch_all_app/core/core.dart';

Future<void> configureDependencies() async {
  await injectServices();
  await injectRepositories();
}
