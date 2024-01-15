import 'package:flutter/material.dart';

class AppTheme {
  static const Color greenColor = Color(0XFF4FCCA3);
  static const Color darkBlueColor = Color(0XFF242A32);
  static const Color darkGreyColor = Color(0XFF3A3F47);
  static const Color lightGreyColor = Color.fromARGB(255, 232, 232, 232);
  static const Color grey = Color(0XFFA0A3A8);
  static const Color whiteColor = Color(0XFFFFFFFF);

  static const String fontFamily = 'Poppins';
  static const EdgeInsets defaultButtonPadding = EdgeInsets.symmetric(
    vertical: 10,
    horizontal: 12,
  );

  static ThemeData getThemeByBrightness(Brightness brightness) {
    return brightness == Brightness.light ? lightTheme : darkTheme;
  }

  static ThemeData get darkTheme {
    const brightness = Brightness.dark;
    final colorScheme = getColorSchemeByBrightness(brightness);

    return ThemeData(
      brightness: brightness,
      fontFamily: fontFamily,
      colorScheme: getColorSchemeByBrightness(brightness),
      textTheme: getTextThemeByBrightness(brightness),
      scaffoldBackgroundColor: colorScheme.background,
      textButtonTheme: getTextButtonTheme(brightness),
      elevatedButtonTheme: getElevatedButtonTheme(brightness),
      chipTheme: getChipTheme(brightness),
      appBarTheme: appBarTheme,
      listTileTheme: getListTileThemeData(brightness),
      tabBarTheme: getTabBarTheme(brightness),
      inputDecorationTheme: getInputDecorationTheme(brightness),
    );
  }

  static ThemeData get lightTheme {
    const brightness = Brightness.light;
    final colorScheme = getColorSchemeByBrightness(brightness);

    return ThemeData(
      brightness: brightness,
      fontFamily: fontFamily,
      colorScheme: getColorSchemeByBrightness(brightness),
      textTheme: getTextThemeByBrightness(brightness),
      scaffoldBackgroundColor: colorScheme.background,
      textButtonTheme: getTextButtonTheme(brightness),
      elevatedButtonTheme: getElevatedButtonTheme(brightness),
      chipTheme: getChipTheme(brightness),
      appBarTheme: appBarTheme,
      listTileTheme: getListTileThemeData(brightness),
      tabBarTheme: getTabBarTheme(brightness),
      inputDecorationTheme: getInputDecorationTheme(brightness),
    );
  }

  static ColorScheme getColorSchemeByBrightness(Brightness brightness) {
    return brightness == Brightness.light ? lightColorScheme : darkColorScheme;
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

  static ColorScheme get lightColorScheme {
    return const ColorScheme.light(
      primary: greenColor,
      onPrimary: darkBlueColor,
      secondary: darkBlueColor,
      onSecondary: whiteColor,
      tertiary: grey,
      onTertiary: whiteColor,
      background: whiteColor,
      onBackground: darkBlueColor,
    );
  }

  static TextTheme getTextThemeByBrightness(Brightness brightness) {
    return TextTheme(
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        color: getColorSchemeByBrightness(brightness).onBackground,
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
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: const TextStyle(
        fontSize: 12,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static TextButtonThemeData getTextButtonTheme(Brightness brightness) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: getColorSchemeByBrightness(brightness).onBackground,
          textStyle: getTextThemeByBrightness(brightness).titleMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: defaultButtonPadding,
        ),
      );

  static ElevatedButtonThemeData getElevatedButtonTheme(
          Brightness brightness) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getTextThemeByBrightness(brightness).titleMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: defaultButtonPadding,
          minimumSize: const Size(0, 42),
        ),
      );

  static ChipThemeData getChipTheme(Brightness brightness) => ChipThemeData(
        backgroundColor: darkColorScheme.tertiary,
        selectedColor: darkColorScheme.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 0,
        ),
        labelStyle: getTextThemeByBrightness(brightness).bodyMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      );

  static AppBarTheme get appBarTheme => const AppBarTheme(
        backgroundColor: darkBlueColor,
        elevation: 0,
      );

  static ListTileThemeData getListTileThemeData(Brightness brightness) =>
      ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        minVerticalPadding: 0,
        titleTextStyle: getTextThemeByBrightness(brightness).titleSmall,
        subtitleTextStyle: getTextThemeByBrightness(brightness).bodyMedium,
        textColor: darkColorScheme.onBackground,
      );

  static TabBarTheme getTabBarTheme(Brightness brightness) => TabBarTheme(
        labelColor: getColorSchemeByBrightness(brightness).onBackground,
        labelStyle: getTextThemeByBrightness(brightness).titleMedium,
        unselectedLabelColor:
            getColorSchemeByBrightness(brightness).onBackground,
        unselectedLabelStyle:
            getTextThemeByBrightness(brightness).bodyLarge?.copyWith(
                  color: getColorSchemeByBrightness(brightness).onBackground,
                ),
        indicatorColor: getColorSchemeByBrightness(brightness).tertiary,
      );

  static InputDecorationTheme getInputDecorationTheme(Brightness brightness) =>
      InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: brightness == Brightness.dark
            ? getColorSchemeByBrightness(brightness).tertiary
            : lightGreyColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 19,
          vertical: 10,
        ),
        hintStyle: getTextThemeByBrightness(brightness).bodyLarge?.copyWith(
              color: getColorSchemeByBrightness(brightness).onBackground,
            ),
      );
}
