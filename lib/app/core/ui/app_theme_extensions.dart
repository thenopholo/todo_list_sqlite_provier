import 'package:flutter/material.dart';

extension AppThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get buttonColor => Theme.of(this).colorScheme.primary;
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get titleText => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      );
}
