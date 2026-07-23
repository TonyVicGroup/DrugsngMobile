import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppDialog {
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String content,
    String yesText = 'Yes',
    String noText = 'No',
    Color noBackgroundColor = Colors.transparent,
    Color yesBackgroundColor = AppColor.primary,
    Color noTextColor = Colors.black,
    Color yesTextColor = Colors.white,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => _AppDialog(
            title: title,
            content: content,
            yesText: yesText,
            noText: noText,
            noBackgroundColor: noBackgroundColor,
            yesBackgroundColor: yesBackgroundColor,
            noTextColor: noTextColor,
            yesTextColor: yesTextColor,
          ),
    );
    return result ?? false;
  }
}

class _AppDialog extends StatelessWidget {
  const _AppDialog({
    required this.title,
    required this.content,
    required this.yesText,
    required this.noText,
    required this.noBackgroundColor,
    required this.yesBackgroundColor,
    required this.noTextColor,
    required this.yesTextColor,
  });

  final String title;
  final String content;
  final String yesText;
  final String noText;
  final Color noBackgroundColor;
  final Color yesBackgroundColor;
  final Color noTextColor;
  final Color yesTextColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(4.r),
        child: SizedBox(
          width: 400.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.sp14(title).w500,
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: SvgPicture.asset(
                          AppSvg.close,
                          width: 11.2.r,
                          height: 11.2.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 2,
                color: const Color(0xFFE5E5E5),
              ),
              24.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.r),
                child: AppText.sp16(content).w400,
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.r),
                child: Row(
                  children: [
                    appButton(
                      () => Navigator.pop(context),
                      noBackgroundColor,
                      noTextColor,
                      noText,
                    ),
                    20.horizontalSpace,
                    appButton(
                      () => Navigator.pop(context, true),
                      yesBackgroundColor,
                      yesTextColor,
                      yesText,
                    ),
                  ],
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget appButton(
    void Function() onTap,
    Color bgColor,
    Color txtColor,
    String text,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 49.h,
          width: 326.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: bgColor,
          ),
          child: AppText.sp16(text).w800.setColor(txtColor),
        ),
      ),
    );
  }
}
