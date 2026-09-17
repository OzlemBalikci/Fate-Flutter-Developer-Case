import 'package:auto_route/auto_route.dart';

part 'navigation.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: SplashRoute.page, initial: true),
    AutoRoute(path: '/onboarding', page: OnboardingRoute.page),
  ];

  @override
  RouteType get defaultRouteType => RouteType.cupertino();
}
