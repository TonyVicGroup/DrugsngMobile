import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/prescription/data/models/prescription.dart';
import 'package:drugs_ng/features/prescription/presentation/widgets/recent_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HealthRecordPage extends StatelessWidget {
  const HealthRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: 20.sp,
              height: 20.sp,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Health Record").w700.black,
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemBuilder: (context, index) {
          return PrescriptionUploadWidget(
            showOptions: true,
            prescription: Prescription(
              id: -1,
              createdDate: DateTime.now(),
              fileName: "fileName$index",
              size: "32kb",
            ),
          );
        },
        separatorBuilder: (context, index) => 25.verticalSpace,
        itemCount: 5,
      ),
    );
  }
}
