import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ConsultationTile extends StatelessWidget {
  const ConsultationTile({super.key, required this.consultation, this.onTap});
  final void Function()? onTap;
  final ConsultationDetails consultation;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.fromLTRB(16.r, 16.r, 0, 16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 25.r,
                  height: 25.r,
                  alignment: Alignment.bottomRight,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(AppImage.testAvatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    width: 8.r,
                    height: 8.r,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primary,
                    ),
                  ),
                ),
                10.horizontalSpace,
                AppText.sp14(
                  consultation.doctorName,
                ).setColor(const Color(0xFF071827)),
              ],
            ),
            8.verticalSpace,
            AppText.sp14(
              DateFormat('dd MMMM yyy').format(consultation.scheduledDate),
            ).w700.primaryColor,
          ],
        ),
      ),
    );
  }
}
