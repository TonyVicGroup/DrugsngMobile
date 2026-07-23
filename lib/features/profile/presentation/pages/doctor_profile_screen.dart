import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/consultation/data/models/doctor_details.dart';
import 'package:drugs_ng/features/consultation/presentation/widgets/doctor_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            children: [
              12.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppText.sp20(
                      'Profile',
                    ).w700.setColor(const Color(0xFF212B36)),
                  ),
                  const CustomImage(AppSvg.edit, color: AppColor.primary),
                ],
              ),
              20.verticalSpace,
              Expanded(
                child: ListView(
                  children: [
                    DoctorProfileWidget(
                      doctor: DoctorDetails(
                        id: 2,
                        firstName: 'firstName',
                        lastName: 'lastName',
                        fullName: 'fullName',
                        email: 'email',
                        dob: DateTime.now(),
                        gender: 'gender',
                        phone: 'phone',
                        workPlace: 'workPlace',
                        about: 'about',
                        location: 'location',
                        yearsOfExp: 5,
                        patients: 5,
                        profileImage: AppImage.testDoctorProfile,
                        specializations: [],
                        ninDocumentUrl: 'ninDocumentUrl',
                        licenseDocumentUrl: 'licenseDocumentUrl',
                        availabilities: [],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
