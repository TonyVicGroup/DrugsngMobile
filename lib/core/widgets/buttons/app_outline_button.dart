import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    required this.text,
    required this.onTap,
    this.status = ButtonStatus.active,
    super.key,
  });

  final String text;
  final void Function() onTap;
  final ButtonStatus status;

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      onTap: onTap,
      child: Container(
        height: 52.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.colorF5F7FA,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.colorE0E0E0, width: 1.r),
        ),
        child:
            status.isLoading
                ? _loader(AppColor.color333333)
                : Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.color333333,
                  ),
                ),
      ),
    );
  }

  static Widget _loader([Color color = AppColor.white]) => SizedBox(
    height: 30.r,
    width: 30.r,
    child: CircularProgressIndicator(color: color, strokeCap: StrokeCap.round),
  );
}
