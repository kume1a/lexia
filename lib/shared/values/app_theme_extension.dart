import 'package:flutter/material.dart';

extension ThemeDataX on ThemeData {
  AppThemeExtension? get appThemeExtension => extension<AppThemeExtension>();
}

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  AppThemeExtension({required this.elSecondary, required this.success, required this.bgPopup});

  final Color elSecondary;
  final Color success;
  final Color bgPopup;

  @override
  ThemeExtension<AppThemeExtension> copyWith({Color? elSecondary, Color? success, Color? bgPopup}) {
    return AppThemeExtension(
      elSecondary: elSecondary ?? this.elSecondary,
      success: success ?? this.success,
      bgPopup: bgPopup ?? this.bgPopup,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      elSecondary: Color.lerp(elSecondary, other.elSecondary, t) ?? elSecondary,
      success: Color.lerp(success, other.success, t) ?? success,
      bgPopup: Color.lerp(bgPopup, other.bgPopup, t) ?? bgPopup,
    );
  }
}
