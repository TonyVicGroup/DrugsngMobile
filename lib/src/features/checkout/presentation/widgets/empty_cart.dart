import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/ui/app_button.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          const Spacer(flex: 3),
          SvgPicture.asset(
            AppSvg.emptyCart,
            width: 100.r,
            height: 100.r,
            colorFilter:
                const ColorFilter.mode(Color(0xFF8B96A5), BlendMode.srcIn),
          ),
          40.verticalSpace,
          AppText.sp30("Your Cart Is Empty").w800.black,
          13.verticalSpace,
          AppText.sp16(
                  "It looks like you haven't added anything to your cart yet. Browse our products and find what you need!")
              .w400
              .centerText
              .setColor(const Color(0xFF8B96A5)),
          const Spacer(flex: 3),
          AppButton.primary(text: "Start Shopping", onTap: () {}),
          120.verticalSpace,
        ],
      ),
    );
  }
}
