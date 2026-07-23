import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_utils.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button_animator.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/checkout/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton {
  static Widget primary({
    required String text,
    required void Function()? onTap,
    ButtonStatus status = ButtonStatus.active,
  }) {
    return AppButtonAnimator(
      // onTap: status.isActive ? onTap : null,
      onTap: onTap ?? () {},
      child: Container(
        height: 51.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: status.isDisabled ? AppColor.lightBlue : AppColor.primary,
          borderRadius: BorderRadius.circular(100.r),
          gradient: LinearGradient(
            colors: [const Color(0xFF0D5CC2), const Color(0xFF00D6EF)],
          ),
        ),
        child:
            status.isLoading
                ? _loader()
                : Text(
                  text,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.white,
                  ),
                ),
      ),
    );
  }

  static Widget secondary({
    required String text,
    required void Function()? onTap,
    ButtonStatus status = ButtonStatus.active,
  }) {
    return InkWell(
      onTap: status.isActive ? onTap : null,
      child: Container(
        height: 51.h,
        width: double.maxFinite,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.whiteBlue,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child:
            status.isLoading
                ? _loader(AppColor.primary)
                : Text(
                  text,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.primary,
                  ),
                ),
      ),
    );
  }

  static Widget svgIcon({
    required String svg,
    required Function() onTap,
    Color? color,
    ButtonStatus status = ButtonStatus.active,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 30.sp,
        height: 30.sp,
        alignment: Alignment.center,
        padding: EdgeInsets.all(7.r),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEAEFF5),
        ),
        child: SvgPicture.asset(
          svg,
          colorFilter:
              color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }

  static Widget back(void Function() onTap) => InkWell(
    onTap: onTap,
    child: Container(
      height: 40.r,
      width: 40.r,
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10.r),
      //   border: Border.all(color: AppColor.lightGrey),
      // ),
      child: SvgPicture.asset(AppSvg.chevronThick),
    ),
  );

  static Widget roundedBack(void Function() onTap) => InkWell(
    onTap: onTap,
    child: Container(
      height: 40.r,
      width: 40.r,
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColor.lightGrey),
      ),
      child: SvgPicture.asset(AppSvg.chevronThick),
    ),
  );

  static Widget _loader([Color color = AppColor.white]) => SizedBox(
    height: 30.r,
    width: 30.r,
    child: CircularProgressIndicator(color: color, strokeCap: StrokeCap.round),
  );

  static Widget checkout() => const _CheckoutIcon();
}

class _CheckoutIcon extends StatelessWidget {
  const _CheckoutIcon();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => goToCart(context),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return SizedBox(
            width: 40.r,
            height: 40.r,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFBDC4CD)),
                    ),
                    child: SvgPicture.asset(
                      AppSvg.shopping,
                      colorFilter: const ColorFilter.mode(
                        AppColor.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                if (state.totalItems() > 1)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primary,
                      ),
                      child: AppText.sp10(
                        "${state.totalItems()}",
                      ).w500.white.setLineHeight(1),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void goToCart(BuildContext context) {
    Navigator.of(context).push(AppUtils.transition(const CartPage()));
  }
}
