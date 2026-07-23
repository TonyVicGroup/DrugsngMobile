import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletListWidget extends StatelessWidget {
  const WalletListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 169.h,
      width: double.maxFinite,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.r),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.8.r),
            child: AspectRatio(
              aspectRatio: 260 / 161,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: AppColor.primary,
                      width: double.maxFinite,
                      height: double.maxFinite,
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: CustomImage(
                      AppImage.walletBg,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          20.horizontalSpace,
          AspectRatio(
            aspectRatio: 260 / 161,
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.8.r),
                border: Border.all(
                  color: const Color(0xFF979797).withOpacity(0.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
