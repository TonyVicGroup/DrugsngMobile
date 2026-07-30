import 'package:drugs_ng/core/contants/app_color.dart';
import 'package:drugs_ng/core/contants/app_image.dart';
import 'package:drugs_ng/core/data/models/app_responses.dart';
import 'package:drugs_ng/core/enum/button_status.dart';
import 'package:drugs_ng/core/enum/item_type_enum.dart';
import 'package:drugs_ng/core/enum/load_status_enum.dart';
import 'package:drugs_ng/core/widgets/popup/app_toast.dart';
import 'package:drugs_ng/features/checkout/data/models/cart.dart';
import 'package:drugs_ng/features/checkout/presentation/cubit/cart_cubit.dart';
import 'package:drugs_ng/features/lab_test/data/repository/lab_test_repository.dart';
import 'package:drugs_ng/features/lab_test/domain/models/wellness_package_detail.dart';
import 'package:drugs_ng/features/lab_test/presentation/cubit/lab_test_cubit.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/lab_location_widget.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/lab_test_specification_widget.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/wellness_info_widget%20copy.dart';
import 'package:drugs_ng/features/lab_test/presentation/widgets/wellness_list_widget.dart';
import 'package:drugs_ng/core/widgets/buttons/app_button.dart';
import 'package:drugs_ng/core/widgets/app_text.dart';
import 'package:drugs_ng/features/product/presentation/widgets/product_detail_carousel.dart';
import 'package:drugs_ng/features/product/presentation/widgets/product_detail_loader.dart';
import 'package:drugs_ng/features/profile/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PackageOverviewPage extends StatefulWidget {
  final int productId;

  const PackageOverviewPage({super.key, required this.productId});

  @override
  State<PackageOverviewPage> createState() => _PackageOverviewPageState();
}

class _PackageOverviewPageState extends State<PackageOverviewPage> {
  final btnStatus = ValueNotifier<ButtonStatus>(ButtonStatus.active);
  final loadingStatus = ValueNotifier(LoadStatusEnum.loading);
  WellnessPackageDetail? wellnessPackage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reload();
    });
  }

  @override
  void dispose() {
    loadingStatus.dispose();
    btnStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        surfaceTintColor: AppColor.white,
        backgroundColor: AppColor.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Center(
            child: SizedBox(
              width: 20.sp,
              height: 20.sp,
              child: SvgPicture.asset(AppSvg.chevronThick),
            ),
          ),
        ),
        title: AppText.sp18("Package Overview").w700.black,
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: loadingStatus,
        builder: (context, status, child) {
          if (status.isLoading) {
            return const ProductDetailLoader();
          } else if (status.isSuccess) {
            WellnessPackageDetail package = wellnessPackage!;
            return ListView(
              children: [
                ProductDetailCarousel(
                  images: package.imageUrl == null ? [] : [package.imageUrl!],
                  produtId: package.id,
                  itemType: ItemTypeEnum.package,
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.labTest,
                            width: 9.w,
                            colorFilter: const ColorFilter.mode(
                              AppColor.green,
                              BlendMode.srcIn,
                            ),
                          ),
                          8.horizontalSpace,
                          AppText.sp12(
                            "In-Lab Testing",
                          ).w400.setColor(AppColor.green),
                        ],
                      ),
                      4.verticalSpace,
                      AppText.sp16(package.name).w700.black,
                      20.verticalSpace,
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     ...List.generate(
                      //       5,
                      //       (i) {
                      //         return product.rating > i
                      //             ? filledStar()
                      //             : unselectedStar();
                      //       },
                      //     ),
                      //     4.horizontalSpace,
                      //     AppText.sp14("(${product.rating})")
                      //         .w400
                      //         .setColor(AppColor.primary),
                      //     dot(),
                      //     InkWell(
                      //       onTap: () => viewReviews(context),
                      //       child: iconText(
                      //         AppSvg.reviews,
                      //         "${product.reviews.length} reviews",
                      //       ),
                      //     ),
                      //     2.horizontalSpace,
                      //     dot(),
                      //     iconText(AppSvg.sold, "${product.amountSold} sold"),
                      //   ],
                      // ),
                      // 10.verticalSpace,
                      LabTestSpecificationWidget(
                        info1: "Blood",
                        title1: "Collection",
                        info2: package.resultTime,
                        title2: "Duration",
                        info3: "No fasting",
                        title3: "Preparation",
                      ),
                      20.verticalSpace,
                      WellnessInformationWidget(package: package),
                      30.verticalSpace,
                      if (package.laboratories.isNotEmpty) ...[
                        AppText.sp16("Lab Location").w500.black,
                        22.verticalSpace,
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder:
                              (context, index) => LabLocationWidget(
                                laboratory: package.laboratories[index],
                              ),
                          separatorBuilder:
                              (context, index) => 10.verticalSpace,
                          itemCount: package.laboratories.length,
                        ),
                        43.verticalSpace,
                      ],
                      // BlocConsumer<CartCubit, CartState>(
                      //   listener: (context, state) {
                      //     if (state.s) {
                      //       AppToast.warn(
                      //         context,
                      //         title: 'Error',
                      //         msg: state.error.message,
                      //       );
                      //     }
                      //   },
                      //   builder: (context, state) {
                      //     if (state is CartStateInitial) {
                      //       context.read<CartCubit>().getCart();
                      //     }
                      //     int idx = state.cart.items.indexWhere((ct) {
                      //       return ct.name == package.name &&
                      //           ct.itemId == package.id;
                      //     });
                      //     if (idx >= 0) {
                      //       return AppText.sp12(
                      //         "${state.cart.items[idx].quantity} item added to cart",
                      //       ).w400.black;
                      //     } else {
                      //       return const SizedBox.shrink();
                      //     }
                      //   },
                      // ),
                      5.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: btnStatus,
                              builder: (context, value, child) {
                                return AppButton.primary(
                                  text: "ADD TO CART",
                                  onTap: () async {
                                    await addToCart(context, package);
                                  },
                                  status: value,
                                );
                              },
                            ),
                          ),
                          21.horizontalSpace,
                          AppButton.checkout(),
                        ],
                      ),
                      40.verticalSpace,
                      AppText.sp16("Recommended Tests").w500.black,
                      // 22.verticalSpace,
                    ],
                  ),
                ),
                BlocBuilder<LabTestCubit, LabTestState>(
                  builder: (context, state) {
                    return WellnessListWidget(state);
                  },
                ),
                20.verticalSpace,
              ],
            );
          } else if (status.isFailed) {
            return Center(child: AppText.sp16("Something went wrong").w500);
          }
          return Center(child: AppText.sp16(AppError.unknown.message).w500);
        },
      ),
    );
  }

  Future addToCart(BuildContext context, WellnessPackageDetail package) async {
    context.read<CartCubit>().addWellnessPackage(package: package, quantity: 1);
  }

  Future reload() async {
    final result = await LabTestRepository().getPackage(widget.productId);
    if (!mounted) return;
    if (result.isRight) {
      wellnessPackage = result.right;
      loadingStatus.value = LoadStatusEnum.success;
    } else {
      loadingStatus.value = LoadStatusEnum.failed;
    }
  }
}
