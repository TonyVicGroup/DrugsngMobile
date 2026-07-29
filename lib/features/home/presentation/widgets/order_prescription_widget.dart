import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/widgets/buttons/app_gradient_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:drugs_ng/features/prescription/presentation/pages/prescription_order_page.dart';
import 'package:drugs_ng/features/profile/presentation/widgets/login_required_modal.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPrescriptionWidget extends StatelessWidget {
  const OrderPrescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88.h,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.colorFFFFFF,
      ),
      child: Row(
        children: [
          CustomImage(Assets.svg.prescriptionBoard, width: 60.h),
          8.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.sp16(
                  "Order with Prescription",
                ).w600.setColor(AppColor.color333333),
                AppText.sp11(
                  'Upload a prescription and a pharmacist'
                  ' will arrange your medications.',
                ).w400.setColor(AppColor.color6D6D6D),
              ],
            ),
          ),
          2.horizontalSpace,
          AppGradientButton(
            text: 'Upload',
            onTap: () => upload(context),
            width: 88.w,
            height: 46.h,
          ),
        ],
      ),
    );
  }

  void upload(BuildContext context) {
    if (context.read<AuthCubit>().isLoggedIn) {
      Navigator.push(
        context,
        AppUtils.transition(const PrescriptionOrderPage()),
      );
    } else {
      LoginRequiredModal.show(context);
    }
  }
}
