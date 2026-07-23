import 'package:drugs_ng/core/services/log_service.dart';
import 'package:drugs_ng/features/auth/presentation/pages/create_account_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:drugs_ng/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  // login & onboarding
  static const onboarding = '/onboarding';
  static const splash = '/splash';
  static const login = '/login';
  static const createAccount = '/createAccount';

  static String currentRoute = splash;

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    //to track current route
    //this will only track pushed route on top of previous route
    currentRoute = routeSettings.name ?? '';
    dLog('Current Route: $currentRoute');

    switch (routeSettings.name) {
      // login & onboarding routes
      case onboarding:
        return OnboardingScreen.route(routeSettings);
      case splash:
        return SplashScreen.route(routeSettings);
      case login:
        return LoginPage.route(routeSettings);
      case createAccount:
        return CreateAccountPage.route(routeSettings);
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
