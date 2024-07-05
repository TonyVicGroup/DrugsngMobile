import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppUtils {
  static const kPageTransitionDuration = Duration(milliseconds: 300);

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static Future pushReplacement(Widget page) async {
    return await AppUtils.navKey.currentState?.pushReplacement(
      PageTransition(
        type: PageTransitionType.fade,
        child: page,
        duration: kPageTransitionDuration,
      ),
    );
  }

  static Future pushWidget(Widget page) async {
    return await AppUtils.navKey.currentState?.push(
      PageTransition(
        type: PageTransitionType.fade,
        child: page,
        duration: kPageTransitionDuration,
      ),
    );
  }
}
