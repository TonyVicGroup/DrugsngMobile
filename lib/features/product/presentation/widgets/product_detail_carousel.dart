import 'package:drugs_ng/core/contants/app_color.dart';
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
      height: 397.h,
      width: double.maxFinite,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColor.colorFFFFFF,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          if (widget.images.isNotEmpty)
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 20.h,
              child: CustomImage(widget.images[imageIdx]),
            ),
          Positioned(
            top: 10.h,
            right: 10.w,
            child: WishlistButton(
              produtId: widget.produtId,
              itemType: widget.itemType,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  // color: AppColor.colorFFFFFF,
                  height: 55.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 25.h),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            imageIdx = index;
                          });
                        },
                        child: Container(
                          height: 55.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(3.r),
                            border:
                                index == imageIdx
                                    ? Border.all(color: AppColor.colorF3F5F9)
                                    : null,
                          ),
                          child: CustomImage(
                            widget.images[index],
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => 10.horizontalSpace,
                    itemCount: widget.images.length,
                  ),
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (idx) => _indicator(idx),
                  ),
                ),
              ],
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
        color: index == imageIdx ? AppColor.color0B8AE1 : AppColor.colorBDC4CD,
      ),
    );
  }
}
