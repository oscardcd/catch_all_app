# Local Storage Package

A lightweight key-value storage package for the Catch All App, built on top of [Hive](https://pub.dev/packages/hive).

## 🚀 Features

- Blazing fast key-value storage.
- Easy to use Singleton pattern.
- Wrapper for common Hive operations.
- Support for Flutter out of the box.

## 📦 Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  local_storage:
    path: ./local_storage
```

## 🛠 Usage

### 1. Initialize the storage

Before using any other method, you must initialize the storage (typically in your `main.dart`):

```dart
import 'package:local_storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.instance.init();
  runApp(MyApp());
}
```

### 2. Basic CRUD operations

#### Put data
```dart
await LocalStorage.instance.put('settings', 'theme', 'dark');
```

#### Get data
```dart
final theme = await LocalStorage.instance.get<String>('settings', 'theme');
print(theme); // outputs: dark
```

#### Delete data
```dart
await LocalStorage.instance.delete('settings', 'theme');
```

#### Clear a box
```dart
await LocalStorage.instance.clear('settings');
```

### 3. Working with Boxes

The package manages box opening automatically, but you can also access a box directly if needed:

```dart
final box = await LocalStorage.instance.openBox<int>('counter');
```

## 🏗 Structure

- `lib/src/local_storage.dart`: Core implementation using Hive.
- `lib/local_storage.dart`: Public API exports.
