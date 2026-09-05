import 'package:flutter/material.dart';
import 'package:fate_developer_case/core/constants/colors.dart';
import 'package:fate_developer_case/core/constants/typographies.dart';
import 'package:flutter_developer_task/core/constants/fonts.gen.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({
    required this.name,
    required this.brightness,
    required this.colors,
    this.typographies = const AppThemeTypography(),
    this.fontFamily = FontFamily.roboto,
  });

  final String name;
  final String fontFamily;
  final Brightness brightness;
  final AppThemeColors colors;
  final AppThemeTypography typographies;

  bool get isDark => brightness == Brightness.dark;

  // ─── ThemeData ─────────────────────────────────────────

  ThemeData get themeData => ThemeData(
    useMaterial3: false,
    extensions: [this],
    brightness: brightness,
    fontFamily: fontFamily,
    primaryColor: colors.primary,
    scaffoldBackgroundColor: colors.background,
    canvasColor: colors.background,
    hintColor: colors.textHint,
    dividerColor: colors.border,
    disabledColor: colors.buttonDisabled,
    colorScheme: _colorScheme,
    textTheme: _textTheme,
    appBarTheme: _appBarTheme,
    iconTheme: _iconTheme,
    dividerTheme: _dividerTheme,
    inputDecorationTheme: _inputDecorationTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    textButtonTheme: _textButtonTheme,
    cardTheme: _cardTheme,
    snackBarTheme: _snackBarTheme,
    progressIndicatorTheme: _progressIndicatorTheme,
  );

  // ─── ColorScheme ───────────────────────────────────────

  ColorScheme get _colorScheme =>
      (isDark ? const ColorScheme.dark() : const ColorScheme.light()).copyWith(
        brightness: brightness,
        primary: colors.primary,
        onPrimary: colors.onPrimary,
        secondary: colors.secondary,
        onSecondary: colors.onSecondary,
        surface: colors.background,
        onSurface: colors.text,
        error: colors.error,
        onError: colors.onPrimary,
        outline: colors.border,
        surfaceTint: colors.primary,
      );

  // ─── TextTheme ─────────────────────────────────────────

  // Ölçeklenmiş TextTheme yalnızca burada, themeData üretilirken (kökteki
  // ScreenUtilInit.builder içinde) bir kez oluşturulur ve tüm widget ağacına
  // ThemeData.textTheme üzerinden akar.
  TextTheme get _textTheme => typographies.toTextTheme(
    primaryColor: colors.text,
    secondaryColor: colors.textSecondary,
  );

  // ─── AppBar ────────────────────────────────────────────

  AppBarTheme get _appBarTheme => AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: colors.text,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: colors.text),
    titleTextStyle: typographies.titleMedium.copyWith(color: colors.text),
  );

  // ─── Icons ─────────────────────────────────────────────

  IconThemeData get _iconTheme => IconThemeData(color: colors.text);

  // ─── Divider ───────────────────────────────────────────

  DividerThemeData get _dividerTheme =>
      DividerThemeData(color: colors.border, thickness: 1, space: 1);

  // ─── Inputs ────────────────────────────────────────────

  InputDecorationTheme get _inputDecorationTheme {
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color, width: width),
        );

    return InputDecorationTheme(
      filled: true,
      fillColor: colors.background,
      hintStyle: typographies.bodySmall.copyWith(color: colors.textHint),
      labelStyle: typographies.titleSmall.copyWith(color: colors.textSecondary),
      errorStyle: typographies.bodySmall.copyWith(color: colors.error),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: border(colors.border),
      enabledBorder: border(colors.border),
      focusedBorder: border(colors.primary, 1.5),
      errorBorder: border(colors.error),
      focusedErrorBorder: border(colors.error, 1.5),
      disabledBorder: border(colors.buttonDisabled),
    );
  }

  // ─── Buttons ───────────────────────────────────────────

  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: colors.primary,
      foregroundColor: colors.onPrimary,
      disabledBackgroundColor: colors.buttonDisabled,
      disabledForegroundColor: colors.onPrimary,
      textStyle: typographies.labelLarge,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  OutlinedButtonThemeData get _outlinedButtonTheme => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: colors.primary,
      textStyle: typographies.labelMedium,
      side: BorderSide(color: colors.border),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colors.primary,
      textStyle: typographies.labelMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  // ─── Card ──────────────────────────────────────────────

  CardThemeData get _cardTheme => CardThemeData(
    elevation: 0,
    color: colors.background,
    surfaceTintColor: Colors.transparent,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: colors.border),
    ),
  );

  // ─── SnackBar ──────────────────────────────────────────

  SnackBarThemeData get _snackBarTheme => SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: colors.text,
    contentTextStyle: typographies.bodyMedium.copyWith(
      color: colors.background,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );

  // ─── ProgressIndicator ─────────────────────────────────

  ProgressIndicatorThemeData get _progressIndicatorTheme =>
      ProgressIndicatorThemeData(color: colors.primary);

  // ─── ThemeExtension ────────────────────────────────────

  @override
  AppTheme copyWith({
    String? name,
    Brightness? brightness,
    AppThemeColors? colors,
    AppThemeTypography? typographies,
    String? fontFamily,
  }) => AppTheme(
    name: name ?? this.name,
    brightness: brightness ?? this.brightness,
    colors: colors ?? this.colors,
    typographies: typographies ?? this.typographies,
    fontFamily: fontFamily ?? this.fontFamily,
  );

  @override
  AppTheme lerp(covariant ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;
    return AppTheme(
      name: name,
      brightness: brightness,
      fontFamily: fontFamily,
      colors: colors.lerp(other.colors, t),
      typographies: typographies.lerp(other.typographies, t),
    );
  }
}
