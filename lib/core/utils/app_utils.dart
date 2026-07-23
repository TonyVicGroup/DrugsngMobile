import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/address_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/user_consultations_cubit.dart';
import 'package:drugs_ng/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:drugs_ng/features/prescription/presentation/cubit/prescription_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/card/card_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/order_history_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/reviews_cubit.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class AppUtils {
  static const kPageTransitionDuration = Duration(milliseconds: 300);

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static PersistentTabController? tabController;
  static const String baseUrl = 'https://drugsngmain.azurewebsites.net/api/v1/';

  // static PersistentTabController? tabController;
  static String get pubNubPublishKey =>
      dotenv.get('pubNubPublishKey', fallback: '');
  static String get pubNubSubscribeKey =>
      dotenv.get('pubNubSubscribeKey', fallback: '');
  static String get pubNubSecretKey =>
      dotenv.get('pubNubSecretKey', fallback: '');
  static String get pubNubChatChannelName =>
      dotenv.get('pubNubChatChannelName', fallback: '');

  static Route<T> transition<T>(Widget page) => PageTransition(
    type: PageTransitionType.rightToLeft,
    child: page,
    duration: kPageTransitionDuration,
    curve: Curves.easeOut,
  );

  static Future pushReplacement(Widget page) async {
    return await AppUtils.navKey.currentState?.pushReplacement(
      transition(page),
    );
  }

  static Future pushWidget(Widget page) async {
    return await AppUtils.navKey.currentState?.push(transition(page));
  }

  // check if widget is visible
  static bool isOnScreen(BuildContext context) {
    final route = ModalRoute.of(context);
    final isCurrentRoute = route?.isCurrent ?? false;
    return isCurrentRoute;
  }

  static void removeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void logout(BuildContext context) {
    context.read<CartCubit>().resetData();
    context.read<PrescriptionCubit>().resetData();
    context.read<OrderHistoryCubit>().resetData();
    context.read<WishlistCubit>().resetData();
    context.read<AddressCubit>().resetData();
    context.read<UserConsultationsCubit>().resetData();
    context.read<CardCubit>().resetData();
    context.read<ReviewsCubit>().resetData();
    context.read<AuthCubit>().logout();
    Navigator.of(context).pushAndRemoveUntil(
      AppUtils.transition(const OnboardingScreen()),
      (route) => false,
    );
  }
}
