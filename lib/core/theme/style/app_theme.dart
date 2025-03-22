import 'package:flutter/material.dart';
import 'package:zanis/core/theme/data/theme_cache.dart';

enum theme { system, light, dark }

class AppTheme {
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? true : false;

  static Future<String> getThemeId() async {
    String currentThemeId = await ThemeCache.getThemeId();
    if (currentThemeId == theme.light.toString() ||
        currentThemeId == theme.dark.toString()) {
      return currentThemeId;
    } else {
      return getThemeIdBySystem();
    }
  }

  static String getThemeIdBySystem() =>
      isSystemDark() ? theme.dark.toString() : theme.light.toString();

  static bool isSystemDark() =>
      WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

  static final ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    textTheme: TextTheme(
      labelSmall: Typography.englishLike2021.labelSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: Typography.englishLike2021.labelMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: Typography.englishLike2021.labelLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: Typography.englishLike2021.bodySmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: Typography.englishLike2021.bodyMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: Typography.englishLike2021.bodyLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: Typography.englishLike2021.headlineSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: Typography.englishLike2021.headlineMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: Typography.englishLike2021.headlineLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: Typography.englishLike2021.displaySmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: Typography.englishLike2021.displayMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
      displayLarge: Typography.englishLike2021.displayLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 48,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: Typography.englishLike2021.titleSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: Typography.englishLike2021.titleMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: Typography.englishLike2021.titleLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ).apply(),
  );

  static final ThemeData dark = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.grey,
    ),
    textTheme: TextTheme(
      labelSmall: Typography.englishLike2021.labelSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: Typography.englishLike2021.labelMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: Typography.englishLike2021.labelLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: Typography.englishLike2021.bodySmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: Typography.englishLike2021.bodyMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: Typography.englishLike2021.bodyLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: Typography.englishLike2021.headlineSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: Typography.englishLike2021.headlineMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: Typography.englishLike2021.headlineLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: Typography.englishLike2021.displaySmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: Typography.englishLike2021.displayMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.w400,
      ),
      displayLarge: Typography.englishLike2021.displayLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 48,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: Typography.englishLike2021.titleSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: Typography.englishLike2021.titleMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: Typography.englishLike2021.titleLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ).apply(),
  );
}
