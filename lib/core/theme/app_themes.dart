import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  //light theme
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: LightThemeColors.primaryColor,
    colorScheme: const ColorScheme.light(
      surface: LightThemeColors.surfaceColor,
      onSurface: LightThemeColors.onSurfaceColor,
      primary: LightThemeColors.primaryColor,
      secondary: LightThemeColors.secondaryColor,
      tertiary: LightThemeColors.brandColor,
      onTertiary: LightThemeColors.onBrandColor,
      tertiaryContainer: LightThemeColors.tertiaryContainerColor,
      surfaceContainer: LightThemeColors.surfaceContainerColor
    ),
    scaffoldBackgroundColor: LightThemeColors.surfaceColor,
  );

  //dark theme
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: DarkThemeColors.primaryColor,
    colorScheme: const ColorScheme.dark(
      surface: DarkThemeColors.surfaceColor,
      onSurface: DarkThemeColors.onSurfaceColor,
      primary: DarkThemeColors.primaryColor,
      secondary: DarkThemeColors.secondaryColor,
      tertiary: DarkThemeColors.brandColor,
      onTertiary: DarkThemeColors.onBrandColor,
      tertiaryContainer: DarkThemeColors.tertiaryContainerColor,
      surfaceContainer: DarkThemeColors.surfaceContainerColor
    ),
    scaffoldBackgroundColor: DarkThemeColors.surfaceColor,
  );
}