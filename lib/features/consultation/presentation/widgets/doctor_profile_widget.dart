import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/doctor_rating_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorProfileWidget extends StatelessWidget {
  final DoctorDetails doctor;
  const DoctorProfileWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 329.h,
        width: 358.w,
        child: Column(
          children: [
            CustomImage(
              doctor.profileImage ?? '',
              width: 358.w,
              height: 249.h,
              fit: BoxFit.contain,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
            ),
            Expanded(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF101010).withOpacity(0.04),
                      blurRadius: 30,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.r),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppText.sp16(
                            doctor.fullName,
                          ).w600.black.setMaxLines(1),
                          Expanded(
                            child: AppText.sp12(
                              "${doctor.specializations.join(' ,')} | ${doctor.workPlace}",
                            ).w400.setColor(const Color(0xFF8B96A5)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              AppSvg.book,
                              width: 18.r,
                              height: 18.r,
                              colorFilter: const ColorFilter.mode(
                                AppColor.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                            8.horizontalSpace,
                            AppText.sp12(
                              "${doctor.patients} Appointments",
                            ).w500.black,
                          ],
                        ),
                        const DoctorRatingChip(rating: 3),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
