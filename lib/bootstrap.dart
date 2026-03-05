import 'package:catch_all_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';

import 'core/core.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // Initialize Local Storage via Hive
    await LocalStorage.instance.init();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await configureDependencies();
    runApp(const CatchAllApp());
  } on Exception catch (e) {
    print(e);
  }
}
