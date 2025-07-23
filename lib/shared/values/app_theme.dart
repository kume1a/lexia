import 'package:flutter/material.dart';

import 'app_theme_extension.dart';
import 'palette.dart';

final _defaultButtonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
const _defaultButtonPadding = EdgeInsets.all(16);

final _defaultInputBorderRadius = BorderRadius.circular(10);

abstract final class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    splashFactory: NoSplash.splashFactory,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.secondary,
      secondary: Palette.secondary,
      onSecondary: Palette.onSecondary,
      primaryContainer: Palette.primaryContainer,
      secondaryContainer: Palette.secondaryContainer,
      surface: Palette.surface,
      onSurface: Palette.onSurface,
    ),
    scaffoldBackgroundColor: Palette.surface,
    dividerColor: Palette.elSecondary,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Palette.elPrimary,
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      backgroundColor: Palette.primaryContainer,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Palette.secondaryDark,
      foregroundColor: Palette.onSecondaryDark,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Palette.surface,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Palette.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 14, color: Palette.elPrimary),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(linearTrackColor: Palette.secondary),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Palette.primaryContainer,
      border: OutlineInputBorder(borderRadius: _defaultInputBorderRadius, borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: _defaultInputBorderRadius, borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderRadius: _defaultInputBorderRadius,
        borderSide: const BorderSide(color: Palette.secondaryContainer),
      ),
      isDense: true,
      constraints: const BoxConstraints(minHeight: 1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      hintStyle: const TextStyle(fontSize: 13, color: Palette.elSecondary),
      labelStyle: const TextStyle(fontSize: 13, color: Palette.elSecondary),
      alignLabelWithHint: true,
      errorMaxLines: 2,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled) ? Palette.secondaryLight : Palette.secondary,
        ),
        shape: WidgetStateProperty.all(_defaultButtonShape),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        overlayColor: WidgetStateProperty.all(Palette.secondaryDark),
        padding: WidgetStateProperty.all(_defaultButtonPadding),
        splashFactory: NoSplash.splashFactory,
        visualDensity: VisualDensity.compact,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected) ? Palette.secondary : Palette.elSecondary,
      ),
      visualDensity: VisualDensity.compact,
    ),
    extensions: [
      AppThemeExtension(elSecondary: Palette.elSecondary, success: Palette.success, bgPopup: Palette.bgPopup),
    ],
  );
}
