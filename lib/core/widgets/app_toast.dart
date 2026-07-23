import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static ToastFuture show(
    BuildContext context, {
    required String msg,
    Duration duration = const Duration(milliseconds: 3300),
    Color borderClr = Colors.black,
    bool? isSucess,
    void Function()? onDismiss,
    dynamic Function(Duration, Duration)? onInitState,
    StyledToastPosition position = StyledToastPosition.top,
  }) {
    return showToast(
      msg,
      onDismiss: onDismiss,
      onInitState: onInitState,
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      shapeBorder: RoundedRectangleBorder(
        side: BorderSide(
          color:
              isSucess == null
                  ? borderClr
                  : isSucess
                  ? Colors.teal
                  : Colors.red,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      // textStyle: AppStyle.txtQuicksand.copyWith(color: Colors.white),
      context: context,
      position: position,
      backgroundColor: Theme.of(context).colorScheme.surface,
      animation: StyledToastAnimation.sizeFade,
      duration: duration,
    );
  }
  // static final FToast fToast = FToast();

  static Widget _toast(_ToastType toastType, String message) => Container(
    width: 300.w,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.r),
      color: AppColor.white,
      border: Border.all(color: AppColor.lightGrey),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: toastType.color,
          ),
          child: SvgPicture.asset(
            toastType.svg,
            colorFilter: const ColorFilter.mode(
              AppColor.white,
              BlendMode.srcIn,
            ),
            width: 15.w,
            height: 15.w,
            fit: BoxFit.contain,
          ),
        ),
        10.horizontalSpace,
        Expanded(child: AppText.sp14(message).w400),
      ],
    ),
  );

  static _showToast(
    BuildContext context,
    _ToastType type,
    String message,
    Duration duration,
  ) {
    bool? isSuccess =
        (type == _ToastType.info) ? null : type == _ToastType.success;
    show(context, msg: message, isSucess: isSuccess);
    // fToast.init(context);
    // fToast.removeCustomToast();
    // fToast.showToast(
    //   child: _toast(type, message),
    //   positionedToastBuilder: (context, widget) {
    //     return Positioned(
    //       top: MediaQuery.of(context).padding.top + 8.h,
    //       left: 0,
    //       right: 0,
    //       child: widget,
    //     );
    //   },
    //   isDismissable: true,
    //   toastDuration: duration,
    // );
  }

  static void warning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) => _showToast(context, _ToastType.warning, message, duration);
  static void info(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) => _showToast(context, _ToastType.info, message, duration);
  static void success(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) => _showToast(context, _ToastType.success, message, duration);
}

enum _ToastType {
  info,
  warning,
  success;

  Color get color {
    switch (this) {
      case info:
        return AppColor.primary;
      case warning:
        return AppColor.red;
      case success:
        return AppColor.green;
    }
  }

  String get svg {
    switch (this) {
      case info:
        return AppSvg.flag;
      case warning:
        return AppSvg.close;
      case success:
        return AppSvg.checkMark;
    }
  }
}
