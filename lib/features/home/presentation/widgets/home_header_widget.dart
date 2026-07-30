import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/navigation/app_route.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/core/widgets/buttons/cart_icon_button.dart';
import 'package:drugs_ng/core/widgets/buttons/notification_icon_button.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/features/home/presentation/widgets/location_chip.dart';
import 'package:drugs_ng/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColor.colorFFFFFF,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          LocationChip.widget(context),
          const Spacer(),
          CustomImage(Assets.images.drugs.path, width: 35.w),
          5.horizontalSpace,
          AppText.sp14('DrugsNG').w400.setColor(AppColor.color0B8AE1),
          const Spacer(),
          CartIconButton(),
          10.horizontalSpace,
          NotificationIconButton(),
        ],
      ),
    );
  }
}
