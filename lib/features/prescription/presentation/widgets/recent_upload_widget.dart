import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/prescription/data/models/prescription.dart';
import 'package:drugs_ng/features/prescription/presentation/cubit/prescription_cubit.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PrescriptionUploadWidget extends StatelessWidget {
  final bool showOptions;
  final Prescription prescription;

  const PrescriptionUploadWidget({
    super.key,
    required this.prescription,
    this.showOptions = true,
  });

  factory PrescriptionUploadWidget.fromFile({required PlatformFile file}) {
    final prescription = Prescription(
      id: -1,
      createdDate: DateTime.now(),
      fileName: file.name,
      size: getFileSizeString(file.size),
    );
    return PrescriptionUploadWidget(
      prescription: prescription,
      showOptions: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPdf = prescription.fileName.endsWith(".pdf");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE5E5E5))),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            isPdf ? Assets.svg.pdf : Assets.svg.image,
            height: 20.sp,
            colorFilter: const ColorFilter.mode(
              AppColor.primary,
              BlendMode.srcIn,
            ),
          ),
          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.sp16(prescription.fileName).w500.black,
                5.verticalSpace,
                AppText.sp12(timeAgoString).w400.black,
              ],
            ),
          ),
          20.horizontalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEAEFF5)),
            ),
            child: AppText.sp12(
              prescription.size.toUpperCase(),
            ).w800.setColor(const Color(0xFF6D6D6D)),
          ),
          if (showOptions)
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Padding(
                  padding: EdgeInsets.only(right: 14.w, left: 24.w),
                  child: SvgPicture.asset(
                    AppSvg.threeDot,
                    height: 13.sp,
                    colorFilter: const ColorFilter.mode(
                      AppColor.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                onChanged: (v) {
                  // v?.onTap();
                  context.read<PrescriptionCubit>().deletePrescription(
                    prescription.id,
                  );
                },
                items:
                    _DropdownMenu.all
                        .map(
                          (menu) => DropdownMenuItem<_DropdownMenu>(
                            value: menu,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  menu.svg,
                                  width: 12.r,
                                  colorFilter: ColorFilter.mode(
                                    menu.color,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                10.horizontalSpace,
                                AppText.sp14(
                                  menu.text,
                                ).w400.setColor(menu.color),
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

  String get timeAgoString {
    final time = prescription.createdDate;

    DateTime now = DateTime.now();
    if (time.year == now.year &&
        time.month == now.month &&
        time.day == now.day) {
      // if (time.hour == now.hour && time.minute == now.minute) {
      //   return "Now";
      // } else {
      return "Today";
      // }
    } else {
      int days = now.difference(time).inDays;
      return "$days days ago";
    }
  }
}

String getFileSizeString(int bytes) {
  const suffixes = ["b", "kb", "mb", "gb", "tb"];
  if (bytes == 0) return '0${suffixes[0]}';
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(1)) + suffixes[i];
}

class _DropdownMenu {
  final int index;
  final String text;
  final String svg;
  final Color color;

  _DropdownMenu({
    required this.index,
    required this.text,
    required this.svg,
    required this.color,
  });

  static List<_DropdownMenu> get all => [
    // _DropdownMenu(
    //     index: 0,
    //     text: "Order with upload",
    //     svg: AppSvg.upload,
    //     color: AppColor.black),
    _DropdownMenu(
      index: 1,
      text: "Delete this upload",
      svg: AppSvg.delete,
      color: AppColor.red,
    ),
  ];
}
