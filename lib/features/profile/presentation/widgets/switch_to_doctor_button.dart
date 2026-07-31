import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SwitchToDoctorButton extends StatelessWidget {
  const SwitchToDoctorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButtonAnimator(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.color084EA7.withAlpha(12),
              AppColor.color0B8AE1.withAlpha(25),
            ],
          ),
          border: Border.all(color: AppColor.color0B8AE1, width: 2.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  Assets.svg.people,
                  width: 20.r,
                  height: 20.r,
                  colorFilter: const ColorFilter.mode(
                    AppColor.color0B8AE1,
                    BlendMode.srcIn,
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: AppText.sp16(
                    'Switch to Doctor Dashboard',
                  ).w600.setColor(AppColor.color333333),
                ),
                8.horizontalSpace,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.color4CAF50.withAlpha(25),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: AppText.sp12(
                    'Approved',
                  ).w500.setColor(AppColor.color4CAF50),
                ),
              ],
            ),
            8.verticalSpace,
            AppText.sp13(
              'Access your appointments, patients, and earnings',
            ).w400.setColor(AppColor.color666666),
          ],
        ),
      ),
    );
  }
}
