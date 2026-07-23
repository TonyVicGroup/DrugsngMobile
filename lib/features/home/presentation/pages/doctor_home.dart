import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/home/presentation/widgets/doctor_home_notification_widget.dart';
import 'package:drugs_ng/features/home/presentation/widgets/doctor_search_button.dart';
import 'package:drugs_ng/features/home/presentation/widgets/set_doctor_availability_button.dart';
import 'package:drugs_ng/features/home/presentation/widgets/upcoming_appointment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            15.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Row(
                children: [
                  CustomImage(
                    AppImage.testDoctorProfile,
                    height: 32.r,
                    width: 32.r,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  12.horizontalSpace,
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final name = context.read<AuthCubit>().user?.fullName;
                      return AppText.sp14('hi ${name ?? 'User'}').w400;
                    },
                  ),
                  const Spacer(),
                  CustomImage(
                    AppSvg.doctorNotification,
                    height: 26.r,
                    width: 26.r,
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: const DoctorSearchButton(),
            ),
            12.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: const Row(children: [SetDoctorAvailabilityButton()]),
            ),
            24.verticalSpace,
            SizedBox(
              height: 161.h,
              width: double.maxFinite,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                separatorBuilder: (context, idx) => 12.horizontalSpace,
                itemBuilder: (context, idx) {
                  return Container(
                    width: 302.w,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.r,
                      vertical: 16.r,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0x33979797)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.sp16(
                                'Fulfilled Consultations',
                              ).w500.setColor(const Color(0xFF979797)),
                              AppText.sp30(
                                '0',
                              ).w500.setColor(const Color(0xFF212B36)),
                              AppText.sp16(
                                '0% Last 30 days',
                              ).w500.setColor(const Color(0xFF979797)),
                            ],
                          ),
                        ),
                        10.horizontalSpace,
                        CustomImage(
                          AppImage.peopleIcon,
                          width: 60.r,
                          height: 60.r,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            12.verticalSpace,
            const UpcomingAppointmentWidget(),
            12.verticalSpace,
            const DoctorHomeNotificationWidget(),
            12.verticalSpace,
          ],
        ),
      ),
    );
  }
}
