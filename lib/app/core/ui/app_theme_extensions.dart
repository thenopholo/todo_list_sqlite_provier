import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension AppThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get buttonColor => Theme.of(this).colorScheme.primary;
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get titleText => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      );
}
