import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_details.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ExpandableConsultationTile extends StatelessWidget {
  const ExpandableConsultationTile({super.key, required this.consultation});
  final ConsultationDetails consultation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: ExpandablePanel(
        header: Padding(
          padding: EdgeInsets.fromLTRB(16.r, 16.r, 0, 16.r),
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
        collapsed: const SizedBox.shrink(),
        expanded: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              iconRow('Doctor\'s name', 'Dr. ${consultation.doctorName}'),
              iconRow('Full Name', consultation.patientName),
              iconRow('Phone Number', ''),
              iconRow('Date of birth', ''),
              iconRow('Gender', ''),
              iconRow('Current Medication', consultation.currentMedication),
              iconRow('Allergies', consultation.allergies),
              iconRow(
                'Previous Medical Conditions',
                consultation.previousMedicalConditions,
              ),
              AppText.sp16('Brief Description of Symptoms/Concerns').w500,
              8.verticalSpace,
              AppText.sp14(consultation.symptomsAndConcerns),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconRow(String title, String info) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.r),
      child: Row(
        children: [
          Expanded(flex: 2, child: AppText.sp16(title).w500),
          Expanded(flex: 3, child: AppText.sp16(info).w700.endAlign),
        ],
      ),
    );
  }
}
