import 'package:flutter/material.dart';
import 'package:fate_developer_case/core/constants/colors.dart';
import 'package:fate_developer_case/core/theme/theme.dart';

class LightAppTheme extends AppTheme {
  const LightAppTheme()
    : super(
        name: 'Light',
        brightness: Brightness.light,
        colors: const AppThemeColors(
          primarySwatch: Colors.grey,
          primary: Color(0xFF111113),
          onPrimary: Color(0xFFFFFFFF),
          secondary: Color(0xFF4A4A4F),
          onSecondary: Color(0xFFFFFFFF),
          background: Color(0xFFFAFAFA),
          text: Color(0xFF111113),
          textSecondary: Color(0xFF5C5C61),
          textHint: Color(0xFFA0A0A6),
          border: Color(0xFFE3E3E6),
          success: Color(0xFF16A34A),
          warning: Color(0xFFF59E0B),
          error: Color(0xFFEF4444),
          info: Color(0xFF3B82F6),
          buttonDisabled: Color(0xFFD4D4D8),
        ),
      );
}
