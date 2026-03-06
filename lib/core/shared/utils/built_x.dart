import 'package:flutter/material.dart';

extension BuildX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
