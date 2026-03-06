import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  LocalStorage._privateConstructor();
  static final LocalStorage _instance = LocalStorage._privateConstructor();

  static LocalStorage get instance => _instance;

  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    return await Hive.openBox<T>(boxName);
  }

  Future<void> put<T>(String boxName, String key, T value) async {
    final box = await openBox<T>(boxName);
    await box.put(key, value);
  }

  Future<T?> get<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  Future<void> delete(String boxName, String key) async {
    final box = await openBox(boxName);
    await box.delete(key);
  }

  Future<void> clear(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }
}
