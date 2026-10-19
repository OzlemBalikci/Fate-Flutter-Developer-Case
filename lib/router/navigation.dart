import 'package:auto_route/auto_route.dart';
import 'package:fate_developer_case/features/home/presentation/pages/home_page.dart';
import 'package:fate_developer_case/features/image_edit/presentation/pages/image_edit_page.dart';
import 'package:fate_developer_case/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:fate_developer_case/features/paywall/presentation/pages/paywall_page.dart';
import 'package:fate_developer_case/features/result/presentation/pages/result_page.dart';
import 'package:fate_developer_case/features/splash/presentation/pages/splash_page.dart';
import 'package:injectable/injectable.dart';

part 'navigation.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: SplashRoute.page, initial: true),
    AutoRoute(path: '/onboarding', page: OnboardingRoute.page),
    AutoRoute(path: '/home', page: HomeRoute.page),
    AutoRoute(path: '/paywall', page: PaywallRoute.page),
    AutoRoute(path: '/image-edit', page: ImageEditRoute.page),
    AutoRoute(path: '/result', page: ResultRoute.page),
  ];

  @override
  RouteType get defaultRouteType => RouteType.cupertino();
}
