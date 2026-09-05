import 'package:flutter/material.dart';

@immutable
class AppThemeColors {
  const AppThemeColors({
    required this.primarySwatch,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.background,
    required this.text,
    required this.textSecondary,
    required this.textHint,
    required this.border,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.buttonDisabled,
  });

  final Color primarySwatch;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color background;
  final Color text;
  final Color textSecondary;
  final Color textHint;
  final Color border;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color buttonDisabled;

  AppThemeColors copyWith({
    Color? primarySwatch,
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? background,
    Color? text,
    Color? textSecondary,
    Color? textHint,
    Color? border,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? buttonDisabled,
  }) => AppThemeColors(
    primarySwatch: primarySwatch ?? this.primarySwatch,
    primary: primary ?? this.primary,
    onPrimary: onPrimary ?? this.onPrimary,
    secondary: secondary ?? this.secondary,
    onSecondary: onSecondary ?? this.onSecondary,
    background: background ?? this.background,
    text: text ?? this.text,
    textSecondary: textSecondary ?? this.textSecondary,
    textHint: textHint ?? this.textHint,
    border: border ?? this.border,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    error: error ?? this.error,
    info: info ?? this.info,
    buttonDisabled: buttonDisabled ?? this.buttonDisabled,
  );

  AppThemeColors lerp(AppThemeColors? other, double t) {
    if (other == null) return this;
    return AppThemeColors(
      primarySwatch: Color.lerp(primarySwatch, other.primarySwatch, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      text: Color.lerp(text, other.text, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      border: Color.lerp(border, other.border, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      buttonDisabled: Color.lerp(buttonDisabled, other.buttonDisabled, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppThemeColors &&
        other.primarySwatch == primarySwatch &&
        other.primary == primary &&
        other.onPrimary == onPrimary &&
        other.secondary == secondary &&
        other.onSecondary == onSecondary &&
        other.background == background &&
        other.text == text &&
        other.textSecondary == textSecondary &&
        other.textHint == textHint &&
        other.border == border &&
        other.success == success &&
        other.warning == warning &&
        other.error == error &&
        other.info == info &&
        other.buttonDisabled == buttonDisabled;
  }

  @override
  int get hashCode => Object.hash(
    primarySwatch,
    primary,
    onPrimary,
    secondary,
    onSecondary,
    background,
    text,
    textSecondary,
    textHint,
    border,
    success,
    warning,
    error,
    info,
    buttonDisabled,
  );

  @override
  String toString() =>
      'AppThemeColors(primary: $primary, '
      'background: $background, text: $text)';
}
