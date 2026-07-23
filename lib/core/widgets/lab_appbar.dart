import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/extensions/widget_extension.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LabAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: Center(
        child: InkWell(
          onTap: () {
            AppUtils.tabController?.openDrawer();
          },
          child: CustomImage(
            AppSvg.labMenu,
            width: 27.w,
            color: AppColor.subText,
          ),
        ),
      ),
      title: Row(
        children: [
          CustomImage(AppImage.logo, height: 23.r),
          5.horizontalSpace,
          AppText.sp18('Drugs.NG').primaryColor.w600,
        ],
      ),
      actions: [
        CustomImage(
          AppSvg.labNotification,
          width: 24.r,
          height: 24.r,
        ).padAll(8.r),
        CustomImage(AppSvg.labSearch, width: 24.r, height: 24.r).padAll(8.r),
        CustomImage(
          AppImage.testAvatar,
          width: 38.r,
          height: 38.r,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(20.r),
        ).clickable(() {}, radius: BorderRadius.circular(20.r)).padAll(10.r),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, kToolbarHeight);
}
