import 'package:flutter/material.dart';

class AppTheme {
  static const Color greenColor = Color(0XFF4FCCA3);
  static const Color darkBlueColor = Color(0XFF242A32);
  static const Color darkGreyColor = Color(0XFF3A3F47);
  static const Color whiteColor = Color(0XFFFFFFFF);

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
      textButtonTheme: textButtonTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      chipTheme: chipTheme,
      appBarTheme: appBarTheme,
      listTileTheme: ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        titleTextStyle: textTheme.titleSmall,
        subtitleTextStyle: textTheme.bodyMedium,
        textColor: darkColorScheme.onBackground,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: darkColorScheme.onBackground,
        labelStyle: textTheme.titleMedium,
        unselectedLabelColor: darkColorScheme.onBackground,
        unselectedLabelStyle: textTheme.bodyLarge?.copyWith(
          color: darkColorScheme.onBackground,
        ),
        indicatorColor: darkColorScheme.tertiary,
      ),
    );
  }

  static ColorScheme get darkColorScheme {
    return const ColorScheme.dark(
      primary: greenColor,
      onPrimary: darkBlueColor,
      secondary: whiteColor,
      onSecondary: darkBlueColor,
      tertiary: darkGreyColor,
      onTertiary: whiteColor,
      background: darkBlueColor,
      onBackground: whiteColor,
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
      bodyLarge: const TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
      ),
      bodyMedium: const TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
      ),
    );
  }

  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkColorScheme.onBackground,
          textStyle: textTheme.titleMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: defaultButtonPadding,
        ),
      );

  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: textTheme.titleMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: defaultButtonPadding,
          minimumSize: const Size(0, 42),
        ),
      );

  static ChipThemeData get chipTheme => ChipThemeData(
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
      );

  static AppBarTheme get appBarTheme => const AppBarTheme(
        backgroundColor: darkBlueColor,
        elevation: 0,
      );
}
