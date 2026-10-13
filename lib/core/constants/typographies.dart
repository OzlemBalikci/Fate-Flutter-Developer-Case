import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@immutable
class AppThemeTypography {
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  const AppThemeTypography({
    this.displayLarge = const TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      height: 1.10,
      letterSpacing: -0.50,
    ),
    this.displayMedium = const TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      height: 1.12,
      letterSpacing: -0.25,
    ),
    this.displaySmall = const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      height: 1.15,
      letterSpacing: -0.25,
    ),
    this.headlineLarge = const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      height: 1.20,
      letterSpacing: -0.25,
    ),
    this.headlineMedium = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      height: 1.25,
      letterSpacing: 0.00,
    ),
    this.headlineSmall = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.30,
      letterSpacing: 0.00,
    ),
    this.titleLarge = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.35,
      letterSpacing: 0.00,
    ),
    this.titleMedium = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.40,
      letterSpacing: 0.10,
    ),
    this.titleSmall = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.40,
      letterSpacing: 0.10,
    ),
    this.bodyLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.50,
      letterSpacing: 0.15,
    ),
    this.bodyMedium = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.50,
      letterSpacing: 0.25,
    ),
    this.bodySmall = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.50,
      letterSpacing: 0.40,
    ),
    this.labelLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.40,
      letterSpacing: 0.10,
    ),
    this.labelMedium = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.40,
      letterSpacing: 0.10,
    ),
    this.labelSmall = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.40,
      letterSpacing: 0.50,
    ),
  });

  TextTheme toTextTheme({Color? primaryColor, Color? secondaryColor}) {
    TextStyle build(TextStyle style, Color? color) => style.copyWith(
      fontSize: style.fontSize?.sp,
      letterSpacing: style.letterSpacing?.sp,
      color: color,
    );

    return TextTheme(
      displayLarge: build(displayLarge, primaryColor),
      displayMedium: build(displayMedium, primaryColor),
      displaySmall: build(displaySmall, primaryColor),
      headlineLarge: build(headlineLarge, primaryColor),
      headlineMedium: build(headlineMedium, primaryColor),
      headlineSmall: build(headlineSmall, primaryColor),
      titleLarge: build(titleLarge, primaryColor),
      titleMedium: build(titleMedium, primaryColor),
      titleSmall: build(titleSmall, primaryColor),
      bodyLarge: build(bodyLarge, primaryColor),
      bodyMedium: build(bodyMedium, secondaryColor ?? primaryColor),
      bodySmall: build(bodySmall, secondaryColor ?? primaryColor),
      labelLarge: build(labelLarge, primaryColor),
      labelMedium: build(labelMedium, primaryColor),
      labelSmall: build(labelSmall, primaryColor),
    );
  }

  AppThemeTypography copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) => AppThemeTypography(
    displayLarge: displayLarge ?? this.displayLarge,
    displayMedium: displayMedium ?? this.displayMedium,
    displaySmall: displaySmall ?? this.displaySmall,
    headlineLarge: headlineLarge ?? this.headlineLarge,
    headlineMedium: headlineMedium ?? this.headlineMedium,
    headlineSmall: headlineSmall ?? this.headlineSmall,
    titleLarge: titleLarge ?? this.titleLarge,
    titleMedium: titleMedium ?? this.titleMedium,
    titleSmall: titleSmall ?? this.titleSmall,
    bodyLarge: bodyLarge ?? this.bodyLarge,
    bodyMedium: bodyMedium ?? this.bodyMedium,
    bodySmall: bodySmall ?? this.bodySmall,
    labelLarge: labelLarge ?? this.labelLarge,
    labelMedium: labelMedium ?? this.labelMedium,
    labelSmall: labelSmall ?? this.labelSmall,
  );

  AppThemeTypography lerp(AppThemeTypography other, double t) {
    TextStyle lerpStyle(TextStyle a, TextStyle b) =>
        TextStyle.lerp(a, b, t) ?? b;

    return AppThemeTypography(
      displayLarge: lerpStyle(displayLarge, other.displayLarge),
      displayMedium: lerpStyle(displayMedium, other.displayMedium),
      displaySmall: lerpStyle(displaySmall, other.displaySmall),
      headlineLarge: lerpStyle(headlineLarge, other.headlineLarge),
      headlineMedium: lerpStyle(headlineMedium, other.headlineMedium),
      headlineSmall: lerpStyle(headlineSmall, other.headlineSmall),
      titleLarge: lerpStyle(titleLarge, other.titleLarge),
      titleMedium: lerpStyle(titleMedium, other.titleMedium),
      titleSmall: lerpStyle(titleSmall, other.titleSmall),
      bodyLarge: lerpStyle(bodyLarge, other.bodyLarge),
      bodyMedium: lerpStyle(bodyMedium, other.bodyMedium),
      bodySmall: lerpStyle(bodySmall, other.bodySmall),
      labelLarge: lerpStyle(labelLarge, other.labelLarge),
      labelMedium: lerpStyle(labelMedium, other.labelMedium),
      labelSmall: lerpStyle(labelSmall, other.labelSmall),
    );
  }
}
