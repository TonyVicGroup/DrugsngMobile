import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/core/utils/app_formater.dart';
import 'package:drugs_ng/features/checkout/data/models/cart.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem item;
  const CartItemWidget({super.key, required this.item});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  ValueNotifier<bool> loading = ValueNotifier(false);

  @override
  void dispose() {
    loading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: loading,
      builder: (context, isLoading, child) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Column(
            children: [
              const Divider(color: Color(0xFFE5E5E5)),
              5.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Row(
                  children: [
                    // SvgPicture.asset(AppSvg.timer),
                    8.horizontalSpace,
                    // AppText.sp12("Results available within 1-2 days"),
                    const Spacer(),
                    ValueListenableBuilder(
                      valueListenable: loading,
                      builder: (context, isLoading, child) {
                        if (isLoading) {
                          return shimmerLoader(28.h, 63.w, 28.r);
                        } else {
                          return InkWell(
                            onTap: removeItem,
                            child: Container(
                              width: 63.w,
                              height: 28.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28.r),
                                border: Border.all(
                                  color: const Color(0xFFEAEFF5),
                                ),
                              ),
                              child: AppText.sp12(
                                "Remove",
                              ).w500.setColor(const Color(0xFFFF5252)),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE5E5E5)),
                          ),
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.sp16(widget.item.name).w500,
                              9.verticalSpace,
                              Row(
                                children: [
                                  AppText.sp12(
                                    widget.item.form ?? "",
                                  ).w400.setColor(AppColor.lightGrey),
                                  8.horizontalSpace,
                                  isLoading
                                      ? shimmerLoader(21.h, 62.w, 10.r)
                                      : Container(
                                        height: 21.h,
                                        width: 62.w,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEDF8FF),
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            arrowButton(false),
                                            Expanded(
                                              child:
                                                  AppText.sp14(
                                                    widget.item.quantity
                                                        .toString(),
                                                  ).primaryColor.centerText,
                                            ),
                                            arrowButton(true),
                                          ],
                                        ),
                                      ),
                                  const Spacer(),
                                  AppText.sp14(
                                    "₦${TextFormater.amount(widget.item.amount)}",
                                  ).w800.endAlign,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    const Divider(color: Color(0xFFE5E5E5)),
                    16.verticalSpace,
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isLoading
                            ? shimmerLoader(18.h, 120.w, 0)
                            : RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${widget.item.quantity} Items",
                                  ),
                                  const TextSpan(
                                    text: "  |  ",
                                    style: TextStyle(color: AppColor.darkGrey),
                                  ),
                                  TextSpan(
                                    text:
                                        "₦${TextFormater.amount(widget.item.amount * widget.item.quantity)}",
                                  ),
                                ],
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 12.w, vertical: 4.r),
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xFFEDF8FF),
                        //     borderRadius: BorderRadius.circular(10.r),
                        //   ),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       AppText.sp14("Order now").w500.primaryColor,
                        //       8.horizontalSpace,
                        //       RotatedBox(
                        //         quarterTurns: 3,
                        //         child: SvgPicture.asset(
                        //           AppSvg.chevronLight,
                        //           width: 10.r,
                        //           colorFilter: const ColorFilter.mode(
                        //             AppColor.primary,
                        //             BlendMode.srcIn,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future removeItem() async {
    context.read<CartCubit>().removeItem(widget.item.itemId, widget.item.name);
  }

  Widget arrowButton(bool add) {
    return InkWell(
      onTap: () async {
        loading.value = true;
        if (add) {
          await context.read<CartCubit>().increase(
            widget.item.name,
            widget.item.itemId,
            1,
          );
        } else {
          if (widget.item.quantity > 1) {
            await context.read<CartCubit>().decrease(
              widget.item.name,
              widget.item.itemId,
              1,
            );
          } /*  else {
            await context.read<CartCubit>().removeItem(
                  widget.item.itemId,
                  widget.item.name,
                );
          } */
        }
        if (mounted) loading.value = false;
      },
      child: RotatedBox(
        quarterTurns: add ? 2 : 0,
        child: Container(
          width: 21.r,
          height: 21.r,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            AppSvg.chevronThick,
            width: 12.r,
            height: 12.r,
            colorFilter: const ColorFilter.mode(
              AppColor.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  Widget shimmerLoader(double height, double width, double radius) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBase,
      highlightColor: AppColor.shimmerHighlight,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColor.shimmerHighlight,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
