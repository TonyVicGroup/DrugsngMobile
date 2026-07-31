import 'package:flutter/material.dart';

class AppColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color primary = Color(0xFF0B8AE1);
  static const Color primaryLight = Color(0xFFE7F3FC);
  static const Color whiteBlue = Color(0xFFEDF8FF);
  static const Color lightBlue = Color(0xFFAFD0FF);
  static const Color lightGrey = Color(0xFFACB2BB);
  static const Color darkGrey = Color(0xFF6D6D6D);
  static const Color text = Color(0xFF5C5C5C);
  static const Color subText = Color(0xFF7D7D7D);
  static const Color subTextLight = Color(0xFFBFBFBF);
  static const Color red = Color(0xFFFF5252);
  static const Color green = Color(0xFF39C316);
  static const Color successPrimary = Color(0xFF00A86B);
  //

  /// Grays
  static const Color color555555 = Color(0xFF555555);
  static const Color color333333 = Color(0xFF333333);

  /// Primary
  static const Color color0B8AE1 = Color(0xFF0B8AE1);

  /// Secondary
  static const Color colorFF8118 = Color(0xFFFF8118);

  /// Page background
  static const Color colorF3F5F9 = Color(0xFFF3F5F9);

  /// Accent Colors
  static const Color color0C7190 = Color(0xFF0C7190);
  static const Color colorEAF2FD = Color(0xFFEAF2FD);
  static const Color colorE6F9F9 = Color(0xFFE6F9F9);
  static const Color color02C0BB = Color(0xFF02C0BB);
  static const Color colorEDF6FE = Color(0xFFEDF6FE);
  static const Color colorF4F4FD = Color(0xFFF4F4FD);
  static const Color colorFEF6EF = Color(0xFFFEF6EF);
  static const Color color823AFC = Color(0xFF823AFC);
  static const Color color6D6D6D = Color(0xFF6D6D6D);
  static const Color colorBDC4CD = Color(0xFFBDC4CD);
  static const Color color1A1D26 = Color(0xFF1A1D26);
  static const Color colorE0E0E0 = Color(0xFFE0E0E0);
  static const Color color00C3EF = Color(0xFF00C3EF);
  static const Color color666666 = Color(0xFF666666);
  static const Color colorF5F7FA = Color(0xFFF5F7FA);
  static const Color color31B5ED = Color(0xFF31B5ED);
  static const Color colorFFFFFF = Color(0xFFFFFFFF);
  static const Color colorF0F0F0 = Color(0xFFF0F0F0);
  static const Color color999999 = Color(0xFF999999);
  static const Color color9CA3AF = Color(0xFF9CA3AF);
  static const Color colorFF9800 = Color(0xFFFF9800);
  static const Color color7C8098 = Color(0xFF7C8098);
  static const Color colorF7F8FB = Color(0xFFF7F8FB);
  static const Color color000000 = Color(0xFF000000);
  static const Color color16A34A = Color(0xFF16A34A);
  static const Color colorF0FDF4 = Color(0xFFF0FDF4);
  static const Color colorFEF2F2 = Color(0xFFFEF2F2);
  static const Color colorC5CDD8 = Color(0xFFC5CDD8);
  static const Color colorECFDF5 = Color(0xFFECFDF5);
  static const Color colorDC2626 = Color(0xFFDC2626);
  static const Color color7F1D1D = Color(0xFF7F1D1D);
  static const Color color5F2121 = Color(0xFF5F2121);
  static const Color colorF0F1F3 = Color(0xFFF0F1F3);
  static const Color color6B7280 = Color(0xFF6B7280);
  static const Color colorD97706 = Color(0xFFD97706);
  static const Color color92400E = Color(0xFF92400E);
  static const Color color111827 = Color(0xFF111827);
  static const Color colorF9FAFB = Color(0xFFF9FAFB);
  static const Color colorE5E7EB = Color(0xFFE5E7EB);
  static const Color colorE1F2FA = Color(0xFFE1F2FA);
  static const Color colorDBE2EA = Color(0xFFDBE2EA);
  static const Color colorF87868 = Color(0xFFF87868);
  static const Color color8B96A5 = Color(0xFF8B96A5);
  static const Color colorBABABA = Color(0xFFBABABA);
  static const Color colorF1F1F1 = Color(0xFFF1F1F1);
  static const Color color75869D = Color(0xFF75869D);
  static const Color color5B5B5B = Color(0xFF5B5B5B);
  static const Color colorE5E5E5 = Color(0xFFE5E5E5);
  static const Color colorFF5252 = Color(0xFFFF5252);
  static const Color color9A3333 = Color(0xFF9A3333);
  static const Color colorFFEAEA = Color(0xFFFFEAEA);
  static const Color color39C316 = Color(0xFF39C316);
  static const Color color2B78CA = Color(0xFF2B78CA);
  static const Color color4CAF50 = Color(0xFF4CAF50);
  static const Color color0E2769 = Color(0xFF0E2769);
  static const Color color084EA7 = Color(0xFF084EA7);
  static const Color color68DEFF = Color(0xFF68DEFF);
  static const Color colorB8D9D2 = Color(0xFFB8D9D2);
  static const Color colorF4F1EA = Color(0xFFF4F1EA);
  static const Color color32C9E6 = Color(0xFF32C9E6);
  static const Color color0D5CC2 = Color(0xFF0D5CC2);
  static const Color color00D6EF = Color(0xFF00D6EF);
  static const Color colorEAEFF5 = Color(0xFFEAEFF5);
  static const Color colorE8EEF4 = Color(0xFFE8EEF4);
  static const Color color1A2332 = Color(0xFF1A2332);

  // shimmer loader colors
  static const Color shimmerBase = Color(0xFFe0e0e0);
  static const Color shimmerHighlight = Color(0xFFFFFFFF);

  // linear gradient
  static const LinearGradient lightBlueGradient = LinearGradient(
    // begin: Alignment,
    colors: [Color(0xFFE8F3FC), Color(0xFFD6ECFA)],
  );

  // shadow
  static const List<BoxShadow> shadow = [
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 20,
      spreadRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0.05),
    ),
  ];
  static const List<BoxShadow> blueShadow = [
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 30,
      spreadRadius: 0,
      color: Color(0x260B8AE1),
    ),
  ];
}
