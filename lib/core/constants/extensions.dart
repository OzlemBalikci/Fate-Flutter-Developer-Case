import 'package:flutter/material.dart';
import 'package:fate_developer_case/core/constants/colors.dart';
import 'package:fate_developer_case/core/theme/light_theme.dart';
import 'package:fate_developer_case/core/theme/theme.dart';
import 'package:fate_developer_case/l10n/app_localizations.dart';

extension AppThemeExtension on BuildContext {
  AppTheme get appTheme =>
      Theme.of(this).extension<AppTheme>() ?? const LightAppTheme();

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppThemeColors get colors => appTheme.colors;
}

extension TextStyleExtension on TextStyle {
  TextStyle withHeight(double? height) => copyWith(height: height);

  TextStyle withColor(Color? color) => copyWith(color: color);

  TextStyle withSize(double? size) => copyWith(fontSize: size);

  TextStyle withWeight(FontWeight? weight) =>
      merge(TextStyle(fontWeight: weight));
}

extension ContextL10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
