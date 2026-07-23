import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/doctor_rating_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorListTile extends StatelessWidget {
  final Doctor doctor;
  final void Function() onTap;
  final bool showRating;

  const DoctorListTile({
    super.key,
    required this.onTap,
    required this.doctor,
    this.showRating = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 4),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              doctor.profileImage,
              borderRadius: BorderRadius.circular(10.r),
              fit: BoxFit.cover,
              width: 67.r,
              height: 67.r,
            ),
            17.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.sp16(doctor.fullName).w500.black,
                  8.verticalSpace,
                  AppText.sp14(
                    "${doctor.speciality} | ${doctor.workPlace}",
                  ).w400.setMaxLines(1).setColor(const Color(0xFF8B96A5)),
                  8.verticalSpace,
                  Row(
                    children: [
                      if (showRating)
                        DoctorRatingChip(rating: doctor.rating.round()),
                      AppText.sp14(
                        "Exp: ${doctor.yearsOfExp}+ years",
                      ).w400.setColor(const Color(0xFF8B96A5)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
