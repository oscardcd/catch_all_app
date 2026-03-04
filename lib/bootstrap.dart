import 'package:catch_all_app/core/injector/init.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:local_storage/local_storage.dart';

import 'core/core.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Storage via Hive
  await LocalStorage.instance.init();

  // Initialize Firebase (run 'flutterfire configure' to generate firebase_options.dart)
  await Firebase.initializeApp();

  await configureDependencies();
  runApp(const CatchAllApp());
}
