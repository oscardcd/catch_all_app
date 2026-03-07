import 'package:catch_all_app/core/core.dart';
import 'package:catch_all_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CatchAllApp extends StatelessWidget {
  const CatchAllApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Catch All',
            debugShowCheckedModeBanner: false,
            theme: themeMode == ThemeMode.light ? CATheme.light : CATheme.dark,
            themeMode: themeMode,
            routerConfig: AppRouter.goRouter,
            locale: TranslationProvider.of(context).flutterLocale, // use slang locale
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
          );
        },
      ),
    );
  }
}
