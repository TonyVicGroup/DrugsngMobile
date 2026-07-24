import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/extensions/context_extension.dart';
import 'package:drugs_ng/core/services/log_service.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({
    super.key,
    required this.produtId,
    required this.itemType,
    this.bgColor = const Color(0xFFEDF8FF),
  });
  final int produtId;
  final ItemTypeEnum itemType;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistCubit, WishlistState>(
      listenWhen:
          (previous, current) =>
              context.isOnScreen && produtId == current.addRemoveId,
      buildWhen:
          (previous, current) =>
              context.isOnScreen && produtId == current.addRemoveId,
      listener: (context, state) {
        if (state.addRemoveId == produtId) {
          if (state.addRemoveStatus.isSuccess) {
            if (state.isInWishlist(produtId, itemType)) {
              dLog('Product $produtId added to wishlist successfully');
              AppToast.show(context, msg: state.message ?? 'Added to wishlist');
            } else {
              dLog('Product $produtId removed from wishlist successfully');
              AppToast.show(
                context,
                msg: state.message ?? 'Removed from wishlist',
              );
            }
          } else if (state.addRemoveStatus.isFailed) {
            dLog(
              'Error adding/removing product $produtId to/from wishlist: ${state.message}',
            );
            AppToast.show(context, msg: state.message ?? 'An error occurred');
          }
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap:
          // state.addRemoveStatus.isLoading
          //     ? null
          //     :
          () {
            dLog("Wishlist ids: ${state.wishlistIds}");
            dLog("Current product id: $produtId, itemType: $itemType");
            if (state.isInWishlist(produtId, itemType)) {
              dLog('added to wishlist, removing...');
              context.read<WishlistCubit>().removeWishlist(produtId, itemType);
            } else {
              dLog('not in wishlist, adding...');
              context.read<WishlistCubit>().addWishlist(produtId, itemType);
            }
          },
          borderRadius: BorderRadius.circular(36.r),
          child: SizedBox(
            width: 36.w,
            height: 36.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    width: 36.w,
                    height: 36.h,
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bgColor,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      state.isInWishlist(produtId, itemType)
                          ? AppSvg.heartFilled
                          : AppSvg.heartOutline,
                      colorFilter: ColorFilter.mode(
                        state.isInWishlist(produtId, itemType)
                            ? AppColor.primary
                            : const Color(0xFF8B96A5),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (state.addRemoveId == produtId &&
                        state.addRemoveStatus.isLoading) {
                      return const CircularProgressIndicator(
                        color: AppColor.primary,
                        strokeWidth: 2,
                      );
                      // Shimmer.fromColors(
                      //   baseColor: AppColor.shimmerBase,
                      //   highlightColor: AppColor.shimmerHighlight,
                      //   child: Container(
                      //     height: 36.w,
                      //     width: 36.h,
                      //     decoration: const BoxDecoration(
                      //       color: AppColor.shimmerHighlight,
                      //       shape: BoxShape.circle,
                      //     ),
                      //   ),
                      // );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
