import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage/local_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  static const String _boxName = 'settings';
  static const String _key = 'theme_mode';

  void _loadTheme() async {
    try {
      final themeIndex = await LocalStorage.instance.get<int>(_boxName, _key);
      if (themeIndex != null && themeIndex < ThemeMode.values.length) {
        emit(ThemeMode.values[themeIndex]);
      }
    } catch (_) {
      emit(ThemeMode.system);
    }
  }

  void updateTheme(ThemeMode mode) async {
    emit(mode);
    try {
      await LocalStorage.instance.put<int>(_boxName, _key, mode.index);
    } catch (_) {}
  }
}
