import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/prescription/presentation/cubit/prescription_cubit.dart';
import 'package:drugs_ng/features/prescription/presentation/widgets/recent_upload_loader.dart';
import 'package:drugs_ng/features/prescription/presentation/widgets/recent_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentUploadsTab extends StatelessWidget {
  const RecentUploadsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        20.verticalSpace,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: BlocBuilder<PrescriptionCubit, PrescriptionState>(
            builder: (context, state) {
              if (state.recentUploads.isEmpty) {
                if (state.uploadStatus.isLoading) {
                  return SizedBox(
                    height: 180.sp,
                    child: const RecentUploadLoader(),
                  );
                }
                return SizedBox(
                  height: 180.sp,
                  child: Center(
                    child:
                        AppText.sp16(
                          "You have no recent prescriptions.",
                        ).setColor(const Color(0xFF979797)).centerText,
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.recentUploads.length,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final pres = state.recentUploads[index];
                  return PrescriptionUploadWidget(prescription: pres);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
