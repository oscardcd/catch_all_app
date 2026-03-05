import 'package:catch_all_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';

import 'core/core.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Storage via Hive
  await LocalStorage.instance.init();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on Exception catch (e) {
    print(e);
  }

  await configureDependencies();
  runApp(const CatchAllApp());
}
