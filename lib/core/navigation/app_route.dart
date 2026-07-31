import 'package:drugs_ng/core/services/log_service.dart';
import 'package:drugs_ng/features/auth/presentation/pages/change_password_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/change_password_success_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/email_otp_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/select_account_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/signup_screen.dart';
import 'package:drugs_ng/features/auth/presentation/pages/forget_password_page.dart';
import 'package:drugs_ng/features/auth/presentation/pages/login_page.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/cart_page.dart';
import 'package:drugs_ng/features/lab_test/presentation/pages/lab_test_discovery_page.dart';
import 'package:drugs_ng/features/navigation/presentation/pages/dashboard_page.dart';
import 'package:drugs_ng/features/notification/presentation/pages/notification_page.dart';
import 'package:drugs_ng/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:drugs_ng/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:drugs_ng/features/product/presentation/pages/product_detail_page.dart';
import 'package:drugs_ng/features/product/presentation/pages/product_reviews_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/add_edit_address_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/address_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/help_support_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/my_review_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/order_history_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/personal_info_page.dart';
import 'package:drugs_ng/features/profile/presentation/pages/wishlist_page.dart';
import 'package:drugs_ng/features/search/presentation/pages/search_page.dart';
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
  static const productDetailScreen = '/productDetailScreen';
  static const productReviewPage = '/productReviewPage';
  static const cartPage = '/cartPage';
  static const notificationPage = '/notificationPage';
  static const labTestDiscovery = '/labTestDiscovery';
  static const searchPage = '/searchPage';
  static const personalInfoPage = '/personalInfoPage';
  static const addressPage = '/addressPage';
  static const orderHistoryPage = '/orderHistoryPage';
  static const wishlistPage = '/wishlistPage';
  static const myReviewPage = '/myReviewPage';
  static const helpSupportPage = '/helpSupportPage';
  static const addAndEditAddressPage = '/addAndEditAddressPage';
  //
  static const dashboard = '/dashboard';

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
      case productDetailScreen:
        return ProductDetailPage.route(routeSettings);
      case productReviewPage:
        return ProductReviewsPage.route(routeSettings);
      case cartPage:
        return CartPage.route(routeSettings);
      case notificationPage:
        return NotificationPage.route(routeSettings);
      case labTestDiscovery:
        return LabTestDiscoveryPage.route(routeSettings);
      case searchPage:
        return SearchPage.route(routeSettings);
      case personalInfoPage:
        return PersonalInfoPage.route(routeSettings);
      case addressPage:
        return AddressPage.route(routeSettings);
      case orderHistoryPage:
        return OrderHistoryPage.route(routeSettings);
      case wishlistPage:
        return WishlistPage.route(routeSettings);
      case myReviewPage:
        return MyReviewPage.route(routeSettings);
      case helpSupportPage:
        return HelpSupportPage.route(routeSettings);
      case addAndEditAddressPage:
        return AddEditAddressPage.route(routeSettings);
      //
      case dashboard:
        return DashboardPage.route(routeSettings);
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
