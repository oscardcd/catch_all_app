import 'package:catch_all_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/local_storage.dart';
import 'core/core.dart';
import 'i18n/strings.g.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  try {
    // Initialize Local Storage via Hive
    await LocalStorage.instance.init();

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    await configureDependencies();
    runApp(TranslationProvider(child: const CatchAllApp()));
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}
