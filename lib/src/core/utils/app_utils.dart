import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class AppUtils {
  static const Duration _duration = Duration(milliseconds: 600);

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static PersistentTabController tabController = PersistentTabController();

  static Route transition(Widget page) => PageTransition(
        type: PageTransitionType.fade,
        child: page,
        duration: _duration,
      );

  static Future pushReplacement(Widget page) async {
    return await AppUtils.navKey.currentState?.pushReplacement(
      PageTransition(
        type: PageTransitionType.fade,
        child: page,
        duration: _duration,
      ),
    );
  }

  static Future push(Widget page) async {
    return await AppUtils.navKey.currentState?.push(
      PageTransition(
        type: PageTransitionType.fade,
        child: page,
        duration: _duration,
      ),
    );
  }

  static void pop<T>([T? result]) async {
    return AppUtils.navKey.currentState?.pop(result);
  }
}
