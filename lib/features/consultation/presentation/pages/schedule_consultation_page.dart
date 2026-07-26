import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_data.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';
import 'package:drugs_ng/features/consultation/presentation/pages/preview_consultation_details_page.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/schedule_consultation_info_form.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/schedule_consultation_time_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduleConsultationPage extends StatefulWidget {
  final DoctorDetails doctor;
  const ScheduleConsultationPage({super.key, required this.doctor});

  @override
  State<ScheduleConsultationPage> createState() =>
      _ScheduleConsultationPageState();
}

class _ScheduleConsultationPageState extends State<ScheduleConsultationPage> {
  bool nextPage = false;

  /// controllers
  final TextEditingController fullNameCntrl = TextEditingController();
  final TextEditingController phoneCntrl = TextEditingController();
  final TextEditingController genderCntrl = TextEditingController();
  final TextEditingController currentMedCntrl = TextEditingController();
  final TextEditingController allergiesCntrl = TextEditingController();
  final TextEditingController prevMedicalCondCntrl = TextEditingController();
  final TextEditingController briefDescribeCntrl = TextEditingController();
  final TextEditingController consultationTypeCntrl = TextEditingController();
  final TextEditingController insuranceProviderCntrl = TextEditingController();
  //
  DateTime? dateofBirth;
  bool shareInformation = false;

  /// time format
  TimeOfDay timeOfDay = TimeOfDay.now();
  DateTime? day;

  /// validators
  GlobalKey<FormState> fieldsFormState = GlobalKey();

  @override
  void dispose() {
    fullNameCntrl.dispose();
    phoneCntrl.dispose();
    genderCntrl.dispose();
    currentMedCntrl.dispose();
    allergiesCntrl.dispose();
    prevMedicalCondCntrl.dispose();
    briefDescribeCntrl.dispose();
    consultationTypeCntrl.dispose();
    insuranceProviderCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: SizedBox(
              width: 20.sp,
              height: 20.sp,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Schedule Consultation").w700.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  child:
                      nextPage
                          ? ScheduleConsultationTimeForm(
                            doctorAvailability: widget.doctor.availabilities,
                            onChanged: (tm, dt) {
                              setState(() {
                                timeOfDay = tm ?? timeOfDay;
                                day = dt ?? day;
                              });
                            },
                            timeOfDay: timeOfDay,
                            date: day,
                          )
                          : ScheduleConsultationInfoForm(
                            doctor: widget.doctor,
                            fullNameCntrl: fullNameCntrl,
                            phoneCntrl: phoneCntrl,
                            genderCntrl: genderCntrl,
                            currentMedCntrl: currentMedCntrl,
                            allergiesCntrl: allergiesCntrl,
                            prevMedicalCondCntrl: prevMedicalCondCntrl,
                            briefDescribeCntrl: briefDescribeCntrl,
                            consultationTypeCntrl: consultationTypeCntrl,
                            insuranceProviderCntrl: insuranceProviderCntrl,
                            formState: fieldsFormState,
                            dateofBirth: dateofBirth,
                            shareInformation: shareInformation,
                            onChanged: (info, dob) {
                              setState(() {
                                dateofBirth = dob ?? dateofBirth;
                                shareInformation = info ?? shareInformation;
                              });
                            },
                          ),
                ),
              ),
              Row(
                children: [
                  Expanded(child: _cancelButton()),
                  12.horizontalSpace,
                  Expanded(
                    child: AppButton.primary(text: "Continue", onTap: next),
                  ),
                ],
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  InkWell _cancelButton() {
    return InkWell(
      onTap: cancel,
      child: Container(
        height: 58.sp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE5E5E5)),
          color: AppColor.white,
        ),
        child: AppText.sp18('Cancel'),
      ),
    );
  }

  void cancel() {
    if (!nextPage) {
      Navigator.pop(context);
    } else {
      setState(() {
        nextPage = false;
      });
    }
  }

  void next() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (nextPage) {
      if ((day != null)) {
        Navigator.push(
          context,
          AppUtils.transition(
            PreviewConsultationDetailsPage(
              data: ConsultationData(
                fullName: fullNameCntrl.text,
                phoneNumber: phoneCntrl.text,
                gender: genderCntrl.text,
                dateOfBirth: dateofBirth!,
                currentMedications: currentMedCntrl.text,
                allergies: allergiesCntrl.text,
                previousMedicalConditions: prevMedicalCondCntrl.text,
                descriptionOfSymptoms: briefDescribeCntrl.text,
                doctor: widget.doctor,
                consultationType: consultationTypeCntrl.text,
                insuranceProvider: insuranceProviderCntrl.text,
                shareHistory: shareInformation,
                scheduledDate: day!.copyWith(
                  hour: timeOfDay.hour,
                  minute: timeOfDay.minute,
                ),
              ),
            ),
          ),
        );
      } else {
        AppToast.warn(context, title: 'Warning', msg: 'Set consultation time');
      }
    } else {
      if (fieldsFormState.currentState?.validate() ?? false) {
        setState(() {
          nextPage = true;
        });
      }
    }
  }
}
