import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/consultation/data/models/consultation_data.dart';
import 'package:drugs_ng/features/consultation/presentation/pages/consultation_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ConsultSuccessPage extends StatelessWidget {
  final ConsultationData data;

  const ConsultSuccessPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            const Spacer(),
            CustomImage(AppSvg.checkCircleGreen, width: 120.r, height: 120.r),
            24.verticalSpace,
            AppText.sp20("Consultation scheduled successfully!").w700,
            12.verticalSpace,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(text: "You have scheduled consultation with "),
                  TextSpan(
                    text: "Dr. ${data.doctor.fullName}",
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(text: " for the "),
                  TextSpan(
                    text: DateFormat(
                      "dd of MMMM yyyy",
                    ).format(data.dateOfBirth),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(text: " and  we have sent an email to "),
                  TextSpan(
                    text: userEmail(context),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(
                    text: " with your order confirmation and bill",
                  ),
                ],
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF5F6C72),
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(child: _homeButton(context)),
                12.horizontalSpace,
                Expanded(
                  child: AppButton.primary(
                    text: "View Consultation",
                    onTap: () => viewConsultation(context),
                  ),
                ),
              ],
            ),
            36.verticalSpace,
          ],
        ),
      ),
    );
  }

  InkWell _homeButton(BuildContext context) {
    return InkWell(
      onTap: () => goHome(context),
      child: Container(
        height: 58.sp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE5E5E5)),
          color: AppColor.white,
        ),
        child: AppText.sp18('Go Home'),
      ),
    );
  }

  String userEmail(BuildContext context) {
    return context.read<AuthCubit>().state.user?.email ?? 'your email';
  }

  void goHome(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void viewConsultation(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.push(context, AppUtils.transition(const ConsultationListPage()));
  }
}
