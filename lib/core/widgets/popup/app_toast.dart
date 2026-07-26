import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static void warn(
    BuildContext context, {
    required String title,
    required String msg,
  }) {
    show(context, msg: msg, type: ToastTypeEnum.warning);
  }

  static void info(
    BuildContext context, {
    required String title,
    required String msg,
  }) {
    show(context, msg: msg, type: ToastTypeEnum.info);
  }

  static void success(
    BuildContext context, {
    required String title,
    required String msg,
  }) {
    show(context, msg: msg, type: ToastTypeEnum.success);
  }

  static void show(
    BuildContext context, {
    String? title,
    required String msg,
    ToastTypeEnum type = ToastTypeEnum.info,
    Duration autoCloseDuration = const Duration(seconds: 3),
  }) {
    // Implementation for showing a toast message
    toastification.show(
      context: context,
      icon: CustomImage(
        type.image,
        width: 20,
        height: 20,
        color: Color(type.iconColor),
      ),
      style: ToastificationStyle.fillColored,
      title:
          title != null
              ? Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              )
              : null,
      description: Text(
        msg,
        style: TextStyle(
          color: Color(0xFFE5E5E5),
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      primaryColor: Color(type.bgColor),

      // backgroundColor: Color(type.bgColor),
      foregroundColor: Colors.white,
      autoCloseDuration: autoCloseDuration,
    );
  }
}

enum ToastTypeEnum {
  success,
  warning,
  info;

  String get image => switch (this) {
    info => Assets.svg.infoTriangle,
    warning => Assets.svg.warnTriangle,
    success => Assets.svg.checkCircle,
  };

  int get iconColor => switch (this) {
    info => 0xFFFFFFFF,
    warning => 0xFFFFFFFF,
    success => 0xFF28BE28,
  };

  int get bgColor => switch (this) {
    info => 0xFFBE8A28,
    warning => 0xFFEF4444,
    success => 0xFF28BE28,
  };
}
