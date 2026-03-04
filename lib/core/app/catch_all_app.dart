import 'package:catch_all_app/core/core.dart';
import 'package:flutter/material.dart';

class CatchAllApp extends StatelessWidget {
  const CatchAllApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Catch All App',
      debugShowCheckedModeBanner: false,
      theme: CATheme.light,
      darkTheme: CATheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
