import 'package:drugs_ng/src/core/contants/app_color.dart';
import 'package:drugs_ng/src/core/contants/app_image.dart';
import 'package:drugs_ng/src/core/data/models/product.dart';
import 'package:drugs_ng/src/core/ui/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: 20.r,
              height: 20.r,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Product Details").w700.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 300.h,
            color: const Color(0xFFEAEFF5),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    product.image,
                    width: 250.w,
                    height: 250.h,
                  ),
                ),
                Positioned(
                  top: 25.h,
                  left: 16.w,
                  child: Container(
                    width: 35.r,
                    height: 35.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFBDC4CD),
                      ),
                    ),
                    child: SvgPicture.asset(
                      AppSvg.heartOutline,
                      width: 17.r,
                      height: 17.r,
                      colorFilter: const ColorFilter.mode(
                          Color(0xFF0B8AE1), BlendMode.srcIn),
                    ),
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
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              border: Border.all(color: Color(0xFF8B96A5))),
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 10.verticalSpace,
                      itemCount: 4),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
