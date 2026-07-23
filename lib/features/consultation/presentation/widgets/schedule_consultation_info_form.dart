import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_checkbox.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_validators.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ScheduleConsultationInfoForm extends StatelessWidget {
  final DoctorDetails doctor;
  final GlobalKey<FormState> formState;
  final TextEditingController fullNameCntrl;
  final TextEditingController phoneCntrl;
  final TextEditingController genderCntrl;
  final TextEditingController currentMedCntrl;
  final TextEditingController allergiesCntrl;
  final TextEditingController prevMedicalCondCntrl;
  final TextEditingController briefDescribeCntrl;
  final TextEditingController consultationTypeCntrl;
  final TextEditingController insuranceProviderCntrl;
  final bool shareInformation;
  final DateTime? dateofBirth;
  final void Function(bool?, DateTime?) onChanged;

  const ScheduleConsultationInfoForm({
    super.key,
    required this.doctor,
    required this.fullNameCntrl,
    required this.phoneCntrl,
    required this.genderCntrl,
    required this.currentMedCntrl,
    required this.allergiesCntrl,
    required this.prevMedicalCondCntrl,
    required this.briefDescribeCntrl,
    required this.consultationTypeCntrl,
    required this.insuranceProviderCntrl,
    required this.formState,
    required this.shareInformation,
    required this.dateofBirth,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          20.verticalSpace,
          infoTextWidget(
            "Note:",
            " Ensure all fields marked with an asterisk (*) are"
                " filled out before submitting the form.",
          ),
          20.verticalSpace,
          infoTextWidget(
            "Privacy Policy:",
            " Your personal information is secure and will only be "
                "used for the purpose of scheduling and conducting your consultation.",
          ),
          24.verticalSpace,
          AppText.sp20("Patient Information"),
          24.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: textField(
                  hint: "Type here",
                  label: "Full Name*",
                  controller: fullNameCntrl,
                  validator: (v) => AppValidators.name(v),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: textField(
                  hint: "Type here",
                  label: "Phone Number*",
                  keyboardType: TextInputType.phone,
                  controller: phoneCntrl,
                  validator: (v) => AppValidators.phone(v),
                ),
              ),
            ],
          ),
          24.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: textField(
                  label: "Date of Birth*",
                  hint: "DD/MM/YYYY",
                  staticInfo:
                      dateofBirth == null
                          ? null
                          : DateFormat('dd / MM / yyyy').format(dateofBirth!),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2400),
                    );
                    onChanged(null, date);
                  },
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: textField(
                  label: "Gender*",
                  controller: genderCntrl,
                  validator: (v) => AppValidators.name(v, 'Enter your gender'),
                ),
              ),
            ],
          ),
          24.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: textField(
                  hint: "Type here",
                  label: "Current Medications*",
                  controller: currentMedCntrl,
                  validator:
                      (v) => AppValidators.name(
                        v,
                        'Enter your medical conditions',
                      ),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: textField(
                  hint: "Type here",
                  label: "Allergies*",
                  controller: allergiesCntrl,
                  validator:
                      (v) => AppValidators.name(v, 'Enter your allergies'),
                ),
              ),
            ],
          ),
          24.verticalSpace,
          textField(
            label: "Previous Medical Conditions*",
            hint: "Type here",
            controller: prevMedicalCondCntrl,
            validator:
                (v) => AppValidators.name(
                  v,
                  'Enter any previous medical conditions',
                ),
          ),
          24.verticalSpace,
          textField(
            label: "Brief Description of Symptoms/Concerns*",
            hint: "Type here",
            height: 125.h,
            controller: briefDescribeCntrl,
            validator: (v) => AppValidators.name(v, "Enter your symptoms"),
          ),
          24.verticalSpace,
          Row(
            children: [
              Expanded(
                child: fixedTextField(
                  "Specialist",
                  doctor.specializations.join(' ,'),
                ),
              ),
              12.horizontalSpace,
              Expanded(child: fixedTextField("Doctor", doctor.fullName)),
            ],
          ),
          24.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: textField(
                  label: "Consultation Type*",
                  controller: consultationTypeCntrl,
                  validator:
                      (v) => AppValidators.name(v, "Enter consultation type"),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: textField(
                  hint: "Type here",
                  label: "Insurance Provider",
                ),
              ),
            ],
          ),
          24.verticalSpace,
          Row(
            children: [
              AppCheckbox.primary(
                value: shareInformation,
                onChanged: (v) {
                  onChanged(v, null);
                },
              ),
              8.horizontalSpace,
              Expanded(
                child: AppText.sp18(
                  "Share your health history with the doctor",
                ),
              ),
            ],
          ),
          24.verticalSpace,
        ],
      ),
    );
  }

  Column fixedTextField(String label, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText.sp14(label).w500,
        8.verticalSpace,
        Container(
          height: 48.h,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: const Color(0xFFE5E5E5),
            border: Border.all(color: const Color(0xFFE5E5E5)),
          ),
          child: AppText.sp12(text).w400,
        ),
      ],
    );
  }

  Column textField({
    required String label,
    String? hint,
    int? maxLines,
    TextInputType? keyboardType,
    TextEditingController? controller,
    String? Function(String?)? validator,
    double? height,
    void Function()? onTap,
    String? staticInfo,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText.sp14(label).w500,
        8.verticalSpace,
        FormField(
          validator:
              validator != null ? (v) => validator(controller?.text) : null,
          builder: (state) {
            String? errorText = state.errorText;
            final Color borderColor =
                errorText != null ? AppColor.red : const Color(0xFFE5E5E5);
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Container(
                    height: height,
                    width: double.maxFinite,
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: 16.r,
                    //   vertical: 15.r,
                    // ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: borderColor),
                    ),
                    child:
                        onTap != null
                            ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.r,
                                vertical: 15.r,
                              ),
                              child: Row(
                                children: [
                                  AppText.sp14((staticInfo ?? hint) ?? ''),
                                ],
                              ),
                            )
                            : TextField(
                              controller: controller,
                              // cursorHeight: 16.h,
                              cursorColor: AppColor.darkGrey,
                              maxLines: maxLines,
                              keyboardType: keyboardType,
                              style: TextStyle(
                                fontSize: 14.sp,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                color: AppColor.black,
                              ),
                              decoration: InputDecoration(
                                hintText: hint,
                                isDense: true,
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  height: 1,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF6D6D6D),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.r,
                                  vertical: 15.r,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                  ),
                ),
                if (errorText != null) ...[
                  8.verticalSpace,
                  AppText.sp12(errorText).w400.setColor(AppColor.red),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  RichText infoTextWidget(String title, String info) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColor.primary,
            ),
          ),
          TextSpan(text: info),
        ],
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF8B96A5),
        ),
      ),
    );
  }
}
