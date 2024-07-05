import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RecentUploadWidget extends StatelessWidget {
  final bool isPdf;
  final String title;
  final DateTime time;
  final String size;

  const RecentUploadWidget({
    super.key,
    required this.isPdf,
    required this.title,
    required this.time,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Color(0xFFE5E5E5),
        ),
      )),
      child: Row(
        children: [
          SvgPicture.asset(
            isPdf ? AppSvg.pdf : AppSvg.image,
            colorFilter:
                const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
          ),
          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.sp16(title).w500.black,
                5.verticalSpace,
                AppText.sp12(dayString).w400.black,
              ],
            ),
          ),
          20.horizontalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEAEFF5)),
            ),
            child: AppText.sp12(size.toUpperCase())
                .w800
                .setColor(const Color(0xFF6D6D6D)),
          ),
          14.horizontalSpace,
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              customButton: Padding(
                padding: EdgeInsets.only(right: 14.w, left: 8.w),
                child: SvgPicture.asset(
                  AppSvg.threeDot,
                  height: 13.h,
                  colorFilter: const ColorFilter.mode(
                    AppColor.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              onChanged: (v) {
                // v?.onTap();
              },
              items: _DropdownMenu.all
                  .map(
                    (menu) => DropdownMenuItem<_DropdownMenu>(
                      value: menu,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            menu.svg,
                            width: 12.r,
                            colorFilter:
                                ColorFilter.mode(menu.color, BlendMode.srcIn),
                          ),
                          10.horizontalSpace,
                          AppText.sp14(menu.text).w400.setColor(menu.color),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              dropdownStyleData: DropdownStyleData(
                width: 180.w,
                // maxHeight: 112.h,
                padding: EdgeInsets.zero,
                // padding: EdgeInsets.symmetric(
                //   horizontal: 13.w,
                //   vertical: 16.h,
                // ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                // offset: Offset(-30.w, 10.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get dayString {
    DateTime now = DateTime.now();

    if (time.year == now.year &&
        time.month == now.month &&
        time.day == now.day) {
      if (time.hour == now.hour && time.minute == now.minute) {
        return "Now";
      } else {
        return "Today";
      }
    } else {
      int days = now.difference(time).inDays;
      return "$days days ago";
    }
  }
}

class _DropdownMenu {
  final int index;
  final String text;
  final String svg;
  final Color color;

  _DropdownMenu(
      {required this.index,
      required this.text,
      required this.svg,
      required this.color});

  static List<_DropdownMenu> get all => [
        _DropdownMenu(
            index: 0,
            text: "Order with upload",
            svg: AppSvg.upload,
            color: AppColor.black),
        _DropdownMenu(
            index: 1,
            text: "Delte this upload",
            svg: AppSvg.delete,
            color: AppColor.red),
      ];
}
