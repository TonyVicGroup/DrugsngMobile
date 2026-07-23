import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/services/log_service.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/app_toast.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_data.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/consultation_cubit.dart';
import 'package:drugs_ng/features/consultation/presentation/pages/consult_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PreviewConsultationDetailsPage extends StatefulWidget {
  final ConsultationData data;

  const PreviewConsultationDetailsPage({super.key, required this.data});

  @override
  State<PreviewConsultationDetailsPage> createState() =>
      _PreviewConsultationDetailsPageState();
}

class _PreviewConsultationDetailsPageState
    extends State<PreviewConsultationDetailsPage> {
  ValueNotifier<ButtonStatus> btnStatus = ValueNotifier(ButtonStatus.active);

  @override
  void dispose() {
    btnStatus.dispose();
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
        title: AppText.sp18("Preview Consultation Details").w700.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView(
          children: [
            30.verticalSpace,
            infoRow("Full Name", widget.data.fullName),
            infoRow("Phone Number", widget.data.phoneNumber),
            infoRow(
              "Date of Birth",
              DateFormat("dd/MM/yyyy").format(widget.data.dateOfBirth),
            ),
            infoRow("Gender", widget.data.gender),
            infoRow("Current Medication", widget.data.currentMedications),
            infoRow("Allergies", widget.data.allergies),
            infoRow(
              "Previous Medical conditions",
              widget.data.previousMedicalConditions,
            ),
            Divider(color: const Color(0xFF919EAB).withOpacity(0.16)),
            34.verticalSpace,
            AppText.sp16(
              "Brief Description of Symptoms/Concerns",
            ).w500.setColor(const Color(0xFF5C6F7F)),
            8.verticalSpace,
            Container(
              constraints: BoxConstraints(minHeight: 122.h),
              padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFE5E5E5)),
              ),
              child: AppText.sp14(
                widget.data.descriptionOfSymptoms,
              ).w400.setColor(const Color(0xFF6D6D6D)),
            ),
            60.verticalSpace,
            ValueListenableBuilder(
              valueListenable: btnStatus,
              builder: (context, value, child) {
                return AppButton.primary(
                  text: "Book Consultation  ₦ 12,000",
                  status: value,
                  onTap: () => _bookConsultation(context),
                );
              },
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }

  Padding infoRow(String title, String info) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 130.w,
            child: AppText.sp16(title).w500.setColor(const Color(0xFF5C6F7F)),
          ),
          30.horizontalSpace,
          Expanded(
            child:
                AppText.sp16(
                  info,
                ).w700.setColor(const Color(0xFF212B36)).endAlign,
          ),
        ],
      ),
    );
  }

  void _bookConsultation(BuildContext context) async {
    btnStatus.value = ButtonStatus.loading;
    dLog(widget.data.tojson());
    // btnStatus.value = ButtonStatus.active;

    // return;
    final result = await context.read<ConsultationCubit>().addConsultation(
      widget.data,
    );
    btnStatus.value = ButtonStatus.active;
    if (result != null) {
      // ignore: use_build_context_synchronously
      AppToast.warning(context, result.message);
    } else {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        AppUtils.transition(ConsultSuccessPage(data: widget.data)),
      );
    }
  }
}
