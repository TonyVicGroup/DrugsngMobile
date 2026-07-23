import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/widgets/custom_image.dart';
import 'package:drugs_ng/core/widgets/wishlist_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailCarousel extends StatefulWidget {
  final List<String> images;
  final int produtId;
  final ItemTypeEnum itemType;

  const ProductDetailCarousel({
    super.key,
    required this.images,
    required this.produtId,
    required this.itemType,
  });

  @override
  State<ProductDetailCarousel> createState() => _ProductDetailCarouselState();
}

class _ProductDetailCarouselState extends State<ProductDetailCarousel> {
  int imageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 300.h,
      color: const Color(0xFFEAEFF5),
      child: Stack(
        children: [
          if (widget.images.isNotEmpty)
            Align(
              alignment: Alignment.center,
              child: CustomImage(
                widget.images[imageIdx],
                width: 250.w,
                height: 250.h,
              ),
            ),
          Positioned(
            top: 25.h,
            left: 16.w,
            child: WishlistButton(
              produtId: widget.produtId,
              itemType: widget.itemType,
            ),
          ),
          Positioned(
            top: 0,
            right: 16.w,
            width: 55.w,
            bottom: 0,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 25.h),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      imageIdx = index;
                    });
                  },
                  child: Container(
                    height: 55.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(3.r),
                      border:
                          index == imageIdx
                              ? Border.all(color: const Color(0xFF8B96A5))
                              : null,
                    ),
                    child: CustomImage(
                      widget.images[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => 10.verticalSpace,
              itemCount: widget.images.length,
            ),
          ),
          Positioned(
            bottom: 15.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (idx) => _indicator(idx),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _indicator(int index) {
    return Container(
      height: 5.r,
      width: 5.r,
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            index == imageIdx
                ? const Color(0xFF0B8AE1)
                : const Color(0xFFBDC4CD),
      ),
    );
  }
}
