import 'package:drugs_ng/core/services/log_service.dart';
import 'package:drugs_ng/features/auth/presentation/pages/change_password_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/change_password_success_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/email_otp_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/select_account_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/signup_screen.dart';
import 'package:drugs_ng/features/auth/presentation/pages/forget_password_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:drugs_ng/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:drugs_ng/features/verification/presentation/pages/complete_doctor_verification_summary_page.dart';
import 'package:drugs_ng/features/verification/presentation/pages/doctor_application_status_page.dart';
import 'package:drugs_ng/features/verification/presentation/pages/doctor_registration_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  // login & onboarding
  static const onboarding = '/onboarding';
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const forgetPassword = '/forgetPassword';
  static const emailOtp = '/emailOtp';
  static const changePassword = '/changePassword';
  static const changePasswordSucces = '/changePasswordSucces';
  static const selectAccountType = '/selectAccountType';
  static const completeDoctorVerificationSummary =
      '/completeDoctorVerificationSummary';
  static const doctorRegistration = '/doctorRegistration';
  static const doctorApplicationStatus = '/doctorApplicationStatus';

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
      case signup:
        return SignupScreen.route(routeSettings);
      case forgetPassword:
        return ForgetPasswordPage.route(routeSettings);
      case emailOtp:
        return EmailOtpPage.route(routeSettings);
      case changePassword:
        return ChangePasswordPage.route(routeSettings);
      case changePasswordSucces:
        return ChangePasswordSuccessPage.route(routeSettings);
      case selectAccountType:
        return SelectAccountPage.route(routeSettings);
      case completeDoctorVerificationSummary:
        return CompleteDoctorVerificationSummaryPage.route(routeSettings);
      case doctorRegistration:
        return DoctorRegistrationPage.route(routeSettings);
      case doctorApplicationStatus:
        return DoctorApplicationStatusPage.route(routeSettings);
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
