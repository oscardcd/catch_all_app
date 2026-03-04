import 'package:catch_all_app/core/injector/init.dart';
import 'package:flutter/material.dart';

import 'core/core.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const CatchAllApp());
}
