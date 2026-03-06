import 'package:catch_all_app/data/injector.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configure(String environment) async {
  getIt.init(environment: environment);
}
