import 'package:flutter/material.dart';
import 'package:fate_developer_case/core/constants/colors.dart';
import 'package:fate_developer_case/core/theme/theme.dart';

class DarkAppTheme extends AppTheme {
  const DarkAppTheme()
    : super(
        name: 'Dark',
        brightness: Brightness.dark,
        colors: const AppThemeColors(
          primarySwatch: Colors.grey,
          primary: Color(0xFFF5F5F5),
          onPrimary: Color(0xFF111113),
          secondary: Color(0xFFA8A8AE),
          onSecondary: Color(0xFF111113),
          background: Color(0xFF0D0D0F),
          text: Color(0xFFF5F5F5),
          textSecondary: Color(0xFFA0A0A6),
          textHint: Color(0xFF6B6B70),
          border: Color(0xFF2A2A2E),
          success: Color(0xFF4ADE80),
          warning: Color(0xFFFBBF24),
          error: Color(0xFFF87171),
          info: Color(0xFF60A5FA),
          buttonDisabled: Color(0xFF3A3A3E),
        ),
      );
}
