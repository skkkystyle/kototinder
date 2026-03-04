import 'package:flutter/material.dart';

class AppGradients extends ThemeExtension<AppGradients> {
  final Gradient primaryGradient;

  const AppGradients({required this.primaryGradient});

  @override
  ThemeExtension<AppGradients> copyWith() {
    return AppGradients(primaryGradient: primaryGradient);
  }

  @override
  ThemeExtension<AppGradients> lerp(
    ThemeExtension<AppGradients>? other,
    double t,
  ) {
    if (other is! AppGradients) return this;
    return AppGradients(
      primaryGradient:
          Gradient.lerp(primaryGradient, other.primaryGradient, t) ??
          primaryGradient,
    );
  }

  static const defaultGradients = AppGradients(
    primaryGradient: LinearGradient(
      colors: [Color(0xFFe3b3f3), Color(0xFFbcbcf3)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );
}
