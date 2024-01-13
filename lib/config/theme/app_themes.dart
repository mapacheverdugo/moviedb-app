import 'package:flutter/material.dart';

class AppTheme {
  static const String fontFamily = 'Poppins';
  static const EdgeInsets defaultButtonPadding = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 12,
  );

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      colorScheme: darkColorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: darkColorScheme.background,
      chipTheme: ChipThemeData(
        backgroundColor: darkColorScheme.tertiary,
        selectedColor: darkColorScheme.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 0,
        ),
        labelStyle: textTheme.bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkColorScheme.onBackground,
          textStyle: textTheme.titleMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: defaultButtonPadding,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: textTheme.titleMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: defaultButtonPadding,
          minimumSize: const Size(0, 42),
        ),
      ),
    );
  }

  static ColorScheme get darkColorScheme {
    return const ColorScheme.dark(
      primary: Color(0XFF4FCCA3),
      onPrimary: Color(0XFF242A32),
      secondary: Color(0XFFFFFFFF),
      onSecondary: Color(0XFF242A32),
      tertiary: Color(0XFF3A3F47),
      onTertiary: Color(0XFFFFFFFF),
      background: Color(0XFF242A32),
      onBackground: Color(0XFFFFFFFF),
    );
  }

  static TextTheme get textTheme {
    return TextTheme(
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        color: darkColorScheme.onBackground,
      ),
      titleLarge: const TextStyle(
        fontSize: 18,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: const TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: const TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: const TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
      ),
    );
  }
}
