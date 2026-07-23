import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/consultation/presentation/cubit/doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConsultationHeaderWidget extends StatelessWidget {
  const ConsultationHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192.h,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      // padding: EdgeInsets.fromLTRB(17.w, 25.h, 0, 25.h),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 15.w,
            top: 10.h,
            child: Image.asset(
              AppImage.expertAdvice,
              height: 192.h,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            width: 216.w,
            top: 24.h,
            left: 17.w,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<DoctorCubit, DoctorState>(
                  builder: (context, state) {
                    return AppText.sp12(
                      "+${state.doctors.length} Doctors Available",
                    ).w400.setColor(const Color(0xFFEDF8FF));
                  },
                ),
                const Spacer(),
                AppText.sp18(
                  "Get Expert Advice. Schedule a Consultation Today.",
                ).w400.white,
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: const Color(0xFFEDF8FF),
                    ),
                    child: AppText.sp14("Find a Doctor").w600.primaryColor,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
