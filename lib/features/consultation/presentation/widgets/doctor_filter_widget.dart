import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/consultation/domain/entity/doctor_menu_item.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorFilterWidget extends StatelessWidget {
  const DoctorFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Container(
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          alignment: Alignment.center,
          child: CustomImage(AppSvg.doctorFilter, height: 24.h),
        ),
        onChanged: (v) {},
        items: [
          // DropdownMenuItem<DoctorMenuItem>(
          //   value: DoctorMenuItem.specialty,
          //   child: subMenu(DoctorMenuItem.specialty),
          // ),
          // DropdownMenuItem<DoctorMenuItem>(
          //   value: DoctorMenuItem.location,
          //   child: subMenu(DoctorMenuItem.location),
          // ),
          DropdownMenuItem<DoctorMenuItem>(
            value: DoctorMenuItem.rating,
            child: ratingSubMenu(context),
          ),
        ],
        dropdownStyleData: DropdownStyleData(
          width: 300.w,
          padding: EdgeInsets.zero,
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
        ),
      ),
    );
  }

  Widget subMenu(DoctorMenuItem menuItem, {double? height}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        barrierColor: Colors.white.withOpacity(0.5),
        customButton: AppText.sp18(menuItem.title),
        onChanged: (v) {},
        items:
            menuItem.options
                .map(
                  (menu) => DropdownMenuItem<String>(
                    value: menu,
                    child: AppText.sp18(menu).w500,
                  ),
                )
                .toList(),
        dropdownStyleData: DropdownStyleData(
          width: 300.w,
          maxHeight: 344.h,
          padding: EdgeInsets.zero,
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
        ),
      ),
    );
  }

  Widget ratingSubMenu(BuildContext context) {
    int? selected = context.read<DoctorCubit>().state.parameters.rating;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        barrierColor: Colors.white.withOpacity(0.5),
        isDense: false,
        customButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppText.sp18("Rating"),
        ),
        onChanged: (rating) {
          if (rating != null) {
            Navigator.pop(context);
            context.read<DoctorCubit>().setRating(rating);
            context.read<DoctorCubit>().findDoctor();
          }
        },
        items:
            [4, 3, 2, 1]
                .map(
                  (rating) => DropdownMenuItem<int>(
                    value: rating,
                    child: Container(
                      margin: EdgeInsets.only(right: 16.r),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.r,
                        vertical: 5.r,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: const Color(0xFFF3FFF4),
                        border:
                            selected == rating
                                ? Border.all(color: const Color(0xFF00A010))
                                : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 16.r,
                            width: 16.r,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF59E0B),
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            alignment: Alignment.center,
                            child: CustomImage(
                              AppSvg.starFilled,
                              color: AppColor.white,
                              width: 12.r,
                              height: 12.r,
                            ),
                          ),
                          4.horizontalSpace,
                          AppText.sp10(rating.toString()),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
        dropdownStyleData: DropdownStyleData(
          width: 300.w,
          maxHeight: 344.h,
          padding: EdgeInsets.zero,
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
        ),
      ),
    );
  }
}
