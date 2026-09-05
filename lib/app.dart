import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fate_developer_case/core/constants/extensions.dart';
import 'package:fate_developer_case/core/theme/dark_theme.dart';
import 'package:fate_developer_case/core/theme/light_theme.dart';
import 'package:fate_developer_case/l10n/app_localizations.dart';

class FateDeveloperCaseApp extends StatelessWidget {
  const FateDeveloperCaseApp({super.key});

  static const Size _designSize = Size(360, 800);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        onGenerateTitle: (context) => context.l10n.appName,
        debugShowCheckedModeBanner: false,
        theme: const LightAppTheme().themeData,
        darkTheme: const DarkAppTheme().themeData,
        themeMode: ThemeMode.system,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
