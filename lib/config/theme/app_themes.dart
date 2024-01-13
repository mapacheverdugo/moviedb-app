import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    colorScheme: darkColorScheme(),
    textTheme: textTheme(),
    scaffoldBackgroundColor: darkColorScheme().background,
  );
}

ColorScheme darkColorScheme() {
  return const ColorScheme.dark(
    primary: Color(0XFF4FCCA3),
    secondary: Color(0XFFFFFFFF),
    background: Color(0XFF242A32),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
    ),
  );
}
